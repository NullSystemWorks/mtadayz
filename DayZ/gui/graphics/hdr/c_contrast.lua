--
-- c_contrast.lua
--

bEffectEnabled = false

Settings = {}
Settings.var = {}

local sX, sY = guiGetScreenSize ()


--------------------------------
-- Switch effect on
--------------------------------
function enableContrast()
	if bEffectEnabled then return end

	-- Version check
	if getVersion ().sortable < "1.1.0" then
		outputChatBox( "Resource is not compatible with this client." )
		return
	end

	-- Input texture
    myScreenSourceFull = dxCreateScreenSource( sX, sY )

	-- Shaders
	contrastShader = dxCreateShader( ":DayZ/gui/graphics/hdr/fx/contrast.fx" )
	bloomCombineShader = dxCreateShader( ":DayZ/gui/graphics/hdr/fx/bloom_combine.fx" )
	bloomExtractShader = dxCreateShader( ":DayZ/gui/graphics/hdr/fx/bloom_extract.fx" )
	blurHShader = dxCreateShader( ":DayZ/gui/graphics/hdr/fx/blurH.fx" )
	blurVShader = dxCreateShader( ":DayZ/gui/graphics/hdr/fx/blurV.fx" )
	modulationShader = dxCreateShader( ":DayZ/gui/graphics/hdr/fx/modulation.fx" )

	-- 1 pixel render target to store the result of scene luminance calculations
	lumTarget = dxCreateRenderTarget( 1, 1 )
	nextLumSampleTime = 0

	-- Overlay texture
	textureVignette = dxCreateTexture ( ":DayZ/gui/graphics/hdr/images/vignette1.dds" );

	-- Get list of all elements used
	effectParts = {
						myScreenSourceFull,
						contrastShader,
						bloomCombineShader,
						bloomExtractShader,
						blurHShader,
						blurVShader,
						modulationShader,
						lumTarget,
						textureVignette
					}

	-- Check list of all elements used
	bAllValid = true
	for _,part in ipairs(effectParts) do
		bAllValid = part and bAllValid
	end

	setEffectType1 ()
	bEffectEnabled = true

	if not bAllValid then
		outputChatBox( "Could not create some things. Please use debugscript 3" )
		disableContrast()
	end
end


--------------------------------
-- Switch effect off
--------------------------------
function disableContrast()
	if not bEffectEnabled then return end

	-- Destroy all shaders
	for _,part in ipairs(effectParts) do
		if part then
			destroyElement( part )
		end
	end
	effectParts = {}
	bAllValid = false
	RTPool.clear()

	-- Flag effect as stopped
	bEffectEnabled = false
end


---------------------------------
-- Settings for effect
---------------------------------
function setEffectType1()
    v = Settings.var
    v.Brightness=0.32
    v.Contrast=2.24

    v.ExtractThreshold=0.72

    v.DownSampleSteps=2
    v.GBlurHBloom=1.68
    v.GBlurVBloom=1.52

    v.BloomIntensity=0.94
    v.BloomSaturation=1.66
    v.BaseIntensity=0.94
    v.BaseSaturation=-0.38

    v.LumSpeed=51
    v.LumChangeAlpha=27

    v.MultAmount=0.46
    v.Mult=0.70
    v.Add=0.10
    v.ModExtraFrom=0.11
    v.ModExtraTo=0.58
    v.ModExtraMult=4

    v.MulBlend=0.82
    v.BloomBlend=0.25

    v.Vignette=0.47

	-- Debugging
    v.PreviewEnable=0
    v.PreviewPosY=0
    v.PreviewPosX=100
    v.PreviewSize=70
end


----------------------------------------------------------------
-- Render
----------------------------------------------------------------
addEventHandler( "onClientHUDRender", root,
    function()
		if not bAllValid or not Settings.var then return end
		-- Bypass effect if left alt and num_7 are held
		if getKeyState("lalt") and getKeyState("num_7") then return end
		local v = Settings.var

		RTPool.frameStart()
		DebugResults.frameStart()
		if myScreenSourceFull then
			dxUpdateScreenSource( myScreenSourceFull )
		end

		-- Get source textures
		local current1 = myScreenSourceFull
		local current2 = myScreenSourceFull
		local sceneLuminance = lumTarget

		-- Effect path 1 (contrast)
		current1 = applyModulation( current1, sceneLuminance, v.MultAmount, v.Mult, v.Add, v.ModExtraFrom, v.ModExtraTo, v.ModExtraMult )
		current1 = applyContrast( current1, v.Brightness, v.Contrast )

		-- Effect path 2 (bloom)
		current2 = applyBloomExtract( current2, sceneLuminance, v.ExtractThreshold )
		current2 = applyDownsampleSteps( current2, v.DownSampleSteps )
		current2 = applyGBlurH( current2, v.GBlurHBloom )
		current2 = applyGBlurV( current2, v.GBlurVBloom )
		current2 = applyBloomCombine( current2, current1, v.BloomIntensity, v.BloomSaturation, v.BaseIntensity, v.BaseSaturation )

		-- Update texture used to calculate the scene luminance level
		updateLumSource( current1, v.LumSpeed, v.LumChangeAlpha )

		-- Final output
		dxSetRenderTarget()
		dxDrawImage( 0, 0, sX, sY, current1, 0, 0, 0, tocolor(255,255,255,v.MulBlend*255) )
		dxDrawImage( 0, 0, sX, sY, current2, 0, 0, 0, tocolor(255,255,255,v.BloomBlend*255) )

		-- Draw border texture
		dxDrawImage( 0, 0, sX, sY, textureVignette, 0, 0, 0, tocolor(255,255,255,v.Vignette*255) )

		-- Debug stuff
		if v.PreviewEnable > 0.5 then
			DebugResults.drawItems ( v.PreviewSize, v.PreviewPosX, v.PreviewPosY )
		end
    end
)


----------------------------------------------------------------
-- post process items
----------------------------------------------------------------

function applyBloomCombine( src, base, sBloomIntensity, sBloomSaturation, sBaseIntensity, sBaseSaturation )
	if not src or not base then return nil end
	local mx,my = dxGetMaterialSize( base )
	local newRT = RTPool.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT, true ) 
	dxSetShaderValue( bloomCombineShader, "sBloomTexture", src )
	dxSetShaderValue( bloomCombineShader, "sBaseTexture", base )
	dxSetShaderValue( bloomCombineShader, "sBloomIntensity", sBloomIntensity )
	dxSetShaderValue( bloomCombineShader, "sBloomSaturation", sBloomSaturation )
	dxSetShaderValue( bloomCombineShader, "sBaseIntensity", sBaseIntensity )
	dxSetShaderValue( bloomCombineShader, "sBaseSaturation", sBaseSaturation )
	dxDrawImage( 0, 0, mx,my, bloomCombineShader )
	DebugResults.addItem( newRT, "BloomCombine" )
	return newRT
end

function applyBloomExtract( src, sceneLuminance, sBloomThreshold )
	if not src or not sceneLuminance then return nil end
	local mx,my = dxGetMaterialSize( src )
	local newRT = RTPool.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT, true ) 
	dxSetShaderValue( bloomExtractShader, "sBaseTexture", src )
	dxSetShaderValue( bloomExtractShader, "sBloomThreshold", sBloomThreshold )
	dxSetShaderValue( bloomExtractShader, "sLumTexture", sceneLuminance )
	dxDrawImage( 0, 0, mx,my, bloomExtractShader )
	DebugResults.addItem( newRT, "BloomExtract" )
	return newRT
end

function applyContrast( src, Brightness, Contrast  )
	if not src then return nil end
	local mx,my = dxGetMaterialSize( src )
	local newRT = RTPool.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT )
	dxSetShaderValue( contrastShader, "sBaseTexture", src )
	dxSetShaderValue( contrastShader, "sBrightness", Brightness )
	dxSetShaderValue( contrastShader, "sContrast", Contrast )
	dxDrawImage( 0, 0, mx, my, contrastShader )
	DebugResults.addItem( newRT, "Contrast" )
	return newRT
end

function applyModulation( src, sceneLuminance, MultAmount, Mult, Add, ExtraFrom, ExtraTo, ExtraMult )
	if not src or not sceneLuminance then return nil end
	local mx,my = dxGetMaterialSize( src )
	local newRT = RTPool.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT )
	dxSetShaderValue( modulationShader, "sBaseTexture", src )
	dxSetShaderValue( modulationShader, "sMultAmount", MultAmount )
	dxSetShaderValue( modulationShader, "sMult", Mult )
	dxSetShaderValue( modulationShader, "sAdd", Add )
	dxSetShaderValue( modulationShader, "sLumTexture", sceneLuminance )
	dxSetShaderValue( modulationShader, "sExtraFrom", ExtraFrom )
	dxSetShaderValue( modulationShader, "sExtraTo", ExtraTo )
	dxSetShaderValue( modulationShader, "sExtraMult", ExtraMult )
	dxDrawImage( 0, 0, mx, my, modulationShader )
	DebugResults.addItem( newRT, "Modulation" )
	return newRT
end

function applyResize( src, tx, ty )
	if not src then return nil end
	local newRT = RTPool.GetUnused(tx, ty)
	if not newRT then return nil end
	dxSetRenderTarget( newRT )
	dxDrawImage( 0,  0, tx, ty, src )
	DebugResults.addItem( newRT, "Resize" )
	return newRT
end

function applyDownsampleSteps( src, steps )
	if not src then return nil end
	for i=1,steps do
		src = applyDownsample ( src )
	end
	return src
end

function applyDownsample( src )
	if not src then return nil end
	local mx,my = dxGetMaterialSize( src )
	mx = mx / 2
	my = my / 2
	local newRT = RTPool.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT )
	dxDrawImage( 0, 0, mx, my, src )
	DebugResults.addItem( newRT, "Downsample" )
	return newRT
end

function applyGBlurH( src, bloom )
	if not src then return nil end
	local mx,my = dxGetMaterialSize( src )
	local newRT = RTPool.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT, true ) 
	dxSetShaderValue( blurHShader, "tex0", src )
	dxSetShaderValue( blurHShader, "tex0size", mx,my )
	dxSetShaderValue( blurHShader, "bloom", bloom )
	dxDrawImage( 0, 0, mx,my, blurHShader )
	DebugResults.addItem( newRT, "GBlurH" )
	return newRT
end

function applyGBlurV( src, bloom )
	if not src then return nil end
	local mx,my = dxGetMaterialSize( src )
	local newRT = RTPool.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT, true ) 
	dxSetShaderValue( blurVShader, "tex0", src )
	dxSetShaderValue( blurVShader, "tex0size", mx,my )
	dxSetShaderValue( blurVShader, "bloom", bloom )
	dxDrawImage( 0, 0, mx,my, blurVShader )
	DebugResults.addItem( newRT, "GBlurV" )
	return newRT
end


function updateLumSource( current, changeRate, changeAlpha )
	if not current then return nil end
	changeRate = changeRate or 50

	local mx,my = dxGetMaterialSize( current );

	local size = 1
	while ( size < mx / 2 or size < my / 2 ) do
		size = size * 2
	end

	current = applyResize( current, size, size )
	while ( size > 1 ) do
		size = size / 2
		current = applyDownsample( current, 2 )
	end

	if getTickCount() > nextLumSampleTime then
		nextLumSampleTime = getTickCount() + changeRate
		dxSetRenderTarget( lumTarget )
		dxDrawImage( 0,  0, 1, 1, current, 0,0,0, tocolor(255,255,255,changeAlpha) )
	end

	current = applyResize( lumTarget, 1, 1 )

	return lumTarget
end


----------------------------------------------------------------
-- Avoid errors messages when memory is low
----------------------------------------------------------------
_dxDrawImage = dxDrawImage
function xdxDrawImage(posX, posY, width, height, image, ... )
	if not image then return false end
	return _dxDrawImage( posX, posY, width, height, image, ... )
end

--
-- c_bloom.lua
--

local scx, scy = guiGetScreenSize()
local bEffectEnabledBloom = false

-----------------------------------------------------------------------------------
-- Le SettingsBloom
-----------------------------------------------------------------------------------
SettingsBloom = {}
SettingsBloom.var = {}
SettingsBloom.var.cutoff = 0.08
SettingsBloom.var.power = 1.88
SettingsBloom.var.bloom = 2.0
SettingsBloom.var.blendR = 204
SettingsBloom.var.blendG = 153
SettingsBloom.var.blendB = 130
SettingsBloom.var.blendA = 140


----------------------------------------------------------------
-- onClientResourceStart
----------------------------------------------------------------
addEventHandler( "onClientResourceStart", resourceRoot,
	function()
	-- Version check
		if getVersion ().sortable < "1.1.0" then
			outputChatBox( "Resource is not compatible with this client." )
			return
		end
	end
)

function toggleBloom(state)
	if state then
		if not myScreenSourceBloom then
			initBloom()
		end
		startBloom()
	else
		stopBloom()
	end
end

function initBloom()
	myScreenSourceBloom = dxCreateScreenSource( scx/2, scy/2 )
	blurHShaderBloom,tecName = dxCreateShader( ":DayZ/gui/graphics/bloom/blurH.fx" )
	outputDebugString( "blurHShaderBloom is using technique " .. tostring(tecName) )

	blurVShaderBloom,tecName = dxCreateShader( ":DayZ/gui/graphics/bloom/blurV.fx" )
	outputDebugString( "blurVShaderBloom is using technique " .. tostring(tecName) )
	
	brightPassShaderBloom,tecName = dxCreateShader( ":DayZ/gui/graphics/bloom/brightPass.fx" )
	outputDebugString( "brightPassShaderBloom is using technique " .. tostring(tecName) )

	addBlendShaderBloom,tecName = dxCreateShader( ":DayZ/gui/graphics/bloom/addBlend.fx" )
	outputDebugString( "addBlendShaderBloom is using technique " .. tostring(tecName) )

	-- Check everything is ok
	bAllValidBloom = myScreenSourceBloom and blurHShaderBloom and blurVShaderBloom and brightPassShaderBloom and addBlendShaderBloom
	if not bAllValidBloom then
		outputDebugString( "Could not create some things. Please use debugscript 3" )
	end
	bEffectEnabledBloom = true
end

function startBloom()
	if bEffectEnabledBloom then return end
	addEventHandler("onClientHUDRender",root,executeBlooming)
	bEffectEnabledBloom = true
end

function stopBloom()
	if not bEffectEnabledBloom then return end
	removeEventHandler("onClientHUDRender",root,executeBlooming)
	bEffectEnabledBloom = false
end


-----------------------------------------------------------------------------------
-- onClientHUDRender
-----------------------------------------------------------------------------------
function executeBlooming()
	if not SettingsBloom.var then
		return
	end
	if bAllValidBloom then
		-- Reset render target pool
		RTPoolBloom.frameStart()
		-- Update screen
		dxUpdateScreenSource( myScreenSourceBloom )
		-- Start with screen
		local currentBloom = myScreenSourceBloom
		-- Apply all the effects, bouncing from one render target to another
		currentBloom = applyBrightPassBloom( currentBloom, SettingsBloom.var.cutoff, SettingsBloom.var.power )
		currentBloom = applyDownsampleBloom( currentBloom )
		currentBloom = applyDownsampleBloom( currentBloom )
		currentBloom = applyGBlurHBloom( currentBloom, SettingsBloom.var.bloom )
		currentBloom = applyGBlurVBloom( currentBloom, SettingsBloom.var.bloom )
		-- When we're done, turn the render target back to default
		dxSetRenderTarget()
		-- Mix result onto the screen using 'add' rather than 'alpha blend'
		if currentBloom then
			dxSetShaderValue( addBlendShaderBloom, "TEX0", currentBloom )
			local col = tocolor(SettingsBloom.var.blendR, SettingsBloom.var.blendG, SettingsBloom.var.blendB, SettingsBloom.var.blendA)
			dxDrawImage( 0, 0, scx, scy, addBlendShaderBloom, 0,0,0, col )
		end
	end
end


-----------------------------------------------------------------------------------
-- Apply the different stages
-----------------------------------------------------------------------------------
function applyDownsampleBloom( Src, amount )
	if not Src then return nil end
	amount = amount or 2
	local mx,my = dxGetMaterialSize( Src )
	mx = mx / amount
	my = my / amount
	local newRT = RTPoolBloom.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT )
	dxDrawImage( 0, 0, mx, my, Src )
	return newRT
end

function applyGBlurHBloom( Src, bloom )
	if not Src then return nil end
	local mx,my = dxGetMaterialSize( Src )
	local newRT = RTPoolBloom.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT, true ) 
	dxSetShaderValue( blurHShaderBloom, "TEX0", Src )
	dxSetShaderValue( blurHShaderBloom, "TEX0SIZE", mx,my )
	dxSetShaderValue( blurHShaderBloom, "BLOOM", bloom )
	dxDrawImage( 0, 0, mx, my, blurHShaderBloom )
	return newRT
end

function applyGBlurVBloom( Src, bloom )
	if not Src then return nil end
	local mx,my = dxGetMaterialSize( Src )
	local newRT = RTPoolBloom.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT, true ) 
	dxSetShaderValue( blurVShaderBloom, "TEX0", Src )
	dxSetShaderValue( blurVShaderBloom, "TEX0SIZE", mx,my )
	dxSetShaderValue( blurVShaderBloom, "BLOOM", bloom )
	dxDrawImage( 0, 0, mx,my, blurVShaderBloom )
	return newRT
end

function applyBrightPassBloom( Src, cutoff, power )
	if not Src then return nil end
	local mx,my = dxGetMaterialSize( Src )
	local newRT = RTPoolBloom.GetUnused(mx,my)
	if not newRT then return nil end
	dxSetRenderTarget( newRT, true ) 
	dxSetShaderValue( brightPassShaderBloom, "TEX0", Src )
	dxSetShaderValue( brightPassShaderBloom, "CUTOFF", cutoff )
	dxSetShaderValue( brightPassShaderBloom, "POWER", power )
	dxDrawImage( 0, 0, mx,my, brightPassShaderBloom )
	return newRT
end


-----------------------------------------------------------------------------------
-- Pool of render targets
-----------------------------------------------------------------------------------
RTPoolBloom = {}
RTPoolBloom.list = {}

function RTPoolBloom.frameStart()
	for rt,info in pairs(RTPoolBloom.list) do
		info.bInUse = false
	end
end

function RTPoolBloom.GetUnused( mx, my )
	-- Find unused existing
	for rt,info in pairs(RTPoolBloom.list) do
		if not info.bInUse and info.mx == mx and info.my == my then
			info.bInUse = true
			return rt
		end
	end
	-- Add new
	local rt = dxCreateRenderTarget( mx, my )
	if rt then
		outputDebugString( "creating new RT " .. tostring(mx) .. " x " .. tostring(mx) )
		RTPoolBloom.list[rt] = { bInUse = true, mx = mx, my = my }
	end
	return rt
end

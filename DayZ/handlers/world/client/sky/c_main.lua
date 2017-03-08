----------------------------------------------------------------
-- resource: Shader Dynamic SKY v2.11 
-- author: Ren712
-- contact: knoblauch700@o2.pl
----------------------------------------------------------------

----------------------------------------------------------------
-- settings
----------------------------------------------------------------
local dynamicSkySettings = {
		modelID = 15057,  -- model id to replace
		sunPreRotation = {25, 0, 0}, -- roll -- pitch ( time) -- yaw
		moonPreRotation = {0, 0, 0}, -- roll -- pitch ( time) -- yaw
		moonShine = 1, -- moon 'shine through clouds' multiplier
		modelScale = {0.125, 0.125, 0.125}, -- skydome scale
		bottomCloudSpread = 700, -- range in which the bottom clouds will appear (after camera.z reaches farClipDistance)
		enableIngameClouds = false, -- enable GTA clouds
		enableCloudTextures = false, -- enable smog/clouds textures
		enableHorizonBlending = true, -- should the sky gradually blend with horizon color
		stratosFade = {14000, 10000}, -- fake stratospheare effect
	}

-- Do not touch
local shaderTable = {}
local textureTable = {}
local modelTable = {}
local tempParam = {}
local moonPhase = 0

----------------------------------------------------------------
-- resource start/stop
----------------------------------------------------------------
function startDynamicSky()
	if dsEffectEnabled then return end
	
	shaderTable.skyboxTropos = dxCreateShader ( ":DayZ/handlers/world/client/sky/fx/shader_dynamicSky2tropos.fx", 2, 0, false, "object" )
	shaderTable.skyboxStratos = dxCreateShader ( ":DayZ/handlers/world/client/sky/fx/shader_dynamicSky2stratos.fx", 2, 0, false, "object" )
	shaderTable.skyboxBottom = dxCreateShader ( ":DayZ/handlers/world/client/sky/fx/shader_dynamicSky2bottom.fx", 3, 0, false, "object" )
	shaderTable.clear = dxCreateShader ( ":DayZ/handlers/world/client/sky/fx/shader_clear.fx", 3, 0, false, "world" )
	textureTable.cloud = dxCreateTexture ( ":DayZ/handlers/world/client/sky/tex/clouds.dds", "dxt5" )
	textureTable.cloudrain = dxCreateTexture(":DayZ/handlers/world/client/sky/tex/clouds_rain.dds", "dxt5")
	textureTable.cloudstorm = dxCreateTexture(":DayZ/handlers/world/client/sky/tex/clouds_storm.dds", "dxt5")
	textureTable.cloudcloudy = dxCreateTexture(":DayZ/handlers/world/client/sky/tex/clouds_cloudy.dds", "dxt5")
	textureTable.normal = dxCreateTexture ( ":DayZ/handlers/world/client/sky/tex/clouds_normal.jpg", "dxt5" ) 
	textureTable.cloudnight = dxCreateTexture(":DayZ/handlers/world/client/sky/tex/clouds_night.dds", "dxt5")
	textureTable.skybox = dxCreateTexture ( ":DayZ/handlers/world/client/sky/tex/skybox.dds", "dxt5" )
	moonPhase = getCurrentMoonPhase()
	textureTable.moon = dxCreateTexture ( ":DayZ/handlers/world/client/sky/tex/moon/"..toint( 20 - toint( moonPhase * 20 ) )..".png" )
	
	-- Get list of all elements used
	effectParts = {
						textureTable.cloud,
						textureTable.cloudrain,
						textureTable.normal,
						textureTable.skybox,
						textureTable.moon,
						shaderTable.skyboxTropos,
						shaderTable.skyboxStratos,
						shaderTable.skyboxBottom,
						shaderTable.clear
					}

	-- Check list of all elements used
	bAllValid = true
	for _,part in ipairs(effectParts) do
		bAllValid = part and bAllValid
	end
	if not bAllValid then 
		outputChatBox('Dynamic Sky v2: failed to start shaders!',255,0,0)
		return
	end

	dxSetShaderValue ( shaderTable.skyboxTropos, "gAlphaMult", 1 )
	dxSetShaderValue ( shaderTable.skyboxTropos, "gHorizonBlending", dynamicSkySettings.enableHorizonBlending )
	dxSetShaderValue ( shaderTable.skyboxTropos, "sClouds", textureTable.cloud )
	dxSetShaderValue ( shaderTable.skyboxTropos, "sNormal", textureTable.normal ) 
	dxSetShaderValue ( shaderTable.skyboxTropos, "sCubeTex", textureTable.skybox )
	dxSetShaderValue ( shaderTable.skyboxTropos, "sMoon", textureTable.moon )
	dxSetShaderValue ( shaderTable.skyboxTropos, "gStratosFade", dynamicSkySettings.stratosFade )
	dxSetShaderValue ( shaderTable.skyboxTropos, "gScale", dynamicSkySettings.modelScale )
	dxSetShaderValue ( shaderTable.skyboxTropos, "gBottCloudSpread", dynamicSkySettings.bottomCloudSpread )
	
	dxSetShaderValue ( shaderTable.skyboxStratos, "gAlphaMult", 1 )
	dxSetShaderValue ( shaderTable.skyboxStratos, "gHorizonBlending", dynamicSkySettings.enableHorizonBlending )
	dxSetShaderValue ( shaderTable.skyboxStratos, "sCubeTex", textureTable.skybox )
	dxSetShaderValue ( shaderTable.skyboxStratos, "sMoon", textureTable.moon )
	dxSetShaderValue ( shaderTable.skyboxStratos, "gStratosFade", dynamicSkySettings.stratosFade )
	dxSetShaderValue ( shaderTable.skyboxStratos, "gScale", dynamicSkySettings.modelScale )
	dxSetShaderValue ( shaderTable.skyboxStratos, "gBottCloudSpread", dynamicSkySettings.bottomCloudSpread )
	
	dxSetShaderValue ( shaderTable.skyboxBottom, "gAlphaMult", 1 )
	dxSetShaderValue ( shaderTable.skyboxBottom, "gHorizonBlending", dynamicSkySettings.enableHorizonBlending )	
	dxSetShaderValue ( shaderTable.skyboxBottom, "sClouds", textureTable.cloud )
	dxSetShaderValue ( shaderTable.skyboxBottom, "gStratosFade", dynamicSkySettings.stratosFade[1],dynamicSkySettings.stratosFade[2])
	dxSetShaderValue ( shaderTable.skyboxBottom, "gScale", dynamicSkySettings.modelScale )	
	dxSetShaderValue ( shaderTable.skyboxBottom, "gBottCloudSpread", dynamicSkySettings.bottomCloudSpread )
	
	engineApplyShaderToWorldTexture ( shaderTable.skyboxStratos	, "skybox_tex" )
	engineApplyShaderToWorldTexture ( shaderTable.skyboxBottom, "skybox_tex_bottom" ) 
	engineApplyShaderToWorldTexture ( shaderTable.clear, "coronamoon" )

		
	if not dynamicSkySettings.enableCloudTextures then
		engineApplyShaderToWorldTexture ( shaderTable.clear, "cloudmasked" )	
	end

	tempParam[1] = getSunSize()
	tempParam[2] = getMoonSize()
	tempParam[3] = getCloudsEnabled()
	setSunSize( 0 )
	setMoonSize( 0 )
    setCloudsEnabled( dynamicSkySettings.enableIngameClouds )
	
	modelTable.txd = engineLoadTXD( ':DayZ/handlers/world/client/sky/tex/skybox_model.txd' )
	engineImportTXD( modelTable.txd, dynamicSkySettings.modelID)
	modelTable.dff = engineLoadDFF( ':DayZ/handlers/world/client/sky/dff/skybox_model.dff', dynamicSkySettings.modelID )
	engineReplaceModel( modelTable.dff, dynamicSkySettings.modelID, true )  

	local camX, camY, camZ = getElementPosition( getLocalPlayer() )
	modelTable.object = createObject ( dynamicSkySettings.modelID, camX, camY, camZ, 0, 0, 0, true )
	setObjectScale( modelTable.object, 8, 8, 8)
	setElementAlpha( modelTable.object, 1 )

	addEventHandler ( "onClientPreRender", getRootElement (), renderSphere ) -- sphere
	addEventHandler ( "onClientPreRender", getRootElement (), renderTime ) -- time
	shaderTable.isSwitched = false
	addEventHandler ( "onClientPreRender", getRootElement (), switchShaders ) -- change shaders
	dsEffectEnabled = true
end

function stopDynamicSky()
	if not dsEffectEnabled then return end
	removeEventHandler ( "onClientPreRender", getRootElement (), renderSphere ) -- sphere
	removeEventHandler ( "onClientPreRender", getRootElement (), renderTime ) -- time
	removeEventHandler ( "onClientPreRender", getRootElement (), switchShaders ) -- change shaders
	
	if isElement(shaderTable.skyboxBottom) then
		engineRemoveShaderFromWorldTexture( shaderTable.skyboxBottom, "skybox_tex_bottom" )
	end
	if isElement(shaderTable.skyboxStratos) then
		engineRemoveShaderFromWorldTexture( shaderTable.skyboxStratos, "skybox_tex" )
	end
	if isElement(shaderTable.skyboxTropos) then
		engineRemoveShaderFromWorldTexture( shaderTable.skyboxTropos, "skybox_tex" )
	end
	if isElement(shaderTable.clear) then
		engineRemoveShaderFromWorldTexture( shaderTable.clear, "*" )
	end	
	
	for _,part in ipairs(effectParts) do
		destroyElement(part)
	end
	
	destroyElement( modelTable.object )
	modelTable.object = nil
	engineRestoreModel( dynamicSkySettings.modelID )
	destroyElement( modelTable.txd )
	destroyElement( modelTable.dff )
	modelTable.txd = nil
	modelTable.dff = nil
	dsEffectEnabled = false
	setSunSize( tempParam[1] )
	setMoonSize( tempParam[2] )
	setCloudsEnabled( tempParam[3] )	
end

function switchShaders()
	if dsEffectEnabled then 
		local camX, camY, camZ = getCameraMatrix()
		if camZ > dynamicSkySettings.stratosFade[2] then
			if shaderTable.isSwitched then
				engineRemoveShaderFromWorldTexture( shaderTable.skyboxTropos, "skybox_tex" )
				engineApplyShaderToWorldTexture ( shaderTable.skyboxStratos	, "skybox_tex" )
				shaderTable.isSwitched = false
			end
		else
			if not shaderTable.isSwitched then
				engineRemoveShaderFromWorldTexture( shaderTable.skyboxStratos, "skybox_tex" )
				engineApplyShaderToWorldTexture ( shaderTable.skyboxTropos, "skybox_tex" )
				shaderTable.isSwitched = true
			end
		end
	end
end

----------------------------------------------------------------
-- onClientPreRender
----------------------------------------------------------------
local isEnteringVeh = false

function renderSphere()
	if dsEffectEnabled then
		-- Set the skybox model position accordingly to the camera position
		local camX, camY, camZ = getCameraMatrix()
		setElementPosition ( modelTable.object, camX, camY, camZ ,false )
	end
end


local oldWeather = -1 
local windVelocity = {{1,0.1},{3,0.2},{4,0.25},{5, 0.15},{7,0.6},{ 10,0.05},{12, 0.25}, { 14,0.06},{15, 0.34},{18, 0.1}}
local removeWeather = {19,30,31,32,118}
local alphaInWater = 1
local alpha_normal = 1
local alpha_rain = 0

function renderTime()
	if not dsEffectEnabled then return end
	local ho,mi,se = getTimeHMS()
	local timeAspect = ((( ho * 60 ) + mi ) + ( se / 60 )) / 1440
			
	dxSetShaderValue ( shaderTable.skyboxTropos, "gRotate", math.rad(dynamicSkySettings.sunPreRotation[1]), math.rad(( timeAspect * 360 ) + 
			dynamicSkySettings.sunPreRotation[2]), math.rad(dynamicSkySettings.sunPreRotation[3] ))
	dxSetShaderValue ( shaderTable.skyboxStratos, "gRotate", math.rad(dynamicSkySettings.sunPreRotation[1]), math.rad(( timeAspect * 360 ) + 
			dynamicSkySettings.sunPreRotation[2]), math.rad(dynamicSkySettings.sunPreRotation[3] ))

	dxSetShaderValue ( shaderTable.skyboxTropos, "mRotate", math.rad(dynamicSkySettings.sunPreRotation[1] + dynamicSkySettings.moonPreRotation[1]), math.rad((( moonPhase + timeAspect ) * 360) + 
			dynamicSkySettings.sunPreRotation[2] + dynamicSkySettings.moonPreRotation[2]), math.rad(dynamicSkySettings.sunPreRotation[3] + dynamicSkySettings.moonPreRotation[3]))
	dxSetShaderValue ( shaderTable.skyboxStratos, "mRotate", math.rad(dynamicSkySettings.sunPreRotation[1] + dynamicSkySettings.moonPreRotation[1]), math.rad((( moonPhase + timeAspect ) * 360) + 
			dynamicSkySettings.sunPreRotation[2] + dynamicSkySettings.moonPreRotation[2]), math.rad(dynamicSkySettings.sunPreRotation[3] + dynamicSkySettings.moonPreRotation[3]))

	dxSetShaderValue ( shaderTable.skyboxTropos, "mMoonLightInt", math.sin( math.pi * moonPhase ) * dynamicSkySettings.moonShine )
	dxSetShaderValue ( shaderTable.skyboxStratos, "mMoonLightInt", math.sin( math.pi * moonPhase ) * dynamicSkySettings.moonShine )
	
	local camX, camY, camZ = getCameraMatrix()
	local watLvl = getWaterLevel(camX, camY, camZ)
	if watLvl then
		if (camZ - 0.65 < watLvl ) then
			dxSetShaderValue ( shaderTable.skyboxTropos, "gIsInWater", true )
			dxSetShaderValue ( shaderTable.skyboxBottom, "gIsInWater", true ) 
			dxSetShaderValue ( shaderTable.skyboxStratos, "gIsInWater", true )
		end
	end
	if not watLvl or (camZ - 0.65 > watLvl ) then
		dxSetShaderValue ( shaderTable.skyboxTropos, "gIsInWater", false )
		dxSetShaderValue ( shaderTable.skyboxBottom, "gIsInWater", false ) 
		dxSetShaderValue ( shaderTable.skyboxStratos, "gIsInWater", false )
	end
	
	local thisWeather = getWeather()
	for index, nr in ipairs(removeWeather) do
		if thisWeather==nr then 
			dxSetShaderValue ( shaderTable.skyboxTropos, "gAlphaMult", 0 )
			dxSetShaderValue ( shaderTable.skyboxBottom, "gAlphaMult", 0 ) 
			dxSetShaderValue ( shaderTable.skyboxStratos, "gAlphaMult", 0 ) 
		end
	end
	local hours,minutes = getTime()
	if hours == 21 or hours == 22 or hours == 23 or hours == 0 or hours == 1 or hours == 2 or hours == 3 or hours == 4 then
		dxSetShaderValue ( shaderTable.skyboxTropos, "sClouds", textureTable.cloudnight )
	else
		if thisWeather == 8 then
			dxSetShaderValue ( shaderTable.skyboxTropos, "sClouds", textureTable.cloudstorm )
		elseif thisWeather == 16 then
			dxSetShaderValue ( shaderTable.skyboxTropos, "sClouds", textureTable.cloudrain )
		elseif thisWeather == 9 or thisWeather == 4 or thisWeather == 7 or thisWeather == 12 or thisWeather == 15 then
			dxSetShaderValue ( shaderTable.skyboxTropos, "sClouds", textureTable.cloudcloudy)
		else
			dxSetShaderValue ( shaderTable.skyboxTropos, "sClouds", textureTable.cloud)
		end
	end
	
	if (thisWeather~=oldWeather) then
		local windVelocityValue = 0.00
		for index, value in ipairs(windVelocity) do
			if value[1]==thisWeather then windVelocityValue = value[2] end
		end
		dxSetShaderValue ( shaderTable.skyboxTropos, "gCloudSpeed", 0.15 * windVelocityValue )
		dxSetShaderValue ( shaderTable.skyboxBottom, "gCloudSpeed", 0.15 * windVelocityValue )
	end
	local r1,g1,b1,r2,g2,b2 = getSunColor()
	dxSetShaderValue ( shaderTable.skyboxTropos, "gSunColor", r1/255, g1/255, b1/255, r2/255, g2/255, b2/255 )
	dxSetShaderValue ( shaderTable.skyboxStratos, "gSunColor", r1/255, g1/255, b1/255, r2/255, g2/255, b2/255 )
	
	if ( ho==0 and mi==0 and se==0 ) then
		dawn_aspect = 0.001
	end
	if ho <= 6 and not ( ho==0 and se==0 and mi==0 ) then
		dawn_aspect =(( ho * 60 + mi + se/60 )) / 360
	end
	
	if ho > 6 and ho < 20 then
		dawn_aspect = 1
	end
 
	if ho >=20  then
		dawn_aspect = -6 * (((( ho - 20 ) * 60 ) + mi + se/60 ) / 1440 ) + 1
	end
	
	--dxSetShaderValue ( shaderTable.skyboxTropos, "gDayTime", dawn_aspect )
	dxSetShaderValue ( shaderTable.skyboxBottom, "gDayTime", dawn_aspect )
	dxSetShaderValue ( shaderTable.skyboxStratos, "gDayTime", dawn_aspect )
	oldWeather = thisWeather
end

function getPositionFromMatrixOffset(m, x, y, z)
	return (x * m[1][1] + y * m[2][1] + z * m[3][1] + m[4][1]), (x * m[1][2] + y * m[2][2] + z * m[3][2] + m[4][2]),
		(x * m[1][3] + y * m[2][3] + z * m[3][3] + m[4][3])
end

function getTimeAspect()
	local ho,mi,se = getTimeHMS()
	return ((( ho * 60 ) + mi ) + ( se / 60 )) / 1440
end
----------------------------------------------------------------
-- getTimeHMS
--		Returns game time including seconds
----------------------------------------------------------------
local timeHMS = {0,0,0}
local minuteStartTickCount
local minuteEndTickCount

function getTimeHMS()
	return unpack(timeHMS)
end

addEventHandler( "onClientPreRender", root,
	function ()
		if not dsEffectEnabled then return end
		local h, m = getTime ()
		local s = 0
		if m ~= timeHMS[2] then
			minuteStartTickCount = getTickCount ()
			local gameSpeed = math.clamp( 0.01, getGameSpeed(), 10 )
			minuteEndTickCount = minuteStartTickCount + 1000 / gameSpeed
		end
		if minuteStartTickCount then
			local minFraction = math.unlerpclamped( minuteStartTickCount, getTickCount(), minuteEndTickCount )
			s = math.min ( 59, math.floor ( minFraction * 60 ) )
		end
		timeHMS = {h, m, s}
	end
)

----------------------------------------------------------------
-- Math helper functions
----------------------------------------------------------------
function math.lerp(from,alpha,to)
    return from + (to-from) * alpha
end

function math.unlerp(from,pos,to)
	if ( to == from ) then
		return 1
	end
	return ( pos - from ) / ( to - from )
end

function math.clamp(low,value,high)
    return math.max(low,math.min(value,high))
end

function math.unlerpclamped(from,pos,to)
	return math.clamp(0,math.unlerp(from,pos,to),1)
end

----------------------------------------------------------------
-- other
----------------------------------------------------------------
function vCardPSVer()
	local smVersion = tostring(dxGetStatus().VideoCardPSVersion)
	outputDebugString("VideoCardPSVersion: "..smVersion)
	return smVersion
end

function getNormalAngle(rotation)
	return math.mod( rotation, 360 )
end


----------------------------------------------------------------
-- exports
----------------------------------------------------------------
function getDynamicSunVector()
	local vecX, vecY, vecZ = eulerToVectorXY(math.rad(getNormalAngle(dynamicSkySettings.sunPreRotation[1])), math.rad(getNormalAngle(( getTimeAspect() * 360 ) + 
	dynamicSkySettings.sunPreRotation[2])), math.rad(getNormalAngle(dynamicSkySettings.sunPreRotation[3])))
	return vecX, vecY, vecZ
end

function getDynamicMoonVector()
	local vecX, vecY, vecZ = eulerToVectorXY(math.rad(getNormalAngle(dynamicSkySettings.sunPreRotation[1] + dynamicSkySettings.moonPreRotation[1])), math.rad(getNormalAngle(((getTimeAspect() + moonPhase) * 360 ) + 
	dynamicSkySettings.sunPreRotation[2] + dynamicSkySettings.moonPreRotation[2])), math.rad(getNormalAngle(dynamicSkySettings.sunPreRotation[3] + dynamicSkySettings.moonPreRotation[3])))
	return vecX, vecY, vecZ
end

function getMoonPhaseValue()
	return moonPhase
end

function isDynamicSkyEnabled()
	return dsEffectEnabled
end
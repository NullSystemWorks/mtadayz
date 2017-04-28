--
--c_shader_light.lua
-- 

local isLightOn = false
-- don't mess with the shader tables
local light_shader = {}
local flashlight = {}
local shader_jaroovka = {}
local shader_rays = {}
local isFlon = {}  -- a list of players with fl turned on (for client)

local switch_key = 'b' -- define the key that switches the light effect

local lightColor = {1,1,0.7,0.7} -- rgba color of the projected light, light rays and the lightbulb
local effectRange = 60 -- effect max distance 120
local DistFade = {110, 80, 49, 1} -- [0]MaxEffectFade,[1]MinEffectFade,[2]MaxFlashFade,[3]MinFlashFade
--local objID = 15060  -- the object we are going to replace (interior building shadow in this case)
local objID = 346
local flashlightTexture
local flashlightModel
local theTikGap = 1000 -- here you set how many seconds to wait after switching the flashlight on/off
local getLastTick = getTickCount ( )
local isLightDir=true -- the vertexes oposite to the lightsource will NOT be affected
local lightDirAcc = 0.2 -- the accuracy of the above (0.01-1)

local textureCube= dxCreateTexture ( ":DayZ/handlers/players/client/flashlight/textures/cubebox.dds")

--This part might be useful for some.
--local i_hate_grass = dxCreateShader ( "shaders/shader_null.fx" )
--engineApplyShaderToWorldTexture ( i_hate_grass, "txgrass0*" )

---------------------------------------------------------------------------------------------------
local removeList = {
						"",												-- unnamed
						"basketball2","skybox_tex", "drvin_screen",		-- other
						"flashlight*","crackedground*",					-- other
						"roughcornerstone*",     						-- other
						"muzzle_texture*",								-- gunshots
						"font*","radar*",								-- hud
						"*headlight*",	 								-- vehicles
						"*shad*",										-- shadows
						"coronastar","coronamoon","coronaringa",		-- coronas
						"lunar",										-- moon
						"tx*",											-- grass effect
						"lod*",											-- lod models
						"cj_w_grad",									-- checkpoint texture
						"*cloud*",										-- clouds
						"*smoke*",										-- smoke
						"sphere_cj",									-- nitro heat haze mask
						"particle*",									-- particle skid and maybe others
						"water*","sw_sand", "coral",					-- sea
						"boatwake*","splash_up","carsplash_*",			-- splash
						"gensplash","wjet4","bubbles",					-- splash
						"blood*",										-- blood
						"siteM16",

					}

---------------------------------------------------------------------------------------------------
--Updates light positions and rotation of the light direction
function renderLight()
for index,thisPed in ipairs(getElementsByType("player")) do
	if light_shader[thisPed] and isElementStreamedIn(thisPed) then
		xx1, yy1, zz1, lxx1, lyy1, lzz1,rl = getCameraMatrix()
		x1, y1, z1 = getPedBonePosition ( thisPed, 24 )
		lx1, ly1, lz1 = getPedBonePosition ( thisPed, 25 )

		local yaw = math.atan2(lx1-x1,ly1-y1) 
		local pitch = (math.atan2(lz1-z1, math.sqrt(((lx1-x1) * (lx1-x1)) + ((ly1-y1) * (ly1-y1))))) 
		local roll = 0
		local movx=xx1-x1 
		local movy=yy1-y1
		local movz=zz1-z1	   
		
		dxSetShaderValue ( light_shader[thisPed],"rotate",yaw,roll,pitch)	
		dxSetShaderValue(light_shader[thisPed],"alterPosition",movx,movy,movz)
		end											
	end
end

function createWorldLightShader(thisPed)
if light_shader[thisPed] then return false end
	light_shader[thisPed] = dxCreateShader ( ":DayZ/handlers/players/client/flashlight/shaders/shader_light.fx",1,effectRange,true,"world,object,vehicle,ped")
	if not light_shader[thisPed] then return false end
	dxSetShaderValue ( light_shader[thisPed],"sCubeTexture", textureCube )
	dxSetShaderValue ( light_shader[thisPed],"isLightDir", isLightDir )
	dxSetShaderValue ( light_shader[thisPed],"isFakeBump", false ) --- see what it does
	dxSetShaderValue ( light_shader[thisPed],"lightColor",lightColor)
	dxSetShaderValue ( light_shader[thisPed],"lightDirAcc", lightDirAcc )
	dxSetShaderValue ( light_shader[thisPed],"DistFade",DistFade)
	engineApplyShaderToWorldTexture ( light_shader[thisPed], "*" )

	-- remove light effect from the texture list
	for _,removeMatch in ipairs(removeList) do
		engineRemoveShaderFromWorldTexture ( light_shader[thisPed], removeMatch )	
	end	
	return true		
end

function destroyWorldLightShader(thisPed)
	if light_shader[thisPed] then
		engineRemoveShaderFromWorldTexture ( light_shader[thisPed], "*" )
		destroyElement ( light_shader[thisPed] )
		light_shader[thisPed]=nil
		dxSetShaderValue(shader_jaroovka[thisPed],"isFLon",false)						
		dxSetShaderValue(shader_rays[thisPed],"isFRon",false)
		return true
	else
		return false
	end
end

---------------------------------------------------------------------------------------------------

function createFlashLightShader(thisPed)
	if not shader_jaroovka[thisPed] then
		shader_jaroovka[thisPed]=dxCreateShader(":DayZ/handlers/players/client/flashlight/shaders/shader_jaroovka.fx",0,0,false)
		shader_rays[thisPed]=dxCreateShader(":DayZ/handlers/players/client/flashlight/shaders/flash_light_rays.fx",0,0,false)
		if not shader_jaroovka[thisPed] or not shader_rays[thisPed] then
			outputChatBox( "Could not create shader. Please use debugscript 3" )
		end		
		engineApplyShaderToWorldTexture ( shader_jaroovka[thisPed],"flashlight_L", flashlight[thisPed] )
		engineApplyShaderToWorldTexture ( shader_rays[thisPed], "flashlight_R", flashlight[thisPed] )	
		dxSetShaderValue (shader_jaroovka[thisPed],"isFLon",false)						
		dxSetShaderValue (shader_rays[thisPed],"isFRon",false)
		dxSetShaderValue (shader_jaroovka[thisPed],"lightColor",lightColor)
		dxSetShaderValue (shader_rays[thisPed],"lightColor",lightColor)	
	end
end

function destroyFlashLightShader(thisPed)
	if shader_jaroovka[thisPed] or shader_rays[thisPed] then
		dxSetShaderValue (shader_jaroovka[thisPed],"isFLon",false)
		dxSetShaderValue (shader_rays[thisPed],"isFRon",false)	
		destroyElement(shader_jaroovka[thisPed])
		destroyElement(shader_rays[thisPed])
		shader_jaroovka[thisPed]=nil
		shader_rays[thisPed]=nil
	end
end

---------------------------------------------------------------------------------------------------

function flashLightEnable(isEN,this_player)
if isEN==true then
	if not flashlight[this_player] then  
		createFlashLightShader(this_player)
		end
	else
		if flashlight[this_player] then
			destroyFlashLightShader(this_player)
		end
	end
end

function playSwitchSound(this_player)
	pos_x,pos_y,pos_z=getElementPosition (this_player)
	local flSound = playSound3D(":DayZ/handlers/players/client/flashlight/sounds/switch.wav", pos_x, pos_y, pos_z, false) 
	setSoundMaxDistance(flSound,3)
	setSoundVolume(flSound,0.6)
end


function flashLightSwitch(isON,this_player)
	if isON then
		if not light_shader[this_player] then 
			playSwitchSound(this_player)
			isFlon[this_player]=true
			createWorldLightShader(this_player) 
			dxSetShaderValue(shader_jaroovka[this_player],"isFLon",true)						
			dxSetShaderValue (shader_rays[this_player],"isFRon",true) 
		end

	else
		if light_shader[this_player] then 
			playSwitchSound(this_player)
			isFlon[this_player]=false
			destroyWorldLightShader(this_player) 	
			dxSetShaderValue(shader_jaroovka[this_player],"isFLon",false)						
			dxSetShaderValue (shader_rays[this_player],"isFRon",false) 
		end
	end
end

function whenPlayerQuits(this_player)
	destroyWorldLightShader(this_player) 
	--destroyFlashlightModel(this_player) 
	destroyFlashLightShader(this_player)  
end


function streamInAndOut()
	for index,this_player in ipairs(getElementsByType("player")) do
		local sPlayerNickname = getPlayerName (this_player)
		if isElementStreamedIn(this_player) and not light_shader[this_player] and isFlon[this_player]==true then 
			createWorldLightShader(this_player) 
			dxSetShaderValue(shader_jaroovka[this_player],"isFLon",true)						
			dxSetShaderValue (shader_rays[this_player],"isFRon",true) 
			--outputChatBox('Streaming in a light bearer: '..sPlayerNickname)  
		end
		if not isElementStreamedIn(this_player) and light_shader[this_player] and isFlon[this_player]==true then 
			destroyWorldLightShader(this_player) 
			dxSetShaderValue(shader_jaroovka[this_player],"isFLon",false)						
			dxSetShaderValue (shader_rays[this_player],"isFRon",false) 
			--outputChatBox('Streaming out a light bearer: '..sPlayerNickname)  
		end
	end
end

-- switch on or off
function toggleLight()
	if getPedWeaponSlot(localPlayer) == 2 and getElementData(localPlayer,"currentweapon_2") == "Flashlight" then
		if ( ( getTickCount ( ) - getLastTick ) < theTikGap ) then 
			--outputChatBox ( 'Flashlight: Please wait ' .. ( theTikGap / 1000 ) .. ' second(s) before turning back on/off.', 255, 22, 22 ) 
			return 
		end
		isLightOn = not isLightOn
		triggerServerEvent ( "onSwitchLight", getLocalPlayer ( ), isLightOn )
		getLastTick = getTickCount ( )
	end
end

-- start or stop using flashlight
function toggleFlashLight()
	if flashlight[getLocalPlayer()] then 
		--outputChatBox('You have switched off the flashlight')
		triggerServerEvent("onSwitchLight",getLocalPlayer(),false)
		triggerServerEvent("onSwitchEffect",getLocalPlayer(),false)
		unbindKey(switch_key,"down",toggleLight)
	else
		triggerServerEvent("onSwitchLight",getLocalPlayer(),false)
		triggerServerEvent("onSwitchEffect",getLocalPlayer(),true)
		--outputChatBox('You have switched on the flashlight')
		bindKey(switch_key,"down",toggleLight)
	end
end


function turnFlashLightOffOnSwitch(previousSlot,currentSlot)
	if currentSlot ~= 2 then
		toggleFlashLight()
	end
end
addEventHandler("onClientPlayerWeaponSwitch",localPlayer,turnFlashLightOffOnSwitch)


---------------------------------------------------------------------------------------------------
started = false
function shaderResourceStart()
	local hour, minutes = getTime()
	--if hour > 7 and hour < 22 then started = false return end
	if started then return end
	started = true
	local ver = getVersion ().sortable
	local build = string.sub( ver, 9, 13 )
	if build<"04938" or ver < "1.3.1" then 
		outputChatBox('The resource is not compatible with this client version!')
		return
	end

	outputChatBox('Hit '..string.upper(switch_key)..' to turn the flashlight on/off', 255, 255, 255 );
	addEventHandler("onClientPreRender", root, renderLight)
	addEventHandler("onClientPreRender", root, streamInAndOut)
	triggerServerEvent("onPlayerStartRes",getLocalPlayer())
	toggleFlashLight()
end
setTimer(shaderResourceStart,1800000,0)

---------------------------------------------------------------------------------------------------

addEventHandler("onClientResourceStart", getResourceRootElement( getThisResource()), shaderResourceStart)

addEvent( "flashOnPlayerEnable", true )
addEvent( "flashOnPlayerQuit", true )
addEvent( "flashOnPlayerSwitch", true )
addEventHandler( "flashOnPlayerQuit", getResourceRootElement( getThisResource()), whenPlayerQuits)
addEventHandler( "flashOnPlayerSwitch", getResourceRootElement( getThisResource()), flashLightSwitch)
addEventHandler( "flashOnPlayerEnable", getResourceRootElement( getThisResource()), flashLightEnable)

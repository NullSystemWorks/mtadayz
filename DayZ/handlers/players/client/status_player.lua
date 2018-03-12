--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: status_player.lua						*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: CLIENT														*----
#-----------------------------------------------------------------------------#
]]

addEventHandler("onClientResourceStart", getResourceRootElement(),
	function()
		dayzVersion = "MTA:DayZ "..getDayZVersion()
		versionLabel  = guiCreateLabel(1,1,0.3,0.3,dayzVersion,true)
		guiSetSize ( versionLabel, guiLabelGetTextExtent ( versionLabel ), guiLabelGetFontHeight ( versionLabel ), false )
		x,y = guiGetSize(versionLabel,true)
		guiSetPosition( versionLabel, 1-x, 1-y*1.8, true )
		guiSetAlpha(versionLabel,0.5)
	end
)

setPedTargetingMarkerEnabled(false)

function stopPlayerVoices()
	for i, player in ipairs(getElementsByType("player")) do
		setPedVoice(player, "PED_TYPE_DISABLED")
	end
end
setTimer(stopPlayerVoices,1000,0)

function playerAddBloodFX(bloodLoss)
	local px,py,pz = getPedBonePosition(localPlayer,3)
	local pdistance = getDistanceBetweenPoints3D(x,y,z,px,py,pz)
	if bloodLoss >= 61 then
		number = 10
	elseif bloodLoss >= 31 and bloodLoss <= 60 then
		number = 6
	elseif bloodLoss >= 10 and bloodLoss <= 30 then
		number = 2
	else
		number = 0
	end
	if pdistance <= 120 then
		fxAddBlood (px,py,pz,0,0,0,number,1)
	end
end
addEvent("onClientPlayerAddBloodFX",true)
addEventHandler("onClientPlayerAddBloodFX",root,playerAddBloodFX)

function setPlayerDeath()
	if getElementData(localPlayer,"logedin") then
		if playerStatusTable[localPlayer]["blood"] <= 0 then
			if not getElementData(localPlayer,"isDead") then
				triggerServerEvent("killDayZPlayer",localPlayer,false,false)
			end
		end
	end
end
--setTimer(setPlayerDeath,1000,0)

function isPlayerInBuilding(x,y,z)
	if isInBuilding(x,y,z) then
		triggerServerEvent("onPlayerChangeStatus",source,"isInBuilding",true)
	else
		triggerServerEvent("onPlayerChangeStatus",source,"isInBuilding",false)
	end
end
addEvent("isPlayerInBuilding",true)
addEventHandler("isPlayerInBuilding",root,isPlayerInBuilding)

function createSneezeOnCold(x,y,z)
	createExplosion(x,y,z+15,8,false,0.5,false)
	local x, y, z, lx, ly, lz = getCameraMatrix()
	randomsound = math.random(0,99)
	if randomsound >= 0 and randomsound <= 10 then
		local getnumber = math.random(0,2)
		playSound(":DayZ/sounds/status/cough_"..getnumber..".ogg",false)
	elseif randomsound >= 11 and randomsound <= 20 then	
		playSound(":DayZ/sounds/status/sneezing.mp3",false)
	end
end
addEvent("onClientPlayerCreateSneezeShake",true)
addEventHandler("onClientPlayerCreateSneezeShake",root,createSneezeOnCold)


function setPlayerPain()
	if getElementData(localPlayer,"logedin") then
		if playerStatusTable[localPlayer]["pain"] ~= nil then
			if playerStatusTable[localPlayer]["pain"] then
				local x,y,z = getElementPosition(getLocalPlayer())
				createExplosion (x,y,z+15,8,false,1.0,false)
				local x, y, z, lx, ly, lz = getCameraMatrix() -- Get the current location and lookat of camera
				x, lx = x + 1, lx + 1 -- What will be the new x and x lookat values
				setCameraMatrix(x,y,z,lx,ly,lz) -- Set camera to new position
				setCameraTarget (getLocalPlayer())
			end
		end
	end
end
setTimer(setPlayerPain,3000,0)

function debugJump()
	if getPedControlState(localPlayer,"jump") then
		setElementData(localPlayer,"jumping",true)
		setTimer(debugJump2,650,1)
	end
end
setTimer(debugJump,100,0)

function debugJump2()
	setElementData(localPlayer,"jumping",false)
end

local SneakEnabled = false
function setPlayerSneakOnWalk()
	if getPedControlState(localPlayer,"walk") then
		if not SneakEnabled then
			triggerServerEvent("setPlayerSneak",localPlayer,69)
			SneakEnabled = true
		end
	else
		if SneakEnabled then
			triggerServerEvent("setPlayerSneak",localPlayer,54)
			SneakEnabled = false
		end
	end
end
setTimer(setPlayerSneakOnWalk,1000,0)

function updateDaysAliveTime()
	if getElementData(localPlayer,"logedin") then
		local daysalive = getElementData(localPlayer,"daysalive")
		setElementData(localPlayer,"daysalive",daysalive+1)
	end
end
--setTimer(updateDaysAliveTime,60000,0)

function updatePlayTime()
	if getElementData(localPlayer,"logedin") then
		local playtime = getElementData(localPlayer,"alivetime")
		setElementData(localPlayer,"alivetime",playtime+1)
	end	
end
--setTimer(updatePlayTime,60000,0)

--[[
function updateHoursAliveTime()
	if getElementData(localPlayer,"logedin") then
		local hourstime = getElementData(localPlayer,"hoursalive")
		setElementData(localPlayer,"hoursalive",hourstime+1)
	end	
end
setTimer(updateHoursAliveTime,3600000,0)
]]

-- Switch to serverside
function playerBloodInWater()
	if getElementData(localPlayer, "logedin") then
		local posX, posY, posZ = getElementPosition(localPlayer)
		if posZ <= -4 then
			if isElementInWater(localPlayer) then
				local pBlood = playerStatusTable[localPlayer]["blood"]
				setElementData(localPlayer,"blood", pBlood - gameplayVariables["waterdamage"])
				setElementData(localPlayer,"pain",true)
			end
		end
	end
end
--setTimer(playerBloodInWater,4000,0)

function onPlayerActionPlaySound(item)
	if item == "meat" then
		local number = math.random(0,1)
		playSound(":DayZ/sounds/items/cook_"..number..".ogg",false)
	elseif item == "water" then
		playSound(":DayZ/sounds/items/fillwater.ogg",false)
	elseif item == "tent" then
		playSound(":DayZ/sounds/items/tentunpack.ogg",false)
	elseif item == "repair" then
		playSound(":DayZ/sounds/items/repair.ogg",false)
	end
end
addEvent("onPlayerActionPlaySound",true)
addEventHandler("onPlayerActionPlaySound",root,onPlayerActionPlaySound)

local bloodTest = {}
local number = 0
local vialsLeft = 3
local handFont = guiCreateFont(":DayZ/fonts/needhelp.ttf",17)

bloodTest["testsheet"] = guiCreateStaticImage(0.13, 0.20, 0.71, 0.61, ":DayZ/gui/status/blood/bloodtest.png", true)
bloodTest["drop1"] = guiCreateStaticImage(0.162, 0.182, 0.13, 0.17, ":DayZ/gui/status/blood/drop.png", true, bloodTest["testsheet"])
guiSetProperty(bloodTest["drop1"], "ImageColours", "tl:FF86787C tr:FF86787C bl:FF86787C br:FF86787C")
bloodTest["drop2"] = guiCreateStaticImage(0.338, 0.182, 0.13, 0.17, ":DayZ/gui/status/blood/drop.png", true, bloodTest["testsheet"])
guiSetProperty(bloodTest["drop2"], "ImageColours", "tl:FF86787C tr:FF86787C bl:FF86787C br:FF86787C")
bloodTest["drop3"] = guiCreateStaticImage(0.512, 0.182, 0.13, 0.17, ":DayZ/gui/status/blood/drop.png", true, bloodTest["testsheet"])
guiSetProperty(bloodTest["drop3"], "ImageColours", "tl:FF86787C tr:FF86787C bl:FF86787C br:FF86787C")
bloodTest["drop4"] = guiCreateStaticImage(0.69, 0.182, 0.13, 0.17, ":DayZ/gui/status/blood/drop.png", true, bloodTest["testsheet"])
guiSetProperty(bloodTest["drop4"], "ImageColours", "tl:FF86787C tr:FF86787C bl:FF86787C br:FF86787C")
bloodTest["tested"] = guiCreateLabel(0.16, 0.45, 0.33, 0.09, getPlayerName(localPlayer), true, bloodTest["testsheet"])
guiLabelSetColor(bloodTest["tested"], 0, 0, 0)
guiLabelSetHorizontalAlign(bloodTest["tested"], "center", false)
guiLabelSetVerticalAlign(bloodTest["tested"], "center")
bloodTest["instructions"] = guiCreateLabel(0.16, 0.68, 0.33, 0.09, "Click the circles to \ndetermine your blood type!", true, bloodTest["testsheet"])
guiLabelSetColor(bloodTest["instructions"], 0, 0, 0)
guiLabelSetVerticalAlign(bloodTest["instructions"], "center")
bloodTest["substance"] = guiCreateStaticImage(0.69, 0.49, 0.22, 0.37, ":DayZ/gui/status/blood/substance.png", true, bloodTest["testsheet"])
bloodTest["substanceleft"] = guiCreateLabel(0.30, 0.42, 0.56, 0.46, vialsLeft, true, bloodTest["substance"])
guiSetFont(bloodTest["substanceleft"], "default-bold-small")
guiLabelSetHorizontalAlign(bloodTest["substanceleft"], "center", false)
guiLabelSetVerticalAlign(bloodTest["substanceleft"], "center")    
bloodTest["close"] = guiCreateLabel(0.11, 0.83, 0.23, 0.07, "Close", true, bloodTest["testsheet"])
guiLabelSetVerticalAlign(bloodTest["close"], "center")
guiLabelSetColor(bloodTest["close"],0,0,0)
guiSetFont(bloodTest["tested"],handFont)
guiSetFont(bloodTest["instructions"],handFont)
guiSetFont(bloodTest["close"],handFont)

guiSetVisible(bloodTest["testsheet"],false)

function activateBloodTest()
	if guiGetVisible(bloodTest["testsheet"]) then
		guiSetVisible(bloodTest["testsheet"],false)
		showCursor(false)
		removeEventHandler("onClientMouseEnter",bloodTest["close"],colorSelected)
		removeEventHandler("onClientMouseLeave",bloodTest["close"],colorDeselected)
	else
		guiSetVisible(bloodTest["testsheet"],true)
		showCursor(not isCursorShowing())
		addEventHandler("onClientMouseEnter",bloodTest["close"],colorSelected,false)
		addEventHandler("onClientMouseLeave",bloodTest["close"],colorDeselected,false)
		vialsLeft = 3
		guiSetProperty(bloodTest["drop1"], "ImageColours", "tl:FF86787C tr:FF86787C bl:FF86787C br:FF86787C")
		guiSetProperty(bloodTest["drop2"], "ImageColours", "tl:FF86787C tr:FF86787C bl:FF86787C br:FF86787C")
		guiSetProperty(bloodTest["drop3"], "ImageColours", "tl:FF86787C tr:FF86787C bl:FF86787C br:FF86787C")
		guiSetProperty(bloodTest["drop4"], "ImageColours", "tl:FF86787C tr:FF86787C bl:FF86787C br:FF86787C")
	end
end

function colorSelected()
	guiLabelSetColor(bloodTest["close"],255,0,0)
end

function colorDeselected (b,s)
	guiLabelSetColor(bloodTest["close"],0,0,0)
end

function closeBloodTest()
	guiSetVisible(bloodTest["testsheet"],false)
	showCursor(not isCursorShowing())
	removeEventHandler("onClientMouseEnter",bloodTest["close"],colorSelected)
	removeEventHandler("onClientMouseLeave",bloodTest["close"],colorDeselected)
end

local bloodTypeSpawn = false
function assignTypeToDrop()
	if not bloodTypeSpawn then
		local bloodstring = ""
		setElementData(bloodTest["drop1"],"bloodtype","0")
		setElementData(bloodTest["drop2"],"bloodtype","A")
		setElementData(bloodTest["drop3"],"bloodtype","B")
		setElementData(bloodTest["drop4"],"bloodtype","AB")
		for i = 1, 4 do 
			addEventHandler("onClientGUIClick",bloodTest["drop"..i],checkBloodType,false)
		end
		addEventHandler("onClientGUIClick",bloodTest["close"],closeBloodTest,false)
		bloodTypeSpawn = true
	end
end
addEventHandler("onClientPlayerSpawn",localPlayer,assignTypeToDrop)

function checkBloodType(button, state)
	if button == "left" then
		if vialsLeft > 0 then
			if getElementData(source,"bloodtype") == playerStatusTable[localPlayer]["bloodtype"] then
				guiSetProperty(source, "ImageColours", "tl:FF00FF00 tr:FF00FF00 bl:FF00FF00 br:FF00FF00")
				--setElementData(localPlayer,"bloodtypediscovered",getElementData(localPlayer,"bloodtype")) <- needs to be changed
				vialsLeft = 0
				guiSetText(bloodTest["substanceleft"],vialsLeft)
			else
				if vialsLeft == 0 then
					triggerEvent("displayClientInfo",localPlayer,"Blood","No more test substance left!",255,0,0)
					return
				else
					guiSetProperty(source, "ImageColours", "tl:FFFF0000 tr:FFFF0000 bl:FFFF0000 br:FFFF0000")
					vialsLeft = vialsLeft-1
					guiSetText(bloodTest["substanceleft"],vialsLeft)
				end
			end
		else
			triggerEvent("displayClientInfo",localPlayer,"Blood","No more test substance left!",255,0,0)
		end
	end
end

function infectionSigns()
	if getElementData(localPlayer,"logedin") then
		if getElementData(localPlayer,"infection") then
			local x,y,z = getElementPosition(localPlayer)
			createExplosion (x,y,z+15,8,false,0.5,false)
			local x, y, z, lx, ly, lz = getCameraMatrix()
			local randomsound = math.random(0,50)
			if randomsound >= 0 and randomsound <= 20 then
				local getnumber = math.random(0,2)
				playSound(":DayZ/sounds/status/cough_"..getnumber..".ogg",false)
			elseif randomsound >= 21 and randomsound <= 40 then	
				playSound(":DayZ/sounds/status/sneezing.mp3",false)
			end
		end
	end
end
--setTimer(infectionSigns,10000,0)

local isHourGlassActive = false
function setPlayerUnconsciousWhenLowBlood()
	if getElementData(localPlayer,"logedin") then
		if playerStatusTable[localPlayer] then
			if playerStatusTable[localPlayer]["blood"] < 3000 and not playerStatusTable[localPlayer]["unconscious"] and not getElementData(localPlayer,"isDead") then
				local number = math.random(1,100)
				if number == 1 then
					if not isHourGlassActive then
						addEventHandler("onClientRender",root,drawHourGlass)
						isHourGlassActive = true
						triggerServerEvent("onPlayerUnconsciousAnimation",localPlayer,"unconscious",localPlayer)
						toggleAllControls(false,true,true)
						enableBlackWhite(true)
						unbindKey("J","down",initInventory)
						triggerServerEvent("unbindFuncKeys",localPlayer)
						--setElementData(localPlayer,"unconscious",true) <- need to be changed
						startRollMessage2("Status","You are unconscious!",255,0,0)
					end
				end
			end
		end
	end
end
setTimer(setPlayerUnconsciousWhenLowBlood,1000,0)

function setPlayerUnconscious()
	if getElementData(localPlayer,"logedin") then
		if playerStatusTable[localPlayer]["unconscious"] then
			if not isHourGlassActive then
				addEventHandler("onClientRender",root,drawHourGlass)
				isHourGlassActive = true
				triggerServerEvent("onPlayerUnconsciousAnimation",localPlayer,"unconscious",localPlayer)
				toggleAllControls(false,true,true)
				enableBlackWhite(true)
				unbindKey("J","down",initInventory)
				triggerServerEvent("unbindFuncKeys",localPlayer)
				startRollMessage2("Status","You are unconscious!",255,0,0)
			end
		else
			if isHourGlassActive then
				removeEventHandler("onClientRender",root,drawHourGlass)
				isHourGlassActive = false
				triggerServerEvent("onPlayerUnconsciousAnimation",localPlayer,"awake",localPlayer)
				toggleAllControls(true,true,true)
				enableBlackWhite(false)
				bindKey("J","down",initInventory)
				triggerServerEvent("bindFuncKeys",localPlayer)
				startRollMessage2("Status","You are awake.",0,255,0)
			end
		end
	end
end
setTimer(setPlayerUnconscious,3000,0)

function wakePlayerFromUnconsciousness()
	if getElementData(localPlayer,"logedin") then
		if playerStatusTable[localPlayer]["unconscious"] then
			local number = math.random(1,100)
			if number >= 1 and number <= 25 then
				removeEventHandler("onClientRender",root,drawHourGlass)
				toggleAllControls(true,true,true)
				enableBlackWhite(false)
				triggerServerEvent("onPlayerUnconsciousAnimation",localPlayer,"awake",localPlayer)
				bindKey("J","down",initInventory)
				triggerServerEvent("bindFuncKeys",localPlayer)
				startRollMessage2("Status","You are awake.",0,255,0)
				isHourGlassActive = false
				--setElementData(localPlayer,"unconscious",false) <- needs to be changed
			end
		end
	end
end
setTimer(wakePlayerFromUnconsciousness,60000,0)

function removeUnconsciousHandlerOnDeath()
	if getElementData(localPlayer,"isDead") then
		if isHourGlassActive then
			--setElementData(localPlayer,"unconscious",false) <- needs to be changed
			removeEventHandler("onClientRender",root,drawHourGlass)
			toggleAllControls(true,true,true)
			enableBlackWhite(false)
			bindKey("J","down",initInventory)
			triggerServerEvent("bindFuncKeys",localPlayer)
			isHourGlassActive = false
		end
	end
end
addEventHandler("onClientPlayerWasted",localPlayer,removeUnconsciousHandlerOnDeath)

local hourglassrotation = 0
local w, h = guiGetScreenSize()
function drawHourGlass()
	if hourglassrotation == 180 then
		if not hourglass then
			hourglass = setTimer(function() hourglassrotation = hourglassrotation+4 killTimer(hourglass) hourglass = false end,1000,1)
		end
	elseif hourglassrotation == 360 then
		if not hourglass2 then
			hourglass2 = setTimer(function() hourglassrotation = 0 killTimer(hourglass2) hourglass2 = false end,1000,1)
		end
	else
		hourglassrotation = hourglassrotation+4
	end
	dxDrawImage(w * 0.3900, h * 0.3217, w * 0.2500, h * 0.3333, ":DayZ/gui/status/misc/circle.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	dxDrawImage(w * 0.4363, h * 0.3567, w * 0.1563, h * 0.2583, ":DayZ/gui/status/misc/hourglass.png", hourglassrotation, 0, 0, tocolor(255, 255, 255, 255), false)
end

function getWeaponNoise(weapon)
	for i,weapon2 in ipairs(weaponNoiseTable) do
		if weapon == weapon2[1] then
			return weapon2[2]
		end
	end
	return 0
end

function getWeaponNoiseFactor(weapon)
    for i,weapon2 in ipairs(weaponNoiseTable) do
        if weapon == weapon2[1] then
            return weapon2[3]
        end
    end
	return 5
end

function setPlayerShootingLevel()
	if getPedControlState(localPlayer,"fire") then
		local weapon = getPedWeapon(localPlayer)
		local noise = getWeaponNoise(weapon) or 0
		setElementData(localPlayer,"shooting",noise)
		if shootTimer then
			killTimer(shootTimer)
		end
		shootTimer = setTimer(resetPlayerShootingLevel,2000,1)
	end
end
--setTimer(setPlayerShootingLevel,100,0)

local playerHasShot = 0
local shootTimer = false
function setPlayerShootingLevel(weapon)
	local noise = getWeaponNoise(weapon) or 0
	playerHasShot = noise
	if shootTimer then
		killTimer(shootTimer)
	end
	shootTimer = setTimer(resetPlayerShootingLevel,1500,1)
end
addEventHandler("onClientPlayerWeaponFire",localPlayer,setPlayerShootingLevel)

function resetPlayerShootingLevel()
	playerHasShot = 0
	shootTimer = false
end

-- New sound & visibility calculation
local initialValue = 0

-- returns a float number between 0 and 1, with 0 = moon and 1 = sun
function isSunOrMoon()
	local hours,minutes = getTime()
	local sunOrMoon = 0
	if hours > 12 then
		sunOrMoon = 2-(hours/12)
	else
		sunOrMoon = hours/12
	end
	return sunOrMoon
end

-- returns a float number between 0 and 1, with 0 = no fog and 1 = fog
function isFogOrNot()
	local fog = getFogDistance()
	local getFog = 0
	if fog < 0 then
		getFog = 1
	else
		getFog = 1-(fog/400)
	end
	return getFog
end

-- returns a float number between 0 and 1, representing moon light intensity
function getMoonIntensity()
	local moonIntensity = math.sin(math.pi*exports.DayZ:getMoonPhaseValue())*1
	return moonIntensity
end

function getCurrentLightLevel()
	local hours,minutes = getTime()
	local weather = getWeather()
	local moonSunLevel = isSunOrMoon()
	local moonLightIntensity = getMoonIntensity()
	local rain = getRainLevel()
	local fog = isFogOrNot()
	local cloudy = 0
	local lightLevel = 0
	-- Workaround for cloud density
	if weather == 4 or weather == 7 or weather == 12 or weather == 15 then
		cloudy = tonumber(weather)/15
	end
	if hours > 6 and hours < 20 then
		moonLightIntensity = 0
	end
	local lightLevel = (moonSunLevel*2)+moonLightIntensity-(cloudy*0.2)-(rain*0.2)-(fog*0.5)
	initialValue = 20+(moonSunLevel*20)
	return lightLevel
end

-- For muffling sounds due to weather
function getCurrentMuffleLevel()
	local rain = getRainLevel()
	local muffleLevel = 0
	muffleLevel = 1-(rain*0.3)
	return muffleLevel
end

function getPlayerPoseVisibility()
	local block, animation = getPedAnimation(localPlayer)
	local moveState = getPedMoveState(localPlayer)
	local scalePose = 0.9
	local scaleMovement = 0.2
	if block == "ped" or block == "SHOP" or block == "BEACH" then
		scalePose = 0.14
		scaleMovement = 0.3
	end
	if moveState == "crouch" or moveState == "crawl" then
		scalePose = 0.6
		scaleMovement = 0.2
	end
	return scalePose,scaleMovement
end

local terrainTable = {
["grass"] = {9,10,11,12,13,14,15,16,17,20,80,81,82,115,116,117,118,119,120,121,122,125,146,147,148,149,150,151,152,153,160},
["concrete"] = {4,5,7,8,34,89,127,135,136,137,138,139,144,165},
["forest"] = {23,41,111,112,113,114,19,21,22,24,25,26,27,40,83,84,87,88,100,110,123,124,126,128,130,132,141,142,145,155,156},
["rock"] = {18,35,36,37,69,109,154,161,6,85,101,134,140},
}

function getTerrainProperties()
	local x,y,z = getElementPosition(localPlayer)
	local material = getGroundMaterial(x,y,z)
	local scale,movement = getPlayerPoseVisibility()
	local terrainVisibility = false
	local terrainNoise = false
	local moveState = getPedMoveState(localPlayer)
	for i, terrain in ipairs(terrainTable["grass"]) do
		if terrain == material then
			initialValue = initialValue*0.65
			terrainVisibility = movement-0.05
			if moveState == "sprint" then
				terrainNoise = 28
			elseif moveState == "jog" then
				terrainNoise = 23
			elseif moveState == "powerwalk" or moveState == "walk" then
				terrainNoise = 19
			elseif moveState == "crawl" then
				terrainNoise = 20
			elseif moveState == "crouch" or moveState == "stand" then
				terrainNoise = 1
			else
				terrainNoise = 23
			end
		end
	end
	for i, terrain in ipairs(terrainTable["concrete"]) do
		if terrain == material then
			initialValue = initialValue*0.85
			terrainVisibility = movement+0.1
			if moveState == "sprint" then
				terrainNoise = 28
			elseif moveState == "jog" then
				terrainNoise = 25
			elseif moveState == "powerwalk" or moveState == "walk" then
				terrainNoise = 19
			elseif moveState == "crawl" then
				terrainNoise = 20
			elseif moveState == "crouch" or moveState == "stand" then
				terrainNoise = 1
			else
				terrainNoise = 25
			end
		end
	end
	for i, terrain in ipairs(terrainTable["forest"]) do
		if terrain == material then
			initialValue = initialValue*0.5
			terrainVisibility = movement-0.1
			if moveState == "sprint" then
				terrainNoise = 32
			elseif moveState == "jog" then
				terrainNoise = 27
			elseif moveState == "powerwalk" or moveState == "walk" then
				terrainNoise = 22
			elseif moveState == "crawl" then
				terrainNoise = 20
			elseif moveState == "crouch" or moveState == "stand" then
				terrainNoise = 1
			else
				terrainNoise = 27
			end
		end
	end
	for i, terrain in ipairs(terrainTable["rock"]) do
		if terrain == material then
			initialValue = initialValue*0.80
			terrainVisibility = movement+0.05
			if moveState == "sprint" then
				terrainNoise = 30
			elseif moveState == "jog" then
				terrainNoise = 23
			elseif moveState == "powerwalk" or moveState == "walk" then
				terrainNoise = 19
			elseif moveState == "crawl" then
				terrainNoise = 20
			elseif moveState == "crouch" or moveState == "stand" then
				terrainNoise = 1
			else
				terrainNoise = 23
			end
		end
	end
	if material == 0 or material == 1 or material == 2 or material == 3 then
		initialValue = initialValue*1.3
		terrainVisibility = movement+0.2
		if moveState == "sprint" then
				terrainNoise = 30
			elseif moveState == "jog" then
				terrainNoise = 23
			elseif moveState == "powerwalk" or moveState == "walk" then
				terrainNoise = 18
			elseif moveState == "crawl" then
				terrainNoise = 20
			elseif moveState == "crouch" or moveState == "stand" then
				terrainNoise = 1
			else
				terrainNoise = 23
			end
	end
	if not terrainVisibility then
		terrainVisibility = 1
	end
	if not terrainNoise then
		terrainNoise = 1
	end
	return terrainVisibility,terrainNoise,initialValue
end

function getPlayerSpeed()
	if not isPedInVehicle(localPlayer) then
		local speedx, speedy, speedz = getElementVelocity(localPlayer)
		local actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5) 
		mps = actualspeed * 50
	else
		playerSpeed = 20
	end
	playerSpeed = math.floor(mps*3.5)
	return playerSpeed
end

--[[
We check the chance for a zombie to detect a player based on his
visibility and sound. The closer the player is to a zombie, the 
bigger the chance to be detected.
]]
function checkLOSChance(distance,value)
	local var = math.max((value-distance),0)
	distance = math.max(0.1,distance)
	local maxExp = math.exp(2)*distance
	local myExp = (math.exp(2)*var)/maxExp
	myExp = math.min(myExp*5,100)
	return myExp
end

-- Working the magic math
-- Left to do: light exposure to fireplace and roadflare, is player in building?
function getSoundAndVisibilityLevel()
	local rain = getRainLevel()
	local fog = isFogOrNot()
	local moonSunLevel = isSunOrMoon()
	local moonLightIntensity = getMoonIntensity()
	local muffleLevel = getCurrentMuffleLevel()
	local lightLevel = getCurrentLightLevel()
	local scale,movement = getPlayerPoseVisibility()
	local terrainVisibility,terrainNoise,initialValue = getTerrainProperties()
	local playerSpeed = getPlayerSpeed()
	totalSound = math.ceil((playerSpeed*terrainNoise*movement*muffleLevel)+playerHasShot)
	totalVisibility = math.ceil((initialValue+(playerSpeed*3))*scale*lightLevel)*1.5
	if isPedInVehicle(localPlayer) then
		totalSound = 100
		totalVisibility = 20
	end
	return totalSound,totalVisibility
end

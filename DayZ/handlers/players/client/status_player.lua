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
		dayzVersion = "MTA:DayZ 0.9.6a"
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

function createBloodFX()
	if getElementData(localPlayer,"logedin") then
		local x,y,z = getElementPosition(localPlayer)
		local bleeding = getElementData(localPlayer,"bleeding") or 0
		if bleeding > 0 then
			local px,py,pz = getPedBonePosition(localPlayer,3)
			local pdistance = getDistanceBetweenPoints3D(x,y,z,px,py,pz)
			if bleeding >= 61 then
				number = 5
			elseif bleeding >= 31 and bleeding <= 60 then
				number = 3
			elseif bleeding >= 10 and bleeding <= 30 then
				number = 1
			else
				number = 0
			end
			if pdistance <= 120 then
				fxAddBlood (px,py,pz,0,0,0,number,1)
			end
		end
	end	
end
setTimer(createBloodFX,300,0)

function setPlayerBleeding()
	if getElementData(localPlayer,"logedin") then
		if getElementData(localPlayer,"bleeding") > 20 then
			setElementData(localPlayer,"blood",getElementData(localPlayer,"blood")-getElementData(localPlayer,"bleeding"))
		else
			local randomnumber = math.random(0,10)
			if randomnumber < 5 then
				setElementData(localPlayer,"bleeding",0)
			end
		end
	end
end
setTimer(setPlayerBleeding,1000,0)

function setPlayerDeath()
	if getElementData(localPlayer,"logedin") then
		if getElementData(localPlayer,"blood") <= 0 then
			if not getElementData(localPlayer,"isDead") then
				triggerServerEvent("kilLDayZPlayer",localPlayer,false,false)
			end
		end
	end
end
setTimer(setPlayerDeath,1000,0)

function setPlayerBrokenbone()
	if getElementData(localPlayer,"logedin") then
		if getElementData(localPlayer,"brokenbone") then
			toggleControl("jump", false)
			toggleControl("sprint",false)
		else
			toggleControl("jump", true)
			toggleControl("sprint", true)
		end
	end
end
setTimer(setPlayerBrokenbone,2000,0)

function setPlayerCold()
	if getElementData(localPlayer,"logedin") then
		if getElementData(localPlayer,"temperature") <= 33 then
			setElementData(localPlayer,"cold",true)
		elseif getElementData(localPlayer,"temperature") > 33 then
			setElementData(localPlayer,"cold",false)
		end
		if getElementData(localPlayer,"cold") then
			local x,y,z = getElementPosition(localPlayer)
			createExplosion (x,y,z+15,8,false,0.5,false)
			local x, y, z, lx, ly, lz = getCameraMatrix()
			randomsound = math.random(0,99)
			if randomsound >= 0 and randomsound <= 10 then
				local getnumber = math.random(0,2)
				playSound(":DayZ/sounds/status/cough_"..getnumber..".ogg",false)
				setElementData(localPlayer,"volume",100)
				setTimer(function() setElementData(localPlayer,"volume",0) end,1500,1)
			elseif randomsound >= 11 and randomsound <= 20 then	
				setElementData(localPlayer,"volume",100)
				setTimer(function() setElementData(localPlayer,"volume",0) end,1500,1)
				playSound(":DayZ/sounds/status/sneezing.mp3",false)
			end
		end	
	end
end
setTimer(setPlayerCold,40000,0)

function isPlayerInBuilding(x,y,z)
	if isInBuilding(x,y,z) then
		triggerServerEvent("onPlayerChangeStatus",source,"isInBuilding",true)
	else
		triggerServerEvent("onPlayerChangeStatus",source,"isInBuilding",false)
	end
end
addEvent("isPlayerInBuilding",true)
addEventHandler("isPlayerInBuilding",root,isPlayerInBuilding)

function setPlayerPain()
	if getElementData(localPlayer,"logedin") then
		if getElementData(localPlayer,"pain") then
			setCameraShakeLevel(gameplayVariables["painshakelevel"])
			setTimer(setCameraShakeLevel,15000,1,0)
		else
			setCameraShakeLevel(0)
		end
	end
end
setTimer(setPlayerPain,90000,0)
--[[ 
Volume (Noise):

0 = Silent
20 = Very Low
40 = Low
60 = Moderate
80 = High
100 = Very High

]]

function setVolume()
	local value = 0
	local block, animation = getPedAnimation(localPlayer)
	if getPedMoveState (localPlayer) == "stand" then
		value = 0
	elseif getPedMoveState (localPlayer) == "crouch" then	
		value = 0
	elseif getPedMoveState(localPlayer) == "crawl" then
		value = 20
	elseif getPedMoveState (localPlayer) == "walk" then
		value = 40
	elseif getPedMoveState (localPlayer) == "powerwalk" then
		value = 60
	elseif getPedMoveState (localPlayer) == "jog" then
		value = 80
	elseif getPedMoveState (localPlayer) == "sprint" then	
		value = 100
	elseif not getPedMoveState (localPlayer) then
		value = 20
	end
	if getElementData(localPlayer,"shooting") and getElementData(localPlayer,"shooting") > 0 then
		value = value+getElementData(localPlayer,"shooting")
	end
	if isPedInVehicle (localPlayer) then
		if getPedOccupiedVehicle(localPlayer) ~= 509 then
			if getVehicleEngineState(getPedOccupiedVehicle(localPlayer)) then
				value = 100
			else
				value = 0
			end
		else
			value = 0
		end
	end
	if value > 100 then
		value = 100
	end
	if block == "ped" or block == "SHOP" or block == "BEACH" then
		value = 0
	end
	setElementData(localPlayer,"volume",value)
end
setTimer(setVolume,100,0)

--[[
Visibility:

0 = Invisible
20 = Very Low Visibility
40 = Low Visibility
60 = Moderate Visibility
80 = High Visibility
100 = Very High Visibility

]]
function setVisibility()
	local value = 0
	local block, animation = getPedAnimation(localPlayer)
	if getPedMoveState (localPlayer) == "stand" then
		value = 40
	elseif getPedMoveState (localPlayer) == "crouch" then	
		value = 0
	elseif getPedMoveState(localPlayer) == "crawl" then
		value = 20
	elseif getPedMoveState (localPlayer) == "walk" then
		value = 60
	elseif getPedMoveState (localPlayer) == "powerwalk" then
		value = 60
	elseif getPedMoveState (localPlayer) == "jog" then
		value = 60
	elseif getPedMoveState (localPlayer) == "sprint" then	
		value = 80
	elseif not getPedMoveState (localPlayer) then	
		value = 20
	end
	if getElementData(localPlayer,"jumping") then
		value = 100
	end
	if isObjectAroundPlayer (localPlayer,2, 4 ) then
		value = 0
	end
	if isPedInVehicle (localPlayer) then
		value = 100
	end
	if block == "ped" or block == "SHOP" or block == "BEACH" then
		value = 0
	end
	if value > 100 then
		value = 100
	end
	setElementData(localPlayer,"visibly",value)
end
setTimer(setVisibility,100,0)

function debugJump()
	if getControlState("jump") then
		setElementData(localPlayer,"jumping",true)
		setTimer(debugJump2,650,1)
	end
end
setTimer(debugJump,100,0)

function debugJump2()
	setElementData(localPlayer,"jumping",false)
end

local SneakEabled = false
function setPlayerSneakOnWalk()
	if getControlState("walk") then
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
setTimer(updateDaysAliveTime,2880000,0)

function updatePlayTime()
	if getElementData(localPlayer,"logedin") then
		local playtime = getElementData(localPlayer,"alivetime")
		setElementData(localPlayer,"alivetime",playtime+1)	
	end	
end
setTimer(updatePlayTime,60000,0)

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
		for i = 1, 4 do
			if i == 1 then
				bloodstring = "0"
				setElementData(bloodTest["drop1"],"bloodtype",bloodstring)
			elseif i == 2 then
				bloodstring = "A"
				setElementData(bloodTest["drop2"],"bloodtype",bloodstring)
			elseif i == 3 then
				bloodstring = "B"
				setElementData(bloodTest["drop3"],"bloodtype",bloodstring)
			elseif i == 4 then
				bloodstring = "AB"
				setElementData(bloodTest["drop4"],"bloodtype",bloodstring)
			end
			addEventHandler("onClientGUIClick",bloodTest["drop"..i],checkBloodType, false)
		end
		addEventHandler("onClientGUIClick",bloodTest["close"],closeBloodTest,false)
		bloodTypeSpawn = true
	end
end
addEventHandler("onClientPlayerSpawn",localPlayer,assignTypeToDrop)

function checkBloodType(button, state)
	if button == "left" then
		if vialsLeft > 0 then
			if getElementData(source,"bloodtype") == getElementData(localPlayer,"bloodtype") then
				guiSetProperty(source, "ImageColours", "tl:FF00FF00 tr:FF00FF00 bl:FF00FF00 br:FF00FF00")
				setElementData(localPlayer,"bloodtypediscovered",getElementData(localPlayer,"bloodtype"))
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
				setElementData(localPlayer,"volume",100)
				setTimer(function() setElementData(localPlayer,"volume",0) end,1500,1)
			elseif randomsound >= 21 and randomsound <= 40 then	
				setElementData(localPlayer,"volume",100)
				setTimer(function() setElementData(localPlayer,"volume",0) end,1500,1)
				playSound(":DayZ/sounds/status/sneezing.mp3",false)
			end
		end
	end
end
setTimer(infectionSigns,10000,0)

local sepsisTimer = 10000
function checkSepsis()
	if getElementData(localPlayer,"logedin") then
		if getElementData(localPlayer,"sepsis") == 1 then
			timer = 900000
			setTimer(function(timer)
				setElementData(localPlayer,"sepsis",2)
				if isTimer(theSepsis) then killTimer(theSepsis) end
			end,timer,1)
		elseif getElementData(localPlayer,"sepsis") == 2 then
			timer = 450000
			setTimer(function(timer)
				setElementData(localPlayer,"sepsis",3)
				if isTimer(theSepsis) then killTimer(theSepsis) end
			end,timer,1)
			timer = 1000
			if not isTimer(theSepsis) then
				theSepsis1= setTimer(function(timer)
					oldBlood = getElementData(localPlayer,"blood")
					triggerServerEvent("onPlayerHasContractedSepsis",localPlayer,4,-1)
				end,timer,0)
			end
		elseif getElementData(localPlayer,"sepsis") == 3 then
			timer = 450000
			setTimer(function(timer)
				setElementData(localPlayer,"sepsis",4)
				if isTimer(theSepsis) then killTimer(theSepsis) end
			end,timer,1)
			timer = 1000
			if not isTimer(theSepsis2) then
				theSepsis = setTimer(function(timer)
					oldBlood = getElementData(localPlayer,"blood")
					triggerServerEvent("onPlayerHasContractedSepsis",localPlayer,4,-2)
				end,timer,0)
			end
		elseif getElementData(localPlayer,"sepsis") == 4 then
			timer = 1000
			if not isTimer(theSepsis) then
				theSepsis = setTimer(function(timer)
					oldBlood = getElementData(localPlayer,"blood")
					triggerServerEvent("onPlayerHasContractedSepsis",localPlayer,4,-3)
				end,timer,0)
			end
		end
	end
end
setTimer(checkSepsis,sepsisTimer,0)

function transmitSepsis()
	for i,player in ipairs(getElementsByType("player")) do
		if getElementData(player,"logedin") then
			if getElementData(localPlayer,"sepsis") == 4 then
				local x1,y1,z1 = getElementPosition(localPlayer)
				local x2,y2,z2 = getElementPosition(player)
				if getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2) <= 5 then
					if getElementData(player,"sepsis") == 0 then
						triggerServerEvent("onPlayerTransmitSepsis",player)
					end
				end
			end
		end
	end
end
setTimer(transmitSepsis,30000,0)

local isHourGlassActive = false
function setPlayerUnconsciousWhenLowBlood()
	if getElementData(localPlayer,"logedin") then
		if getElementData(localPlayer,"blood") < 3000 and not getElementData(localPlayer,"unconscious") then
			local number = math.random(1,100)
			if number == 1 then
				if not isHourGlassActive then
					addEventHandler("onClientRender",root,drawHourGlass)
					isHourGlassActive = true
					setPedAnimation(localPlayer,"ped","FLOOR_hit_f",-1,false)
					toggleAllControls(false,true,true)
					enableBlackWhite(true)
					unbindKey("J","down",initInventory)
					triggerServerEvent("unbindFuncKeys",localPlayer)
					setElementData(localPlayer,"unconscious",true)
					startRollMessage2("Status","You are unconscious!",255,0,0)
				end
			end
		end
	end
end
setTimer(setPlayerUnconsciousWhenLowBlood,1000,0)

function setPlayerUnconscious()
	if getElementData(localPlayer,"logedin") then
		if getElementData(localPlayer,"unconscious") then
			if not isHourGlassActive then
				addEventHandler("onClientRender",root,drawHourGlass)
				isHourGlassActive = true
				setPedAnimation(localPlayer,"ped","FLOOR_hit_f",-1,false)
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
				setPedAnimation(localPlayer,"ped","getup_front",-1,false)
				setTimer(function() setPedAnimation (localPlayer,false) end,1300,1)
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
		if getElementData(localPlayer,"unconscious") then
			local number = math.random(1,100)
			if number >= 1 and number <= 25 then
				removeEventHandler("onClientRender",root,drawHourGlass)
				toggleAllControls(true,true,true)
				enableBlackWhite(false)
				setPedAnimation(localPlayer,"ped","getup_front",-1,false)
				setTimer(function() setPedAnimation (localPlayer,false) end,1300,1)
				bindKey("J","down",initInventory)
				triggerServerEvent("bindFuncKeys",localPlayer)
				startRollMessage2("Status","You are awake.",0,255,0)
				isHourGlassActive = false
				setElementData(localPlayer,"unconscious",false)
			end
		end
	end
end
setTimer(wakePlayerFromUnconsciousness,60000,0)

function removeUnconsciousHandlerOnDeath()
	if getElementData(localPlayer,"isDead") then
		if isHourGlassActive then
			removeEventHandler("onClientRender",root,drawHourGlass)
			toggleAllControls(true,true,true)
			enableBlackWhite(false)
			bindKey("J","down",initInventory)
			triggerServerEvent("bindFuncKeys",localPlayer)
			isHourGlassActive = false
		end
	end
end
setTimer(removeUnconsciousHandlerOnDeath,4000,0)

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

local backpackLoadTable = {}
local ammoLoadTable = {}
local itemLoadTable = {}
local weaponLoadTable = {}
local mps = 0
local ammoLoad = 0
local itemLoad = 0
local weaponLoad = 0
local playerSpeed = 0
local playerHunger = 0
local playerThirst = 0
function getPlayerLoad()
	if getElementData(localPlayer,"logedin") then
		backpackLoadTable = {}
		ammoLoadTable = {}
		itemLoadTable = {}
		weaponLoadTable = {}
		ammoLoad = 0
		itemLoad = 0
		weaponLoad = 0
		for i, item in ipairs(itemWeightTable) do
			if item[3] == "Weapon" then
				table.insert(weaponLoadTable,{item[2],getElementData(localPlayer,item[1])})
			elseif item[3] == "Ammo" then
				table.insert(ammoLoadTable,{item[2],getElementData(localPlayer,item[1])})
			elseif item[3] == "Item" then
				table.insert(itemLoadTable,{item[2],getElementData(localPlayer,item[1])})
			end
		end
		for i, load in ipairs(ammoLoadTable) do
			ammoLoad = ammoLoad+(load[1]*load[2])
		end
		for i, load in ipairs(itemLoadTable) do
			itemLoad = itemLoad+(load[1]*load[2])
		end
		for i, load in ipairs(weaponLoadTable) do
			weaponLoad = weaponLoad+(load[1]*load[2])
		end
		local myLoad = (ammoLoad*0.2)+(itemLoad*0.1)+(weaponLoad*0.5)
		
		if not isPedInVehicle(localPlayer) then
			local speedx, speedy, speedz = getElementVelocity (localPlayer)
			local actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5) 
			mps = actualspeed * 50
		else
			playerSpeed = 20
		end
		playerSpeed = math.floor(mps*3.5)
		
		local hunger = (math.abs((((12000 - getElementData(localPlayer,"blood")) / 12000) * 5) + playerSpeed + myLoad) * 3)
		playerHunger = 0
		playerHunger = math.round(playerHunger+(hunger/80),2)
		
		local thirst = 2
		thirst = (playerSpeed+4)*3
		playerThirst = 0
		playerThirst = math.round(playerThirst+(thirst/120)*(getElementData(localPlayer,"temperature")/37),2)
	end
end
setTimer(getPlayerLoad,30000,0)

function setPlayerHunger()
	if getElementData(localPlayer,"logedin") then
		if getElementData(localPlayer,"food") > 0 then
			setElementData(localPlayer,"food",getElementData(localPlayer,"food")-playerHunger)
		else
			setElementData(localPlayer,"food",0)
		end
	end
end
setTimer(setPlayerHunger,30100,0)

function setPlayerThirst()
	if getElementData(localPlayer,"logedin") then
		if getElementData(localPlayer,"thirst") > 0 then
			setElementData(localPlayer,"thirst",getElementData(localPlayer,"thirst")-playerThirst)
		else
			setElementData(localPlayer,"thirst",0)
		end
	end
end
setTimer(setPlayerThirst,30100,0)
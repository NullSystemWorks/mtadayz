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
		dayzVersion = "MTA:DayZ 0.9.4.2a"
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
setTimer(setPlayerBleeding,30000,0)

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
				playSound(":DayZ/sounds/status/coughing.mp3",false)
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
			local x,y,z = getElementPosition(localPlayer)
			createExplosion (x,y,z+15,8,false,1.0,false)
			local x, y, z, lx, ly, lz = getCameraMatrix()
			x, lx = x + 1, lx + 1
			setCameraMatrix(x,y,z,lx,ly,lz)
			setCameraTarget (localPlayer)
		end
	end
end
setTimer(setPlayerPain,6000,0)
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
	value = 0
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
		value = 100
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
	value = 0
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
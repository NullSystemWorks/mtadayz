--[[

	Author: CiBeR
	Version: 0.1
	Copyright: DayZ Gamemode. All rights reserved to Developers
	Current Devs: Lawliet, CiBeR, Jboy

	
]]--
-- Settings
 maxHealth = 12000
 maxFood = 100
 maxThirst = 100
 maxSlots = gameplayVariables["maxslots"]

addEventHandler("onElementDataChange",getRootElement(),
 function(data)
  if getElementType(source) == "player" then
    if data == "blood" then
        checkHealth(source)
    elseif data == "food" then
        checkFood(source)
    elseif data == "thirst" then
        checkThirst(source)
    elseif data == "MAX_Slots" then
        checkSlots(source)
    else
    end
  end
end)

function checkHealth(source)
    local vHealth = getElementData(source, "blood") or 0
    if vHealth > maxHealth and not hasObjectPermissionTo ( source, "command.mute" ) then
        setElementData(source, "blood", 1000)
        kickPlayer(source, "[AC] : Health Hack")
    end
end

function checkFood(source)
    local vFood = getElementData(source, "food") or 0
    if vFood > maxFood and not hasObjectPermissionTo ( source, "command.mute" ) then
        setElementData(source, "food", 30)
        kickPlayer(source, "[AC] : Food Hack")
    end
end

function checkThirst(source)
    local vThirst = getElementData(source, "thirst") or 0
    if vThirst > maxThirst and not hasObjectPermissionTo ( source, "command.mute" ) then
        setElementData(source, "thirst", 30)
        kickPlayer(source, "[AC] : Thirst Hack")
    end
end

function checkSlots(source)
    local vSlots = getElementData(source, "MAX_Slots") or 0
    if vSlots > maxSlots and not hasObjectPermissionTo ( source, "command.mute" ) then
        setElementData(source, "MAX_Slots", 8)
        kickPlayer(source, "[AC] : Slots Hack")
    end
end

function detectVehicleCheat(theVehicle, seat, jacked)
	if theVehicle then
		if ( getElementModel(theVehicle) == 432 or getElementModel(theVehicle) == 425 or getElementModel(theVehicle) == 501 or getElementModel(theVehicle) == 564 or getElementModel(theVehicle) == 594 or getElementModel(theVehicle) == 601 or getElementModel(theVehicle) == 447 or getElementModel(theVehicle) == 520 ) then
			if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(source)), aclGetGroup ( "Everyone" ) ) and not hasObjectPermissionTo ( source, "command.mute" ) then
				kickPlayer(source, "[AC] : Vehicle Hack")
			end
		end
	end
end
addEventHandler("onPlayerVehicleEnter", getRootElement(), detectVehicleCheat)

WeaponID = {
    [35] = true,
    [36] = true,
    [38] = true,
}

function detectWeaponCheat(previousWeaponID, currentWeaponID)
  if ( WeaponID[currentWeaponID] ) then
    if not hasObjectPermissionTo ( source, "command.mute" ) then
        kickPlayer(source, "[AC] : Weapon Hack")
    end
  end
end
addEventHandler("onPlayerWeaponSwitch", getRootElement(), detectWeaponCheat)

local lossCount = {}
local isLosingConnection = false
function checkLoss()
	for i, v in ipairs(getElementsByType("player")) do
		if getElementData(v,"logedin") then
			local loss = getNetworkStats(v)["packetlossLastSecond"]
			if not lossCount[v] then
				lossCount[v] = 0
			end
			if loss > 80 then -- If we have packet loss then send message and add counter.
				if not isLosingConnection then
					isLosingConnection = true
					triggerClientEvent("onPlayerIsLosingConnection",v,isLosingConnection)
					outputSideChat("Player "..getPlayerName(v).." is losing connection",root,255,0,0)
				end
				lossCount[v] = lossCount[v] + 1
				if lossCount[v] >= gameplayVariables["packetlossmax"] then -- If counter is equal to gameplayVariables["packetlossmax"] or higher then reset counter and kick player
					lossCount[v] = nil
					kickPlayer(v, "[AC] : Packet Loss")
				end
			else -- If packet loss was corrected then reset counter
				lossCount[v] = 0
				isLosingConnection = false
				triggerClientEvent("onPlayerIsLosingConnection",v,isLosingConnection)
			end
		end
	end
end

if gameplayVariables["packetlosskick"] then -- Check boolean to see if we want to kick on packet loss
	setTimer(checkLoss,2000,0) -- Set timer to check every two seconds
end

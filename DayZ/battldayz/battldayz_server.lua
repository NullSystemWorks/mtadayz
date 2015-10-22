--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: battldayz_server.lua					*----
----* Original Author: CiBeR96											*----

----* 				This gamemode is being developed by 				*----
----*				L, CiBeR96, 1B0Y, Remi & Renkon						*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]

-- Settings
maxHealth = 12000
maxFood = 100
maxThirst = 100
maxSlots = gameplayVariables["maxslots"]

addEventHandler("onElementDataChange",getRootElement(),
	function(data)
		if gameplayVariables["securitylevel"] and gameplayVariables["securitylevel"] == 0 then 
			return 
		end
		if getElementType(source) == "player" then
			if data == "blood" then
				checkHealth(source)
			elseif data == "food" then
				checkFood(source)
			elseif data == "thirst" then
				checkThirst(source)
			elseif data == "MAX_Slots" then
				checkSlots(source)
			end
		end
	end
)

function checkHealth(source)
	local vHealth = getElementData(source, "blood") or 0
    if vHealth > maxHealth and not hasObjectPermissionTo ( source, "command.mute" ) then
		if gameplayVariables["securitylevel"] and gameplayVariables["securitylevel"] == 2 then
			setElementData(source,"blood",-1)
			banPlayer(source,false,false,true,"BattlDayZ","[BattlDayZ] Health Hack",gameplayVariables["bantime"])
		elseif gameplayVariables["securitylevel"] and gameplayVariables["securitylevel"] == 1 then
			setElementData(source, "blood", 1)
			kickPlayer(source, "[BattlDayZ]: Health Hack")
		end
    end
end

function checkFood(source)
    local vFood = getElementData(source, "food") or 0
    if vFood > maxFood and not hasObjectPermissionTo ( source, "command.mute" ) then
        if gameplayVariables["securitylevel"] and gameplayVariables["securitylevel"] == 2 then
			setElementData(source,"food",0)
			banPlayer(source,false,false,true,"BattlDayZ","[BattlDayZ] Food Hack",gameplayVariables["bantime"])
		elseif gameplayVariables["securitylevel"] and gameplayVariables["securitylevel"] == 1 then
			setElementData(source, "food", 1)
			kickPlayer(source, "[BattlDayZ]: Food Hack")
		end
    end
end

function checkThirst(source)
    local vThirst = getElementData(source, "thirst") or 0
    if vThirst > maxThirst and not hasObjectPermissionTo ( source, "command.mute" ) then
		if gameplayVariables["securitylevel"] and gameplayVariables["securitylevel"] == 2 then
			setElementData(source,"thirst",0)
			banPlayer(source,false,false,true,"BattlDayZ","[BattlDayZ] Thirst Hack",gameplayVariables["bantime"])
		elseif gameplayVariables["securitylevel"] and gameplayVariables["securitylevel"] == 1 then
			setElementData(source, "thirst", 1)
			kickPlayer(source, "[BattlDayZ]: Thirst Hack")
		end
	end
end

function checkSlots(source)
    local vSlots = getElementData(source, "MAX_Slots") or 0
    if vSlots > maxSlots and not hasObjectPermissionTo ( source, "command.mute" ) then
        if gameplayVariables["securitylevel"] and gameplayVariables["securitylevel"] == 2 then
			setElementData(source,"MAX_Slots",8)
			banPlayer(source,false,false,true,"BattlDayZ","[BattlDayZ] Backpack Hack",gameplayVariables["bantime"])
		elseif gameplayVariables["securitylevel"] and gameplayVariables["securitylevel"] == 1 then
			setElementData(source, "MAX_Slots", 8)
			kickPlayer(source, "[BattlDayZ]: Backpack Hack")
		end
    end
end

function banTeleport()
	if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup("Everyone")) and not hasObjectPermissionTo(source, "command.mute") then
		if gameplayVariables["securitylevel"] and gameplayVariables["securitylevel"] == 2 then
			banPlayer(source,false,false,true,"BattlDayZ","[BattlDayZ] Teleport Hack",gameplayVariables["bantime"])
		elseif gameplayVariables["securitylevel"] and gameplayVariables["securitylevel"] == 1 then
			kickPlayer(source, "[BattlDayZ] Teleport Hack")
		end
	end
end
addEvent("bantp",true)
addEventHandler("bantp",getRootElement(),banTeleport)

function logged()
setTimer(function(source)
	if hasObjectPermissionTo(source, "command.mute") then
		triggerClientEvent(source,"startANTItp",source,1)
	else
		triggerClientEvent(source,"startANTItp",source,2)
	end
end,1000,1,source)
end
--addEventHandler("onPlayerLogin",getRootElement(),logged)
addEventHandler("onPlayerSpawn",getRootElement(),logged)

function detectVehicleCheat(theVehicle, seat, jacked)
	if theVehicle then
		if ( getElementModel(theVehicle) == 432 or getElementModel(theVehicle) == 425 or getElementModel(theVehicle) == 501 or getElementModel(theVehicle) == 564 or getElementModel(theVehicle) == 594 or getElementModel(theVehicle) == 601 or getElementModel(theVehicle) == 447 or getElementModel(theVehicle) == 520 ) then
			if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(source)), aclGetGroup ( "Everyone" ) ) and not hasObjectPermissionTo ( source, "command.mute" ) then
				if gameplayVariables["securitylevel"] and gameplayVariables["securitylevel"] == 2 then
					banPlayer(source,false,false,true,"BattlDayZ","[BattlDayZ] Vehicle Hack",gameplayVariables["bantime"])
				elseif gameplayVariables["securitylevel"] and gameplayVariables["securitylevel"] == 1 then
					kickPlayer(source, "[BattlDayZ]: Vehicle Hack")
				end
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
        if gameplayVariables["securitylevel"] and gameplayVariables["securitylevel"] == 2 then
			banPlayer(source,false,false,true,"BattlDayZ","[BattlDayZ] Weapon Hack",gameplayVariables["bantime"])
		elseif gameplayVariables["securitylevel"] and gameplayVariables["securitylevel"] == 1 then
			kickPlayer(source, "[BattlDayZ]: Weapon Hack")
		end
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
					outputSideChat("Player "..string.gsub(getPlayerName(v), '#%x%x%x%x%x%x', '' ).." is losing connection",root,255,0,0)
				end
				lossCount[v] = lossCount[v] + 1
				if lossCount[v] >= gameplayVariables["packetlossmax"] then -- If counter is equal to gameplayVariables["packetlossmax"] or higher then reset counter and kick player
					lossCount[v] = nil
					kickPlayer(v, "[BattlDayZ]: Packet Loss detected")
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

function onQuitCheckForCombatLog(quitType)
	if gameplayVariables["combatlog"] then
		local time = getRealTime()
		local timeLeft = getElementData (source,"combattime")
		if timeLeft then
			if time.timestamp-timeLeft < 30 then
				local playerAccount = getPlayerAccount(source)
				if (playerAccount) then
					setAccountData(playerAccount,"blood",-5) -- Kill the player for combat logging
				end
			end
		end
	end
end
addEventHandler ("onPlayerQuit",root,onQuitCheckForCombatLog)

function protectedByBattlDayZ()
	setTimer(function(source) 
		outputChatBox("This server is protected by BattlDayZ (V1.1), an anticheat system.",source,255,0,0)
	end,2000,1,source)
end
addEventHandler("onPlayerLogin",root,protectedByBattlDayZ)

function onCombatNotifyServer(player)
	outputDebugString("[BattlDayZ] "..getPlayerName(player).." is in combat")
end
addEvent("onCombatNotifyServer",true)
addEventHandler("onCombatNotifyServer",root,onCombatNotifyServer)

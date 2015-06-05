--[[

	Author: CiBeR
	Version: 0.1
	Copyright: DayZ Gamemode. All rights reserved to Developers
	Current Devs: Lawliet, CiBeR
	
]]--
-- Settings
 maxHealth = 12000
 maxFood = 100
 maxThirst = 100
 maxSlots = 80 -- You must put the number of slots of the best backpack of your server

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
    if vHealth > maxHealth and not hasObjectPermissionTo ( source, "function.mute" ) then
        setElementData(source, "blood", 12000)
        kickPlayer(source, "[AC] : Health Hack")
    end
end

function checkFood(source)
    local vFood = getElementData(source, "food") or 0
    if vFood > maxFood and not hasObjectPermissionTo ( source, "function.mute" ) then
        setElementData(source, "food", 30)
        kickPlayer(source, "[AC] : Food Hack")
    end
end

function checkThirst(source)
    local vThirst = getElementData(source, "thirst") or 0
    if vThirst > maxThirst and not hasObjectPermissionTo ( source, "function.mute" ) then
        setElementData(source, "thirst", 30)
        kickPlayer(source, "[AC] : Thirst Hack")
    end
end

function checkSlots(source)
    local vSlots = getElementData(source, "MAX_Slots") or 0
    if vSlots > maxSlots and not hasObjectPermissionTo ( source, "function.mute" ) then
        setElementData(source, "MAX_Slots", 0)
        kickPlayer(source, "[AC] : Slots Hack")
    end
end

function detectVehicleCheat(vehicle, seat, jacked)
  if ( getElementModel(vehicle) == 432 or getElementModel(vehicle) == 425 or getElementModel(vehicle) == 501 or getElementModel(vehicle) == 564 or getElementModel(Vehicle) == 594 or getElementModel(vehicle) == 601 or getElementModel(vehicle) == 447 or getElementModel(vehicle) == 520 ) then
    if isObjectInACLGroup ( "user." ..getAccountName(getPlayerAccount(source)), aclGetGroup ( "Everyone" ) ) and not hasObjectPermissionTo ( source, "function.mute" ) then
       kickPlayer(source, "[AC] : Vehicle Hack")
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
    if not hasObjectPermissionTo ( source, "function.mute" ) then
        kickPlayer(source, "[AC] : Weapon Hack")
    end
  end
end
addEventHandler("onPlayerWeaponSwitch", getRootElement(), detectWeaponCheat)
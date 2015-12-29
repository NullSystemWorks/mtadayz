--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: loot_player.lua						*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]

function onPlayerTakeItemFromGround (itemName,col)
	itemPlus = 1
	if itemName == "11.43x23mm Cartridge" then
		itemPlus = 7
	elseif itemName == "9x18mm Cartridge" then
		itemPlus = 8
	elseif itemName == "9x19mm Cartridge" then
		itemPlus = 17
	elseif itemName == ".303 British Cartridge" then
		itemPlus = 10
	elseif itemName == "5.45x39mm Cartridge" then
		itemPlus = 30
	elseif itemName == "7.62x39mm Cartridge" then
		itemPlus = 30
	elseif itemName == "7.62x51mm Cartridge" then
		itemPlus = 20
	elseif itemName == "5.56x45mm Cartridge" then
		itemPlus = 20
	elseif itemName == "7.62x54mm Cartridge" then
		itemPlus = 10
	elseif itemName == "1866 Slug" then
		itemPlus = 15
	elseif itemName == "12 Gauge Pellet" then
		itemPlus = 7
	elseif itemName == "M136 Rocket" then
		itemPlus = 0
	elseif itemName == "Bolt" then
		itemPlus = 7
	elseif itemName == "Bizon PP-19 SD" or itemName == "Lee Enfield" or itemName == "AK-74" or itemName == "AKS-74U" or itemName == "RPK" or itemName == "AKM" or itemName == "Sa58V CCO" or itemName == "Sa58V RCO" or itemName == "FN FAL" or itemName == "M24" or itemName == "DMR" or itemName == "M40A3" or itemName == "G36A CAMO" or itemName == "G36C" or itemName == "G36C CAMO" or itemName == "G36K CAMO" or itemName == "L85A2 RIS Holo" or itemName == "M16A2" or itemName == "M16A2 M203" or itemName == "M4A1" or itemName == "M16A4" or itemName == "CZ 550" or itemName == "SVD Dragunov" or itemName == "Mosin-Nagant" or itemName == "Winchester 1866" or itemName == "Double-barreled Shotgun" or itemName == "M1014" or itemName == "Remington 870" or itemName == "Compound Crossbow" or itemName == "Hatchet" then
		removeBackWeaponOnDrop()	
	end
	local x,y,z = getElementPosition(source)
	local id,ItemType = getItemTablePosition (itemName)
	destroyElement(getElementData(col,"parent"))
	destroyElement(col)
	setElementData(client,itemName,(getElementData(client,itemName) or 0)+itemPlus)
	local theTime = getRealTime()
	local hour = theTime.hour
	local minute = theTime.minute
	local seconds = theTime.second
	local theAccount = getPlayerAccount(client)
	if hour < 10 then
		hour = "0"..hour
	else
		hour = theTime.hour
	end
	if minute < 10 then
		minute  = "0"..minute
	else
		minute = theTime.minute
	end
	if seconds < 10 then
		minute = "0"..seconds
	else
		seconds = theTime.second
	end
	exports.DayZ:saveLog("[DayZ] ["..hour..":"..minute..":"..seconds.."] "..getAccountName(theAccount).." picked up from ground: "..itemName.."\n","game")
	outputDebugString("[DayZ] ["..hour..":"..minute..":"..seconds.."] "..getAccountName(theAccount).." picked up from ground: "..itemName,0,0,255,0)
end
addEvent( "onPlayerTakeItemFromGround", true )
addEventHandler( "onPlayerTakeItemFromGround", getRootElement(), onPlayerTakeItemFromGround )

function onPlayerChangeLoot(loot)
local players = getElementsWithinColShape (loot,"player")
	for theKey,player in ipairs(players) do 
		triggerClientEvent(player,"refreshLootManual",player,loot)
	end	
end
addEvent( "onPlayerChangeLoot", true )
addEventHandler( "onPlayerChangeLoot", getRootElement(), onPlayerChangeLoot )

function getItemTablePosition (itema)
	for id, item in ipairs(buildingClasses[tostring("other")]) do
		if itema == item[1] then
			return id,"other"
		end
	end

	return item,itemString
end

function playerDropAItem(itemName)
	local x,y,z = getElementPosition(source)
	local item,itemString = getItemTablePosition(itemName)
	local itemPickup = createItemPickup(item,x+math.random(-1.25,1.25),y+math.random(-1.25,1.25),z,itemString)
	local theTime = getRealTime()
	local hour = theTime.hour
	local minute = theTime.minute
	local seconds = theTime.second
	local theAccount = getPlayerAccount(client)
	if hour < 10 then
		hour = "0"..hour
	else
		hour = theTime.hour
	end
	if minute < 10 then
		minute  = "0"..minute
	else
		minute = theTime.minute
	end
	if seconds < 10 then
		minute = "0"..seconds
	else
		seconds = theTime.second
	end
	exports.DayZ:saveLog("[DayZ] ["..hour..":"..minute..":"..seconds.."] "..getAccountName(theAccount).." dropped to ground: "..itemName.."\r\n","game")
	outputDebugString("[DayZ] ["..hour..":"..minute..":"..seconds.."] "..getAccountName(theAccount).." dropped to ground: "..itemName,0,0,255,0)
end
addEvent( "playerDropAItem", true )
addEventHandler( "playerDropAItem", getRootElement(), playerDropAItem )

--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: functions_gear.lua					*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: CLIENT														*----
#-----------------------------------------------------------------------------#
]]


function hideInventoryManual()
	closeInventory()
end
addEvent("hideInventoryManual", true)
addEventHandler("hideInventoryManual", localPlayer, hideInventoryManual)

function refreshInventoryManual()
	placeItemsInInventory()
end
addEvent("refreshInventoryManual", true)
addEventHandler("refreshInventoryManual", localPlayer, refreshInventoryManual)

function refreshLootManual(loot)
	refreshLoot(loot)
end
addEvent("refreshLootManual", true)
addEventHandler("refreshLootManual", localPlayer, refreshLootManual)

function getPlayerMaxAviableSlots()
	return getElementData(localPlayer, "MAX_Slots")
end
--[[
function getPlayerMaxAviableSlots()
	return getElementData(localPlayer, "Item_Slots")
end
]]

function getPlayerMaxAvailableWeaponSlots()
	return getElementData(localPlayer,"Weapon_Slots")
end

function getPlayerMaxAvailableBackpackSlots()
	return getElementData(localPlayer,"Backpack_Item_Slots")
end

function getPlayerMaxAvailableWeaponBackpackSlots()
	return getElementData(localPlayer,"Backpack_Weapon_Slots")
end

function getLootMaxAviableSlots(loot)
	if isElement ( loot ) then
		return getElementData(loot, "MAX_Slots")
	else
		return 0
	end
end

function moveItemOutOfInventory(itemName)
if playerMovedInInventory then startRollMessage2("Inventory", "Abusing exploits will result in a ban!", 255, 22, 0) return true end
	if getElementData(localPlayer, itemName) and getElementData(localPlayer, itemName) >= 1 then
		if isPlayerInLoot() then
			local isVehicle = getElementData(isPlayerInLoot(), "vehicle")
			local isTent = getElementData(isPlayerInLoot(), "tent")
			if isVehicle and not isTent then
				local veh = getElementData(isPlayerInLoot(), "parent")
				local tires,engine,parts,scrap,glass,rotary = getVehicleAddonInfos(getElementModel(veh))
				if itemName == "Tire" then itemName = "Tire" end
				if itemName == "Engine" then itemName = "Engine" end
				if itemName == "Tank Parts" then itemName = "Parts" end
				if itemName == "Scrap Metal" then itemName = "Scrap" end
				if itemName == "Windscreen Glass" then itemName = "Glass" end
				if itemName == "Main Rotary Parts" then itemName = "Rotary" end
				if not getElementData(isPlayerInLoot(), itemName.."_inVehicle") then setElementData(isPlayerInLoot(), itemName .. "_inVehicle", 0) end
				if (itemName == "Tire" and tires > 0 and getElementData ( isPlayerInLoot(), "Tire_inVehicle") < tires) or ( itemName == "Engine" and engine > 0 and getElementData ( isPlayerInLoot(), "Engine_inVehicle") < engine) or ( itemName == "Parts" and parts > 0 and getElementData ( isPlayerInLoot(), "Parts_inVehicle") < parts) or ( itemName == "Scrap" and scrap > 0 and getElementData ( isPlayerInLoot(), "Scrap_inVehicle") < scrap) or ( itemName == "Glass" and glass > 0 and getElementData ( isPlayerInLoot(), "Glass_inVehicle") < glass) or ( itemName == "Rotary" and rotary > 0 and getElementData ( isPlayerInLoot(), "Rotary_inVehicle") < rotary) then
					triggerEvent("onPlayerMoveItemOutOFInventory", localPlayer, itemName.."_inVehicle", isPlayerInLoot())
				else
					if itemName == "Tire" then itemName = "Tire" end
					if itemName == "Engine" then itemName = "Engine" end
					if itemName == "Parts" then itemName = "Tank Parts" end
					if itemName == "Scrap" then itemName = "Scrap Metal" end
					if itemName == "Glass" then itemName = "Winscreen Glass" end
					if itemName == "Rotary" then itemName = "Main Rotary Parts" end
					if isToolbeltItem(itemName) or getLootCurrentSlots(getElementData(localPlayer, "currentCol")) + getItemSlots(itemName) <= getLootMaxAviableSlots(isPlayerInLoot()) then
						triggerEvent("onPlayerMoveItemOutOFInventory", localPlayer, itemName, isPlayerInLoot())
					else
						startRollMessage2("Inventory","Vehicle's inventory is full!",255,22,0)
					end
				end
				playerMovedInInventory = true
				setTimer(function()
					playerMovedInInventory = false
				end, 700, 1)
			elseif isToolbeltItem(itemName) or getLootCurrentSlots(getElementData(localPlayer, "currentCol")) + getItemSlots(itemName) <= getLootMaxAviableSlots(isPlayerInLoot()) then
				triggerEvent("onPlayerMoveItemOutOFInventory", localPlayer, itemName, isPlayerInLoot())
				playerMovedInInventory = true
				setTimer(function()
					playerMovedInInventory = false
				end, 700, 1)
			else
				startRollMessage2("Inventory", "Inventory is full!", 255, 22, 0)
				return true
			end
			local col = getElementData(localPlayer, "currentCol")
			setTimer(placeItemsInInventory, 200, 2)
		else
			triggerEvent("onPlayerMoveItemOutOFInventory", localPlayer, itemName, false)
			setTimer(placeItemsInInventory, 200, 2)
		end
	end
end

function onPlayerMoveItemOutOFInventory (itemName,loot)
local itemPlus = 1
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
	elseif itemName == ".308 Winchester Cartridge" then
		itemPlus = 8
	elseif itemName == "7.62x54mm Cartridge" then
		itemPlus = 10
	elseif itemName == "1866 Slug" then
		itemPlus = 15
	elseif itemName == "12 Gauge Pellet" then
		itemPlus = 7
	elseif itemName == "Bolt" then
		itemPlus = 7
	elseif itemName == "Lee Enfield" or itemName == "AK-74" or itemName == "AKS-74U" or itemName == "RPK" or itemName == "AKM" or itemName == "Sa58V CCO" or itemName == "Sa58V RCO" or itemName == "FN FAL" or itemName == "M24" or itemName == "DMR" or itemName == "M40A3" or itemName == "G36A CAMO" or itemName == "G36C" or itemName == "G36C CAMO" or itemName == "G36K CAMO" or itemName == "L85A2 RIS Holo" or itemName == "M16A2" or itemName == "M16A2 M203" or itemName == "M16A2" or itemName == "M16A4" or itemName == "CZ 550" or itemName == "SVD Dragunov" or itemName == "Mosin-Nagant" or itemName == "Winchester 1866" or itemName == "Double-barreled Shotgun" or itemName == "M1014" or itemName == "Remington 870" or itemName == "Compound Crossbow" or itemName == "Hatchet" or itemName == "Bizon PP-19 SD" or itemName == "MP5A5" then
		triggerServerEvent("removeBackWeaponOnDrop",localPlayer)
	end
	if loot then
		if not getElementData(loot,"itemloot") and getElementType(getElementData(loot,"parent")) == "vehicle" then
			if itemName == "Full Gas Canister" then
				if getElementData(loot,"fuel")+20 < getVehicleMaxFuel(loot) then
					addingfuel = 20
				elseif getElementData(loot,"fuel")+20 > getVehicleMaxFuel(loot)+15 then
					triggerEvent ("displayClientInfo", localPlayer,"Vehicle","The tank is full!",255,22,0) 
					return
				else
					addingfuel = getVehicleMaxFuel(loot)-getElementData(loot,"fuel")
				end
				setElementData(loot,"fuel",getElementData(loot,"fuel")+addingfuel)
				playSound(":DayZ/sounds/items/refuel.ogg",false)
			setElementData(localPlayer,itemName,getElementData(localPlayer,itemName)-itemPlus)
			setElementData(localPlayer,"Empty Gas Canister",(getElementData(localPlayer,"Empty Gas Canister") or 0)+itemPlus) 
			triggerEvent ("displayClientInfo", localPlayer,"Vehicle","Filled gas into vehicle!",22,255,0) 
			return
			end
		end
	end
	itemName2 = itemName
	if itemName == "Tire_inVehicle" then itemName2 = "Tire" end
	if itemName == "Engine_inVehicle" then itemName2 = "Engine" end
	if itemName == "Parts_inVehicle" then itemName2 = "Tank Parts" end
	if itemName == "Scrap_inVehicle" then itemName2 = "Scrap Metal" end
	if itemName == "Glass_inVehicle" then itemName2 = "Windscreen Glass" end
	if itemName == "Rotary_inVehicle" then itemName2 = "Main Rotary Parts" end
	if loot then
		setElementData(loot,itemName,(getElementData(loot,itemName) or 0)+1)
		local players = getElementsWithinColShape (loot,"player")
			if #players > 1 then
				triggerServerEvent("onPlayerChangeLoot",getRootElement(),loot)
			end	
		if not getElementData(loot,"itemloot") and getElementType(getElementData(loot,"parent")) == "vehicle" then
		end
	else
		triggerServerEvent("playerDropAItem",localPlayer,itemName)
	end
	if itemName == "Tire_inVehicle" then itemName = "Tire" end
	if itemName == "Engine_inVehicle" then itemName = "Engine" end
	if itemName == "Parts_inVehicle" then itemName = "Tank Parts" end
	if itemName == "Scrap_inVehicle" then itemName = "Scrap Metal" end
	if itemName == "Glass_inVehicle" then itemName = "Windscreen Glass" end
	if itemName == "Rotary_inVehicle" then itemName = "Main Rotary Parts" end
	setElementData(localPlayer,itemName,getElementData(localPlayer,itemName)-itemPlus)
	if loot and getElementData(loot,"itemloot") then
		triggerServerEvent("refreshItemLoot",getRootElement(),loot,getElementData(loot,"parent"))
	end
end
addEvent( "onPlayerMoveItemOutOFInventory", true )
addEventHandler( "onPlayerMoveItemOutOFInventory", getRootElement(), onPlayerMoveItemOutOFInventory )

function refreshLoot()
	return true
end

function onPlayerMoveItemInInventory(itemName,loot)
	local itemPlus = 1
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
	elseif itemName == ".308 Winchester Cartridge" then
		itemPlus = 8
	elseif itemName == "7.62x54mm Cartridge" then
		itemPlus = 10
	elseif itemName == "1866 Slug" then
		itemPlus = 15
	elseif itemName == "12 Gauge Pellet" then
		itemPlus = 7
	elseif itemName == "Bolt" then
		itemPlus = 7
	elseif itemName == "Assault Pack (ACU)" then
		itemPlus = 1
	elseif itemName == "Czech Vest Pouch" then
		itemPlus = 1
	elseif itemName == "ALICE Pack" then
		itemPlus = 1	
	elseif itemName == "Survival ACU" then
		itemPlus = 1
	elseif itemName == "British Assault Pack" then
		itemPlus = 1
	elseif itemName == "Backpack (Coyote)" then
		itemPlus = 1
	elseif itemName == "Czech Backpack" then
		itemPlus = 1
	end
	if not getElementData(localPlayer, itemName) then
		setElementData(localPlayer, itemName, itemPlus)
	else
		setElementData(localPlayer, itemName, getElementData(localPlayer, itemName )+itemPlus)
	end
	if itemPlus == 0 then
		setElementData(loot, itemName, getElementData(loot, itemName) - 0)
	else
		setElementData(loot, itemName, getElementData(loot, itemName) - 1)
	end
	local players = getElementsWithinColShape(loot, "player")
	if #players > 1 then
		triggerServerEvent("onPlayerChangeLoot", getRootElement(), loot)
	end
	if getElementData(loot, "itemloot") then
		triggerServerEvent("refreshItemLoot", getRootElement(), loot, getElementData(loot, "parent"))
	end
end
addEvent("onPlayerMoveItemInInventory", true)
addEventHandler("onPlayerMoveItemInInventory", getRootElement(), onPlayerMoveItemInInventory)

function onPlayerMoveItemIntoBackpack(itemName, itemType, itemSize)
	local itemPlus = 1
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
	elseif itemName == ".308 Winchester Cartridge" then
		itemPlus = 8
	elseif itemName == "7.62x54mm Cartridge" then
		itemPlus = 10
	elseif itemName == "1866 Slug" then
		itemPlus = 15
	elseif itemName == "12 Gauge Pellet" then
		itemPlus = 7
	elseif itemName == "Bolt" then
		itemPlus = 7
	elseif itemName == "Assault Pack (ACU)" then
		itemPlus = 1
	elseif itemName == "Czech Vest Pouch" then
		itemPlus = 1
	elseif itemName == "ALICE Pack" then
		itemPlus = 1	
	elseif itemName == "Survival ACU" then
		itemPlus = 1
	elseif itemName == "British Assault Pack" then
		itemPlus = 1
	elseif itemName == "Backpack (Coyote)" then
		itemPlus = 1
	elseif itemName == "Czech Backpack" then
		itemPlus = 1
	end
	if itemType == "weapon" then
		setElementData(localPlayer,"Weapon_Slots",getElementData(localPlayer,"Weapon_Slots")-1)
		setElementData(localPlayer,"Backpack_Weapon_Slots",getElementData(localPlayer,"Backpack_Weapon_Slots")+1)
	elseif itemType == "item" then
		setElementData(localPlayer,"Item_Slots",getElementData(localPlayer,"Item_Slots")-itemSize)
		setElementData(localPlayer,"Backpack_Item_Slots",getElementData(localPlayer,"Backpack_Item_Slots")+itemSize)
	end
end
addEvent("onPlayerMoveItemIntoBackpack", true)
addEventHandler("onPlayerMoveItemIntoBackpack", getRootElement(), onPlayerMoveItemIntoBackpack)

function onClientOpenInventoryStopMenu()
  triggerEvent("disableMenu", localPlayer)
end

function isPlayerInLoot()
	if getElementData(localPlayer, "loot") then
		return getElementData(localPlayer, "currentCol")
	end
	return false
end

local playerFire = {}
local fireCounter = 0
function playerUseItem(itemName,itemInfo)
	if itemInfo == "Drink" then
		if getElementData(localPlayer,itemName) >= 1 then
			if itemName == "Water Bottle" then
				playSound(":DayZ/sounds/items/drink_0.ogg",false)
			else
				playSound(":DayZ/sounds/items/drinksoda.ogg",false)
			end
			triggerServerEvent("onPlayerRequestChangingStats",localPlayer,itemName,itemInfo,"thirst")
		end
	elseif itemInfo == "Eat" then
		if getElementData(localPlayer,itemName) >= 1 then
			local number = math.random(0,3)
			playSound(":DayZ/sounds/items/eat_"..number..".ogg",false)
			triggerServerEvent("onPlayerRequestChangingStats",localPlayer,itemName,itemInfo,"food")
		end
	elseif itemInfo == "Put clothes on" then
		triggerServerEvent("onPlayerChangeSkin",localPlayer,itemName)
	elseif itemName == "Empty Water Bottle" then
		triggerServerEvent("onPlayerRefillWaterBottle",localPlayer,itemName)		
	elseif itemName == "Tent" then
		playSound(":DayZ/sounds/items/tentunpack.ogg",false)
		triggerServerEvent("onPlayerPitchATent",localPlayer,itemName)
	elseif itemInfo == "Build a wire fence"	then
		triggerServerEvent("onPlayerBuildAWireFence",localPlayer,itemName)
	elseif itemName == "Road Flare" then
		triggerServerEvent("onPlayerPlaceRoadflare",localPlayer,itemName)	
	elseif itemInfo == "Make a Fire" then
		if getElementData (localPlayer,"Wood Pile") > 0 then
			triggerServerEvent("onPlayerMakeAFire", localPlayer, itemName)
		else
			triggerEvent("displayClientInfo", localPlayer, "Matches", "You need a Wood Pile!", 22, 255, 0)
		end	
	elseif itemInfo == "Use" then
		triggerServerEvent("onPlayerUseMedicObject",localPlayer,itemName)
    elseif itemInfo == "Heat" then
        triggerServerEvent("onPlayerUseMedicObject",localPlayer,itemName)
    elseif itemInfo == "Painkiller" then
		local number = math.random(0,3)
		playSound(":DayZ/sounds/items/painkiller_"..number..".ogg",false)
        triggerServerEvent("onPlayerUseMedicObject",localPlayer,itemName)
    elseif itemInfo == "Morphine" then
        triggerServerEvent("onPlayerUseMedicObject",localPlayer,itemName)
    elseif itemName == "Bandage" then
		local number = math.random(0,1)
		playSound(":DayZ/sounds/items/bandage_"..number..".ogg",false)
        triggerServerEvent("onPlayerUseMedicObject",localPlayer,itemName)  
	elseif itemName == "Blood Bag" then
		triggerServerEvent("onPlayerUseMedicObject",localPlayer,itemName)
    elseif itemInfo == "Use Googles" then
        triggerServerEvent("onPlayerChangeView",localPlayer,itemName)  
    elseif itemInfo == "Equip Primary Weapon" then
		isCarryingWeapon = false
		isHoldingWeapon = true
        triggerServerEvent("onPlayerRearmWeapon",localPlayer,itemName,1)
    elseif itemInfo == "Equip Secondary Weapon" then
        triggerServerEvent("onPlayerRearmWeapon",localPlayer,itemName,2)
    elseif itemInfo == "Equip Special Weapon" then
        triggerServerEvent("onPlayerRearmWeapon",localPlayer,itemName,2)
	elseif itemInfo == "Craft" then
		setElementData(localPlayer,"selectedBlueprint",itemName)
		checkComponents()
	elseif itemInfo == "Activate" then
		triggerServerEvent("onPlayerActivateKeycard",localPlayer,itemName)
	elseif itemInfo == "Test Blood" then
		closeInventory()
		activateBloodTest()
		setElementData(localPlayer, "Blood Test Kit", getElementData(localPlayer, "Blood Test Kit")-1)
	elseif itemInfo == "Transfusion" then
		closeInventory()
		triggerServerEvent("onPlayerTransfuseBlood",localPlayer)
	elseif itemInfo == "Equip Backpack" then
		if itemName == "Assault Pack (ACU)" then
			if getPlayerCurrentSlots() <= 12 then
				triggerServerEvent("onPlayerEquipBackpack",localPlayer,itemName)
			else
				startRollMessage2("Backpack","This backpack is too small.",255,0,0)
			end
		elseif itemName == "Czech Vest Pouch" then
			if getPlayerCurrentSlots() <= 13 then
				triggerServerEvent("onPlayerEquipBackpack",localPlayer,itemName)
			else
				startRollMessage2("Backpack","This backpack is too small.",255,0,0)
			end
		elseif itemName == "ALICE Pack" then
			if getPlayerCurrentSlots() <= 16 then
				triggerServerEvent("onPlayerEquipBackpack",localPlayer,itemName)
			else
				startRollMessage2("Backpack","This backpack is too small.",255,0,0)
			end
		elseif itemName == "Survival ACU" then
			if getPlayerCurrentSlots() <= 17 then
				triggerServerEvent("onPlayerEquipBackpack",localPlayer,itemName)
			else
				startRollMessage2("Backpack","This backpack is too small.",255,0,0)
			end
		elseif itemName == "British Assault Pack" then
			if getPlayerCurrentSlots() <= 18 then
				triggerServerEvent("onPlayerEquipBackpack",localPlayer,itemName)
			else
				startRollMessage2("Backpack","This backpack is too small.",255,0,0)
			end
		elseif itemName == "Backpack (Coyote)" then
			if getPlayerCurrentSlots() <= 24 then
				triggerServerEvent("onPlayerEquipBackpack",localPlayer,itemName)
			else
				startRollMessage2("Backpack","This backpack is too small.",255,0,0)
			end
		elseif itemName == "Czech Backpack" then
			if getPlayerCurrentSlots() <= 30 then
				triggerServerEvent("onPlayerEquipBackpack",localPlayer,itemName)
			else
				startRollMessage2("Backpack","This backpack is too small.",255,0,0)
			end
		end
	end
end

function onWeaponFireDeductAmmo(weapon)
	if source == localPlayer then
		local weapon_1 = getElementData(source,"currentweapon_1")
		local weapon_2 = getElementData(source,"currentweapon_2")
		local ammoName
		if weapon == 25 or weapon == 26 or weapon == 27 or weapon == 30 or weapon == 31 or weapon == 33 or weapon == 34 then
			ammoName = getWeaponAmmoFromName(weapon_1)
		else
			ammoName = getWeaponAmmoFromName(weapon_2)
		end
		if getElementData(localPlayer,ammoName) > 0 then
			setElementData(localPlayer,ammoName,getElementData(localPlayer,ammoName)-1)
		end
	end
end
addEventHandler ("onClientPlayerWeaponFire",localPlayer,onWeaponFireDeductAmmo)

setRadioChannel(0)
function makeRadioStayOff()
	setRadioChannel(0)
	cancelEvent()
end
addEventHandler("onClientPlayerRadioSwitch",getRootElement(),makeRadioStayOff)
--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: world_loot.lua						*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]

--[[
DYNAMIC RESOURCES SYSTEM

The way it works:

Each possible loot spawnpoint in the world has one buildingClass, denoted in the table buildingClasses. Items in their respective part
of the table are GUARANTEED to spawn, though their chances are all different from each other. Now, some parts of table have a comment
in them, for example, " -- generic: 56.02%. 
This means that there is a 56.02% that an item from the table called "lootpileType", section ["generic"], will spawn. Between 2-5 items
will spawn if the roll is sucessful, meaning each lootpile will always have at least 2-5 different items.

This is achieved by first rolling a value between 0 and 99, and if it's above a certain value denoted in the table, the respective
lootpileType will be called. Then, another roll gets executed which determines what items are going to spawn. Items in the lootpileType
tables all have their own chance.

Blueprints and their parts only spawn in industrial spawnpoints, and are randomly generated too.

]]

function createItemPickup(item,x,y,z,tableStringName)
	if item and x and y and z then
		local object = createObject(buildingClasses[tostring(tableStringName)][item][2],x,y,z-0.875,buildingClasses[tostring(tableStringName)][item][4],0,math.random(0,360))
		setObjectScale(object,buildingClasses[tostring(tableStringName)][item][3])
		setElementCollisionsEnabled(object, false)
		setElementFrozen (object,true)
		local col = createColSphere(x,y,z,0.75)
		setElementData(col,"item",buildingClasses[tostring(tableStringName)][item][1])
		setElementData(col,"parent",object)
		setTimer(function()
			if isElement(col) then
				destroyElement(col)
				destroyElement(object)
			end	
		end,900000,1)
		return object
	end
end

function createItemLoot (lootPlace,x,y,z,id)
	col = createColSphere(x,y,z,1.25)
	setElementData(col,"itemloot",true)
	setElementData(col,"parent",lootPlace)
	setElementData(col,"MAX_Slots",20)
	--Items
	for i, item in ipairs(buildingClasses[lootPlace]) do
		local value =  math.percentChance(item[5],math.random(1,5))
		setElementData(col,item[1],value)
		--weapon Ammo
		local ammoData,weapID = getWeaponAmmoType (item[1],true)
		if ammoData and value > 0 then
			setElementData(col,ammoData,math.random(1,3))
		end
	end
	--itemLoot
	refreshItemLoot (col,lootPlace)
	
	return col
end

function refreshItemLoot (col,place)
	local objects = getElementData(col,"objectsINloot")
	if objects then
		if objects[1] ~= nil then
			destroyElement(objects[1])
		end
		if objects[2] ~= nil then
			destroyElement(objects[2])
		end
		if objects[3] ~= nil then
			destroyElement(objects[3])
		end
	end
	--setting objects
	local counter = 0
	local obejctItem = {}
	--Tables
	for i, item in ipairs(buildingClasses["other"]) do
		if getElementData(col,item[1]) and getElementData(col,item[1]) > 0 then
			if counter == 3 then
				break
			end	
			counter = counter + 1
			local x,y,z = getElementPosition(col)
			obejctItem[counter] = createObject(item[2],x+math.random(-1,1),y+math.random(-1,1),z-0.875,item[4])
			setObjectScale(obejctItem[counter],item[3])
			setElementCollisionsEnabled(obejctItem[counter], false)
			setElementFrozen (obejctItem[counter],true)
		end
	end
	-------Debug
	if obejctItem[1] == nil then
		local x,y,z = getElementPosition(col)
		obejctItem[1] = createObject(1463,x+math.random(-1,1),y+math.random(-1,1),z-0.875,0)
		setObjectScale(obejctItem[1],0)
		setElementCollisionsEnabled(obejctItem[1], false)
		setElementFrozen (obejctItem[1],true)
	end
	if obejctItem[2] == nil then
		local x,y,z = getElementPosition(col)
		obejctItem[2] = createObject(1463,x+math.random(-1,1),y+math.random(-1,1),z-0.875,0)
		setObjectScale(obejctItem[2],0)
		setElementCollisionsEnabled(obejctItem[2], false)
		setElementFrozen (obejctItem[2],true)
	end
	if obejctItem[3] == nil then
		local x,y,z = getElementPosition(col)
		obejctItem[3] = createObject(1463,x+math.random(-1,1),y+math.random(-1,1),z-0.875,0)
		setObjectScale(obejctItem[3],0)
		setElementCollisionsEnabled(obejctItem[3], false)
		setElementFrozen (obejctItem[3],true)
	end
	setElementData(col,"objectsINloot",{obejctItem[1], obejctItem[2], obejctItem[3]})
end
addEvent( "refreshItemLoot", true )
addEventHandler( "refreshItemLoot", getRootElement(), refreshItemLoot )

generic_items = false
military_items = false
trash_items = false
blueprint_items = false

local async = Async()
async:setPriority("normal")

function insertIntoTableResidential()
	local value_generic = math.random(0,200)/2
	local value_military = math.random(0,200)/2
	local value_trash = math.random(0,200)/2
	if value_generic <= 56 then
		table.merge(buildingClasses["Residential"],lootpileType["generic"])
	end
	if value_military <= 24 then
		table.merge(buildingClasses["Residential"],lootpileType["food"])
	end
	if value_trash <= 14 then
		table.merge(buildingClasses["Residential"],lootpileType["trash"])
	end
	setTimer(insertIntoTableIndustrial,30000,1)
end

function createPickupsOnServerStart()
        iPickup = 0
        async:foreach(pickupPositions["Residential"],
            function(pos)
                iPickup = iPickup + 1
                createItemLoot("Residential", pos[1], pos[2], pos[3], iPickup)
            end
        )
    setTimer(createPickupsOnServerStart2, 60000, 1)
end

function insertIntoTableIndustrial()
local value_generic = math.random(0,200)/2
local value_military = math.random(0,200)/2
local value_trash = math.random(0,200)/2
local value_blueprint = math.random(0,200)/2
	if value_generic <= 18 then
		table.merge(buildingClasses["Industrial"],lootpileType["generic"])
	end
	if value_military <= 4  then
		table.merge(buildingClasses["Industrial"],lootpileType["military"])
	end
	if value_trash <= 28 then
		table.merge(buildingClasses["Industrial"],lootpileType["trash"])
	end
	for i,item in ipairs(lootpileType["BlueprintParts"]) do
		if value_blueprint <= 10 then
			local whatitem = math.percentChance(item[5],math.random(1,3))
			if item[1] and whatitem == 1 then
				blueprint_items = {item[1],item[2],item[3],item[4],item[5]}
				table.insert(buildingClasses["Industrial"],blueprint_items)
			end
		end
	end
	setTimer(insertIntoTableFarm,30000,1)
end

function createPickupsOnServerStart2()
	for i,pos in ipairs(pickupPositions["industrial"]) do
		iPickup = iPickup + 1
		createItemLoot("Industrial",pos[1],pos[2],pos[3],iPickup)
	end
	setTimer(createPickupsOnServerStart3,60000,1)
end

function insertIntoTableFarm()
local value_generic = math.random(0,200)/2
local value_military = math.random(0,200)/2
local value_trash = math.random(0,200)/2
	if value_generic <= 27 then
		table.merge(buildingClasses["Farm"],lootpileType["generic"])
	end
	if value_trash <= 22 then
		table.merge(buildingClasses["Farm"],lootpileType["trash"])
	end
	setTimer(insertIntoTableSuperMarket,30000,1)
end

function createPickupsOnServerStart3()
	for i,pos in ipairs(pickupPositions["farm"]) do
		iPickup = iPickup + 1
		createItemLoot("Farm",pos[1],pos[2],pos[3],iPickup)
	end
	setTimer(createPickupsOnServerStart4,60000,1)
end

function insertIntoTableSuperMarket()
local value_generic = math.random(0,200)/2
local value_military = math.random(0,200)/2
local value_trash = math.random(0,200)/2
	if value_generic <= 5 then
		table.merge(buildingClasses["Supermarket"],lootpileType["generic"])
	end
	if value_military <= 28 then
		table.merge(buildingClasses["Supermarket"],lootpileType["food"])
	end
	if value_trash <= 14 then
		table.merge(buildingClasses["Supermarket"],lootpileType["trash"])
	end
	setTimer(insertIntoTableMilitary,30000,1)
end

function createPickupsOnServerStart4()
	for i,pos in ipairs(pickupPositions["supermarket"]) do
		iPickup = iPickup + 1
		createItemLoot("Supermarket",pos[1],pos[2],pos[3],iPickup)
	end
	setTimer(createPickupsOnServerStart5,60000,1)
end

function insertIntoTableMilitary()
local value_generic = math.random(0,200)/2
local value_military = math.random(0,200)/2
local value_trash = math.random(0,200)/2
	if value_generic <= 18 then
		table.merge(buildingClasses["Military"],lootpileType["generic"])
	end
	if value_military <= 48 then
		table.merge(buildingClasses["Military"],lootpileType["military"])
	end
	if value_trash <= 2 then
		table.merge(buildingClasses["Military"],lootpileType["medical"])
	end
end

function createPickupsOnServerStart5()
	for i,pos in ipairs(pickupPositions["military"]) do
		iPickup = iPickup + 1
		createItemLoot("Military",pos[1],pos[2],pos[3],iPickup)
	end
end

setTimer(insertIntoTableResidential,5000,1)
setTimer(createPickupsOnServerStart,30000,1)
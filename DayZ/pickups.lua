fuckUp = { { { { "nothing to see here" } } } } function fuckUp:fuckUp2() return "nope" end fuckUp:fuckUp2()
--Server start requirements
--serverslots
--gamemodename
--
getResourceRootElement(getThisResource()) 
function checkResourceRequirements ( res )
	fuckUp = { { { { "nothing to see here" } } } } function fuckUp:fuckUp2() return "nope" end fuckUp:fuckUp2()
	local reason = false
	local i = string.find(getServerName(),"GTA:SA DayZ Version")
	if not i then 
		reason = "Servername incorrect! Prefix #2 is missing (GTA:SA DayZ Version)"
	elseif i > 1 then
		reason = "Servername incorrect! Prefix #2 must be at the beginning (GTA:SA DayZ Version)"		
	end
	if not string.find(getServerName(),"| community.vavegames.net |",0,true) then
		reason = "Servername incorrect! Prefix #1 is missing (| community.vavegames.net |)"
	end
	if string.find(string.lower(getServerName()),"official") then
		reason = "Servername incorrect! You are not an 'official' server!"
	end
	--use max players defined in the server config as it can't be changed after resource start unlike getMaxPlayers which can be altered using setMaxPlayers
	if tonumber(getServerConfigSetting("maxplayers")) > 77 then
		reason = "Too many slots (maximum: 77), stopping resource..."
	end
	if getResourceName(getThisResource()) ~= "DayZ" then
		reason = "Name of resource does not match (DayZ)!"
	end
	if reason ~= false then
		outputServerLog ( "Resource " .. getResourceName(res) .. " wasn't started: ("..reason..")." )
		outputChatBox ( "Resource " .. getResourceName(res) .. " wasn't started: ("..reason..").", getRootElement(), 255, 255, 255 )
		outputConsole ( "Resource " .. getResourceName(res) .. " wasn't started: ("..reason..")." )
		outputDebugString ( "Resource " .. getResourceName(res) .. " wasn't started: ("..reason..")." )
		cancelEvent()
	end	
end
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), checkResourceRequirements )


local itemTable = {
----------------------
["farm"] = {
{"Wood Pile",1463,0.4,0,13},
{"Bandage",1578,0.5,0,4},
{"Water Bottle",2683,1,0,6},
{"Pasta Can",2770,1,0,6},
{"Beans Can",2601,1,0,6},
{"Burger",2768,1,0,6},
{"Empty Soda Cans",2673,0.5,0,12},
{"Scruffy Burgers",2675,0.5,0,12},
{"Soda Bottle",2647,1,0,9},
{"Empty Gas Canister",1650,1,0,10},
{"Hunting Knife",335,1,90,4},
{"Box of Matches",328,0.4,90,8},
{"Desert Eagle",348,1,90,0.2},
{"Morphine",1579,1,0,4},
{"Tent",1279,1,0,0.5},
{"M1911",346,1,90,4},
{"Painkiller",2709,3,0,3.5},
{"Lee Enfield",357,1,90,0.3},
{"Winchester 1866",349,1,90,0.3},
{"Tire",1073,1,0,2},
{"Tank Parts",1008,1,0.8,2},
{"Civilian Clothing",1241,2,0,2.5},
{"Map",1277,0.8,90,6},
{"GPS",2976,0.15,0,2},
},
----------------------
["residential"] = {
{"Box of Matches",328,0.4,90,5},
{"Wood Pile",1463,0.4,0,5},
{"M1911",346,1,90,1.5},
{"M9 SD",347,1,90,1.9},
{"Winchester 1866",349,1,90,0.1},
{"PDW",352,1,90,1},
{"Hunting Knife",335,1,90,3},
{"Hatchet",339,1,90,1},
{"Pizza",1582,1,0,7},
{"Soda Bottle",2647,1,0,7},
{"Empty Gas Canister",1650,1,0,9},
{"Roadflare",324,1,90,9},
{"Milk",2856,1,0,7},
{"Assault Pack (ACU)",3026,1,0,6},
{"Painkiller",2709,3,0,7},
{"Empty Soda Cans",2673,0.5,0,12},
{"Scruffy Burgers",2675,0.5,0,12},
{"Grenade",342,1,0,0.01},
{"Desert Eagle",348,1,90,0.4},
{"Sawn-Off Shotgun",350,1,90,0.3},
{"SPAZ-12 Combat Shotgun",351,1,90,0.4},
{"MP5A5",353,1,90,0.4},
{"Watch",2710,1,0,3},
{"Heat Pack",1576,5,0,6},
{"Wire Fence",933,0.25,0,1},
{"Lee Enfield",357,1,90,0.3},
{"Alice Pack",1248,1,0,1.5},
{"Tire",1073,1,0,1},
{"Tank Parts",1008,0.8,0,1},
{"Morphine",1579,1,0,2},
{"Civilian Clothing",1241,2,0,9},
{"Map",1277,0.8,90,10},
{"GPS",2976,0.15,0,3},
{"Pasta Can",2770,1,0,7},
{"Beans Can",2601,1,0,7},
--{"TEC-9",372,1,90,0},
{"Burger",2768,1,0,7},
{"Golf Club",333,1,90,3},
{"Baseball Bat",336,1,90,3},
{"Shovel",337,1,90,3},
},
----------------------
["military"] = {
{"Box of Matches",328,0.4,90,2},
{"M1911",346,1,90,5},
{"M9 SD",347,1,90,4},
{"Winchester 1866",349,1,90,3},
{"PDW",352,1,90,4},
{"Hunting Knife",335,1,90,2.4},
{"Hatchet",339,1,90,2.1},
{"Pizza",1582,1,0,2},
{"Soda Bottle",2647,1,0,2},
{"Empty Gas Canister",1650,1,0,4},
{"Roadflare",324,1,90,4},
{"Milk",2856,1,0,1},
{"Painkiller",2709,3,0,4},
{"Empty Soda Cans",2673,0.5,0,12},
{"Scruffy Burgers",2675,0.5,0,12},
{"Grenade",342,1,0,0.5},
{"Sawn-Off Shotgun",350,1,90,2.3},
{"SPAZ-12 Combat Shotgun",351,1,90,2.3},
{"MP5A5",353,1,90,2.8},
{"Watch",2710,1,0,4},
{"Heat Pack",1576,5,0,3},
{"Wire Fence",933,0.25,0,1},
{"Lee Enfield",357,1,90,3.5},
{"Alice Pack",1248,1,0,4},
{"Night Vision Goggles",368,1,90,4},
{"Binoculars",369,1,0,4},
{"Tire",1073,1,0,2},
{"Tank Parts",1008,0.8,0,2},
{"Morphine",1579,1,0,4},
{"Camouflage Clothing",1247,2,0,4.5},
{"Civilian Clothing",1241,2,0,3},
--{"TEC-9",372,1,90,3},
{"AK-47",355,1,90,3.8},
{"GPS",2976,0.15,0,3},
{"Map",1277,0.8,90,7},
{"Toolbox",2969,0.5,0,1},
{"Engine",929,0.3,0,2},
{"Tent",1279,1,0,4.5},
{"Ghillie Suit",1213,2,0,0.3},
{"M4",356,1,90,2.4},
{"CZ 550",358,1,90,0.4},
{"Infrared Goggles",369,1,90,3},
{"Assault Pack (ACU)",3026,1,0,5},
{"Czech Backpack",1239,1,0,2}, 
{"Radio Device",330,1,0,6},
{"Coyote Backpack",1252,1,0,0.9},
{"Shovel",337,1,90,1},
},
----------------------
["industrial"] = {
{"Wire Fence",933,0.25,0,7},
{"Toolbox",2969,0.5,0,3},
{"Tire",1073,1,0,4},
{"Engine",929,0.3,0,3.5},
{"Tank Parts",1008,1,0.8,4},
{"Winchester 1866",349,1,90,3},
{"Water Bottle",2683,1,0,4},
{"Pasta Can",2770,1,0,4},
{"Beans Can",2601,1,0,4},
{"Burger",2768,1,0,4},
{"Empty Soda Cans",2673,0.5,0,12},
{"Scruffy Burgers",2675,0.5,0,10},
{"Soda Bottle",2647,1,0,4},
{"Empty Gas Canister",1650,1,0,6},
{"Full Gas Canister",1650,1,0,1.5},
{"Map",1277,0.8,90,3},
{"Watch",2710,1,0,2},
{"Box of Matches",328,0.4,90,5},
{"Wood Pile",1463,0.4,0,2},
{"M1911",346,1,90,1.5},
{"PDW",352,1,90,2},
{"Hunting Knife",335,1,90,2},
{"Hatchet",339,1,90,1.5},
{"Pizza",1582,1,0,4},
{"Roadflare",324,1,90,5},
{"Milk",2856,1,0,4},
{"Assault Pack (ACU)",3026,1,0,6},
{"Coyote Backpack",1252,1,0,0.5},
{"Radio Device",330,1,0,6},
{"Golf Club",333,1,90,1.5},
{"Baseball Bat",336,1,90,1.5},
{"Shovel",337,1,90,1.5},
{"Night Vision Goggles",368,1,90,1.5},
},
----------------------
["supermarket"] = {
{"Raw Meat",2804,0.5,90,8},
{"Box of Matches",328,0.4,90,5},
{"Wood Pile",1463,0.4,0,5},
{"M1911",346,1,90,3.5},
{"PDW",352,1,90,2},
{"Hunting Knife",335,1,90,3},
{"Hatchet",339,1,90,2.1},
{"Pizza",1582,1,0,7},
{"Soda Bottle",2647,1,0,7},
{"Empty Gas Canister",1650,1,0,5},
{"Roadflare",324,1,90,6},
{"Milk",2856,1,0,7},
{"Assault Pack (ACU)",3026,1,0,6},
{"Pasta Can",2770,1,0,7},
{"Beans Can",2601,1,0,7},
{"Burger",2768,1,0,7},
{"Painkiller",2709,3,0,7},
{"Empty Soda Cans",2673,0.5,0,12},
{"Scruffy Burgers",2675,0.5,0,12},
{"MP5A5",353,1,90,0.5},
{"Watch",2710,1,0,3},
{"Heat Pack",1576,5,0,6},
{"Wire Fence",933,0.25,0,1},
{"Lee Enfield",357,1,90,0.2},
{"Alice Pack",1248,1,0,0.5},
{"Tire",1073,1,0,1},
{"Tank Parts",1008,1,0.8,2},
{"Morphine",1579,1,0,2},
{"Civilian Clothing",1241,2,0,3.5},
{"Map",1277,0.8,90,4},
{"GPS",2976,0.15,0,1},
{"Radio Device",330,1,0,6},
{"Golf Club",333,1,90,1.9},
{"Baseball Bat",336,1,90,1.4},
{"Shovel",337,1,90,0.3},
},
["other"] = {
{"Raw Meat",2804,0.5,90},
{"Cooked Meat",2806,0.5,90},
{"Full Gas Canister",1650,1,0},
{"Empty Water Bottle",2683,1,0},
{"Survivor Clothing",1577,2,0},
{"Night Vision Goggles",368,1,90},
{"Infrared Goggles",369,1,90},
{"1866 Slug",2358,2,0},
{"2Rnd. Slug",2358,2,0},
{"SPAZ-12 Pellet",2358,2,0},
{"MP5A5 Mag",2358,2,0},
{"AK Mag",1271,2,0},
{"M4 Mag",1271,2,0},
{"M1911 Mag",3013,2,0},
{"M9 SD Mag",3013,2,0},
{"Desert Eagle Mag",3013,2,0},
--{"M136 Rocket",3082,0.7,90},
{"CZ 550 Mag",2358,2,0},
{"Lee Enfield Mag",2358,2,0},
{"PDW Mag",2041,2,0},
{"MP5A5 Mag",2041,2,0},
{"Box of Matches",328,0.4,90,5},
{"Wood Pile",1463,0.4,0,5},
{"M1911",346,1,90,3.5},
{"PDW",352,1,90,2},
{"Hunting Knife",335,1,90,2.5},
{"Hatchet",339,1,90,1.8},
{"Pizza",1582,1,0,7},
{"Soda Bottle",2647,1,0,7},
{"Empty Gas Canister",1650,1,0,5},
{"Roadflare",324,1,90,6},
{"Milk",2856,1,0,5},
{"Assault Pack (ACU)",3026,1,0,6},
{"Painkiller",2709,3,0,7},
{"Empty Soda Cans",2673,0.5,0,12},
{"Scruffy Burgers",2675,0.5,0,12},
{"MP5A5",353,1,90,1.5},
{"Watch",2710,1,0,3},
{"Heat Pack",1576,5,0,6},
{"Wire Fence",933,0.25,0,1},
{"Lee Enfield",357,1,90,1.5},
{"Alice Pack",1248,1,0,1.5},
{"Coyote Backpack",1252,1,0,0.7},
{"Tire",1073,1,0,1},
{"Tank Parts",1008,1,0.8,4},
{"Morphine",1579,1,0,2},
{"Civilian Clothing",1241,2,0,3.5},
{"Map",1277,0.8,90,4},
{"Toolbox",2969,0.5,0,3},
{"Engine",929,0.3,0,3.5},
{"Winchester 1866",349,1,90,2},
{"Water Bottle",2683,1,0,4},
{"M9 SD",347,1,90,5},
{"Grenade",342,1,0,0.5},
{"Sawn-Off Shotgun",350,1,90,2},
{"SPAZ-12 Combat Shotgun",351,1,90,1.9},
{"Binoculars",369,1,0,4},
{"Camouflage Clothing",1247,2,0,4.5},
--{"TEC-9",372,1,90,4},
{"AK-47",355,1,90,0.9},
{"M136 Rocket Launcher",359,1,90,0},
{"Ghillie Suit",1213,2,0,0.01},
{"M4",356,1,90,0.9},
{"CZ 550",358,1,90,0.3},
{"Heat-Seeking RPG",360,1,90,0},
{"Bandage",1578,0.5,0,4},
{"Pasta Can",2770,1,0,5},
{"Beans Can",2601,1,0,6},
{"Burger",2768,1,0,2},
{"Tent",1279,1,0,0.5},
{"M1911",346,1,90,3},
{"Desert Eagle",348,1,90,3},
{"GPS",2976,0.15,0,1},
{"Medic Kit",2891,2.2,0},
{"Blood Bag",1580,1,0},
{"Radio Device",2966,0.5,0,5},
{"Golf Club",333,1,90,1.9},
{"Baseball Bat",336,1,90,1.4},
{"Shovel",337,1,90,1.5},
},
}

weaponAmmoTable = {

["M1911 Mag"] = {
{"M1911",22},
},

["M9 SD Mag"] = {
{"M9 SD",23},
},

["Desert Eagle Mag"] = {
{"Desert Eagle",24},
},

["PDW Mag"] = {
{"PDW",28},
},

["MP5A5 Mag"] = {
{"MP5A5",29},
},

["AK Mag"] = {
{"AK-47",30},
},

["M4 Mag"] = {
{"M4",31},
},

["1866 Slug"] = {
{"Winchester 1866",25},
},

["2Rnd. Slug"] = {
{"Sawn-Off Shotgun",26},
},

["SPAZ-12 Pellet"] = {
{"SPAZ-12 Combat Shotgun",27},
},

["CZ 550 Mag"] = {
{"CZ 550",34},
},

["Lee Enfield Mag"] = {
{"Lee Enfield",33},
},

["M136 Rocket"] = {
{"Heat-Seeking RPG",36},
{"M136 Rocket Launcher",35},
},


["others"] = {
{"Parachute",46},
{"Satchel",39},
{"Tear Gas",17},
{"Grenade",16},
{"Hunting Knife",4},
{"Hatchet",8},
{"Binoculars",43},
{"Baseball Bat",5},
{"Golf Club",2},
{"Shovel",6},
{"Radio Device",1},
},
}

function getWeaponAmmoType (weaponName,notOthers)
	if not notOthers then
		for i,weaponData in ipairs(weaponAmmoTable["others"]) do
			if weaponName == weaponData[1] then
				return weaponData[1],weaponData[2]
			end
		end
	end	
	for i,weaponData in ipairs(weaponAmmoTable["M1911 Mag"]) do
		if weaponName == weaponData[1] then
			return "M1911 Mag",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["M9 SD Mag"]) do
		if weaponName == weaponData[1] then
			return "M9 SD Mag",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["Desert Eagle Mag"]) do
		if weaponName == weaponData[1] then
			return "Desert Eagle Mag",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["PDW Mag"]) do
		if weaponName == weaponData[1] then
			return "PDW Mag",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["MP5A5 Mag"]) do
		if weaponName == weaponData[1] then
			return "MP5A5 Mag",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["AK Mag"]) do
		if weaponName == weaponData[1] then
			return "AK Mag",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["M4 Mag"]) do
		if weaponName == weaponData[1] then
			return "M4 Mag",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["1866 Slug"]) do
		if weaponName == weaponData[1] then
			return "1866 Slug",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["2Rnd. Slug"]) do
		if weaponName == weaponData[1] then
			return "2Rnd. Slug",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["SPAZ-12 Pellet"]) do
		if weaponName == weaponData[1] then
			return "SPAZ-12 Pellet",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["CZ 550 Mag"]) do
		if weaponName == weaponData[1] then
			return "CZ 550 Mag",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["Lee Enfield Mag"]) do
		if weaponName == weaponData[1] then
			return "Lee Enfield Mag",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["M136 Rocket"]) do
		if weaponName == weaponData[1] then
			return "M136 Rocket",weaponData[2]
		end
	end
	return false
end



function createItemPickup(item,x,y,z,tableStringName)
	if item and x and y and z then
		local object = createObject(itemTable[tostring(tableStringName)][item][2],x,y,z-0.875,itemTable[tostring(tableStringName)][item][4],0,math.random(0,360))
		setObjectScale(object,itemTable[tostring(tableStringName)][item][3])
		setElementCollisionsEnabled(object, false)
		setElementFrozen (object,true)
		local col = createColSphere(x,y,z,0.75)
		setElementData(col,"item",itemTable[tostring(tableStringName)][item][1])
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

function table.size(tab)
    local length = 0
    for _ in pairs(tab) do length = length + 1 end
    return length
end

function math.percentChance (percent,repeatTime)
	local hits = 0
	for i = 1, repeatTime do
	local number = math.random(0,200)/2
		if number <= percent then
			hits = hits+1
		end
	end
	return hits
end

function createItemLoot (lootPlace,x,y,z,id)
	col = createColSphere(x,y,z,1.25)
	setElementData(col,"itemloot",true)
	setElementData(col,"parent",lootPlace)
	setElementData(col,"MAX_Slots",12)
	--Items
	for i, item in ipairs(itemTable[lootPlace]) do
		local value =  math.percentChance (item[5],math.random(1,2))
		setElementData(col,item[1],value)
		--weapon Ammo
		local ammoData,weapID = getWeaponAmmoType (item[1],true)
		if ammoData and value > 0 then
			setElementData(col,ammoData,math.random(1,2))
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
	for i, item in ipairs(itemTable["other"]) do
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

function createPickupsOnServerStart()
	iPickup = 0
	for i,pos in ipairs(pickupPositions["residential"]) do
		iPickup = iPickup + 1
		createItemLoot("residential",pos[1],pos[2],pos[3],iPickup)
	end
	setTimer(createPickupsOnServerStart2,5000,1)
end

function createPickupsOnServerStart2()
	for i,pos in ipairs(pickupPositions["industrial"]) do
		iPickup = iPickup + 1
		createItemLoot("industrial",pos[1],pos[2],pos[3],iPickup)
	end
	setTimer(createPickupsOnServerStart3,5000,1)
end

function createPickupsOnServerStart3()
	for i,pos in ipairs(pickupPositions["farm"]) do
		iPickup = iPickup + 1
		createItemLoot("farm",pos[1],pos[2],pos[3],iPickup)
	end
	setTimer(createPickupsOnServerStart4,5000,1)
end

function createPickupsOnServerStart4()
	for i,pos in ipairs(pickupPositions["supermarket"]) do
		iPickup = iPickup + 1
		createItemLoot("supermarket",pos[1],pos[2],pos[3],iPickup)
	end
	setTimer(createPickupsOnServerStart5,5000,1)
end

function createPickupsOnServerStart5()
	for i,pos in ipairs(pickupPositions["military"]) do
		iPickup = iPickup + 1
		createItemLoot("military",pos[1],pos[2],pos[3],iPickup)
	end
end


createPickupsOnServerStart()

------------------------------------------------------------------------------
--OTHER ITEM STUFF
vehicleFuelTable = {
-- {MODEL ID, MAX. FUEL},
{422,80},
{470,100},
{468,30},
{433,140},
{437,140},
{509,0},
{487,60},
{497,60},
{453,60},
}

function getVehicleMaxFuel(loot)
	local modelID = getElementModel(getElementData(loot,"parent"))
	for i,vehicle in ipairs(vehicleFuelTable) do
		if modelID == vehicle[1] then
			 return vehicle[2]
		end
	end
	return false
end
--[[
function onPlayerMoveItemOutOFInventory (itemName,loot)
local itemPlus = 1
if itemName == "Pistol Ammo" then
	itemPlus = 17
elseif itemName == "Smg Ammo" then
	itemPlus = 40
elseif itemName == "Assault Ammo" then
	itemPlus = 30
elseif itemName == "Sniper Ammo" then
	itemPlus = 10
elseif itemName == "Shotgun Ammo" then
	itemPlus = 7
elseif itemName == "M4" or itemName == "AK-47" or itemName == "Sniper Rifle" or itemName == "Shotgun" or itemName == "SPAZ-12 Combat Shotgun" or itemName == "Sawn-Off Shotgun" or itemName == "Heat-Seeking RPG" or itemName == "Rocket Launcher" or itemName == "Country Rifle" then
	removeBackWeaponOnDrop()
end
if loot then 
if not getElementData(loot,"itemloot") and getElementType(getElementData(loot,"parent")) == "vehicle" then
	if itemName == "Full Gas Canister" then
		if getElementData(loot,"fuel")+20 < getVehicleMaxFuel(loot) then
			addingfuel = 20
		elseif getElementData(loot,"fuel")+20 > getVehicleMaxFuel(loot)+15 then
			triggerClientEvent (source, "displayClientInfo", source,"Vehicle","The tank is full",255,22,0)
			return
		else
			addingfuel = getVehicleMaxFuel(loot)-getElementData(loot,"fuel")
		end
		setElementData(loot,"fuel",getElementData(loot,"fuel")+addingfuel)
		setElementData(source,itemName,getElementData(source,itemName)-itemPlus)
		setElementData(source,"Empty Gas Canister",(getElementData(source,"Empty Gas Canister") or 0)+itemPlus)
		triggerClientEvent (source, "displayClientInfo", source,"Vehicle","Filled up the vehicles Fuel",22,255,0)
		isVehicleReadyToStart2(getElementData(loot,"parent"))
		return
	end
end
end
itemName2 = itemName
if itemName == "Tire_inVehicle" then itemName2 = "Tire" end
if itemName == "Engine_inVehicle" then itemName2 = "Engine" end
if (getElementData(source,itemName2) or 0)/itemPlus < 1 then
	triggerClientEvent (source, "displayClientInfo", source,"Inventory","You dont got a full Magazine to drop",255,22,0)
return
end
	if loot then
		setElementData(loot,itemName,(getElementData(loot,itemName) or 0)+1)
		onPlayerChangeLoot(loot)	
		if not getElementData(loot,"itemloot") and getElementType(getElementData(loot,"parent")) == "vehicle" then
			isVehicleReadyToStart2(getElementData(loot,"parent"))
		end
	else
		local x,y,z = getElementPosition(source)
		local item,itemString = getItemTablePosition(itemName)
		local itemPickup = createItemPickup(item,x+math.random(-1.25,1.25),y+math.random(-1.25,1.25),z,itemString)
	end
	if itemName == "Tire_inVehicle" then itemName = "Tire" end
	if itemName == "Engine_inVehicle" then itemName = "Engine" end
	setElementData(source,itemName,getElementData(source,itemName)-itemPlus)
	if loot and getElementData(loot,"itemloot") then
		refreshItemLoot (loot,getElementData(loot,"parent"))
	end
end
addEvent( "onPlayerMoveItemOutOFInventory", true )
addEventHandler( "onPlayerMoveItemOutOFInventory", getRootElement(), onPlayerMoveItemOutOFInventory )
]]
--[[
function onPlayerMoveItemInInventory (itemName,loot)
local itemPlus = 1
if itemName == "Pistol Ammo" then
	itemPlus = 17
elseif itemName == "Smg Ammo" then
	itemPlus = 40
elseif itemName == "Assault Ammo" then
	itemPlus = 30
elseif itemName == "Sniper Ammo" then
	itemPlus = 10
elseif itemName == "Shotgun Ammo" then
	itemPlus = 7
elseif itemName == "Small Backpack" then
	if getElementData(source,"MAX_Slots") == 16 then triggerClientEvent (source, "displayClientInfo", source,"Inventory","You allready got a Small Backpack",255,22,0) return end
	if getElementData(source,"MAX_Slots") == 28 then triggerClientEvent (source, "displayClientInfo", source,"Inventory","You allready got a bigger Backpack",255,22,0) return end
	setElementData(source,"MAX_Slots",16)
	setElementData(loot,itemName,getElementData(loot,itemName)-1)
	itemPlus = 0
elseif itemName == "Alice Backpack" then
	if getElementData(source,"MAX_Slots") == 28 then triggerClientEvent (source, "displayClientInfo", source,"Inventory","You allready got a Alice Backpack",255,22,0) return end
	if getElementData(source,"MAX_Slots") == 36 then triggerClientEvent (source, "displayClientInfo", source,"Inventory","You allready got a bigger Backpack",255,22,0) return end
	setElementData(source,"MAX_Slots",28)
	setElementData(loot,itemName,getElementData(loot,itemName)-1)
	itemPlus = 0
elseif itemName == "Coyote Backpack" then
	if getElementData(source,"MAX_Slots") == 36 then triggerClientEvent (source, "displayClientInfo", source,"Inventory","You allready got a Coyote Backpack",255,22,0) return end
	setElementData(source,"MAX_Slots",36)
	setElementData(loot,itemName,getElementData(loot,itemName)-1)
	itemPlus = 0	
end
	if loot then
		--if itemPlus > (getElementData(loot,itemName) or 0) then
			--itemPlus = getElementData(loot,itemName) 
		--end
			setElementData(source,itemName,(getElementData(source,itemName) or 0)+itemPlus) 
			if itemPlus == 0 then
				setElementData(loot,itemName,getElementData(loot,itemName)-0)
			else
				setElementData(loot,itemName,getElementData(loot,itemName)-1)
			end
			onPlayerChangeLoot(loot)
	end
	if getElementData(loot,"itemloot") then
		refreshItemLoot (loot,getElementData(loot,"parent"))
	end
end
addEvent( "onPlayerMoveItemInInventory", true )
addEventHandler( "onPlayerMoveItemInInventory", getRootElement(), onPlayerMoveItemInInventory )
]]
function onPlayerTakeItemFromGround (itemName,col)
	itemPlus = 1
	if itemName == "M1911 Mag" then
		itemPlus = 7
	elseif itemName == "M9 SD Mag" then
		itemPlus = 15
	elseif itemName == "Desert Eagle Mag" then
		itemPlus = 7
	elseif itemName == "PDW Mag" then
		itemPlus = 30
	elseif itemName == "MP5A5 Mag" then
		itemPlus = 20
	elseif itemName == "AK Mag" then
		itemPlus = 30
	elseif itemName == "M4 Mag" then
		itemPlus = 20
	elseif itemName == "1866 Slug" then
		itemPlus = 7
	elseif itemName == "2Rnd. Slug" then
		itemPlus = 2
	elseif itemName == "SPAZ-12 Pellet" then
		itemPlus = 7
	elseif itemName == "CZ 550 Mag" then
		itemPlus = 5
	elseif itemName == "Lee Enfield Mag" then
		itemPlus = 10
	elseif itemName == "M136 Rocket" then
		itemPlus = 0
	elseif itemName == "M4" or itemName == "AK-47" or itemName == "CZ 550" or itemName == "Winchester 1866" or itemName == "SPAZ-12 Combat Shotgun" or itemName == "Sawn-Off Shotgun" or itemName == "Heat-Seeking RPG" or itemName == "M136 Rocket Launcher" or itemName == "Lee Enfield" then
		removeBackWeaponOnDrop()	
	end
	local x,y,z = getElementPosition(source)
	local id,ItemType = getItemTablePosition (itemName)
	setElementData(source,itemName,(getElementData(source,itemName) or 0)+itemPlus)
	destroyElement(getElementData(col,"parent"))
	destroyElement(col)
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

function playerDropAItem(itemName)
	local x,y,z = getElementPosition(source)
	local item,itemString = getItemTablePosition(itemName)
	local itemPickup = createItemPickup(item,x+math.random(-1.25,1.25),y+math.random(-1.25,1.25),z,itemString)
end
addEvent( "playerDropAItem", true )
addEventHandler( "playerDropAItem", getRootElement(), playerDropAItem )

function getItemTablePosition (itema)
	for id, item in ipairs(itemTable[tostring("other")]) do
		if itema == item[1] then
			return id,"other"
		end
	end

	return item,itemString
end

function refreshItemLoots ()
	outputChatBox("#ffaa00WARNING! #ffffff - SPAWNPOINTS FOR ITEMS ARE BEING REFRESHED! BEWARE OF MASSIVE LAG!",getRootElement(),255,255,255,true)
	for i, loots in ipairs(getElementsByType("colshape")) do
		local itemloot = getElementData(loots,"itemloot")
		if itemloot then
		local objects = getElementData(loots,"objectsINloot")
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
			destroyElement(loots)
		end	
	end
	createPickupsOnServerStart()
	setTimer(refreshItemLootPoints,gameplayVariables["itemrespawntimer"] ,1)
end


--Refresh items
function refreshItemLootPoints ()
	local time = getRealTime()
	local hour = time.hour
	outputChatBox("#ff2200WARNING! #ffffff - SPAWNPOINTS FOR ITEMS WILL BE REFRESHED IN 1 MINUTE! BEWARE OF MASSIVE LAG!",getRootElement(),255,255,255,true)
	setTimer(refreshItemLoots,60000,1)
end
setTimer(refreshItemLootPoints,gameplayVariables["itemrespawntimer"] ,1)


--[[
#---------------------------------------------------------------#
----*			DayZ MTA Script vehicle_spawns.lua			*----
----* This Script is owned by Marwin, you are not allowed to use or own it.
----* Owner: Marwin W., Germany, Lower Saxony, Otterndorf
----* Skype: xxmavxx96
----* Developers: L, CiBeR,	Jboy							*----
#---------------------------------------------------------------#
]]

--[[
THE NEW VEHICLE SPAWN SYSTEM

All vehicles have a random chance to spawn. The rarity ranges from common
to rare, with 12 vehicles of the same type being spawned at most with common
rarity and 2 with rare.


]]

-- Vehicles
ATV_Spawns = gameplayVariables["atvspawns"]
Bus_Spawns = gameplayVariables["busspawns"]
Bike_Spawns = gameplayVariables["bikespawns"]
GAZ_Spawns = gameplayVariables["gazspawns"]
Military_O_Spawns = gameplayVariables["militaryoffroadspawns"]
Motorcycle_Spawns = gameplayVariables["motorcyclespawns"]
Pickup_O_Spawns = gameplayVariables["pickupoffroadspawns"]
Hatchback_Spawns = gameplayVariables["hatchbackspawns"]
Pickup_Spawns = gameplayVariables["pickupspawns"]
SVan_Spawns = gameplayVariables["svanspawns"]
Skoda_Spawns = gameplayVariables["skodaspawns"]
Tractor_Spawns = gameplayVariables["tractorspawns"]
UAZ_Spawns = gameplayVariables["uazspawns"]
Ural_C_Spawns = gameplayVariables["uralcivilianspawns"]
SUV_Spawns = gameplayVariables["suvspawns"]
V3S_C_Spawns = gameplayVariables["v3scivilianspawns"]


-- Aircraft
AH6X_LB_Spawns = gameplayVariables["ah6xspawns"]
UH1H_Huey_Spawns = gameplayVariables["hueyspawns"]
Mi17_Spawns = gameplayVariables["mi17spawns"]
MH6J_Spawns = gameplayVariables["mh6jspawns"]
An2_BP_Spawns = gameplayVariables["an2biplanespawns"]


-- Boats
FishingBoat_Spawns = gameplayVariables["fishingboatspawns"]
SmallBoat_Spawns = gameplayVariables["smallboatspawns"]
PBX_Spawns = gameplayVariables["pbxspawns"]


-- Others
tentSpawns = gameplayVariables["tentsspawns"]
heliCrashSites = gameplayVariables["helicrashsides"]



hospitalPacks = {

{-2670.87890625,636.8984375,14.453125},
{-2637.0556640625,635.03125,14.453125},
{-1515.669921875,2519.166015625,56.0703125},
{-1513.888671875,2519.5908203125,56.064819335938},
{-1528.8955078125,2516.724609375,55.986171722412},
{2022.1650390625,-1402.6806640625,17.18045425415},
{2042.7001953125,-1409.4775390625,17.1640625},
{-316.5478515625,1051.6494140625,20.340259552002},
{-337.9541015625,1049.490234375,19.739168167114},
{-331.5849609375,1046.037109375,26.012474060059},
{-307.0419921875,1045.27734375,26.012474060059},
{1171.490234375,-1310.560546875,13.986573219299},
{1171.609375,-1306.556640625,13.996350288391},
{1158.5048828125,-1326.333984375,31.503561019897},
{1159.80078125,-1323.9013671875,31.498970031738},
{1238.7119140625,328.2431640625,19.7555103302},
{1229.365234375,311.1435546875,24.7578125},
{-2204.07421875,-2309.58203125,31.375},
{1615.939453125,1818.0537109375,10.8203125},
{1601.9443359375,1816.736328125,10.8203125},
{1590.0166015625,1792.0234375,30.46875},
{1607.3232421875,1776.7412109375,37.3125},
{2107.7626953125,926.16015625,10.8203125},
{2116.12890625,925.7705078125,10.9609375},
{2122.1865234375,925.3193359375,10.8203125},
}

patrolPoints = {

{-1603.2197265625,-2712.736328125,48.9453125},
{2465.748046875,-2215.55859375,13.546875},
{2473.439453125,-2215.56640625,13.546875},
{2480.0732421875,-2216.140625,13.546875},
{2487.24609375,-2215.5966796875,13.546875},
{2494.1005859375,-2215.5859375,13.546875},
{-1686.6728515625,408.9970703125,7.3984375},
{-1682.34375,412.9384765625,7.3984375},
{-1680.0263671875,402.3642578125,7.3984375},
{-1675.84375,406.4677734375,7.3984375},
{-1670.5615234375,411.8359375,7.3984375},
{-1666.2392578125,416.2509765625,7.3984375},
{-1672.7939453125,422.81640625,7.3984375},
{-1677.20703125,418.46484375,7.3984375},
{-2410.7021484375,969.9091796875,45.4609375},
{-2410.744140625,975.220703125,45.4609375},
{-2410.837890625,980.5302734375,45.4609375},
{-1329.3046875,2668.5126953125,50.46875},
{-1328.7314453125,2673.90625,50.0625},
{-1327.0185546875,2679.3876953125,50.46875},
{-1327.3798828125,2684.62890625,50.0625},
{1940.7099609375,-1778.5244140625,13.390598297119},
{1940.6552734375,-1774.908203125,13.390598297119},
{1940.630859375,-1771.728515625,13.390598297119},
{1940.7080078125,-1767.3837890625,13.390598297119},
{-1477.921875,1868.138671875,32.639846801758},
{-1466.1552734375,1869.0048828125,32.6328125},
{-1464.5224609375,1861.3828125,32.639846801758},
{-1477.4599609375,1860.5205078125,32.6328125},
{-735.9208984375,2744.0087890625,47.2265625},
{-739.0439453125,2744.2421875,47.165451049805},
{377.6953125,2601.1083984375,16.484375},
{624.5263671875,1676.25390625,6.9921875},
{620.2958984375,1681.2431640625,6.9921875},
{616.248046875,1686.4169921875,7.1875},
{612.783203125,1691.1650390625,7.1875},
{609.2060546875,1696.201171875,7.1875},
{605.8505859375,1700.978515625,7.1875},
{602.27734375,1706.3603515625,7.1875},
{2141.037109375,2742.734375,10.960174560547},
{2142.3115234375,2752.6982421875,10.96019744873},
{2147.9521484375,2752.3203125,10.8203125},
{2152.60546875,2751.953125,10.8203125},
{2152.984375,2743.85546875,10.8203125},
{2147.75,2743.7392578125,10.8203125},
{-97.6298828125,-1175.0283203125,2.4990689754486},
{-90.74609375,-1177.853515625,2.2021217346191},
{-84.75390625,-1163.853515625,2.3359375},
{-91.5771484375,-1160.5732421875,2.4453125},
{-1606.525390625,-2717.2138671875,48.9453125},
{-1609.7109375,-2721.544921875,48.9453125},
{-1599.83203125,-2708.302734375,48.9453125},
{-2246.314453125,-2558.8212890625,32.0703125},
{-2241.3125,-2561.3662109375,32.0703125},
{-1132.2880859375,-135.0986328125,14.14396572113},
{-1153.529296875,-156.373046875,14.1484375},
{-1142.826171875,-145.67578125,14.14396572113},
{655.611328125,-557.9912109375,16.501491546631},
{655.6572265625,-572.1728515625,16.501491546631},
{1601.791015625,2203.90625,11.060997009277},
{1596.806640625,2203.4345703125,10.8203125},
{1590.197265625,2203.4853515625,10.8203125},
{1589.4775390625,2195.43359375,10.8203125},
{1596.125,2194.294921875,10.8203125},
{1601.6591796875,2194.3369140625,10.8203125},
{2206.8466796875,2470.47265625,10.8203125},
{2206.94140625,2474.75,10.8203125},
{2206.9267578125,2478.86328125,10.8203125},
{2198.06640625,2480.6953125,10.8203125},
{2197.541015625,2475.791015625,10.995170593262},
{2197.609375,2471.9169921875,10.995170593262},
{2120.8251953125,915.4833984375,10.8203125},
{2115.1181640625,915.44140625,10.8203125},
{2109.076171875,915.4228515625,10.8203125},
{2109.22265625,924.8779296875,10.9609375},
{2114.9404296875,924.8857421875,10.9609375},
{2119.5126953125,925.2861328125,10.9609375},
{2645.7197265625,1112.7802734375,10.8203125},
{2639.984375,1112.56640625,10.8203125},
{2634.828125,1112.3466796875,10.9609375},
{2634.1826171875,1101.9482421875,10.8203125},
{2636.7509765625,1101.6748046875,10.8203125},
{2643.5126953125,1101.81640625,10.8203125},
{2209.576171875,2469.8251953125,10.8203125},
{2208.8310546875,2475.09375,10.8203125},
{1005.078125,-901.7490234375,42.216625213623},
{993.025390625,-902.474609375,42.222496032715},
}

lootItems = {
["helicrashsides"] = {
{"FN FAL",355,1,90,0.87},
{"Bizon PP-19",353,1,90,2.17},
{"Sporter 22",357,1,90,0.87},
{"Blaze 95 Double Rifle",350,1,90,1.3},
{"G36C",355,1,90,0,2.17},
{"M4",356,1,90,0.43},
{"NV Goggles",368,1,90,0.43},
{"CZ 550",358,1,90,4.35},
{"DMR",358,1,90,0,4.35},
{"Sa58V CCO",355,1,90,0,1.30},
{"Bandage",1578,0.5,0,4.35},
{"Heat Pack",1576,1,0,4.35},
{"Blood Bag",1580,1,0,4.35},
{"Morphine",1579,1,0,4.35},
{"Painkiller",1580,1,0,4.35},
{"1866 Slug",2358,2,0,4.35},
{"2Rnd. Slug",2358,2,0,4.35},
{"12 Gauge Pellet",2358,2,0,4.35},
{"9x18mm Cartridge",2358,2,0,4.35},
{"5.45x39mm Cartridge",1271,2,0,4.35},
{"5.56x45mm Cartridge",1271,2,0,4.35},
{".45 ACP Cartridge",3013,2,0,4.35},
{"9x19mm SD Cartridge",3013,2,0,4.35},
{"9.3x62mm Cartridge",2358,2,0,4.35},
{".303 British Cartridge",2358,2,0,4.35},
{"9x19mm Cartridge",2041,2,0,4.35},
{"9x18mm Cartridge",2041,2,0,4.35},
{"Bolt",2041,2,0,4.35},
{"Camouflage Clothing",1577,1,0,3.48},
{"Ghillie Suit",1577,1,0,2.17},
},

["hospital"] = {
{"Heat Pack",1576,1,0},
{"Bandage",1578,0.5,0},
{"Blood Bag",1580,1,0},
{"Morphine",1579,1,0},
{"Blood Bag",1580,1,0},
{"Blood Bag",1580,1,0},
{"Painkiller",1580,1,0},
},
}

vehicleAddonsInfo = {
-- {Model, Wheels, Engine, TankParts, ScrapMetal, WindscreenGlass, RotaryParts, Name, ColsphereSize, Slots, Fuel,RealName}

-- VEHICLES
{471,4,1,1,0,0,0,"ATV",2,50,30,"Quadbike"},
{431,6,1,1,0,0,0,"Bus",5,50,100,"Bus"},
{509,2,0,0,0,0,0,"Old Bike",2,0,0,"Bike"},
{546,4,1,1,0,0,0,"GAZ",3,50,200,"Intruder"},
{433,8,1,1,0,0,0,"Military Offroad",4,50,200,"Barracks"},
{468,2,1,1,0,0,0,"Motorcycle",2,5,55,"Sanchez"},
{543,4,1,1,0,0,0,"Offroad Pickup Truck",3,50,100,"Sadler"},
{426,4,1,1,0,0,0,"Old Hatchback",3,50,50,"Premier"},
{422,4,1,1,0,0,0,"Pickup Truck",3,50,200,"Bobcat"},
{418,4,4,1,0,0,0,"S1203 Van",3,50,60,"Moonbeam"},
{400,4,1,1,0,0,0,"Skoda",3,75,200,"Landstalker"},
{531,4,1,1,0,0,0,"Tractor",3,50,100,"Tractor"},
{470,4,1,1,0,0,0,"UAZ",3,50,100,"Patriot"},
{455,6,1,1,0,0,0,"Ural Civilian",5,200,200,"Flatbed"},
{490,4,1,1,0,0,0,"SUV",3,50,200,"FBI Rancher"},
{478,6,1,1,0,0,0,"V3S Civilian",5,200,160,"Walton"},

-- AIRCRAFT
{469,0,1,0,0,0,1,"AH6X Little Bird",7,20,1000,"Sparrow"},
{417,0,1,0,0,0,1,"UH-1H Huey",7,50,1000,"Leviathan"},
{487,0,1,0,0,0,1,"Mi-17",7,20,1000,"Maverick"},
{488,0,1,0,0,0,1,"MH6J",7,20,600,"News Chopper"},
{511,2,1,0,0,0,2,"An-2 Biplane",7,100,400,"Beagle"},

-- BOATS
{453,0,1,0,0,0,0,"Fishing Boat",4,400,100,"Reefer"},
{595,0,1,0,0,0,0,"Small Boat",3,0,100,"Launch"},
{473,0,1,0,0,0,0,"PBX",2,0,100,"Dinghy"},
}

vehicleFuelTable = {
-- {Model,MaxFuel}

-- VEHICLES
{471,30},
{431,100},
{509,0},
{546,200},
{433,200},
{468,55},
{543,100},
{426,50},
{422,200},
{418,60},
{400,200},
{531,100},
{470,100},
{455,200},
{490,200},
{478,160},

-- AIRCRAFT
{469,1000},
{417,1000},
{487,1000},
{488,600},
{511,400},

-- BOATS
{453,100},
{595,100},
{473,100}

}

local itemsDataTable = {
	{"M4"},
	{"CZ 550"},
	{"Winchester 1866"},
	{"SPAZ-12 Combat Shotgun"},
	{"Sawn-Off Shotgun"},
	{"AK-47"},
	{"Lee Enfield"},
	{"Sporter 22"},
	{"Mosin 9130"},
	{"Crossbow"},
	{"SKS"},
	{"Blaze 95 Double Rifle"},
	{"Remington 870"},
	{"FN FAL"},
	{"G36C"},
	{"Sa58V CCO"},
	{"SVD Dragunov"},
	{"DMR"},
	{"M1911"},
	{"M9 SD"},
	{"PDW"},
	{"G17"},
	{"MP5A5"},
	{"Desert Eagle"},
	{"Bizon PP-19"},
	{"Revolver"},
	{"Hunting Knife"},
	{"Hatchet"},
	{"Baseball Bat"},
	{"Shovel"},
	{"Golf Club"},
	{"Machete"},
	{"Crowbar"},
	{"Parachute"},
	{"Tear Gas"},
	{"Grenade"},
	{"Binoculars"},
	{"45 ACP Cartridge"},
	{"9x19mm SD Cartridge"},
	{"9x19mm Cartridge"},
	{"9x18mm Cartridge"},
	{"545x39mm Cartridge"},
	{"556x45mm Cartridge"},
	{"1866 Slug"},
	{"2Rnd Slug"},
	{"12 Gauge Pellet"},
	{"93x62mm Cartridge"},
	{"303 British Cartridge"},
	{"Bolt"},
	{"Baked Beans"},
	{"Pasta"},
	{"Sardines"},
	{"Frank_Beans"},
	{"Can (Corn)"},
	{"Can (Peas)"},
	{"Can (Pork)"},
	{"Can (Stew)"},
	{"Can (Ravioli)"},
	{"Can (Fruit)"},
	{"Can (Chowder)"},
	{"Pistachios"},
	{"Trail Mix"},
	{"MRE"},
	{"Water Bottle"},
	{"Soda Can (Pepsi)"},
	{"Soda Can (Cola)"},
	{"Soda Can (Mountain Dew)"},
	{"Can (Milk)"},
	{"Wood Pile"},
	{"Bandage"},
	{"Road Flare"},
	{"Empty Gas Canister"},
	{"Full Gas Canister"},
	{"Medic Kit"},
	{"Heat Pack"},
	{"Painkiller"},
	{"Morphine"},
	{"Blood Bag"},
	{"Wire Fence"},
	{"Raw Meat"},
	{"Tire"},
	{"Engine"},
	{"Tank Parts"},
	{"Tent"},
	{"Box of Matches"},
	{"Watch"},
	{"GPS"},
	{"Map"},
	{"Toolbox"},
	{"IR Goggles"},
	{"NV Goggles"},
	{"Cooked Meat"},
	{"Radio Device"},
	{"Compass"},
	{"Camouflage Clothing"},
	{"Civilian Clothing"},
	{"Survivor Clothing"},
	{"Ghillie Suit"},
	{"Empty Water Bottle"},
	{"Empty Soda Can"},
	{"Assault Pack (ACU)"},
	{"ALICE Pack"},
	{"British Assault Pack"},
	{"Czech Vest Pouch"},
	{"Backpack (Coyote)"},
	{"Czech Backpack"},
	{"Survival ACU"},
	{"Area 69 Keycard"},
	{"San Fierro Carrier Keycard"},
	{"M4 Blueprint"},
	{"CZ 550 Blueprint"},
	{"Winchester 1866 Blueprint"},
	{"SPAZ-12 C Shtgn Blueprint"},
	{"Sawn-Off Shtgn Blueprint"},
	{"AK-47 Blueprint"},
	{"Lee Enfield Blueprint"},
	{"Sporter 22 Blueprint"},
	{"Mosin 9130 Blueprint"},
	{"Crossbow Blueprint"},
	{"SKS Blueprint"},
	{"Blaze 95 D R Blueprint"},
	{"Remington 870 Blueprint"},
	{"FN FAL Blueprint"},
	{"G36C Blueprint"},
	{"Sa58V CCO Blueprint"},
	{"SVD Dragunov Blueprint"},
	{"DMR Blueprint"},
	{"M1911 Blueprint"},
	{"M9 SD Blueprint"},
	{"PDW Blueprint"},
	{"G17 Blueprint"},
	{"MP5A5 Blueprint"},
	{"Bizon PP-19 Blueprint"},
	{"Revolver Blueprint"},
	{"Desert Eagle Blueprint"},
	{"Hunting Knife Blueprint"},
	{"Hatchet Blueprint"},
	{"Baseball Bat Blueprint"},
	{"Shovel Blueprint"},
	{"Golf Club Blueprint"},
	{"Machete Blueprint"},
	{"Crowbar Blueprint"},
	{"Parachute Blueprint"},
	{"Tear Gas Blueprint"},
	{"Grenade Blueprint"},
	{"Binoculars Blueprint"},
	{"45 ACP Cartridge Blueprint"},
	{"9x19mm SD Cartridge Blueprint"},
	{"9x19mm Cartridge Blueprint"},
	{"9x18mm Cartridge Blueprint"},
	{"545x39mm Cartridge Blueprint"},
	{"556x45mm Cartridge Blueprint"},
	{"1866 Slug Blueprint"},
	{"2Rnd Slug Blueprint"},
	{"12 Gauge Pellet Blueprint"},
	{"93x62mm Cartridge Blueprint"},
	{"303 British Cartridge Blueprint"},
	{"Bolt Blueprint"},
	{"Medic Kit Blueprint"},
	{"Wire Fence Blueprint"},
	{"Tent Blueprint"},
	{"Camouflage Clthng Blueprint"},
	{"Survivor Clthng Blueprint"},
	{"Civilian Clthng Blueprint"},
	{"Ghillie Suit Blueprint"},
	{"Road Flare Blueprint"},
	{"Toolbox Blueprint"},
	{"Radio Device Blueprint"},
	{"IR Goggles Blueprint"},
	{"NV Goggles Blueprint"},
	{"Gun Barrel"},
	{"Short Gun Barrel"},
	{"Gun Stock"},
	{"Thread"},
	{"Cloth"},
	{"Gun Powder"},
	{"Mechanical Supplies"},
	{"Cables"},
	{"Nails"},
	{"Sheet"},
	{"Barbed Wire"},
	{"Duct Tape"},
	{"Glue"},
	{"Drugs"},
	{"Bandaid"},
	{"Vitamins"},
	{"Tissue"},
	{"Small Box"},
	{"String"},
	{"Needle"},
	{"Microchips"},
	{"Optics"},
	{"Sharp Metal"},
	{"Handle"},
	{"Wooden Stick"},
	{"Hand Saw"},
	{"Metal Plate"},
	{"Metallic Stick"},
	{"Small Casing"},
}

addEventHandler("onResourceStart",getResourceRootElement(getThisResource()), function()
	local vehicleManager = getAccount("vehicleManager","ds4f9$")
	if not vehicleManager then
		addAccount("vehicleManager","ds4f9$")
	end
	vehicledatabase = dbConnect("sqlite", "database/vehicles.db","","","share=1")
	tentdatabase = dbConnect("sqlite", "database/tents.db","","","share=1")
	local vehicle_table = dbExec(vehicledatabase, "CREATE TABLE IF NOT EXISTS vehicles (model INT, Veh_Health FLOAT, last_x FLOAT, last_y FLOAT, last_z FLOAT, last_rX FLOAT, last_rY FLOAT, last_rZ FLOAT, MAX_Slots INT, fuel FLOAT, Tire_inVehicle INT, Engine_inVehicle INT, Parts_inVehicle INT, Scrap_inVehicle INT, Glass_inVehicle INT, Rotary_inVehicle INT, vehicle_name TEXT, ColSize FLOAT, ID INT)")
	local tent_table = dbExec(tentdatabase, "CREATE TABLE IF NOT EXISTS tents (model INT, last_x FLOAT, last_y FLOAT, last_z FLOAT, last_rX FLOAT, last_rY FLOAT, last_rZ FLOAT, MAX_Slots INT, objectscale FLOAT, ColsphereSize FLOAT, Owner TEXT)")
	if vehicledatabase and tentdatabase then
		outputServerLog("[DayZ] CONNECTED TO VEHICLE DATABASE.")
		outputServerLog("[DayZ] CONNECTED TO TENTS DATABASE.")
	else
		outputServerLog("[DayZ] FAILED TO CONNECT TO DATABASE 'vehicles' and 'tents'. CHECK IF THEY EXIST.")
	end	
end)


function getVehicleAddonInfos (id)
	for i,veh in ipairs(vehicleAddonsInfo) do
		if veh[1] == id then
			return veh[2], veh[3], veh[4], veh[5], veh[6], veh[7], veh[8], veh[9], veh[10], veh[11], veh[12]
		end
	end
end

function getVehicleMaxFuel(loot)
	local modelID = getElementModel(getElementData(loot,"parent"))
	for i,vehicle in ipairs(vehicleFuelTable) do
		if modelID == vehicle[1] then
			 return vehicle[2]
		end
	end
	return false
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

function createHeliCrashSite()
	if cargoCol then
		destroyElement(getElementData(cargoCol,"parent"))
		destroyElement(cargoCol)
	end
	local item_id = math.random(table.size(heliCrashSites))
	local x,y,z = heliCrashSites[item_id][1],heliCrashSites[item_id][2],heliCrashSites[item_id][3]
	cargobob = createVehicle(548,x,y,z,nil,nil,nil)
	setElementHealth(cargobob,0)
	setElementFrozen(cargobob,true)
	cargoCol = createColSphere(x,y,z,3)
	setElementData(cargoCol,"parent",cargobob)
	setElementData(cargoCol,"helicrash",true)
	setElementData(cargoCol,"MAX_Slots",0)
	for i, item in ipairs(lootItems["helicrashsides"]) do
		local value =  math.percentChance (item[5]*3.5,math.random(1,2))
		setElementData(cargoCol,item[1],value)
		--weapon Ammo
		local ammoData,weapID = getWeaponAmmoType (item[1],true)
		if ammoData and value > 0 then
			setElementData(cargoCol,ammoData,math.random(1,2))
		end
	end
	setTimer(createHeliCrashSite,3600000,1)
end
createHeliCrashSite()

function updateHospitals ()
	for i,box in pairs(hospitalCol) do
		for _,items in ipairs(lootItems["hospital"]) do
			setElementData(hospitalCol[i],items[1],math.random(1,5))
		end
	end
	setTimer(updateHospitals,3600000,1)
end

hospitalCol = {}
function createHospitalPacks()
	number1 = 0
	for i,box in ipairs(hospitalPacks) do
		number1 = number1+1
		local x,y,z = box[1],box[2],box[3]
		object = createObject(1558,x,y,z,nil,nil,nil)
		hospitalCol[i] = createColSphere(x,y,z,2)
		setElementData(hospitalCol[i],"parent",object)
		setElementData(hospitalCol[i],"hospitalbox",true)
		setElementData(hospitalCol[i],"MAX_Slots",20)
		for _,items in ipairs(lootItems["hospital"]) do
			local randomNumber = math.random(1,10)
			if randomNumber >= 2 then
				setElementData(hospitalCol[i],items[1],math.random(1,5))
			end
		end	
	end
	setTimer(updateHospitals,3600000,1)
end
createHospitalPacks()

for i,patrol in ipairs(patrolPoints) do
	local x,y,z = patrol[1],patrol[2],patrol[3]
	patrolCol = createColSphere(x,y,z,3)
	setElementData(patrolCol,"patrolstation",true)
end

dayzVehicles = {}

theItems = {}
theTentItems = {}

function saveVehiclesToDB()
    dbExec(vehicledatabase, "DROP TABLE vehicles")
    dbExec(vehicledatabase, "CREATE TABLE IF NOT EXISTS vehicles (model INT, Veh_Health FLOAT, last_x FLOAT, last_y FLOAT, last_z FLOAT, last_rX FLOAT, last_rY FLOAT, last_rZ FLOAT, MAX_Slots INT, fuel FLOAT, Tire_inVehicle INT, Engine_inVehicle INT, Parts_inVehicle INT, Scrap_inVehicle INT, Glass_inVehicle INT, Rotary_inVehicle INT, vehicle_name TEXT, ColSize FLOAT, ID INT)")
    for i, data in ipairs(itemsDataTable) do
		dbExec(vehicledatabase,'ALTER TABLE vehicles ADD "'..data[1]..'" INT')
	end
	for i, col in ipairs(getElementsByType("colshape")) do
		local veh = getElementData(col,"vehicle")
		local tent = getElementData(col,"tent")
		if veh and not tent then
			local vehicle = getElementData(col,"parent")
			local model = getElementModel(vehicle)
			local veh_health = getElementHealth(vehicle)
			local x, y, z = getElementPosition(vehicle)
			local rotx, roty, rotz = getElementRotation(vehicle)
			local slots = getElementData(getElementData(vehicle, "parent"), "MAX_Slots") or 0
			local fuel = getElementData(getElementData(vehicle, "parent"), "fuel") or 0
			local tires = getElementData(getElementData(vehicle, "parent"), "Tire_inVehicle")
			local engines = getElementData(getElementData(vehicle, "parent"), "Engine_inVehicle") or 0
			local parts = getElementData(getElementData(vehicle, "parent"), "Parts_inVehicle") or 0
			local scrap = getElementData(getElementData(vehicle, "parent"), "Scrap_inVehicle") or 0
			local glass = getElementData(getElementData(vehicle, "parent"), "Glass_inVehicle") or 0
			local rotary = getElementData(getElementData(vehicle, "parent"), "Rotary_inVehicle") or 0
			local name = getElementData(getElementData(vehicle,"parent"),"vehicle_name") or getVehicleName(model)
			local veh_ID = getElementID(getElementData(vehicle,"parent"))
			local tires2,engine2,parts2,scrap2,glass2,rotary2,name2,colsphere,slots2,fuel2 = getVehicleAddonInfos(model)
			dbExec(vehicledatabase, "INSERT INTO vehicles (model, Veh_Health, last_x, last_y, last_z, last_rX, last_rY, last_rZ, MAX_Slots, fuel, Tire_inVehicle, Engine_inVehicle, Parts_inVehicle, Scrap_inVehicle, Glass_inVehicle, Rotary_inVehicle, vehicle_name, ColSize, ID) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", model, veh_health, x, y, z, rotx, roty, rotz, slots, fuel, tires, engines, parts, scrap, glass, rotary, name, colsphere, veh_ID)
			for key,item in ipairs(itemsDataTable) do
				local itemAmount = getElementData(col, item[1]) or 0
				dbExec(vehicledatabase, 'UPDATE vehicles SET "'..item[1]..'"=? WHERE ID=?',itemAmount,veh_ID)
			end
		end
	end
	outputServerLog("[DayZ] VEHICLES HAVE BEEN SAVED TO THE DATABASE.")
end
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), saveVehiclesToDB)

function createBackupOfVehicles(playerSource,command)
	if gameplayVariables["backupenabled"] then
		if hasObjectPermissionTo (playerSource, "command.mute") then
			outputServerLog("[DayZ] CREATING BACKUP OF VEHICLES...")
			saveVehiclesToDB()
		else
			outputChatBox("You are not allowed to use this command!",playerSource,255,0,0)
		end
	else
		outputChatBox("Backup for vehicles is turned off!",playerSource,255,0,0)
	end
end
addCommandHandler("backup",createBackupOfVehicles)

function createBackupOfVehiclesOnInterval()
	if gameplayVariables["backupenabled"] then
		outputServerLog("[DayZ] CREATING BACKUP OF VEHICLES...")
		saveVehiclesToDB()
	end
end
setTimer(createBackupOfVehiclesOnInterval,gameplayVariables["backupinterval"],0)


function createVehiclesFromDB(model, Veh_Health, last_x, last_y, last_z, last_rX, last_rY, last_rZ, MAX_Slots, fuel, Tire_inVehicle, Engine_inVehicle, Parts_inVehicle, Scrap_inVehicle, Glass_inVehicle, Rotary_inVehicle, vehicle_name, ColSize, ID, theItems)
	local veh = createVehicle(model, last_x, last_y, last_z, last_rX, last_rY, last_rZ)
    local vehCol = createColSphere(last_x, last_y, last_z, tonumber(ColSize))
    attachElements(vehCol, veh, 0, 0, 0)
    setElementData(vehCol, "parent", veh)
    setElementData(veh, "parent", vehCol)
    setElementData(vehCol,"vehicle", true)
    setElementData(vehCol,"MAX_Slots",tonumber(MAX_Slots))
    setElementData(vehCol,"Tire_inVehicle",tonumber(Tire_inVehicle))
    setElementData(vehCol,"Engine_inVehicle",tonumber(Engine_inVehicle))
    setElementData(vehCol,"Parts_inVehicle",tonumber(Parts_inVehicle))
	setElementData(vehCol,"Scrap_inVehicle",tonumber(Scrap_inVehicle))
	setElementData(vehCol,"Glass_inVehicle",tonumber(Glass_inVehicle))
	setElementData(vehCol,"Rotary_inVehicle",tonumber(Rotary_inVehicle))
    setElementData(vehCol, "spawn", {model, last_x, last_y, last_z})
    setElementData(vehCol, "fuel", tonumber(fuel))
	setElementID(vehCol, tostring(ID))
	setElementData(vehCol,"vehicle_name",tostring(vehicle_name))
	setElementHealth(veh,tonumber(Veh_Health))
    for i, data in ipairs(theItems) do
		if getElementID(vehCol) == tostring(data[1]) then
			setElementData(vehCol, tostring(data[2]),tonumber(data[3]))
		end
	end
end

function loadVehiclesFromDB(q)
    if (q) then
        local p = dbPoll( q, -1 )
        if (#p > 0) then
            for _, d in pairs (p) do
				for i,item in ipairs(itemsDataTable) do
					if d[item[1]] then
						table.insert(theItems,{d["ID"],item[1],d[item[1]]})
					end
				end
				createVehiclesFromDB( d["model"], d["Veh_Health"], d["last_x"], d["last_y"], d["last_z"], d["last_rX"], d["last_rY"], d["last_rZ"], d["MAX_Slots"], d["fuel"], d["Tire_inVehicle"], d["Engine_inVehicle"], d["Parts_inVehicle"], d["Scrap_inVehicle"], d["Glass_inVehicle"], d["Rotary_inVehicle"], d["vehicle_name"], d["ColSize"], d["ID"], theItems)
			end
        end
    end
end


function loadVehiclesOnServerStart()
	dbQuery(loadVehiclesFromDB, { }, vehicledatabase, "SELECT * FROM vehicles")
	outputServerLog("[DayZ] VEHICLES HAVE BEEN LOADED.")
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), loadVehiclesOnServerStart)


function saveTentsToDB()
    dbExec(tentdatabase, "DROP TABLE tents")
    dbExec(tentdatabase, "CREATE TABLE IF NOT EXISTS tents (model INT, last_x FLOAT, last_y FLOAT, last_z FLOAT, last_rX FLOAT, last_rY FLOAT, last_rZ FLOAT, MAX_Slots INT, objectscale FLOAT, ColsphereSize FLOAT, Owner TEXT)")
    for i, data in ipairs(itemsDataTable) do
		dbExec(tentdatabase,'ALTER TABLE tents ADD "'..data[1]..'" INT')
	end
	for i, col in ipairs(getElementsByType("colshape")) do
        local isTent = getElementData(col, "tent")
        if isTent then
            local theTent = getElementData(col,"parent")
            local x,y,z = getElementPosition(theTent)
            local rx,ry,rz = getElementRotation(theTent)
            local model = getElementModel(theTent)
            local MAX_Slots = getElementData(getElementData(theTent,"parent"),"MAX_Slots") or 100
            local scale = getObjectScale(theTent)
			local owner = getElementID(getElementData(theTent,"parent"))
            dbExec(tentdatabase, "INSERT INTO tents (model, last_x, last_y, last_z, last_rX, last_rY, last_rZ, MAX_Slots, objectscale, ColSphereSize, Owner) VALUES(?,?,?,?,?,?,?,?,?,?,?)", model, x, y, z, rx, ry, rz, MAX_Slots, scale, 4, owner)
            for key,item in ipairs(itemsDataTable) do
				local itemAmount = getElementData(getElementData(theTent,"parent"), item[1]) or 0
				dbExec(tentdatabase, 'UPDATE tents SET "'..item[1]..'"=? WHERE Owner=?',itemAmount,owner)
			end
        end
    end
	outputServerLog("[DayZ] TENTS HAVE BEEN SAVED TO DATABASE.")
end
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), saveTentsToDB)


function createTentsFromDB(model, last_x, last_y, last_z, last_rX, last_rY, last_rZ, MAX_Slots, objectscale, ColSphereSize, Owner, theTentItems)
	local tent = createObject(model, last_x, last_y, last_z, last_rX, last_rY, last_rZ)
    local tentCol = createColSphere(last_x, last_y, last_z, 4)
    attachElements(tentCol, tent, 0, 0, 0)
	setObjectScale(tent,objectscale)
    setElementData(tentCol, "parent", tent)
    setElementData(tent, "parent", tentCol)
    setElementData(tentCol,"vehicle", true)
	setElementData(tentCol,"tent",true)
    setElementData(tentCol,"MAX_Slots",tonumber(MAX_Slots))
	setElementID(tentCol, tostring(Owner))
    for i, data in ipairs(theTentItems) do
		if getElementID(tentCol) == tostring(data[1]) then
			setElementData(tentCol, tostring(data[2]),tonumber(data[3]))
		end
	end
end

function loadTentsFromDB(q)
    if (q) then
        local p = dbPoll( q, -1 )
        if (#p > 0) then
            for _, d in pairs (p) do
				for i,item in ipairs(itemsDataTable) do
					if d[item[1]] then
						table.insert(theTentItems,{d["Owner"],item[1],d[item[1]]})
					end
				end
				createTentsFromDB( d["model"], d["last_x"], d["last_y"], d["last_z"], d["last_rX"], d["last_rY"], d["last_rZ"], d["MAX_Slots"], d["objectscale"],  d["ColSphereSize"], d["Owner"], theTentItems)
			end
        end
    end
end


function loadTentsOnServerStart()
	dbQuery(loadTentsFromDB, { }, tentdatabase, "SELECT * FROM tents")
	outputServerLog("[DayZ] TENTS HAVE BEEN LOADED.")
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), loadTentsOnServerStart)



--[[
RARITY TYPES AND THEIR CHANCES

Common: 75%
Uncommon: 35%
Rare: 10%

]]


function spawnDayZVehicles()
if getAccount("vehicleManager") and getAccountData(getAccount("vehicleManager"),"serverhasloadvehicles") then return end
local v_counter = 0
	for i,veh in ipairs(ATV_Spawns) do
		local number = math.percentChance(veh[7],8)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(471,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,2)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",50)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{471,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(Bus_Spawns) do	
		local number = math.percentChance(veh[7],4)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(431,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,5)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",50)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation
			setElementData(vehCol,"spawn",{431,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(Bike_Spawns) do
		local number = math.percentChance(veh[7],14)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			veh = createVehicle(509,x,y,z)
			vehCol = createColSphere(x,y,z,2)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",0)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation
			setElementData(vehCol,"spawn",{509,x,y,z})
			--others
			setElementData(vehCol,"fuel",0)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(GAZ_Spawns) do
		local number = math.percentChance(veh[7],2)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(546,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,3)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",50)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation
			setElementData(vehCol,"spawn",{546,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(Military_O_Spawns) do
		local number = math.percentChance(veh[7],2)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			veh = createVehicle(433,x,y,z)
			vehCol = createColSphere(x,y,z,4)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",50)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation
			setElementData(vehCol,"spawn",{433,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementData(vehCol,"Grenade",10)
			setElementData(vehCol,"9.3x62mm Cartridge",10)
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(Motorcycle_Spawns) do
		local number = math.percentChance(veh[7],4)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(468,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,2)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",5)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation
			setElementData(vehCol,"spawn",{468,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(Pickup_O_Spawns) do
		local number = math.percentChance(veh[7],4)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(543,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,3)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",50)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{543,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(Hatchback_Spawns) do
		local number = math.percentChance(veh[7],2)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(426,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,3)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",50)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{426,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(Pickup_Spawns) do
		local number = math.percentChance(veh[7],2)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(422,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,3)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",50)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{422,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(SVan_Spawns) do
		local number = math.percentChance(veh[7],2)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(418,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,3)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",50)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{418,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(Skoda_Spawns) do
		local number = math.percentChance(veh[7],2)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(426,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,3)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",75)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{426,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(Tractor_Spawns) do
		local number = math.percentChance(veh[7],4)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(531,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,3)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",50)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{531,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(UAZ_Spawns) do
		local number = math.percentChance(veh[7],4)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(470,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,3)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",50)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{470,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(Ural_C_Spawns) do
		local number = math.percentChance(veh[7],2)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(455,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,5)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",200)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{455,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(SUV_Spawns) do
		local number = math.percentChance(veh[7],2)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(490,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,3)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",50)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{490,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(V3S_C_Spawns) do
		local number = math.percentChance(veh[7],1)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(478,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,5)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",200)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{478,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	-- AIRCRAFT
	for i,veh in ipairs(AH6X_LB_Spawns) do
		local number = math.percentChance(veh[7],3)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(469,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,7)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",20)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{469,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(UH1H_Huey_Spawns) do
		local number = math.percentChance(veh[7],3)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(417,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,7)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",50)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{417,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(Mi17_Spawns) do
		local number = math.percentChance(veh[7],3)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(487,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,7)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",20)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{487,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(MH6J_Spawns) do
		local number = math.percentChance(veh[7],3)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(488,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,7)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",20)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{488,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(An2_BP_Spawns) do
		local number = math.percentChance(veh[7],2)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(511,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,7)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",100)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{511,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	-- BOATS
	for i,veh in ipairs(FishingBoat_Spawns) do
		local number = math.percentChance(veh[7],1)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(453,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,4)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",400)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{453,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(SmallBoat_Spawns) do
		local number = math.percentChance(veh[7],2)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(595,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,3)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",0)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{595,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(PBX_Spawns) do
		local number = math.percentChance(veh[7],1)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(473,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,2)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",0)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{473,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,tent in ipairs(tentSpawns) do
		v_counter = v_counter+1
		local x,y,z = tent[1],tent[2],tent[3]
		tent = createObject(3243,x,y,z-1)
		setObjectScale(tent,0.5)
		tentCol = createColSphere(x,y,z,4)
		attachElements ( tentCol, tent, 0, 0, 0 )
		setElementData(tentCol,"parent",tent)
		setElementData(tent,"parent",tentCol)
		setElementData(tentCol,"tent",true)
		setElementData(tentCol,"vehicle",true)
		setElementData(tentCol,"MAX_Slots",30)
		setElementData(tentCol,"veh_ID",v_counter)
	end
	setAccountData(getAccount("vehicleManager"),"serverhasloadvehicles",true)
	exports.DayZ:saveLog("----- END OF SPAWNING VEHICLES -----\r\n","debug")
end
setTimer(spawnDayZVehicles,10000,1)

function notifyAboutExplosion()
	local col = getElementData(source,"parent")
	local x1,y1,z1 = getElementPosition(source)
	id,x,y,z  = getElementData(col,"spawn")[1],getElementData(col,"spawn")[2],getElementData(col,"spawn")[3],getElementData(col,"spawn")[4]
    setTimer(respawnDayZVehicle,1800000,1,id,x,y,z,source,col,getElementData(col,"MAX_Slots"))
	setElementData(col,"deadVehicle",true)
	setElementData(source,"isExploded",true)
	createExplosion (x1+4,y1+1,z1,4)
	createExplosion (x1+2,y1-4,z1,4)
	createExplosion (x1-1,y1+5,z1,4)
	createExplosion (x1-4,y1,z1-2,4)
end
addEventHandler("onVehicleExplode", getRootElement(), notifyAboutExplosion)

function respawnVehiclesInWater()
	for i,veh in ipairs(getElementsByType("vehicle")) do
		if isElementInWater(veh) and getElementModel(veh) ~= 453 or getElementModel(veh) ~= 595 or getElementModel(veh) ~= 473 then
			local col = getElementData(veh,"parent")
			if col then
				id,x,y,z  = getElementData(col,"spawn")[1],getElementData(col,"spawn")[2],getElementData(col,"spawn")[3],getElementData(col,"spawn")[4]
				respawnDayZVehicle(id,x,y,z,veh,col,getElementData(col,"MAX_Slots"))
			end
		end
	end
end
setTimer(respawnVehiclesInWater,1800000,0)

function respawnDayZVehicle(id,x,y,z,veh,col,max_slots)
	destroyElement(veh)
	destroyElement(col)
	veh = createVehicle(id,x,y,z+1)
	vehCol = createColSphere(x,y,z,4)
	attachElements ( vehCol, veh, 0, 0, 0 )
	setElementData(vehCol,"parent",veh)
	setElementData(veh,"parent",vehCol)
	setElementData(vehCol,"vehicle",true)
	setElementData(vehCol,"MAX_Slots",max_slots)
	--Engine + Tires
	local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
	setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
	setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
	setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
	setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
	setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
	setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
	setElementData(vehCol,"vehicle_name",name)
	--vehicle_indentifikation
	setElementData(vehCol,"spawn",{id,x,y,z})
	--others
	setElementData(vehCol,"fuel",10)
	setElementData(veh,"isExploded",false)
	setElementData(vehCol,"deadVehicle",false)
end

vehicleFuelInfo = {
-- {Model,MaxFuel}

-- VEHICLES
{471,0.1},
{431,0.3},
{509,0},
{546,0.5},
{433,0.5},
{468,0.1},
{543,0.5},
{426,0.1},
{422,0.5},
{418,0.1},
{400,0.5},
{531,0.3},
{470,0.3},
{455,0.5},
{490,0.5},
{478,0.4},

-- AIRCRAFT
{469,3},
{417,3},
{487,3},
{488,2},
{511,1},

-- BOATS
{453,0.5},
{595,0.5},
{473,0.5}

}


function onPlayerEnterDayzVehicle(veh,seat)
	local col = getElementData(veh,"parent")
	local id = getElementModel(veh)
	if not seat == 1 then return end
	local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (id)
	setVehicleEngineState ( veh, false )
	setElementData(veh,"maxfuel",getVehicleMaxFuel(col))
	setElementData(veh,"needtires",tires)
	setElementData(veh,"needengines",engine)
	setElementData(veh,"needparts",parts)
	setElementData(veh,"needscrap",scrap)
	setElementData(veh,"needglass",glass)
	setElementData(veh,"needrotary",rotary)
	setElementData(col,"vehicle_name",name)
	if ((getElementData(col,"Tire_inVehicle") or 0) < tonumber(tires)) then
		setVehicleEngineState ( veh, false )
		return	
	end
	if ((getElementData(col,"Engine_inVehicle") or 0) < tonumber(engine)) then
		setVehicleEngineState ( veh, false )
		return
	end
	if ((getElementData(col,"Rotary_inVehicle") or 0) < tonumber(rotary)) then
		setVehicleEngineState ( veh, false )
		return
	end
	if not getElementData(col,"Parts_inVehicle") then
		setElementData(col,"Parts_inVehicle",math.random(0,parts))
	end
	if (getElementData(col,"fuel") or 0) <= 1 then
		if getElementModel(veh) ~= 509 then
			triggerClientEvent (source, "displayClientInfo", source,"Vehicle","No tank left in this vehicle!",22,255,0)
			setVehicleEngineState ( veh, false )
			return
		end
	end
	setVehicleEngineState ( veh, true )
	if id == 490 then
		setElementData(source,"GPS",getElementData(source,"GPS")+1)
	end
	bindKey(source,"k","down",setEngineStateByPlayer)
	outputChatBox("Press 'K' to turn the engine on/off!",source)
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), onPlayerEnterDayzVehicle )

function onPlayerExitDayzVehicle(veh,seat)
	if seat == 0 then
		local id = getElementModel(veh)
		setVehicleEngineState ( veh, false )
		unbindKey(source,"k","down",setEngineStateByPlayer)
		if id == 490 then
			setElementData(source,"GPS",getElementData(source,"GPS")-1)
		end
	end	
end
addEventHandler ( "onPlayerVehicleExit", getRootElement(), onPlayerExitDayzVehicle )

function getVehicleFuelRemove (id,col)
	for i,veh in ipairs(vehicleFuelInfo) do
		if veh[1] == id then
			if not getElementData(col,"Parts_inVehicle") == 1 then
				return veh[2]*2
			end
			return veh[2]
		end
	end
end

function setVehiclesFuelPerMinute ()
	if not gameplayVariables["fuelEnabled"] == true then return end --Disable fuel comsumption if setting is set to false.
	
	for i,veh in ipairs(getElementsByType("vehicle")) do
		if getVehicleEngineState(veh) == true then
			if getElementData(getElementData(veh,"parent"),"fuel") >= 0 then
				setElementData(getElementData(veh,"parent"),"fuel",getElementData(getElementData(veh,"parent"),"fuel")-getVehicleFuelRemove(getElementModel(veh),getElementData(veh,"parent")))
			else
				setVehicleEngineState ( veh, false )
			end
		end
	end
end
setTimer(setVehiclesFuelPerMinute,20000,0)

function isVehicleReadyToStart2 (veh)
	if getElementData(getElementData(veh,"parent"),"fuel") >= 1 then
		local tires,engine,parts,scrap,glass,rotary = getVehicleAddonInfos (getElementModel(veh))
		if (getElementData(getElementData(veh,"parent"),"Tire_inVehicle") or 0) > tonumber(tires) and (getElementData(getElementData(veh,"parent"),"Engine_inVehicle") or 0) > tonumber(engine) and (getElementData(getElementData(veh,"parent"),"Rotary_inVehicle") or 0) > tonumber(rotary) then 
			setVehicleEngineState ( veh, true )
		end
	end
	setTimer(isVehicleReadyToStart2,1000,1,veh)
end

repairTimer = {}
function repairVehicle (veh)
	if repairTimer[veh] then triggerClientEvent (source, "displayClientInfo", source,"Vehicle",name.." is currently being repaired!",255,0,0) return end
	local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
	if getElementData(source,"Toolbox") and getElementData(source,"Toolbox") > 0 and getElementData(source,"Scrap Metal") and getElementData(source,"Scrap Metal") > 0 then
		local health = math.floor(getElementHealth(veh))
		repairTimer[veh] = setTimer(fixVehicleDayZ,(1000-health)*120,1,veh,source)
		setElementFrozen (veh,true)
		setElementData(veh,"repairer",source)
		setElementData(source,"repairingvehicle",veh)
		setPedAnimation (source,"SCRATCHING","sclng_r",nil,true,false)
		triggerClientEvent (source, "displayClientInfo", source,"Vehicle","You started to repair "..name,0,255,0)
	else
		triggerClientEvent (source, "displayClientInfo", source,"Vehicle","You need Scrap Metal to repair a vehicle!",255,0,0)
	end
end
addEvent("repairVehicle",true)
addEventHandler("repairVehicle",getRootElement(),repairVehicle)

function fixVehicleDayZ(veh,player)
	local scrap = getElementData(player,"Scrap Metal")
	if scrap then
		setElementHealth(veh,getElementHealth(veh)+200)
		if getElementHealth(veh) >= 1000 then 
			setElementHealth(veh,1000) 
			fixVehicle (veh) 
		end
		setPedAnimation(player,false)
		setElementData(player,"Scrap Metal",getElementData(player,"Scrap Metal")-1)
		setElementFrozen (veh,false)
		repairTimer[veh] = nil
		setElementData(veh,"repairer",nil)
		setElementData(player,"repairingvehicle",nil)
		triggerClientEvent (player, "displayClientInfo", player,"Vehicle","You finished repairing "..getVehicleName(veh),0,255,0)
	end
end

function stopFixxingWhileMoving()
	local veh = getElementData(source,"repairingvehicle")
	setPedAnimation(source)
	setElementFrozen (veh,false)
	setElementData(veh,"repairer",nil)
	setElementData(source,"repairingvehicle",nil)
	triggerClientEvent (source, "displayClientInfo", source,"Vehicle","You stopped repairing "..getVehicleName(veh),255,22,0)
	killTimer(repairTimer[veh])
	repairTimer[veh] = nil
end
addEvent("onClientMovesWhileAnimation",true)
addEventHandler("onClientMovesWhileAnimation",getRootElement(),stopFixxingWhileMoving)

function debugFixxing()
	for i,veh in ipairs(getElementsByType("vehicle")) do
		if getElementData(veh,"repairer") == source then
			outputDebugString("Vehicle repairer disconnected - destroyed tables")
			killTimer(repairTimer[veh])
			setElementFrozen (veh,false)
			repairTimer[veh] = nil
			setElementData(veh,"repairer",nil)
		end	
	end
end
addEventHandler("onPlayerQuit",getRootElement(),debugFixxing)


function setEngineStateByPlayer (playersource)
	local veh = getPedOccupiedVehicle (playersource)
	if getElementData(getElementData(veh,"parent"),"fuel") <= 1 then 
		return
	else
		setVehicleEngineState (veh, not getVehicleEngineState(veh))
	end
	if getVehicleEngineState(veh) then
		triggerClientEvent (playersource, "displayClientInfo", playersource,"Vehicle","Engine started!",22,255,0)
	else
		triggerClientEvent (playersource, "displayClientInfo", playersource,"Vehicle","Engine stopped!",255,22,0)
	end
end
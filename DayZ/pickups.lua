local lootpileType = {

["trash"] = {
{"Empty Soda Can",2673,0.5,0,31.25},
{"Empty Tin Can",2673,0.5,0,62.5},
{"Broken Whiskey Bottle",2673,0.5,0,6.25},
},

["civilian"] = {
{"Empty Soda Can",2673,0.5,0,8.82},
{"Empty Tin Can",2673,0.5,0,8.82},
{"Broken Whiskey Bottle",2673,0.5,0,8.82},
{"Soda Bottle",2647,1,0,11.76},
{"Milk",2856,1,0,8.82},
{"Pizza",1582,1,0,4.90},
{"Pasta Can",2770,1,0,4.90},
{"Beans Can",2601,1,0,4.90},
{"Burger",2768,1,0,4.90},
{".45 ACP Cartridge",3013,2,0,4.90},
{"2Rnd. Slug",2358,2,0,4.90},
{"12 Gauge Pellet",2358,2,0,4.90},
{"Bandage",1578,0.5,0,5.88},
{"Painkiller",2709,3,0,5.88},
},

["food"] = {
{"Empty Soda Can",2673,0.5,0,12.87},
{"Empty Tin Can",2673,0.5,0,12.87},
{"Broken Whiskey Bottle",2673,0.5,0,12.87},
{"Soda Bottle",2647,1,0,8.91},
{"Milk",2856,1,0,12.87},
{"Pizza",1582,1,0,8.91},
{"Pasta Can",2770,1,0,8.91},
{"Beans Can",2601,1,0,8.91},
{"Burger",2768,1,0,8.91},
{"Bandage",1578,0.5,0,3.96},
},

["hunter"] = {
{"Bandage",1578,0.5,0,27.78},
{".45 ACP Cartridge",3013,2,0,5.56},
{"9.3x62mm Cartridge",2358,2,0,13.89},
{".303 British Cartridge",2358,2,0,13.89},
{"Empty Water Bottle",2683,1,0,5.56},
{"Bolt",2041,2,0,27.78},
{"Heat Pack",1576,5,0,5.56},
},

["generic"] = {
{"Empty Soda Can",2673,0.5,0,6},
{"Empty Tin Can",2673,0.5,0,6},
{"Broken Whiskey Bottle",2673,0.5,0,4},
{"Soda Bottle",2647,1,0,6},
{"Milk",2856,1,0,4},
{"Pizza",1582,1,0,1},
{"Pasta Can",2770,1,0,1},
{"Beans Can",2601,1,0,1},
{"Burger",2768,1,0,1},
{"Empty Water Bottle",2683,1,0,1},
{"Water Bottle",2683,1,0,1},
{"Bandage",1578,0.5,0,11},
{".45 ACP Cartridge",3013,2,0,4},
{"2Rnd. Slug",2358,2,0,5},
{"12 Gauge Pellet",2358,2,0,5},
{"1866 Slug",2358,2,0,2},
{"Bolt",2041,2,0,4},
{"Roadflare",324,1,90,7},
{"Painkiller",2709,3,0,2},
{"Heat Pack",1576,5,0,4},
},

["medical"] = {
{"Bandage",1578,0.5,0,43.48},
{"Painkiller",2709,3,0,21.74},
{"Morphine",1579,1,0,21.74},
{"Heat Pack",1576,5,0,4.35},
},

["military"] = {
{"Empty Tin Can",2673,0.5,0,17.82},
{"Empty Soda Can",2673,0.5,0,8.91},
{"Soda Bottle",2647,1,0,0.99},
{"Milk",2856,1,0,0.99},
{"Bandage",1578,0.5,0,3.96},
{"Painkiller",2709,3,0,3.96},
{"Morphine",1579,1,0,0.99},
{"1866 Slug",2358,2,0,3.96},
{"2Rnd. Slug",2358,2,0,3.96},
{"12 Gauge Pellet",2358,2,0,3.96},
{"9x18mm Cartridge",2358,2,0,1.98},
{"5.45x39mm Cartridge",1271,2,0,3.96},
{"5.56x45mm Cartridge",1271,2,0,3.96},
{".45 ACP Cartridge",3013,2,0,4.95},
{"9x19mm SD Cartridge",3013,2,0,0.99},
{"9.3x62mm Cartridge",2358,2,0,3.96},
{".303 British Cartridge",2358,2,0,1.98},
{"9x19mm Cartridge",2041,2,0,3.96},
{"Bolt",2041,2,0,1.98},
{"Roadflare",324,1,90,4},
{"Wire Fence",933,0.25,0,1},
{"Grenade",342,1,0,0.99},
{"Heat Pack",1576,5,0,3.96},
},

["policeman"] = {
{"Bandage",1578,0.5,0,31.25},
{".45 ACP Cartridge",3013,2,0,25},
{"9x18mm Cartridge",2358,2,0,9.38},
{"1866 Slug",2358,2,0,9.38},
{"12 Gauge Pellet",2358,2,0,16.63},
{"Roadflare",324,1,90,9.38},
},

}


local itemTable = {
----------------------
["farm"] = {
{"Lee Enfield",357,1,90,3.92},
{"Mosin 9130",357,1,90,0.98},
{"Winchester 1866",349,1,90,2.94},
{"Crossbow",349,1,90,2.94},
{"M1911",346,1,90,1.40},
{"Revolver",348,1,90,3,1.12},
{"PDW",352,1,90,2,3.64},
{"Hatchet",339,1,90,16.67},
{".303 British Cartridge",2358,2,0,1.98},
{"1866 Slug",2358,2,0,3.96},
{".45 ACP Cartridge",3013,2,0,4.95},
{"9x19mm Cartridge",2041,2,0,3.96},
{"Bolt",2041,2,0,1.98},
{"Civilian Clothing",1241,2,0,10.78},
{"Water Bottle",2683,1,0,27.45},
{"Box of Matches",328,0.4,90,10.78},
{"Tent",1279,1,0,5.88},
{"Tank Parts",1008,1,0.8,0.98},
{"Empty Gas Canister",1650,1,0,5.88},
{"Empty Soda Can",2673,0.5,0,21.57},
},

----------------------
["residential"] = {
{"Lee Enfield",357,1,90,1.68},
{"Winchester 1866",349,1,90,0.28},
{"Remington 870",351,1,90,0.84},
{"M1911",346,1,90,1.40},
{"Revolver",348,1,90,1.12},
{"PDW",352,1,90,3.64},
{"Hunting Knife",335,1,90,2.24},
{"Hatchet",339,1,90,1},
{"Shovel",337,1,90,3},
{"1866 Slug",2358,2,0,3.96},
{"12 Gauge Pellet",2358,2,0,3.96},
{"9x18mm Cartridge",2358,2,0,1.98},
{".45 ACP Cartridge",3013,2,0,4.95},
{"9.3x62mm Cartridge",2358,2,0,3.96},
{".303 British Cartridge",2358,2,0,1.98},
{"9x19mm Cartridge",2041,2,0,3.96},
{"Assault Pack (ACU)",3026,1,0,0.28},
{"Alice Pack",1248,1,0,0.84},
{"OS Backpack",1644,1,0,0.84},
{"Civilian Clothing",1241,2,0,9},
{"Camouflage Clothing",1247,2,0,0.28},
{"Ghillie Suit",1213,2,0,0.28},
{"Pizza",1582,1,0,28.01},
{"Milk",2856,1,0,7,28.01},
{"Binoculars",369,1,0,1.68},
{"Watch",2710,1,0,4.20},
{"Compass",1579,1,0,1.40},
{"Map",1277,0.8,90,0.84},
{"GPS",2976,0.15,0,0.84},
{"Box of Matches",328,0.4,90,1.68},
{"Empty Gas Canister",1650,1,0,9},
{"Empty Soda Can",2673,0.5,0,14.01},
{"Tire",1073,1,0,1.53},
{"Tank Parts",1008,0.8,0,1.53},
{"Engine",929,0.3,0,1.53},
},
----------------------
["military"] = {
{"Crossbow",349,1,90,1},
{"Winchester 1866",349,1,90,3},
{"Sawn-Off Shotgun",350,1,90,2.3},
{"Blaze 95 Double Rifle",351,1,90,2},
{"SPAZ-12 Combat Shotgun",351,1,90,2.3},
{"Remington 870",351,1,90,1.3},
{"Lee Enfield",357,1,90,3.5},
{"Sporter 22",357,1,90,3.5},
{"Mosin 9130",357,1,90,3.5},
{"SKS",357,1,90,3.5},
{"AK-47",355,1,90,3.8},
{"FN FAL",355,1,90,3.8},
{"G36C",355,1,90,3.8},
{"Sa58V CCO",355,1,90,3.8},
{"M4",356,1,90,2.4},
{"CZ 550",358,1,90,0.4},
{"DMR",358,1,90,0.4},
{"SVD Dragunov",358,1,90,0.4},
{"M1911",346,1,90,5},
{"M9 SD",347,1,90,4},
{"PDW",352,1,90,4},
{"MP5A5",353,1,90,2.8},
{"Bizon PP-19",353,1,90,2.8},
{"Grenade",342,1,0,0.5},
{"Hunting Knife",335,1,90,1.91},
{"1866 Slug",2358,2,0,3.96},
{"2Rnd. Slug",2358,2,0,3.96},
{"12 Gauge Pellet",2358,2,0,3.96},
{"9x18mm Cartridge",2358,2,0,1.98},
{"5.45x39mm Cartridge",1271,2,0,3.96},
{"5.56x45mm Cartridge",1271,2,0,3.96},
{".45 ACP Cartridge",3013,2,0,4.95},
{"9x19mm SD Cartridge",3013,2,0,0.99},
{"9.3x62mm Cartridge",2358,2,0,3.96},
{".303 British Cartridge",2358,2,0,1.98},
{"9x19mm Cartridge",2041,2,0,3.96},
{"Bolt",2041,2,0,1.98},
{"Alice Pack",1248,1,0,19.12},
{"OS Backpack",1644,1,0,1.91},
{"Assault Pack (ACU)",3026,1,0,0.38},
{"Czech Backpack",1239,1,0,23.40},
{"Coyote Backpack",1252,1,0,9.61},
{"Camouflage Clothing",1247,2,0,4.5},
{"Ghillie Suit",1213,2,0,0.3},
{"Medic Kit",2891,2.2,0,1.91},
{"Binoculars",369,1,0,1.15},
{"Map",1277,0.8,90,0.96},
{"GPS",2976,0.15,0,0.19},
{"Wire Fence",933,0.25,0,0.38},
{"Toolbox",2969,0.5,0,0.96},
{"Night Vision Goggles",368,1,90,1.91},
{"Infrared Goggles",369,1,90,1.91},
{"Radio Device",330,1,0,1.15},
{"Tent",1279,1,0,1.53},
},
----------------------
["industrial"] = {
{"M4",356,1,90,3.92},
{"Bizon PP-19",353,1,90,17.65},
{"Hunting Knife",335,1,90,2},
{"Hatchet",339,1,90,1.5},
{"Golf Club",333,1,90,1.5},
{"5.56x45mm Cartridge",1271,2,0,3.96},
{"9x18mm Cartridge",2358,2,0,1.98},
{"Assault Pack (ACU)",3026,1,0,6},
{"Ghillie Backpack",1275,1,0,0.5},
{"Wire Fence",933,0.25,0,0.98},
{"Toolbox",2969,0.5,0,1.96},
{"Tire",1073,1,0,4.90},
{"Engine",929,0.3,0,5.88},
{"Tank Parts",1008,1,0.8,1.96},
{"Map",1277,0.8,90,3.92},
{"Watch",2710,1,0,3.92},
{"Radio Device",330,1,0,6},
{"Empty Gas Canister",1650,1,0,6},
{"Full Gas Canister",1650,1,0,3.92},
{"Empty Soda Can",2673,0.5,0,28.43},

},
----------------------
["supermarket"] = {
{"Winchester 1866",349,1,90,0.94},
{"Lee Enfield",357,1,90,0.94},
{"M1911",346,1,90,1.89},
{"PDW",352,1,90,1.89},
{"Revolver",348,1,90,0.94},
{"MP5A5",353,1,90,0.51},
{"Hunting Knife",335,1,90,1.89},
{"Shovel",337,1,90,0,1.89},
{"1866 Slug",2358,2,0,3.96},
{"9x18mm Cartridge",2358,2,0,1.98},
{"5.45x39mm Cartridge",1271,2,0,3.96},
{".45 ACP Cartridge",3013,2,0,4.95},
{"9x19mm SD Cartridge",3013,2,0,3.96},
{"9.3x62mm Cartridge",2358,2,0,3.96},
{".303 British Cartridge",2358,2,0,1.98},
{"9x19mm Cartridge",2041,2,0,3.96},
{"Assault Pack (ACU)",3026,1,0,1.89},
{"Alice Pack",1248,1,0,2.83},
{"OS Backpack",1644,1,0,0.94},
{"Civilian Clothing",1241,2,0,3.5},
{"Pizza",1582,1,0,7},
{"Pasta Can",2770,1,0,7},
{"Beans Can",2601,1,0,7},
{"Burger",2768,1,0,7},
{"Soda Bottle",2647,1,0,7},
{"Milk",2856,1,0,7},
{"Raw Meat",2804,0.5,90,8},
{"Box of Matches",328,0.4,90,4.72},
{"Watch",2710,1,0,14.15},
{"Tire",1073,1,0,1},
{"Tank Parts",1008,1,0.8,2},
{"Map",1277,0.8,90,4.72},
{"Compass",1579,1,0,0.94},
{"GPS",2976,0.15,0,4.72},
{"Radio Device",330,1,0,6},
{"Empty Soda Can",2673,0.5,0,14.15},
},
--[[
AMMO

{"1866 Slug",2358,2,0},
{"2Rnd. Slug",2358,2,0},
{"12 Gauge Pellet",2358,2,0},
{"9x18mm Cartridge",2358,2,0},
{"5.45x39mm Cartridge",1271,2,0},
{"5.56x45mm Cartridge",1271,2,0},
{".45 ACP Cartridge",3013,2,0},
{"9x19mm SD Cartridge",3013,2,0},
{"9.3x62mm Cartridge",2358,2,0},
{".303 British Cartridge",2358,2,0},
{"9x19mm Cartridge",2041,2,0},
{"9x18mm Cartridge",2041,2,0},
{"Bolt",2041,2,0},

]]

["other"] = {
{"Raw Meat",2804,0.5,90},
{"Cooked Meat",2806,0.5,90},
{"Full Gas Canister",1650,1,0},
{"Empty Water Bottle",2683,1,0},
{"Survivor Clothing",1577,2,0},
{"Night Vision Goggles",368,1,90},
{"Infrared Goggles",369,1,90},
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
{"Bizon PP-19",353,1,90,1.5},
{"Watch",2710,1,0,3},
{"Heat Pack",1576,5,0,6},
{"Wire Fence",933,0.25,0,1},
{"Lee Enfield",357,1,90,1.5},
{"Sporter 22",357,1,90,1.5},
{"Mosin 9130",357,1,90,1.5},
{"SKS",357,1,90,1.5},
{"Alice Pack",1248,1,0,1.5},
{"OS Backpack",1644,1,0,1.5},
{"Coyote Backpack",1252,1,0,0.7},
{"Ghillie Backpack",1275,1,0,0.7},
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
{"Blaze 95 Double Rifle",350,1,90,2},
{"SPAZ-12 Combat Shotgun",351,1,90,1.9},
{"Remington 870",351,1,90,1.9},
{"Binoculars",369,1,0,4},
{"Camouflage Clothing",1247,2,0,4.5},
{"AK-47",355,1,90,0.9},
{"FN FAL",355,1,90,0.9},
{"G36C",355,1,90,0.9},
{"Sa58V CCO",355,1,90,0.9},
{"M136 Rocket Launcher",359,1,90,0},
{"Ghillie Suit",1213,2,0,0.01},
{"M4",356,1,90,0.9},
{"CZ 550",358,1,90,0.3},
{"DMR",358,1,90,0.3},
{"SVD Dragunov",358,1,90,0.3},
{"Heat-Seeking RPG",360,1,90,0},
{"Bandage",1578,0.5,0,4},
{"Pasta Can",2770,1,0,5},
{"Beans Can",2601,1,0,6},
{"Burger",2768,1,0,2},
{"Tent",1279,1,0,0.5},
{"M1911",346,1,90,3},
{"Desert Eagle",348,1,90,3},
{"Revolver",348,1,90,3},
{"GPS",2976,0.15,0,1},
{"Medic Kit",2891,2.2,0},
{"Blood Bag",1580,1,0},
{"Radio Device",2966,0.5,0,5},
{"Golf Club",333,1,90,1.9},
{"Baseball Bat",336,1,90,1.4},
{"Shovel",337,1,90,1.5},
},

["interiors"] = {
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

["GhostBase"] = {
{"Water Bottle",2683,1,0,100},
{"Lee Enfield",357,1,90,100},
{"Alice Pack",1248,1,0,100},
{"Binoculars",369,1,0,100},
{"Map",1277,0.8,90,100},
{"Tent",1279,1,0,4.100},
{"Radio Device",330,1,0,100},
{"M9 SD",347,1,90,100},
},
}

weaponAmmoTable = {

[".45 ACP Cartridge"] = {
{"M1911",22},
{"Desert Eagle",24},
{"Revolver",24},
},

["9x19mm SD Cartridge"] = {
{"M9 SD",23},
},

["9x19mm Cartridge"] = {
{"PDW",28},
},

["9x18mm Cartridge"] = {
{"MP5A5",29},
{"Bizon PP-19",29},
},

["5.45x39mm Cartridge"] = {
{"AK-47",30},
{"FN FAL",30},
{"G36C",30},
{"Sa58V CCO",30},
},

["5.56x45mm Cartridge"] = {
{"M4",31},
},

["1866 Slug"] = {
{"Winchester 1866",25},
},

["2Rnd. Slug"] = {
{"Sawn-Off Shotgun",26},
{"Blaze 95 Double Rifle",25},
},

["12 Gauge Pellet"] = {
{"SPAZ-12 Combat Shotgun",27},
{"Remington 870",27},
},

["9.3x62mm Cartridge"] = {
{"CZ 550",34},
{"DMR",34},
{"SVD Dragunov",34},
},

[".303 British Cartridge"] = {
{"Lee Enfield",33},
{"Sporter 22",33},
{"Mosin 9130",33},
{"SKS",33},
},

["M136 Rocket"] = {
{"Heat-Seeking RPG",36},
{"M136 Rocket Launcher",35},
},

["Bolt"] = {
{"Crossbow",25},
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
{"Shovel",6},
{"Golf Club",2},
{"Machete",8},
{"Crowbar",2},
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
	for i,weaponData in ipairs(weaponAmmoTable[".45 ACP Cartridge"]) do
        if weaponName == weaponData[1] then
            return ".45 ACP Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["9x19mm SD Cartridge"]) do
        if weaponName == weaponData[1] then
            return "9x19mm SD Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["9x19mm Cartridge"]) do
        if weaponName == weaponData[1] then
            return "9x19mm Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["9x18mm Cartridge"]) do
        if weaponName == weaponData[1] then
            return "9x18mm Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["5.45x39mm Cartridge"]) do
        if weaponName == weaponData[1] then
            return "5.45x39mm Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["5.56x45mm Cartridge"]) do
        if weaponName == weaponData[1] then
            return "5.56x45mm Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["1866 Slug"]) do
        if weaponName == weaponData[1] then
            return "1866 Slug",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["12 Gauge Pellet"]) do
        if weaponName == weaponData[1] then
            return "12 Gauge Pellet",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["2Rnd. Slug"]) do
        if weaponName == weaponData[1] then
            return "2Rnd. Slug",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["9.3x62mm Cartridge"]) do
        if weaponName == weaponData[1] then
            return "9.3x62mm Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable[".303 British Cartridge"]) do
        if weaponName == weaponData[1] then
            return ".303 British Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["M136 Rocket"]) do
        if weaponName == weaponData[1] then
            return "M136 Rocket",weaponData[2]
        end
    end
	for i,weaponData in ipairs(weaponAmmoTable["Bolt"]) do
		if weaponName == weaponData[1] then
			return "Bolt",weaponData[2]
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
		local value =  math.percentChance (item[5],math.random(1,5))
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
	setTimer(createPickupsOnServerStart2,10000,1)
end

function createPickupsOnServerStart2()
	for i,pos in ipairs(pickupPositions["industrial"]) do
		iPickup = iPickup + 1
		createItemLoot("industrial",pos[1],pos[2],pos[3],iPickup)
	end
	setTimer(createPickupsOnServerStart3,10000,1)
end

function createPickupsOnServerStart3()
	for i,pos in ipairs(pickupPositions["farm"]) do
		iPickup = iPickup + 1
		createItemLoot("farm",pos[1],pos[2],pos[3],iPickup)
	end
	setTimer(createPickupsOnServerStart4,10000,1)
end

function createPickupsOnServerStart4()
	for i,pos in ipairs(pickupPositions["supermarket"]) do
		iPickup = iPickup + 1
		createItemLoot("supermarket",pos[1],pos[2],pos[3],iPickup)
	end
	setTimer(createPickupsOnServerStart5,10000,1)
end

function createPickupsOnServerStart5()
	for i,pos in ipairs(pickupPositions["military"]) do
		iPickup = iPickup + 1
		createItemLoot("military",pos[1],pos[2],pos[3],iPickup)
	end
	setTimer(createPickupsForGhostBase,10000,1)
end

function createPickupsForGhostBase()
	for i,pos in ipairs(pickupPositions["GhostBase"]) do
		iPickup = iPickup + 1
		createItemLoot("GhostBase",pos[1],pos[2],pos[3],iPickup)
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
{483,140},
{508,140},
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


function onPlayerTakeItemFromGround (itemName,col)
	itemPlus = 1
	if itemName == ".45 ACP Cartridge" then
		itemPlus = 7
	elseif itemName == "9x19mm SD Cartridge" then
		itemPlus = 15
	elseif itemName == "9x19mm Cartridge" then
		itemPlus = 30
	elseif itemName == "9x18mm Cartridge" then
		itemPlus = 20
	elseif itemName == "5.45x39mm Cartridge" then
		itemPlus = 30
	elseif itemName == "5.56x45mm Cartridge" then
		itemPlus = 20
	elseif itemName == "1866 Slug" then
		itemPlus = 7
	elseif itemName == "2Rnd. Slug" then
		itemPlus = 2
	elseif itemName == "12 Gauge Pellet" then
		itemPlus = 7
	elseif itemName == "9.3x62mm Cartridge" then
		itemPlus = 5
	elseif itemName == ".303 British Cartridge" then
		itemPlus = 10
	elseif itemName == "M136 Rocket" then
		itemPlus = 0
	elseif itemName == "Bolt" then
		itemPlus = 7
	elseif itemName == "M4" or itemName == "Mosin 9130" or itemName == "Sporter 22" or itemName == "SKS" or itemName == "Blaze 95 Double Rifle" or itemName == "DMR" or itemName == "SVD Dragunov" or itemName == "Crossbow" or itemName == "Bizon PP-19" or itemName == "FN FAL" or itemName == "G36C" or itemName == "Sa58V CCO" or itemName == "AK-47" or itemName == "CZ 550" or itemName == "Winchester 1866" or itemName == "SPAZ-12 Combat Shotgun" or itemName == "Sawn-Off Shotgun" or itemName == "Heat-Seeking RPG" or itemName == "M136 Rocket Launcher" or itemName == "Lee Enfield" then
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


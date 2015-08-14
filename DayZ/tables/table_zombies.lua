--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: functions_player.lua					*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SHARED														*----
#-----------------------------------------------------------------------------#
]]


ZombiePedSkins = {56,67,68,69,70,92,97,105,107,108,126,127,128,152,162,167,188,195,209,212,229,230,258,264,277,280 }


ZombieLoot = {
{56,"civilian"},
{67,"civilian"},
{68,"civilian"},
{69,"civilian"},
{70,"hunter"},
{92,"hunter"},
{97,"hunter"},
{105,"hunter"},
{107,"generic"},
{108,"generic"},
{126,"generic"},
{127,"generic"},
{264,"generic"},
{277,"generic"},
{280,"generic"},
{128,"medical"},
{152,"medical"},
{162,"medical"},
{167,"medical"},
{188,"military"},
{195,"military"},
{206,"military"},
{209,"military"},
{212,"policeman"},
{229,"policeman"},
{230,"policeman"},
{258,"policeman"}
}

zombieLootType = {

["civilian"] = {
{"Empty Soda Can",2673,0.5,0,8.82},
{"Empty Tin Can",2673,0.5,0,8.82},
{"Broken Whiskey Bottle",2673,0.5,0,8.82},
{"Soda Can (Cola)",2647,1,0,11.76},
{"Soda Can (Pepsi)",2856,1,0,8.82},
{"Baked Beans",1582,1,0,4.90},
{"Sardines",2770,1,0,4.90},
{"Frank & Beans",2601,1,0,4.90},
{"Pasta",2768,1,0,4.90},
{".45 ACP Cartridge",3013,2,0,4.90},
{"2Rnd. Slug",2358,2,0,4.90},
{"12 Gauge Pellet",2358,2,0,4.90},
{"Bandage",1578,0.5,0,5.88},
{"Painkiller",2709,3,0,5.88},
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
{"Soda Can (Cola)",2647,1,0,6},
{"Soda Can (Pepsi)",2856,1,0,4},
{"Baked Beans",1582,1,0,1},
{"Sardines",2770,1,0,1},
{"Frank & Beans",2601,1,0,1},
{"Pasta",2768,1,0,1},
{"Empty Water Bottle",2683,1,0,1},
{"Water Bottle",2683,1,0,1},
{"Bandage",1578,0.5,0,11},
{".45 ACP Cartridge",3013,2,0,3},
{"9.3x62mm Cartridge",2358,2,0,1},
{".303 British Cartridge",2358,2,0,4},
{"9x19mm SD Cartridge",3013,2,0,4},
{"2Rnd. Slug",2358,2,0,5},
{"12 Gauge Pellet",2358,2,0,5},
{"9x18mm Cartridge",2358,2,0,9},
{"1866 Slug",2358,2,0,2},
{"Bolt",2041,2,0,4},
{"Road Flare",324,1,90,7},
{"Painkiller",2709,3,0,2},
{"Heat Pack",1576,5,0,4},
{"Assault Pack (ACU)",3026,1,0,6},
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
{"Soda Can (Cola)",2647,1,0,0.99},
{"Soda Can (Pepsi)",2856,1,0,0.99},
{"Bandage",1578,0.5,0,3.96},
{"Painkiller",2709,3,0,3.96},
{"Morphine",1579,1,0,0.99},
{"5.56x45mm Cartridge",1271,2,0,3.96},
{"9.3x62mm Cartridge",2358,2,0,3.96},
{".45 ACP Cartridge",3013,2,0,4.95},
{"9x19mm SD Cartridge",3013,2,0,0.99},
{"5.45x39mm Cartridge",1271,2,0,3.96},
{"12 Gauge Pellet",2358,2,0,3.96},
{"1866 Slug",2358,2,0,3.96},
{"2Rnd. Slug",2358,2,0,3.96},
{"9x19mm Cartridge",2041,2,0,1.98},
{"Bolt",2041,2,0,1.98},
{"Road Flare",324,1,90,4},
{"Wire Fence",933,0.25,0,1},
{"Grenade",342,1,0,0.99},
{"Heat Pack",1576,5,0,3.96},
{"Area 69 Keycard",1581,1,0,3.50},
{"San Fierro Carrier Keycard",1581,1,0,3.50},
},

["policeman"] = {
{"Bandage",1578,0.5,0,31.25},
{".45 ACP Cartridge",3013,2,0,25},
{"9x18mm Cartridge",2358,2,0,9.38},
{"1866 Slug",2358,2,0,9.38},
{"12 Gauge Pellet",2358,2,0,16.63},
{"Road Flare",324,1,90,9.38},
{"San Fierro Carrier Keycard",1581,1,0,7},
},
}
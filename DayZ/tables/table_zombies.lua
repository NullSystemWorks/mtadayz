--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: functions_player.lua					*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SHARED														*----
#-----------------------------------------------------------------------------#
]]

-- Not in use
ZombieSpawnPositions = {

{0,0,5},

}


ZombiePedSkins = {56,67,68,69,70,92,97,105,107,108,126,127,128,152,162,167,188,195,209,212,229,230,258,264,277,280}


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
{"Empty Soda Can",8.82},
{"Empty Tin Can",8.82},
{"Broken Whiskey Bottle",8.82},
{"Soda Can (Cola)",11.76},
{"Soda Can (Pepsi)",8.82},
{"Baked Beans",4.90},
{"Sardines",4.90},
{"Frank & Beans",4.90},
{"Pasta",4.90},
{"9x18mm Cartridge",6.86},
{"11.43x23mm Cartridge",4.90},
{"1866 Slug",4.90},
{"12 Gauge Pellet",4.90},
{"Bandage",5.88},
{"Painkiller",5.88},
},

["hunter"] = {
{"Bandage",27.78},
{"11.43x23mm Cartridge",5.56},
{"7.62x51mm Cartridge",13.89},
{".303 British Cartridge",13.89},
{"Empty Water Bottle",5.56},
{"Bolt",27.78},
{"Heat Pack",5.56},
},

["generic"] = {
{"Empty Soda Can",0,6},
{"Empty Tin Can",0,6},
{"Broken Whiskey Bottle",0,4},
{"Soda Can (Cola)",0,6},
{"Soda Can (Pepsi)",0,4},
{"Baked Beans",1},
{"Sardines",1},
{"Frank & Beans",1},
{"Pasta",1},
{"Empty Water Bottle",1},
{"Water Bottle",1},
{"Bandage",11},
{"11.43x23mm Cartridge",3},
{"5.56x45mm Cartridge",1},
{".303 British Cartridge",4},
{"9x19mm Cartridge",4},
{"12 Gauge Pellet",5},
{"9x18mm Cartridge",9},
{"1866 Slug",2},
{"Bolt",4},
{"Road Flare",7},
{"Painkiller",2},
{"Heat Pack",4},
{"Assault Pack (ACU)",6},
},

["medical"] = {
{"Bandage",43.48},
{"Painkiller",21.74},
{"Morphine",21.74},
{"Heat Pack",4.35},
},

["military"] = {
{"Empty Tin Can",17.82},
{"Empty Soda Can",8.91},
{"Soda Can (Cola)",0.99},
{"Soda Can (Pepsi)",0.99},
{"Bandage",3.96},
{"Painkiller",3.96},
{"Morphine",0.99},
{"5.45x39mm Cartridge",0.99},
{"7.62x39mm Cartridge",0.99},
{"7.62x51mm Cartridge",0.99},
{"5.56x45mm Cartridge",0.99},
{"11.43x23mm Cartridge",4.95},
{"9x19mm Cartridge",0.99},
{"12 Gauge Pellet",3.96},
{"1866 Slug",3.96},
{"9x18mm Cartridge",1.98},
{"Bolt",1.98},
{"Road Flare",4},
{"Wire Fence",1},
{"Grenade",0.99},
{"Heat Pack",3.96},
{"Area 69 Keycard",3.50},
{"San Fierro Carrier Keycard",3.50},
},

["policeman"] = {
{"Bandage",31.25},
{"11.43x23mm Cartridge",25},
{"9x18mm Cartridge",9.38},
{"1866 Slug",9.38},
{"12 Gauge Pellet",16.63},
{"Road Flare",9.38},
{"San Fierro Carrier Keycard",7},
},
}
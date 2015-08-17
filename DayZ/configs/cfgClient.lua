--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: cfgClient.lua							*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: CLIENT														*----
#-----------------------------------------------------------------------------#
]]

-- PING CHECK
gameplayVariables["ping"] = 600 -- Checks if ping is over the set amount. DEFAULT: 600

-- ZOMBIE DAMAGE
gameplayVariables["zombiedamage"] = 650 -- Damage done by zombies - DEFAULT: math.random(400,900), for consistent damage, remove math.random(400,900) and insert value (EXAMPLE: 1000)

-- MISC
gameplayVariables["enablenight"] = false -- Whether or not the night should be darker - DEFAULT: true - SET TO false to disable - remember you need to set it in editor_server.lua too.

-- HEADSHOT MULTIPLIER
gameplayVariables["headshotdamage_player"] = 1.5 -- Multiplier for damage on head shot (player). DEFAULT: 1.5, EXAMPLE: damage*1.5
gameplayVariables["headshotdamage_zombie"] = 1.5 -- Multiplier for damage on head shot (zombies). DEFAULT: 1.5, EXAMPLE: damage*1.5
	
-- SOUND VOLUME
gameplayVariables["ambiencesoundvolume"] = 0.8 -- How loud ambience sounds should be. Set to 0 to disable, max is 1.0. - DEFAULT: 0.8

-- BATTLDAYZ SETUP
gameplayVariables["combatlog"] = true -- Enable/Disable anti combat log output - DEFAULT: true
	
-- WEAPON DAMAGE
damageTable = {
-- {"WEAPON NAME",DAMAGE},
{"M4",3555},
{"CZ 550",8000},
{"Winchester 1866",4500},
{"MP5A5",889},
{"SPAZ-12 Combat Shotgun",4500},
{"AK-47",2722},
{"Lee Enfield",6722},
{"Hunting Knife",1500},
{"Hatchet",4500},
{"M1911",1389},
{"M9 SD",889},
{"PDW",889},
--{"TEC-9",889},
{"Sawn-Off Shotgun",4500},
{"Desert Eagle",1389},
{"Grenade",17998},
{"Baseball Bat",1199},
{"Shovel",1203},
{"Golf Club",953},
{"Mosin 9130",6722},
{"Sporter 22",6722},
{"Crossbow",3555},
{"SKS",4000},
{"Revolver",1389},
{"Blaze 95 Double Rifle",4500},
{"Remington 870",4500},
{"Bizon PP-19",889},
{"FN FAL",8000},
{"G36C",3300},
{"Sa58V CCO",4100},
{"SVD Dragunov",8000},
{"DMR",8000},
{"G17",889},
{"Machete",12500},
{"Crowbar",1389},
}

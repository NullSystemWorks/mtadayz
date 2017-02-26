--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: table_achievements.lua				*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SHARED														*----
#-----------------------------------------------------------------------------#
]]

pathToImg = "gui/achievements/icons/"
achievements = {
	[1] = {
		["identification"] = "kill50p",
		["name"] = "Killing 50 players",
		["description"] = "Kill 50 players to win this achievement and some items",
		["items"] = {{"Flashlight",1},{"Bandage",3}},
		["conditions"] = {{"murders","greater",10},{"zombieskilled","less",10}},
		["image"] = "achiev1.png"
	},
	[2] = {
		["identification"] = "kill50z",
		["name"] = "Killing 50 zombies",
		["description"] = "Kill 50 zombies to win this achievement and some items",
		["items"] = {{"Flashlight",1},{"Bandage",3}},
		["conditions"] = {{"zombieskilled","greater",30}},
		["image"] = "achiev1.png"
	},
}
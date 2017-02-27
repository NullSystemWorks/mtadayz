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
	["murderer"] = {
		["name"] = "There's bloood!!!",
		["description"] = "Your first kill",
		["items"] = {{"Gray Pants",1},{"Bandage",1}},
		["conditions"] = {{"murders","greater",0}},
		["image"] = "achiev1.png"
	},
	["murderer02"] = {
		["name"] = "Killing 5 players",
		["description"] = "Kill before being killed",
		["items"] = {{"Flashlight",1},{"Bandage",3}},
		["conditions"] = {{"murders","greater",4}},
		["image"] = "achiev1.png"
	},
	["murderer03"] = {
		["name"] = "Kill before being killed",
		["description"] = "Kill 50 players to win this achievement and some items",
		["items"] = {{"Flashlight",1},{"Bandage",3}},
		["conditions"] = {{"murders","greater",49}},
		["image"] = "achiev1.png"
	},
	["zombies01"] = {
		["name"] = "uuuurrrgh!!",
		["description"] = "Kill your first zombie",
		["items"] = {{"MRE",1},{"Bandage",3}},
		["conditions"] = {{"zombieskilled","greater",0}}, -- zombieskilled > 0 (1 or more)
		["image"] = "achiev1.png"
	},
	["zombies02"] = {
		["name"] = "Zombie's leader",
		["description"] = "Kill 50 zombies to win this achievement and some items",
		["items"] = {{"MRE",1},{"Bandage",3}},
		["conditions"] = {{"zombieskilled","greater",49}},
		["image"] = "achiev1.png"
	},
	["ATimeRecordist"] = {
		["name"] = "Are you still alive? 01",
		["description"] = "Being alive for more than 5 hours",
		["items"] = {{"MRE",1},{"Black Bandana (H)",1}},
		["conditions"] = {{"alivetime","greater",350}},
		["image"] = "achiev1.png"
	},
	["ATimeRecordist2"] = {
		["name"] = "Are you still alive? 02",
		["description"] = "Being alive for more than 10 hours",
		["items"] = {{"MRE",1},{"Black Bandana (H)",1}},
		["conditions"] = {{"alivetime","greater",600}},
		["image"] = "achiev1.png"
	},
	["bandit"] = {
		["name"] = "Call the Cops, there's a bandit!",
		["description"] = "Kill someone and be a bandit to win it and some items",
		["items"] = {{"MRE",1},{"Black Bandana (H)",1}},
		["conditions"] = {{"bandit","equal",true}},
		["image"] = "achiev1.png"
	},
	["hero"] = {
		["name"] = "HERO?",
		["description"] = "Save someone! Kill some bandits and win a reward",
		["items"] = {{"Compound Crossbow",1},{"MRE",1},{"Bolt",5}},
		["conditions"] = {{"banditskilled","greater",1}},
		["image"] = "achiev1.png"
	},
	["hero2"] = {
		["name"] = "My HERO!",
		["description"] = "Kill 10 bandits and save the world or a woman...",
		["items"] = {{"G36K CAMO",1},{"5.56x45mm Cartridge",30}},
		["conditions"] = {{"banditskilled","greater",10}},
		["image"] = "achiev1.png"
	},
	["hero3"] = {
		["name"] = "It's a Bird...It's a Plane...It's Survival MAN!",
		["description"] = "Save the world (Killed 50 bandits)",
		["items"] = {{"SVD Dragunov",1},{"7.62x54mm Cartridge",10}},
		["conditions"] = {{"banditskilled","greater",50}},
		["image"] = "achiev1.png"
	},
}

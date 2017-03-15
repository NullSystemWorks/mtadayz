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
		["name"] = "Tasting Blood I",
		["description"] = "Kill 1 Player",
		["items"] = {{"Gray Pants",1},{"Bandage",1}},
		["conditions"] = {{"murders","greater",0}},
		["image"] = "achiev1.png"
	},
	["murderer02"] = {
		["name"] = "Tasting Blood II",
		["description"] = "Kill 3 Players",
		["items"] = {{"Flashlight",1},{"Bandage",3}},
		["conditions"] = {{"murders","greater",2}},
		["image"] = "achiev1.png"
	},
	["murderer03"] = {
		["name"] = "Tasting Blood III",
		["description"] = "Kill 50 Players",
		["items"] = {{"Flashlight",1},{"Bandage",3}},
		["conditions"] = {{"murders","greater",49}},
		["image"] = "achiev1.png"
	},
	["zombies01"] = {
		["name"] = "Survival Of The Fittest I",
		["description"] = "Kill 1 Zombie",
		["items"] = {{"MRE",1},{"Bandage",3}},
		["conditions"] = {{"zombieskilled","greater",0}}, -- zombieskilled > 0 (1 or more)
		["image"] = "achiev1.png"
	},
	["zombies02"] = {
		["name"] = "Survival Of The Fittest II",
		["description"] = "Kill 50 Zombies",
		["items"] = {{"MRE",1},{"Bandage",3}},
		["conditions"] = {{"zombieskilled","greater",49}},
		["image"] = "achiev1.png"
	},
	["ATimeRecordist"] = {
		["name"] = "Against All Odds I",
		["description"] = "Stay alive for more than 5 hours",
		["items"] = {{"MRE",1},{"Black Bandana (H)",1}},
		["conditions"] = {{"alivetime","greater",350}},
		["image"] = "achiev1.png"
	},
	["ATimeRecordist2"] = {
		["name"] = "Against All Odds II",
		["description"] = "Stay alive for more than 10 hours",
		["items"] = {{"MRE",1},{"Black Bandana (H)",1}},
		["conditions"] = {{"alivetime","greater",600}},
		["image"] = "achiev1.png"
	},
	["bandit"] = {
		["name"] = "What You Are In The Dark",
		["description"] = "Become a bandit",
		["items"] = {{"MRE",1},{"Black Bandana (H)",1}},
		["conditions"] = {{"bandit","equal",true}},
		["image"] = "achiev1.png"
	},
	["hero"] = {
		["name"] = "He Who Fights Monsters I",
		["description"] = "Kill 1 Bandit",
		["items"] = {{"Compound Crossbow",1},{"MRE",1},{"Bolt",5}},
		["conditions"] = {{"banditskilled","greater",0}},
		["image"] = "achiev1.png"
	},
	["hero2"] = {
		["name"] = "He Who Fights Monsters II",
		["description"] = "Kill 10 Bandits",
		["items"] = {{"G36K CAMO",1},{"5.56x45mm Cartridge",30}},
		["conditions"] = {{"banditskilled","greater",9}},
		["image"] = "achiev1.png"
	},
	["hero3"] = {
		["name"] = "He Who Fights Monsters III",
		["description"] = "Kill 50 Bandits",
		["items"] = {{"SVD Dragunov",1},{"7.62x54mm Cartridge",10}},
		["conditions"] = {{"banditskilled","greater",49}},
		["image"] = "achiev1.png"
	},
	["litterbug"] = {
		["name"] = "Litterbug",
		["description"] = "Collect 5 Empty Tin Cans",
		["items"] = {{"Bandage",1},{"MRE",1}},
		["conditions"] = {{"Empty Tin Can","equal",5}},
		["image"] = "achiev1.png"
	},
	["seemyhouse"] = {
		["name"] = "I Can See My House From Here!",
		["description"] = "Fly a plane/heli",
		["items"] = {{"MRE",1},{"Can (Corn)",1}},
		["conditions"] = {{"blank","misc_zaxis",300}},
		["image"] = "achiev1.png"
	},
	["bloodypulp"] = {
		["name"] = "Bloody Pulp",
		["description"] = "Drop below 6000 blood",
		["items"] = {{"MRE",1},{"Can (Corn)",1}},
		["conditions"] = {{"blood","less",6000}},
		["image"] = "achiev1.png"
	},
	["goingcommando"] = {
		["name"] = "Going Commando",
		["description"] = "Wear no clothes",
		["items"] = {{"MRE",0},{"Can (Corn)",0}},
		["conditions"] = {{"blank","clothes",0}},
		["image"] = "achiev1.png"
	},
	["area69"] = {
		["name"] = "Roswell Conspiracies",
		["description"] = "Visit Area 69",
		["items"] = {{"MRE",0},{"Can (Corn)",0}},
		["conditions"] = {{"blank","area",0}},
		["image"] = "achiev1.png"
	},
	["sanfierrocarrier"] = {
		["name"] = "USS Werfukd",
		["description"] = "Visit the San Fierro Carrier",
		["items"] = {{"MRE",0},{"Can (Corn)",0}},
		["conditions"] = {{"blank","carrier",0}},
		["image"] = "achiev1.png"
	},
}

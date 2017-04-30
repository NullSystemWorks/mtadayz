--[[
#---------------------------------------------------------------#
----*			DayZ MTA Script editor_client.lua			*----
----* This Script is owned by Marwin, you are allowed to edit it.
----* Owner: Marwin W., Germany, Lower Saxony, Otterndorf
----* Skype: xxmavxx96
----*														*----
#---------------------------------------------------------------#
]]

-- SCOREBOARD
shownText = {}
 
	shownText["name"] = "Name"
	shownText["murders"] = "Murders"
	shownText["zombieskilled"] = "Zombies killed:"
	shownText["alivetime"] = "Alivetime"
	shownText["headshots"] =  "Headshots"
	shownText["blood"] =  "Blood"
	shownText["temperature"] =  "Temperature"
	shownText["humanity"] =  "Humanity"
	shownText["banditskilled"] =  "Bandits killed:"
	shownText["players"] =  "Players:"


gameplayVariables = {}

-- PING CHECK	

	gameplayVariables["ping"] = 600 -- Checks if ping is over the set amount. DEFAULT: 600
	
-- ZOMBIE DAMAGE
	gameplayVariables["zombiedamage"] = math.random(400,900) -- Damage done by zombies - DEFAULT: math.random(400,900), for consistent damage, remove math.random(400,900) and insert value (EXAMPLE: 1000)
	
	gameplayVariables["enablenight"] = true -- Whether or not the night should be darker - DEFAULT: true - SET TO false to disable - remember you need to set it in editor_server.lua too.
	
-- WEAPON DAMAGE
damageTable = {
-- {"WEAPON NAME",DAMAGE},
{"M4",3500},
{"CZ 550",8000},
{"Winchester 1866",4500},
{"MP5A5",889},
{"SPAZ-12 Combat Shotgun",2000},
{"AK-47",2722},
--{"Heat-Seeking RPG",0},
--{"M136 Rocket Launcher",0},
{"Lee Enfield",8000},
{"Hunting Knife",1500},
{"Hatchet",1006},
{"M1911",889},
{"M9 SD",889},
{"PDW",889},
--{"TEC-9",889},
{"Sawn-Off Shotgun",2000},
{"Desert Eagle",1389},
{"Grenade",17998},
{"Baseball Bat",953},
{"Shovel",953},
{"Golf Club",953},
}

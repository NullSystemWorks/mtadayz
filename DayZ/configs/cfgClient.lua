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
gameplayVariables["zombiedamage"] = 650 -- Damage done by zombies - DEFAULT: 650, for consistent damage, remove math.random(400,900) and insert value (EXAMPLE: 1000)

-- MISC
gameplayVariables["enablenight"] = true -- Whether or not the night should be darker - DEFAULT: true

-- HEADSHOT MULTIPLIER
gameplayVariables["headshotdamage_player"] = 1.5 -- Multiplier for damage on head shot (player). DEFAULT: 1.5, EXAMPLE: damage*1.5
gameplayVariables["headshotdamage_zombie"] = 1.5 -- Multiplier for damage on head shot (zombies). DEFAULT: 1.5, EXAMPLE: damage*1.5
	
-- SOUND VOLUME
gameplayVariables["ambiencesoundvolume"] = 0.8 -- How loud ambience sounds should be. Set to 0 to disable, max is 1.0. - DEFAULT: 0.8

-- PAIN SHAKE LEVEL
gameplayVariables["painshakelevel"] = 150 -- How much should the camera shake when in pain. DEFAULT: 150, value can be from 0 - 255

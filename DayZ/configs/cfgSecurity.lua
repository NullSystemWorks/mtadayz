--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: cfgSecurity.lua						*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* 				This gamemode is being developed by 				*----
----*				L, CiBeR96, 1B0Y, Remi & Renkon						*----
----* Type: SHARED														*----
#-----------------------------------------------------------------------------#
]]

outputDebugString("[DayZ] cfgSecurity loaded")

gameplayVariables["combatlog"] = true -- // Enable/Disable anti combat logging - DEFAULT: true
gameplayVariables["securitylevel"] = 1 -- // Set security level: 2 = Ban, 1 = Kick, 0 = Disabled - DEFAULT: 1
gameplayVariables["bantime"] = 0 -- // If security level is 2, for how long should the player be banned (in seconds)? - 0 = Forever - DEFAULT: 0
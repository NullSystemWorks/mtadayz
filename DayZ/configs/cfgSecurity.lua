--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: cfgSecurity.lua						*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* 				This gamemode is being developed by 				*----
----*				L, CiBeR96, 1B0Y, Remi & Renkon						*----
----* Type: SHARED														*----
#-----------------------------------------------------------------------------#
]]

gameplayVariables["combatlog"] = true -- // Enable/Disable anti combat logging - DEFAULT: true
gameplayVariables["securitylevel"] = 1 -- // Set security level: 2 = Ban, 1 = Kick, 0 = Disabled - DEFAULT: 1
gameplayVariables["bantime"] = 0 -- // If security level is 2, for how long should the player be banned (in seconds)? - 0 = Forever - DEFAULT: 0
gameplayVariables["packetlosskick"] = true -- Allow the gamemode to kick a player if his packet loss is 100% for 5 seconds - DEFAULT: true
gameplayVariables["packetlossmax"] = 10 -- Set the max packet loss counter - DEFAULT: 10
gameplayVariables["maxslots"] = 30 -- Max slot amount in your server( Include VIP Slots ) - DEFAULT: 30
gameplayVariables["noadvert"] = true -- Banning players who write the server ip
gameplayVariables["adBanTime"] = 86400 -- If noadvert is true, define how much time should the banTime be in seconds. DEFAULT: 86400( 1 Day )

outputDebugString("[DayZ] cfgSecurity loaded")

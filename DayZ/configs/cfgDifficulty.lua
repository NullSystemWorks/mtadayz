--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: cfgDifficulty.lua						*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y, Rémi		*----
----* Type: SHARED														*----
#-----------------------------------------------------------------------------#
]]

gameplayVariables["difficulty"] = "normal" -- // Possible values: "normal", "veteran", "hardcore" - See below for description

outputDebugString("[DayZ] cfgDifficulty loaded (Difficulty: "..tostring(gameplayVariables["difficulty"])..")")

--[[
DIFFICULTIES

Normal: 
Crosshairs are visible, 1.0x multiplier for zombie blood + damage, player tags are visible

Veteran:
Crosshairs are visible, 1.5x multiplier for zombie blood + damage, player tags are not visible

Hardcore:
Crosshairs are not visible, 3.0x multiplier for zombie blood + damage, player tags are not visible

]]
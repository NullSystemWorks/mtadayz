--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: actions_player.lua					*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: CLIENT														*----
#-----------------------------------------------------------------------------#
]]
--Disallow blocking attacks
addEventHandler("onClientRender", root,
function ()
if getControlState("aim_weapon") and getControlState("jump") then
	setControlState("jump",false)
end
end
)

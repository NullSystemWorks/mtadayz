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
function()
	if getPedControlState(localPlayer,"aim_weapon") and getPedControlState(localPlayer,"jump") then
		setControlState("jump",false)
	end
	if getPedWeapon(localPlayer) == 0 then
		toggleControl("fire",false)
		toggleControl("aim_weapon",false)
	else
		toggleControl("fire",true)
		toggleControl("aim_weapon",true)
	end
end)

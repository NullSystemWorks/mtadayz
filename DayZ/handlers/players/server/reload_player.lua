--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: reload_player.lua						*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]

function reloadWeapon()
	reloadPedWeapon(client)
end
addEvent("relWep", true)
addEventHandler("relWep", resourceRoot, reloadWeapon)
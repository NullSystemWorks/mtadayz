--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: pingkick_player.lua					*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]

function kickPlayerOnHighPing ()
	if gameplayVariables["pingkick"] then
		outputChatBox (getPlayerName(source).." was kicked due to high ping!",getRootElement(),255,0,0,true)	
		kickPlayer(source,"Your ping was too high!")
	end
end
addEvent("kickPlayerOnHighPing",true)
addEventHandler("kickPlayerOnHighPing",root,kickPlayerOnHighPing)
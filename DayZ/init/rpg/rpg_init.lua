--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: rpg_init.lua							*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]



addEventHandler("onResourceStart",getResourceRootElement(getThisResource()), function()
	skillsDB = dbConnect("sqlite", "database/skills.db","","","share=0")
	dbExec(skillsDB, "CREATE TABLE IF NOT EXISTS skills (playerName TEXT, skillsData TEXT)")
	if skillsDB then
		outputServerLog("[DayZ] CONNECTED TO SKILLS DATABASE.")
	else
		outputServerLog("[DayZ] FAILED TO CONNECT TO DATABASE 'skills'. CHECK IF THEY EXIST.")
	end	
end)


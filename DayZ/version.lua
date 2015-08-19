--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: version.lua						*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]

local timer
version = "0.9.5a"

addEventHandler("onResourceStart",resourceRoot,
function()
	checkVersion()
	timer = setTimer(checkVersion,60000*60,0) --Update hourly
end)

function checkVersion()
	callRemote("http://mta-dayz.org/version.php",onVersionReturn)
end

function onVersionReturn(_version)
	if (_version == "ERROR") then
		return checkVersion() --Force check again
	end
	
	if _version ~= version then
		outputServerLog("[DayZ] A new version of MTA DayZ is available!")
		outputServerLog("[DayZ] Current Version: "..version.." | New Version: ".._version)
		outputServerLog("[DayZ] Download the new version at http://mta-dayz.org!")
		return
	end
	outputServerLog("[DayZ] MTA DayZ is up-to-date.")
end
--[[
#---------------------------------------------------------------#
----*			DayZ MTA Script version.lua			    	*----
----* This Script is owned by Marwin, you are not allowed to use or own it.
----* Owner: Marwin W., Germany, Lower Saxony, Otterndorf
----* Skype: xxmavxx96
----* Developers: L, CiBeR,	Jboy							*----
#---------------------------------------------------------------#
]]

local timer
version = "0.9.1.1a"

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
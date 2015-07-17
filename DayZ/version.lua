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

addEventHandler("onResourceStart",resourceRoot,
function()
	checkVersion()
	timer = setTimer(checkVersion,60000*60,0) --Update hourly
end)

function checkVersion()
	callRemote("--WEBHOST--/dayz/version.php",onVersionReturn)
end

function onVersionReturn(_version)
	if (_version == "ERROR") then
		return checkVersion() --Force check again
	end
	
	if _version ~= version then
		outputServerLog("[DayZ] A new version of MTA DayZ is available! Current version: "..version.." | New version: ".._version)
		outputServerLog("[DayZ] Download the new version at http://mtadayz.heliohost.org/forum/index.php?action=forum")
		return
	end
	outputServerLog("[DayZ] Gamemode is up-to-date.")
end
--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: cfgAddons.lua							*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]
-- [[ Setting game type (Is this still needed?) ]] --

addons = "DayZ 0.9.5a // "
function addAddonInfo (name,description)
	addons = addons.." "..name.." | "
	setGameType (addons)
end

function changeGameType()
	setGameType("DayZ 0.9.5a")	
end
addEventHandler("onResourceStart",root,changeGameType)

-- [[ Automatically start all resources with "addon_" in name ]] --
function loadAddons( res )
if not gameplayVariables["autostartaddons"] then return end
	for resourceKey, resourceValue in ipairs(getResources()) do
		local name = getResourceName(resourceValue)
		if string.find(name,"addon_") then
			startResource(resourceValue)
		end
	end
end
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), loadAddons )

-- [[ Stops all resources with "addon_" in name ]] --
function unloadAddons ( res )
if not gameplayVariables["autostartaddons"] then return end
	for resourceKey, resourceValue in ipairs(getResources()) do
		local name = getResourceName(resourceValue)
		if string.find(name,"addon_") then
			stopResource(resourceValue)
		end
	end
end
addEventHandler ( "onResourceStop", getResourceRootElement(getThisResource()), unloadAddons )

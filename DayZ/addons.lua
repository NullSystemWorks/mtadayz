--[[
#---------------------------------------------------------------#
----*			DayZ MTA Script addons.lua			    	*----
----* This Script is owned by Marwin, you are not allowed to use or own it.
----* Owner: Marwin W., Germany, Lower Saxony, Otterndorf
----* Skype: xxmavxx96
----* Developers: L, CiBeR,	Jboy							*----
#---------------------------------------------------------------#
]]

-- [[ Setting game type (Is this still needed?) ]] --

addons = "DayZ 0.9.3a // "
function addAddonInfo (name,description)
	addons = addons.." "..name.." | "
	setGameType (addons)
end

function changeGameType()
	setGameType("DayZ 0.9.3a")	
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),changeGameType)

--night addon (Should be separate)
--[[
function nightAddon1 ()
	if gameplayVariables["enablenight"] then 
		addAddonInfo ("Night","Night time with fading effect.")
	end
end

function nightAddon () 
	setTimer(nightAddon1,10000,1)
end
nightAddon () 
]]

-- [[ Automatically start all resources with "addon_" in name ]] --
function loadAddons( res )
if not gameplayVariables["autostartaddons"] then return end
	for resourceKey, resourceValue in ipairs(getResources()) do
		local name = getResourceName(resourceValue)
		if string.find(name,"addon_") then
			startResource(resourceValue)
			setGameType("DayZ 0.9.0a")
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

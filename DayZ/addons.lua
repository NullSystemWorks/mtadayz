-- [[ Setting game type (Is this still needed?) ]] --

addons = "DayZ 0.8a // "
function addAddonInfo (name,description)
	addons = addons..name.." | "
	setGameType (addons)
end

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
	for resourceKey, resourceValue in ipairs(getResources()) do
		local name = getResourceName(resourceValue)
		if string.find(name,"addon_") then
			stopResource(resourceValue)
		end
	end
end
addEventHandler ( "onResourceStop", getResourceRootElement(getThisResource()), unloadAddons )

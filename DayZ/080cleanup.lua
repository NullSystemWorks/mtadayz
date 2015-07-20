--[[
#---------------------------------------------------------------#
----*			DayZ MTA Script 080cleanup.lua			*----
----* This Script is owned by Marwin, you are not allowed to use or own it.
----* Owner: Marwin W., Germany, Lower Saxony, Otterndorf
----* Skype: xxmavxx96
----* Developers: L, CiBeR,	Jboy							*----
#---------------------------------------------------------------#
]]

local accountsDeleted = 0
function onStart()
	for k,v in ipairs(getAccounts()) do
		--Let's clean up those pesky old vehicle accounts
		if string.find(getAccountName(v), "vehicle_number") then
			outputDebugString("[Cleanup] Found old vehicle data, deleting...")
			removeAccount(v)
			accountsDeleted = accountsDeleted + 1
		end
		
		--And now for the tents...
		if (string.find(getAccountName(v), "tent_number") then
			outputDebugString("[Cleanup] Found old tent data, deleting...")
			removeAccount(v)
			accountsDeleted = accountsDeleted + 1
		end
	end
	
	outputDebugString("[Cleanup] Done. "..accountsDeleted.." vehicles/tents deleted.")
end
addEventHandler("onResourceStart",resourceRoot,onStart)
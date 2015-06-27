--[[

	Resource Name: Statistics Window for DayZ
	Author: L
	Version: 1.0.0
	Description: Allows one to see other players statistics, such as blood, humanity, skin, etc.
    Version Type: PREMIUM
]]



local aclGroup 
local isConfigOkay = true 


addEventHandler("onResourceStart", resourceRoot,
function()
	call (getResourceFromName("DayZ"), "addAddonInfo", "Stats Window", "Statistics Window for DayZ (Premium)")
	aclGroup = get("aclMinimumGroup")
	if string.find(aclGroup, ",") then
		aclGroup = split(aclGroup, ',')
	end
	if type(aclGroup) == "string" then
		if not aclGetGroup(aclGroup) then 
			outputError("Error in meta.xml of this resource! - Please check if group exists in ACL.xml!") 
			isConfigOkay = false
			return 
		end
	else
		for i, val in ipairs(aclGroup) do
			if not aclGetGroup(aclGroup[i]) then
				outputError("Error in meta.xml of this resource! - Please check if group exists in ACL.xml!") 
				isConfigOkay = false
				return
			end
		end
	end
end )

addCommandHandler("stats",
function(pSource)
	
	if not isConfigOkay then return end
	if type(aclGroup) == "string" then
		if not isObjectInACLGroup ("user."..getAccountName(getPlayerAccount(pSource)), aclGetGroup(aclGroup)) then return end
		triggerClientEvent(pSource, "onStatsOpen", pSource)
	else
		for i, _ in ipairs(aclGroup) do
			if isObjectInACLGroup ("user."..getAccountName(getPlayerAccount(pSource)), aclGetGroup(aclGroup[i])) then
				triggerClientEvent(pSource, "onStatsOpen", pSource)
				break
			end
		end
	end
end )


function outputError(msg)
	outputDebugString(msg, 1)
	outputChatBox(msg, root, 255, 0, 0, true)
end



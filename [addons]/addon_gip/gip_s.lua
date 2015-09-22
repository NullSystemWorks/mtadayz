--[[
/**
	@ name: Give-an-Item Panel (GIP)
	@ author: Renkon
	@ version: 1.0
	@ type: DayZ Addon
	@ description: Panel which lets you give items to any player connected to your server.
*/
]]

addEvent("onGIPGive", true)

local aclGroup -- // Minimum group in order to access give GUI.
local isConfigOkay = true -- // Checking if script works correctly.

-- // Adding required information in order to make the addon work correctly. --
addEventHandler("onResourceStart", resourceRoot,
function()
	aclGroup = get("aclMinimumGroup")
	if string.find(aclGroup, ",") then
		aclGroup = split(aclGroup, ',')
	end
	if type(aclGroup) == "string" then
		if not aclGetGroup(aclGroup) then 
			outputError("Error in meta.xml. Bad ACL Group. Resource will not work.") 
			isConfigOkay = false
			return 
		end
	else
		for i, val in ipairs(aclGroup) do
			if not aclGetGroup(aclGroup[i]) then
				outputError("Error in meta.xml. Bad ACL Group. Resource will not work.") 
				isConfigOkay = false
				return
			end
		end
	end
end )

-- // Handling /give command. --
addCommandHandler("give",
function(pSource)
	
	if not isConfigOkay then return end
	if type(aclGroup) == "string" then
		if not isObjectInACLGroup ("user."..getAccountName(getPlayerAccount(pSource)), aclGetGroup(aclGroup)) then return end
		triggerClientEvent(pSource, "onGIPOpened", pSource)
	else
		for i, _ in ipairs(aclGroup) do
			if isObjectInACLGroup ("user."..getAccountName(getPlayerAccount(pSource)), aclGetGroup(aclGroup[i])) then
				triggerClientEvent(pSource, "onGIPOpened", pSource)
				break
			end
		end
	end
end )

-- // Function to inform. --
function outputError(msg)
	outputDebugString(msg, 1)
	outputChatBox(msg, root, 255, 0, 0, true)
end

-- // Give handler. --
addEventHandler("onGIPGive", root,
function(pName, item, quantity)
	local theTime = getRealTime()
	local hour = theTime.hour
	local minute = theTime.minute
	local seconds = theTime.second
	if hour < 10 then
		hour = "0"..hour
	else
		hour = theTime.hour
	end
	if minute < 10 then
		minute  = "0"..minute
	else
		minute = theTime.minute
	end
	if seconds < 10 then
		minute = "0"..seconds
	else
		seconds = theTime.second
	end
	setElementData(getPlayerFromName(pName), item, getElementData(getPlayerFromName(pName),item)+quantity)
	outputChatBox("Given "..quantity.." "..item.." to "..pName, source, 255, 255, 0)
	outputChatBox(getAccountName(getPlayerAccount(client)).." gave you "..quantity.." "..item, getPlayerFromName(pName), 255, 255, 0)
	exports.DayZ:saveLog("["..hour..":"..minute..":"..seconds.."] "..getAccountName(getPlayerAccount(getPlayerFromName(pName))).." got an item via GIP: "..item.."(x"..quantity..") by "..getAccountName(getPlayerAccount(client)).."\n","admin")
end )
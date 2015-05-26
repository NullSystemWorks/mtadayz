invitations = {}

addEventHandler("onResourceStart", resourceRoot, function()
	local columnName = get("column_name")
	exports.scoreboard:scoreboardAddColumn("gang", root, columnName:len() * 12, columnName)
	executeSQLQuery("CREATE TABLE IF NOT EXISTS gangs (gang_name STRING, gang_leader STRING, gang_members, gang_subleaders STRING)")
	executeSQLQuery("CREATE TABLE IF NOT EXISTS gang_members (gang_name STRING, member_account STRING, added_by STRING)")
	executeSQLQuery("CREATE TABLE IF NOT EXISTS alliance (alliance_name STRING, alliance_creator STRING, alliance_gangs STRING)")
	checkPlayerGroupDetails()	
	for index, player in ipairs(getElementsByType("player")) do
		local gang = getAccountGang(getAccountName(getPlayerAccount(player)))
		setElementData(player, "gang", gang)
	end
end)

addEventHandler("onPlayerLogin", root, function(_, account)
	local gang = getAccountGang(getAccountName(account))
	setElementData(source, "gang", gang)
end)

function showGangPanel(thePlayer)
	local gangName = getElementData(thePlayer, "gang")
	if gangName ~= "None" then
		local memberList = getGangMembers(gangName)
		triggerClientEvent(thePlayer, "gangSystem:openGangPanel", thePlayer, memberList)
	end
end

--disabled
addCommandHandler(get("gang_list_command"), function(thePlayer)
	local gangList = getGangList()
		if gangList and #gangList > 0 then
		triggerClientEvent(thePlayer, "gangSystem:openGangList", thePlayer, gangList)
	end
end)

addEvent("gangSystem:invitePlayer", true)
addEventHandler("gangSystem:invitePlayer", root, function(playerName)
	local gangName = getElementData(source, "gang")
	local accountName = getAccountName(getPlayerAccount(source))
	local player = getPlayerFromNamePart(playerName)
	if getGangLeader(gangName) == accountName or isGangSubLeader(gangName, accountName) then
		if player and isElement(player) then
			local playerAccountName = getAccountName(getPlayerAccount(player))
			if getAccountGang(gangName, playerAccountName) == "None" then
				invitations[player] = {gangName, source}
				outputChatBox("Gang system: You have invited " .. getPlayerName(player) .. " to the gang.", source, 0, 255, 0)
				outputChatBox("Gang system: You have been invited to " .. gangName .. ", write /accept to join.", player, 0, 255, 0)
			else
				outputChatBox("Gang system: This player is already in a gang!", source, 255, 0, 0)
			end
		else
			outputChatBox("Gang system: " .. playerName .. " matches no players!", source, 255, 0, 0)
		end
	else
		outputChatBox("Gang system: You're not allowed to use this function.", source, 255, 0, 0)
	end
end)

--disabled see groupsystem.lua
addCommandHandler(get("gang_create_command"), function(thePlayer, command, ...)
	local accountName = getAccountName(getPlayerAccount(thePlayer))
	local gangName = table.concat({...}, " ")
	if gangName and gangName ~= "" then
		local added, errorMsg = addGang(gangName, accountName)
		if added then
			outputChatBox("Gang created: Gang name: " .. gangName .. "!", thePlayer, 0, 255, 0)
		else
			outputChatBox("Gang error: " .. errorMsg .. "!", thePlayer, 255, 0, 0)
		end
	end
end)

addEvent("gangSystem:kickMember", true)
addEventHandler("gangSystem:kickMember", root, function(memberAccount)
	local gangName = getElementData(source, "gang")
	local accountName = getAccountName(getPlayerAccount(source))
	if gangName ~= "None" then
		if getGangLeader(gangName) == accountName or isGangSubLeader(gangName, accountName) then
			if getGangLeader(gangName) ~= memberAccount then
				if removeGangMember(gangName, memberAccount, getPlayerName(source)) then
					outputChatBox("Gang system: You have kicked " .. memberAccount .. " from the gang.", source, 255, 50, 0)
				end
			else
				outputChatBox("Gang system: You can't kick the gang leader.", source, 255, 0, 0)
			end
		else
			outputChatBox("Gang system: You're not allowed to use this function.", source, 255, 0, 0)
		end
	end
end)

addEvent("gangSystem:leaveGang", true)
addEventHandler("gangSystem:leaveGang", root, function()
	local gangName = getElementData(source, "gang")
	local accountName = getAccountName(getPlayerAccount(source))
	if gangName ~= "None" and accountName ~= "Guest" then
		if getGangLeader(gangName) ~= accountName then
			if removeGangMember(gangName, accountName) then
				outputChatBox("Gang system: You have left " .. gangName .. ".", source, 255, 50, 0)
			end
		else
			outputChatBox("Gang system: You may not leave the gang as you're the leader of it.", source, 255, 0, 0)
		end
	end
end)

addEvent("gangSystem:destroyGang", true)
addEventHandler("gangSystem:destroyGang", root, function()
	local gangName = getElementData(source, "gang")
	local accountName = getAccountName(getPlayerAccount(source))
	if gangName ~= "None" and accountName ~= "Guest" then
		if getGangLeader(gangName) == accountName then
			if removeGang(gangName) then
				outputChatBox("Gang system: You have destroyed the gang " .. gangName .. ".", source, 255, 50, 0)
			end
		else
			outputChatBox("Gang system: You're not allowed to use this function.", source, 255, 0, 0)
		end
	end
end)

addCommandHandler("accept", function(thePlayer)
	local invited, theGang, inviter = isPlayerGangInvited(thePlayer)
	if invited then
		addGangMember(theGang, getAccountName(getPlayerAccount(thePlayer)), getAccountName(getPlayerAccount(inviter)))
		outputChatBox("Gang system: Welcome to " .. tostring(theGang) .. "!", thePlayer, 0, 255, 0)
		for index, player in pairs(getPlayersByGang(theGang)) do
			outputChatBox("Gang system: " .. getPlayerName(thePlayer) .. " has joined the gang!", player, 0, 255, 0)
		end
		invitations[thePlayer] = false
	end
end)

addEvent("onPlayerJoinGang", true)
addEventHandler("onPlayerJoinGang", root, function(gangName)
	if doesGangExists(gangName) then
		executeSQLUpdate("gangs", "gang_members = '" .. #getGangMembers(gangName) + 1 .. "'", "gang_name = '" .. tostring(gangName) .. "'")
	end
end)

addEvent("onPlayerLeaveGang", true)
addEventHandler("onPlayerLeaveGang", root, function(gangName)
	if doesGangExists(gangName) then
		executeSQLUpdate("gangs", "gang_members = '" .. #getGangMembers(gangName) - 1 .. "'", "gang_name = '" .. tostring(gangName) .. "'")
	end
end)

addEvent("onGangJoinAlliance",true)
addEventHandler("OnGangJoinAlliance", root, function(gangName)
	if doesGangExists(gangName) then
		executeSQLUpdate("alliance","alliance_gangs = '" .. tostring(gangName) .. "'")
	end
end)


addEvent("gangSystem:getSubLeaders", true)
addEventHandler("gangSystem:getSubLeaders", root, function()
	local gangName = getElementData(source, "gang")
	if gangName and gangName ~= "None" then
		local subLeaders = getGangSubLeaders(gangName)
		triggerClientEvent(source, "gangSystem:returnSubLeaders", source, subLeaders)
	end
end)

addEvent("gangSystem:addSubLeader", true)
addEventHandler("gangSystem:addSubLeader", root, function(memberAccount)
	local gangName = getElementData(source, "gang")
	local accountName = getAccountName(getPlayerAccount(source))
	if gangName ~= "None" and accountName ~= "Guest" then
		if getGangLeader(gangName) == accountName then
			local isSubLeader, errorMsg = isGangSubLeader(gangName, memberAccount)
			if not isSubLeader then
				if editGangSubLeaders(gangName, memberAccount, true) then
					outputChatBox("Gang system: You have added " .. memberAccount .. " as a sub leader.", source, 0, 255, 0)
				else
					outputChatBox("Gang system: " .. tostring(errorMsg), source, 255, 50, 0)
				end
			else
				outputChatBox("Gang system: This member is already a sub leader.", source, 255, 50, 0)
			end
		else
			outputChatBox("Gang system: You're not allowed to use this function.", source, 255, 0, 0)
		end
	end
end)

addEvent("gangSystem:removeSubLeader", true)
addEventHandler("gangSystem:removeSubLeader", root, function(memberAccount)
	local gangName = getElementData(source, "gang")
	local accountName = getAccountName(getPlayerAccount(source))
	if gangName ~= "None" and accountName ~= "Guest" then
		if getGangLeader(gangName) == accountName then
			local isSubLeader, errorMsg = isGangSubLeader(gangName, memberAccount)
			if isSubLeader then
				if editGangSubLeaders(gangName, memberAccount, false) then
					triggerEvent("gangSystem:getSubLeaders", source)
					outputChatBox("Gang system: You have removed " .. memberAccount .. " from a sub leaders.", source, 255, 50, 0)
				else
					outputChatBox("Gang system: " .. tostring(errorMsg), source, 255, 50, 0)
				end
			else
				outputChatBox("Gang system: " .. tostring(errorMsg), source, 255, 50, 0)
			end
		else
			outputChatBox("Gang system: You're not allowed to use this function.", source, 255, 0, 0)
		end
	end
end)

--[[
addEvent("onLeaderFormAlliance",true)
function formAlliance(playersource)
local gangName = getElementData(source, "gang")
local accountName = getAccountName(getPlayerAccount(source))
	if gangName ~= "None" and accountName ~= "Guest" then
		if getGangLeader(gangName) == accountName then
			outputChatBox("Invitation to form an alliance has been sent.",source,0,255,0)
		else
			outputChatBox("You are not allowed to perform this action!",source,0,255,0)
		end
	end
end
addEventHandler("onLeaderFormAlliance",source,formAlliance)
]]
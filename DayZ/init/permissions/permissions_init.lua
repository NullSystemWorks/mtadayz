--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: permissions.lua						*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]

function preventCommandSpam(commandName)
	if commandName == "login" or commandName == "logout" then
		cancelEvent()
	end
end
addEventHandler("onPlayerCommand", root, preventCommandSpam)

function getTeamMemberOnline ()
	theTableMembersOnline = ""
	for i,player in ipairs(getElementsByType("player")) do
		local account = getPlayerAccount(player)
		if not isGuestAccount(account) then
			if getElementData(player,"supporter") or getElementData(player,"admin") then
				theTableMembersOnline = theTableMembersOnline..","..getPlayerName(player)
			end
		end
	end
	if theTableMembersOnline == "" then
		return "N/A"
	else
		return theTableMembersOnline
	end
end

function getPlayerWildcard(namePart)
	namePart = string.lower(namePart)
	
	local bestaccuracy = 0
	local foundPlayer, b, e
	for _,player in ipairs(getElementsByType("player")) do
		b,e = string.find(string.lower(string.gsub(getPlayerName(player), "#%x%x%x%x%x%x", "")), namePart)
		if b and e then
			if e-b > bestaccuracy then
				bestaccuracy = e-b
				foundPlayer = player
			end
		end
	end
	
	if (foundPlayer) then
		return foundPlayer
	else
		return false
	end
end

function setGroup (playersource,command,teamName,targetString)
	if (isObjectInACLGroup("user." ..getAccountName(getPlayerAccount(playersource)), aclGetGroup("Admin")))  then
		local foundTargetPlayer = getPlayerWildcard(targetString)
		if (foundTargetPlayer) then
			if teamName ~= "admin" or teamName ~= "supporter" or teamName ~= "remove" then 
				outputChatBox ("Correct names are admin, supporter and remove!",playersource,255,0,0,true)	
				return
			end
			if teamName == "remove" then
				value = false
				account = getPlayerAccount(foundTargetPlayer)
				setAccountData(account,"admin",value)
				setAccountData(account,"supporter",value)
				setElementData(foundTargetPlayer,"admin",value)
				setElementData(foundTargetPlayer,"supporter",value)
			else
				value = true
			end
			account = getPlayerAccount(foundTargetPlayer)
			accountname = getAccountName(account)
			setAccountData(account,teamName,value)
			setElementData(foundTargetPlayer,teamName,value)
			if value == true then
				outputChatBox ("#FFFFFF"..getPlayerName (foundTargetPlayer).." #FF0000 has been promoted to "..teamName.."!",getRootElement(),27, 89, 224,true)
			else
				outputChatBox ("#FFFFFF"..getPlayerName (foundTargetPlayer).." #FF0000 lost his status...",getRootElement(),27, 89, 224,true)
			end
		else
			outputChatBox ("#FFFFFFCan't find player! Did you input the correct name?",playersource,27, 89, 224,true)		
		end
	else
		outputChatBox ("#FFFFFFYou are not an admin!",playersource,27, 89, 224,true)		
	end
end
addCommandHandler("add",setGroup)
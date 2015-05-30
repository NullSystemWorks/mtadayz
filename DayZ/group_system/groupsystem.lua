--[[
addGang - Arguments: gangName, gangLeader. Returns: true or false.
removeGang - Arguments: gangName. Returns: true or false.
doesGangExists - Arguments: gangName. Returns: true or false.
getGangList - Arguments: None. Returns: A table with gang list.
getGangMembers - Arguments: gangName. Returns: A table with gang members.
addGangMember - Arguments: gangName, accountName, playerName, addedBy. Returns: true or false (if false, it'll return a second argument with the error.).
removeGangMember - Arguments: gangName, accountName, kickerName (if used it'll output who kicked the member, else it'll output that you left).
isGangMember - Arguments: gangName, accountName. Returns: true or false.
getAccountGang - Arguments: accountName. Returns: The gang name, 'None' otherwise.
getGangLeader - Arguments: gangName. Returns: The gang leader.
getGangSubLeaders - Arguments: gangName. Returns: A JSON string with gang sub leaders.
isPlayerGangInvited - Arguments: thePlayer. Returns: 3 arguments: invited, gangName, inviter.
getPlayersByGang - Arguments: gangName. Returns: A table with gang players.
isGangSubLeader - Arguments: gangName, accountName. Returns: true or false.
]]


PermissionsTable = {
	["Leader"] = {
		{"isRuler",true},
		{"isRecruiter",true},
		{"isRegulator",true},
		{"isPromoter",true},
		{"isArchitect",true},
		{"isTreasurer",true},
		{"isTech",true},
		{"isTactician",true},
		{"Level",7},
	},
	
	["Co-Leader"] = {
		{"isRuler",false},
		{"isRecruiter",true},
		{"isRegulator",true},
		{"isPromoter",true},
		{"isArchitect",true},
		{"isTreasurer",true},
		{"isTech",true},
		{"isTactician",true},
		{"Level",6},
	},
	
	["General"] = {
		{"isRuler",false},
		{"isRecruiter",true},
		{"isRegulator",true},
		{"isPromoter",false},
		{"isArchitect",true},
		{"isTreasurer",true},
		{"isTech",true},
		{"isTactician",true},
		{"Level",5},
	},
	
	["Officer"] = {
		{"isRuler",false},
		{"isRecruiter",true},
		{"isRegulator",true},
		{"isPromoter",false},
		{"isArchitect",false},
		{"isTreasurer",true},
		{"isTech",false},
		{"isTactician",false},
		{"Level",4},
	},
	
	["Soldier"] = {
		{"isRuler",false},
		{"isRecruiter",true},
		{"isRegulator",false},
		{"isPromoter",false},
		{"isArchitect",false},
		{"isTreasurer",true},
		{"isTech",false},
		{"isTactician",false},
		{"Level",3},
	},
	
	["Survivor"] = {
		{"isRuler",false},
		{"isRecruiter",false},
		{"isRegulator",false},
		{"isPromoter",false},
		{"isArchitect",false},
		{"isTreasurer",true},
		{"isTech",false},
		{"isTactician",false},
		{"Level",2},
	},
	
	["Bandit"] = {
		{"isRuler",false},
		{"isRecruiter",false},
		{"isRegulator",false},
		{"isPromoter",false},
		{"isArchitect",false},
		{"isTreasurer",false},
		{"isTech",false},
		{"isTactician",false},
		{"Level",1},
	},
}

function getGangSlots (gangname)
	local account = getAccount(getGangLeader(gangname))
	if account then
		return (getAccountData(account,"gangslots") or 0)
	else
		return 12
	end
end

function checkPlayerGroupDetails ()
	gangtable = {}
	local gangtablename = getGangList()
	for i,group in pairs(gangtablename) do
		local gangtablemembers = #getGangMembers(group["gang_name"])
		local groupleader = getGangLeader(group["gang_name"])
		local gangvip = getGangSlots (group["gang_name"])
		table.insert(gangtable,{group["gang_name"],groupleader,gangtablemembers,gangvip})	
	end	
	--setElementData(getRootElement(),"ganglist",gangtable)
end
setTimer(checkPlayerGroupDetails,120000,0)

playerTeam = createTeam ("Player")
function updateGangTable()
	--setElementData(getRootElement(),"ganglist",gangtable)
	setPlayerTeam(source,playerTeam)
end
addEventHandler("onPlayerJoin",getRootElement(),updateGangTable)

function groupChat( message, messageType )
	cancelEvent()
    if (messageType == 2) then
		if getElementData(source,"gang") == "None" then return end
		if not doesGangExists(getElementData(source,"gang")) then return end
		for i, player in ipairs(getPlayersByGang(getElementData(source,"gang"))) do
			if getElementData(player,"gang") == "None" then break end
			if getElementData(player,"gang") == getElementData(source,"gang") then
				outputChatBox("[CAMP]"..getPlayerName(source)..": "..message,player,9,249,17,true)
			end	
		end
	end	
end
addEventHandler( "onPlayerChat", getRootElement(), groupChat )

function refreshClientGangList()
	triggerClientEvent(source, "refreshGangListToClient", source, gangtable)
end
addEvent("refreshClientGangList",true)
addEventHandler("refreshClientGangList",getRootElement(),refreshClientGangList)

function refreshPlayerGangMemberList ()
	local gangmembertable = {}
	local account = getPlayerAccount(source)
	local gang = getAccountGang(getAccountName(account))
	if gang == "None" then return end
	for i,gangmember in pairs(getGangMembers(gang)) do
		local groupleader = getGangLeader(gang)
		gangleader = false
		if gangmember["member_account"] == groupleader then
			gangleader = true
		end
		logedin = false
		if getAccountPlayer(getAccount(gangmember["member_account"])) then
			logedin = true
			player = getAccountPlayer(getAccount(gangmember["member_account"]))
			name = getPlayerName(player)
			rank = getAccountData(getAccount(gangmember["member_account"]),"group_rank")
		end
		table.insert(gangmembertable,{gangmember["member_account"],gangleader,logedin,player,name,rank})	
	end	
	triggerClientEvent(source, "refreshGangMemberTableToClient", source, gangmembertable)
end
addEvent("refreshPlayerGangMemberList",true)
addEventHandler("refreshPlayerGangMemberList",getRootElement(),refreshPlayerGangMemberList)

function refreshPlayerInvite ()
	invited,gangName,inviter = isPlayerGangInvited(source)
	if invited then
		if not getElementData(source,"gang") == "None" then return end
		local gangmember = #getGangMembers(gangName)
		local gangvip = getGangSlots (gangName)
		triggerClientEvent(source,"updatePlayerInvites",source,gangName,getPlayerName(inviter),gangmember,gangvip)
	end
end
addEvent("refreshPlayerInvite",true)
addEventHandler("refreshPlayerInvite",getRootElement(),refreshPlayerInvite)

--Gui Triggers
function acceptGroupInvite ()
	invited,gangName,inviter = isPlayerGangInvited(source)
	if invited then
		if #getGangMembers(getElementData(inviter,"gang"))+1 > getGangSlots(getElementData(inviter,"gang")) then 
			outputChatBox("This encampment is full!",source,255,0,0,true) 
			return
		end
		rank = setAccountData(getPlayerAccount(client),"group_rank","Bandit")
		addGangMember(gangName,getAccountName(getPlayerAccount(source)),inviter,rank)
		for i, permission in ipairs(PermissionsTable["Bandit"]) do
			setAccountData(getPlayerAccount(client),permission[1],permission[2])
		end
		outputChatBox("You joined the encampment "..gangName..".",source,0,255,0,true)
	end
end
addEvent("acceptGroupInvite",true)
addEventHandler("acceptGroupInvite",getRootElement(),acceptGroupInvite)

function destroyGroup ()
	local groupleader = getGangLeader(getElementData(source,"gang"))
	local rank = getAccountData(getPlayerAccount(client),"group_rank")
	if getAccountName(getPlayerAccount(source)) == groupleader or rank == "Leader" then
		for i,gangmember in pairs(getGangMembers(getElementData(source,"gang"))) do
			removeGangMember(getAccountGang(getAccount(gangmember["member_account"])),gangmember["member_account"])
			for i,permission in ipairs(PermissionsTable[rank]) do
				setAccountData(getPlayerAccount(client),"group_rank",false)
				setAccountData(getPlayerAccount(client),permission[1],false)
				setElementData(client,"isOriginalLeader",false)
				setElementData(client,"group_rank",false)
				setElementData(client,"Leader",false)
			end
		end
		outputChatBox(getPlayerName(source).." closed his encampment: "..getElementData(source,"gang").."!",source,22,255,22,true)
		removeGang(getAccountGang(getAccountName(getPlayerAccount(source))))
	else
		outputChatBox("Insufficient permission (Role needed: Ruler)!",source,22,255,22,true)
	end
end
addEvent("destroyGroup",true)
addEventHandler("destroyGroup",getRootElement(),destroyGroup)

function leaveGroup ()
	if getElementData(source,"gang") == "None" then return end
	local groupleader = getGangLeader(getElementData(source,"gang"))
	if getAccountName(getPlayerAccount(source)) == groupleader then 
		outputChatBox("You cannot leave your own encampment!",source,255,0,0,true) 
		return 
	end
	outputChatBox(getPlayerName(source).." left the encampment: "..getElementData(source,"gang").."!" ,source,255,0,0,true)
	removeGangMember(getAccountGang(getAccountName(getPlayerAccount(source))),getAccountName(getPlayerAccount(source)))
end
addEvent("leaveGroup",true)
addEventHandler("leaveGroup",getRootElement(),leaveGroup)

function kickGroupMember(playerName)
	if getElementData(source,"gang") == "None" then return end
	--if string.find(playerName,"(Leader)") then return end
	--if getPlayerName(source) == playerName then return end
	local groupleader = getGangLeader(getElementData(source,"gang"))
	local isRegulator = getAccountData(getPlayerAccount(client),"isRegulator")
	local rank = getAccountData(getAccount(playerName),"group_rank")
	if getAccountName(getPlayerAccount(source)) == groupleader or isRegulator then
		if rank == "Leader" or rank == "Co-Leader" then
			outputChatBox("You cannot kick the "..tostring(rank).."!",source,255,0,0,true)
			return
		else
			outputChatBox(playerName.." was kicked out of "..getElementData(source,"gang").."!",source,255,0,0,true)
			removeGangMember(getElementData(source,"gang"),playerName,getPlayerName(source))
		end
	else
		outputChatBox("Insufficient permission (Role needed: Regulator)!",source,22,255,22,true)
	end
end
addEvent("kickGroupMember",true)
addEventHandler("kickGroupMember",getRootElement(),kickGroupMember)

function addGroupSubLeader (playerName)
	if getElementData(source,"gang") == "None" then return end
	if string.find(playerName,"(Leader)") then return end
	local groupleader = getGangLeader(getElementData(source,"gang"))
	if getAccountName(getPlayerAccount(source)) == groupleader then
		if not getAccountPlayer(getAccount(playerName)) then outputChatBox(playerName.." #22ff22 needs to be online!",source,22,255,22,true) return end
		triggerEvent ( "gangSystem:addSubLeader", source, getPlayerName(getAccountPlayer(getAccount(playerName))) )
		outputChatBox(playerName.." #22ff22 is now a subleader!",source,22,255,22,true)
		outputChatBox("You are now a subleader!",getAccountPlayer(getAccount(playerName)),22,255,22,true)
	else
		outputChatBox(getPlayerName(source)..",#22ff22 you are not the groupleader!",source,22,255,22,true)
	end
end
addEvent("addGroupSubLeader",true)
addEventHandler("addGroupSubLeader",getRootElement(),addGroupSubLeader)

function removeGroupSubLeader (playerName)
	if getElementData(source,"gang") == "None" then return end
	if string.find(playerName,"(Leader)") then return end
	local groupleader = getGangLeader(getElementData(source,"gang"))
	if getAccountName(getPlayerAccount(source)) == groupleader then
		if not getAccountPlayer(getAccount(playerName)) then outputChatBox(playerName..", #22ff22 needs to be online!",source,22,255,22,true) return end
		if isGangSubLeader(getElementData(source,"team"),playerName) then
			triggerEvent ( "gangSystem:removeSubLeader", source, getPlayerName(getAccountPlayer(getAccount(playerName))) )
			outputChatBox(playerName..", #22ff22 is not a subleader anymore!",source,22,255,22,true)
		else	
			outputChatBox(playerName..", #22ff22 is not a subleader!",source,22,255,22,true)
		end	
	else
		outputChatBox(getPlayerName(source).." #22ff22, you are not the groupleader!",source,22,255,22,true)
	end
end
addEvent("removeGroupSubLeader",true)
addEventHandler("removeGroupSubLeader",getRootElement(),removeGroupSubLeader)

function invitePlayerToGroup (playerName)
	if getElementData(source,"gang") == "None" then return end
	local groupleader = getGangLeader(getElementData(source,"gang"))
	local isRecruiter = getAccountData(getPlayerAccount(client),"isRecruiter")
	if getAccountName(getPlayerAccount(source)) == groupleader or isRecruiter then
		if #getGangMembers(getElementData(source,"gang"))+1 < getGangSlots(getElementData(source,"gang")) then
			if not getPlayerFromName(playerName) == false then
				if getElementData(getPlayerFromName(playerName),"gang") == "None" then
					triggerEvent ( "gangSystem:invitePlayer", source, playerName )
				else
					outputChatBox(playerName.." is in a group already!",source,22,255,22,true)
				end	
			else
				outputChatBox(playerName.." is not online!",source,22,255,22,true)
			end
		else
			outputChatBox(getPlayerName(source)..", your encampment is full!",source,22,255,22,true)
		end
	else
		outputChatBox("Insufficient permission (Role needed: Recruiter)!",source,22,255,22,true)
	end
end
addEvent("invitePlayerToGroup",true)
addEventHandler("invitePlayerToGroup",getRootElement(),invitePlayerToGroup)

function gangcreateCommandHandler (cmd)
	if cmd == "creategang" then
		cancelEvent()
	elseif cmd == "accept" then
		cancelEvent()
		outputChatBox("Press F1 to accept the group invitation!",source,255,255,255,true)
	elseif cmd == "gangs" then
		cancelEvent()
	end
end
addEventHandler("onPlayerCommand",getRootElement(),gangcreateCommandHandler)

function isGangExisting (gangname)
	for i,group in pairs(getGangList()) do
		if group["gang_name"] == gangname then 
			return true
		end
	end
	return false
end

function createGroupForPlayer (playersource,command,...)
	local teamName = table.concat({...}, " ")
	if not isGuestAccount(getPlayerAccount(playersource)) and getElementData(playersource,"gang") == "None" then
		if teamName then
			if not isGangExisting (teamName) then
				addGang(teamName,getAccountName(getPlayerAccount(playersource)),getPlayerName(playersource))
				setAccountData(getPlayerAccount(playersource),"gangslots",12)
				setAccountData(getPlayerAccount(playersource),"group_rank","Leader")
				setAccountData(getPlayerAccount(playersource),"isOriginalLeader",true)
				setElementData(playersource,"group_rank","Leader")
				setElementData(playersource,"isOriginalLeader",true)
				for i,permission in ipairs(PermissionsTable["Leader"]) do
					setAccountData(getPlayerAccount(playersource),permission[1],permission[2])
				end
				outputChatBox ("Encampment has been created!",playersource,0,0,255,true)	
			else
				outputChatBox ("This encampment exists already!",playersource,0,255,0,true)	
			end
		else
			outputChatBox ("Syntax is /createcamp <name>!",playersource,0,0,255,true)	
		end
	else
		outputChatBox ("You are in an encampment already!",playersource,255,0,0,true)		
	end
end
addCommandHandler("createcamp",createGroupForPlayer)

function isPlayerRole()
local rank = getAccountData(getPlayerAccount(client),"group_rank")
	for i,permission in ipairs(PermissionsTable[rank]) do
		setElementData(client,permission[1],permission[2])
	end
end
addEvent("isPlayerRole",true)
addEventHandler("isPlayerRole",root,isPlayerRole)	
	
function convertAccountToPlayerName()
local getName = getElementData(client,"selectedMember")
local getTheAccount = getAccount(getName)		-- if false then no account exists
local account = getAccountPlayer(getTheAccount) -- if false then player is not logged in
local playerName = getPlayerName(account)		-- if false then player has logged out before storing data
	if not account then
		setElementData(client,"selectedMember",false)
	else
		setElementData(client,"selectedMember",playerName)
	end
end
addEvent("convertAccountToPlayerName",true)
addEventHandler("convertAccountToPlayerName",root,convertAccountToPlayerName)

function convertPlayerNameToAccount()
local getName = getElementData(client,"selectedMember")
local getPlayer = getPlayerFromName(getName)
local account = getPlayerAccount(getPlayer)
oldgetName = getName
	if not account then
		setElementData(client,"selectedMember",false)
	else
		setElementData(client,"selectedMember",getAccount(getAccountName(account)))
		--outputDebugString("Converted: " ..getAccountName(account)..", Player: "..oldgetName)
	end
end
addEvent("convertPlayerNameToAccount",true)
addEventHandler("convertPlayerNameToAccount",root,convertPlayerNameToAccount)

function saveRankToPlayer()
local getName = getElementData(client,"selectedMember")
local rank = getElementData(getAccountPlayer(getName),"group_rank")
setAccountData(getName,"group_rank",rank)
end
addEvent("saveRankToPlayer",true)
addEventHandler("saveRankToPlayer",root,saveRankToPlayer)

function savePermissionsToAccount()
local getName = getElementData(client,"selectedMember")
local rank = getElementData(getAccountPlayer(getName),"group_rank")
	for i,permission in ipairs(PermissionsTable[rank]) do
		setAccountData(getName,permission[1],permission[2])
	end
end
addEvent("savePermissionsToAccount",true)
addEventHandler("savePermissionsToAccount",root,savePermissionsToAccount)

function isPlayerOriginalLeader()
local isOriginalLeader = getAccountData(getPlayerAccount(client),"isOriginalLeader")
	if isOriginalLeader then
		setElementData(client,"isOriginalLeader",true)
	else
		setElementData(client,"isOriginalLeader",false)
	end
end
addEvent("isPlayerOriginalLeader",true)
addEventHandler("isPlayerOriginalLeader",root,isPlayerOriginalLeader)

function setGroupVIP (playersource,command,targetString,moreSlots)
	if (isObjectInACLGroup("user." ..getAccountName(getPlayerAccount(playersource)), aclGetGroup("Admin")))  then
		if getAccount(targetString) then
			local oldData = getAccountData(getAccount(targetString),"gangslots") or 0
			setAccountData(getAccount(targetString),"gangslots",oldData+moreSlots)
			outputChatBox(targetString.."'s encampment now has VIC status - New amount of slots: "..getAccountData(getAccount(targetString),"gangslots"),playersource,255,0,0,true)
		end
	else
		outputChatBox ("You are not an Admin!",playersource,255,0,0,true)		
	end
end
addCommandHandler("givevip",setGroupVIP)

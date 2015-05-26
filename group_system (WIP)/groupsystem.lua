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
		end
		table.insert(gangmembertable,{gangmember["member_account"],gangleader,logedin,player})	
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
		if #getGangMembers(getElementData(inviter,"gang"))+1 > getGangSlots(getElementData(inviter,"gang")) then outputChatBox(getPlayerName(source)..", #22ff22This group is full!",source,22,255,22,true) return end
		addGangMember(gangName,getAccountName(getPlayerAccount(source)),"Leader")
		setElementData(source,"group_rank","Bandit")
		outputChatBox(getPlayerName(source).." #22ff22 joined the group "..gangName.."!",getRootElement(),22,255,22,true)
	end
end
addEvent("acceptGroupInvite",true)
addEventHandler("acceptGroupInvite",getRootElement(),acceptGroupInvite)

function destroyGroup ()
	local groupleader = getGangLeader(getElementData(source,"gang"))
	if getAccountName(getPlayerAccount(source)) == groupleader then
		for i,gangmember in pairs(getGangMembers(getElementData(source,"gang"))) do
			removeGangMember(getAccountGang(getAccount(gangmember["member_account"])),gangmember["member_account"])
			setAccountData(getPlayerAccount(source),"isRuler",false)
			setAccountData(getPlayerAccount(source),"isRecruiter",false)
			setAccountData(getPlayerAccount(source),"isRegulator",false)
			setAccountData(getPlayerAccount(source),"isPromoter",false)
			setAccountData(getPlayerAccount(source),"isArchitect",false)
			setAccountData(getPlayerAccount(source),"isTreasurer",false)
			setAccountData(getPlayerAccount(source),"isTech",false)
			setAccountData(getPlayerAccount(source),"isTactician",false)
			setAccountData(getPlayerAccount(source),"Leader",false)
			setElementData(source,"OldSave",false)
		end
		outputChatBox(getPlayerName(source).." #22ff22 closed his group: "..getElementData(source,"gang").."!",getRootElement(),22,255,22,true)
		removeGang(getAccountGang(getAccountName(getPlayerAccount(source))))
	else
		outputChatBox(getPlayerName(source)..", #22ff22you can't close this group!",source,22,255,22,true)
	end
end
addEvent("destroyGroup",true)
addEventHandler("destroyGroup",getRootElement(),destroyGroup)

function leaveGroup ()
	if getElementData(source,"gang") == "None" then return end
	local groupleader = getGangLeader(getElementData(source,"gang"))
	if getAccountName(getPlayerAccount(source)) == groupleader then outputChatBox(getPlayerName(source)..",#22ff22 you can't leave your own group!",source,22,255,22,true) return end
	outputChatBox(getPlayerName(source).." #22ff22 left the group: "..getElementData(source,"gang").."!" ,getRootElement(),22,255,22,true)
	removeGangMember(getAccountGang(getAccountName(getPlayerAccount(source))),getAccountName(getPlayerAccount(source)))
end
addEvent("leaveGroup",true)
addEventHandler("leaveGroup",getRootElement(),leaveGroup)

function kickGroupMember (playerName)
	if getElementData(source,"gang") == "None" then return end
	if string.find(playerName,"(Leader)") then return end
	--if getPlayerName(source) == playerName then return end
	local groupleader = getGangLeader(getElementData(source,"gang"))
	if getAccountName(getPlayerAccount(source)) == groupleader or isGangSubLeader(getElementData(source,"gang"),getAccountName(getPlayerAccount(source))) then
		outputChatBox(playerName.." #22ff22 was kicked out of "..getElementData(source,"gang").."!",getRootElement(),22,255,22,true)
		removeGangMember(getElementData(source,"gang"),playerName,getPlayerName(source))
	else
		outputChatBox(getPlayerName(source)..",#22ff22 you cannot kick members!",source,22,255,22,true)
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
	if getAccountName(getPlayerAccount(source)) == groupleader then
		if #getGangMembers(getElementData(source,"gang"))+1 < getGangSlots(getElementData(source,"gang")) then
		if not getPlayerFromName(playerName) == false then
			if getElementData(getPlayerFromName(playerName),"gang") == "None" then
				triggerEvent ( "gangSystem:invitePlayer", source, playerName )
			else
				outputChatBox(playerName.." #22ff22 is in a group already!",source,22,255,22,true)
			end	
		else
			outputChatBox(playerName.."#22ff22 is not online!",source,22,255,22,true)
		end
		else
			outputChatBox(getPlayerName(source)..", #22ff22 your group is full!",source,22,255,22,true)
		end
	else
		outputChatBox(getPlayerName(source)..", #22ff22 you need to be the leader of this group!",source,22,255,22,true)
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
			addGang (teamName,getAccountName(getPlayerAccount(playersource)))
			setAccountData(getPlayerAccount(playersource),"gangslots",12)
			setAccountData(getPlayerAccount(playersource),"isRuler",true)
			setAccountData(getPlayerAccount(playersource),"isRecruiter",true)
			setAccountData(getPlayerAccount(playersource),"isRegulator",true)
			setAccountData(getPlayerAccount(playersource),"isPromoter",true)
			setAccountData(getPlayerAccount(playersource),"isArchitect",true)
			setAccountData(getPlayerAccount(playersource),"isTreasurer",true)
			setAccountData(getPlayerAccount(playersource),"isTech",true)
			setAccountData(getPlayerAccount(playersource),"isTactician",true)	
			setAccountData(getPlayerAccount(playersource),"group_rank","Leader")
			outputChatBox ("Encampment has been created!",playersource,0,0,255,true)	
			else
				outputChatBox ("This encampment exists already!",playersource,0,255,0,true)	
			end
		else
			outputChatBox ("#FFFFFFSyntax is /createcamp <name>!",playersource,0,0,255,true)	
		end
	else
		outputChatBox ("You are in an encampment already!",playersource,255,0,0,true)		
	end
end
addCommandHandler("createcamp",createGroupForPlayer)

function setPermissionsFirstTime()
	isRulerA = getAccountData(getPlayerAccount(client),"isRuler")
	isRecruiterA = getAccountData(getPlayerAccount(client),"isRecruiter")
	isRegulatorA = getAccountData(getPlayerAccount(client),"isRegulator")
	isPromoterA = getAccountData(getPlayerAccount(client),"isPromoter")
	isArchitectA = getAccountData(getPlayerAccount(client),"isArchitect")
	isTreasurerA = getAccountData(getPlayerAccount(client),"isTreasurer")
	isTechA = getAccountData(getPlayerAccount(client),"isTech")
	isTacticianA = getAccountData(getPlayerAccount(client),"isTactician")
	setElementData(client,"isRuler",isRulerA)
	setElementData(client,"isRecruiter",isRecruiterA)
	setElementData(client,"isRegulator",isRegulatorA)
	setElementData(client,"isPromoter",isPromoterA)
	setElementData(client,"isArchitect",isArchitectA)
	setElementData(client,"isTreasuer",isTreasurerA)
	setElementData(client,"isTech",isTechA)
	setElementData(client,"isTactician",isTacticianA)
end
addEvent("setPermissionsFirstTime",true)
addEventHandler("setPermissionsFirstTime",root,setPermissionsFirstTime)
	
--[[
function createPermissionsXML()
local teamName = getElementData(source,"gang")
	PermissionsXML = xmlCreateFile("@group_permissions/permissions_"..teamName..".xml","permission")
	xmlCreateChild(PermissionsXML,"Leader")
	xmlCreateChild(PermissionsXML,"Co-Leader")
	xmlCreateChild(PermissionsXML,"General")
	xmlCreateChild(PermissionsXML,"Officer")
	xmlCreateChild(PermissionsXML,"Soldier")
	xmlCreateChild(PermissionsXML,"Survivor")
	xmlCreateChild(PermissionsXML,"Bandit")
			
	leader = xmlFindChild(PermissionsXML,"Leader",0)
	coleader = xmlFindChild(PermissionsXML,"Co-Leader",0)
	general = xmlFindChild(PermissionsXML,"General",0)
	officer = xmlFindChild(PermissionsXML,"Officer",0)
	soldier = xmlFindChild(PermissionsXML,"Soldier",0)
	survivor = xmlFindChild(PermissionsXML,"Survivor",0)
	bandit = xmlFindChild(PermissionsXML,"Bandit",0)
	
	xmlNodeSetAttribute(leader,"ruler","true")
	xmlNodeSetAttribute(leader,"recruiter","true")
	xmlNodeSetAttribute(leader,"regulator","true")
	xmlNodeSetAttribute(leader,"promoter","true")
	xmlNodeSetAttribute(leader,"architect","true")
	xmlNodeSetAttribute(leader,"treasurer","true")
	xmlNodeSetAttribute(leader,"tech","true")
	xmlNodeSetAttribute(leader,"tactician","true")
	
	xmlNodeSetAttribute(coleader,"ruler","false")
	xmlNodeSetAttribute(coleader,"recruiter","true")
	xmlNodeSetAttribute(coleader,"regulator","true")
	xmlNodeSetAttribute(coleader,"promoter","true")
	xmlNodeSetAttribute(coleader,"architect","true")
	xmlNodeSetAttribute(coleader,"treasurer","true")
	xmlNodeSetAttribute(coleader,"tech","true")
	xmlNodeSetAttribute(coleader,"tactician","true")
	
	xmlNodeSetAttribute(general,"ruler","false")
	xmlNodeSetAttribute(general,"recruiter","true")
	xmlNodeSetAttribute(general,"regulator","true")
	xmlNodeSetAttribute(general,"promoter","false")
	xmlNodeSetAttribute(general,"architect","true")
	xmlNodeSetAttribute(general,"treasurer","true")
	xmlNodeSetAttribute(general,"tech","true")
	xmlNodeSetAttribute(general,"tactician","true")
	
	xmlNodeSetAttribute(officer,"ruler","false")
	xmlNodeSetAttribute(officer,"recruiter","true")
	xmlNodeSetAttribute(officer,"regulator","false")
	xmlNodeSetAttribute(officer,"promoter","false")
	xmlNodeSetAttribute(officer,"architect","false")
	xmlNodeSetAttribute(officer,"treasurer","true")
	xmlNodeSetAttribute(officer,"tech","false")
	xmlNodeSetAttribute(officer,"tactician","true")
			
	xmlNodeSetAttribute(soldier,"ruler","false")
	xmlNodeSetAttribute(soldier,"recruiter","true")
	xmlNodeSetAttribute(soldier,"regulator","false")
	xmlNodeSetAttribute(soldier,"promoter","false")
	xmlNodeSetAttribute(soldier,"architect","false")
	xmlNodeSetAttribute(soldier,"treasurer","true")
	xmlNodeSetAttribute(soldier,"tech","false")
	xmlNodeSetAttribute(soldier,"tactician","false")
	
	xmlNodeSetAttribute(survivor,"ruler","false")
	xmlNodeSetAttribute(survivor,"recruiter","false")
	xmlNodeSetAttribute(survivor,"regulator","false")
	xmlNodeSetAttribute(survivor,"promoter","false")
	xmlNodeSetAttribute(survivor,"architect","false")
	xmlNodeSetAttribute(survivor,"treasurer","true")
	xmlNodeSetAttribute(survivor,"tech","false")
	xmlNodeSetAttribute(survivor,"tactician","false")
	
	xmlNodeSetAttribute(bandit,"ruler","false")
	xmlNodeSetAttribute(bandit,"recruiter","false")
	xmlNodeSetAttribute(bandit,"regulator","false")
	xmlNodeSetAttribute(bandit,"promoter","false")
	xmlNodeSetAttribute(bandit,"architect","false")
	xmlNodeSetAttribute(bandit,"treasurer","false")
	xmlNodeSetAttribute(bandit,"tech","false")
	xmlNodeSetAttribute(bandit,"tactician","false")
	
	xmlSaveFile(PermissionsXML)
	xmlUnloadFile(PermissionsXML)
end
addEvent("createPermissionsXML")
addEventHandler("createPermissionsXML",root,createPermissionsXML)

XMLFile = {}
]]
PermissionsTable = {

["Ranks"] = {
{"Leader"},
{"Co-Leader"},
{"General"},
{"Officer"},
{"Soldier"},
{"Survivor"},
{"Bandit"},
},

["Roles"] = {
{"ruler",1},
{"recruiter",2},
{"regulator",3},
{"promoter",4},
{"architect",5},
{"treasurer",6},
{"tech",7},
{"tactician",8},
},
}

function savePermissions()
local teamName = getElementData(client,"gang")
local isRuler = getElementData(client,"isRuler")
local isRecruiter = getElementData(client,"isRecruiter")
local isRegulator = getElementData(client,"isRegulator")
local isPromoter = getElementData(client,"isPromoter")
local isArchitect = getElementData(client,"isArchitect")
local isTreasurer = getElementData(client,"isTreasurer")
local isTech = getElementData(client,"isTech")
local isTactician = getElementData(client,"isTactician")
	if isRuler then
		setAccountData(getPlayerAccount(client),"isRuler",true)
	else
		setAccountData(getPlayerAccount(client),"isRuler",false)
	end
	if isRecruiter then
		setAccountData(getPlayerAccount(client),"isRecruiter",true)
	else
		setAccountData(getPlayerAccount(client),"isRecruiter",false)
	end
	if isRegulator then
		setAccountData(getPlayerAccount(client),"isRegulator",true)
	else
		setAccountData(getPlayerAccount(client),"isRegulator",false)
	end
	if isPromoter then
		setAccountData(getPlayerAccount(client),"isPromoter",true)
	else
		setAccountData(getPlayerAccount(client),"isPromoter",false)
	end
	if isArchitect then
		setAccountData(getPlayerAccount(client),"isArchitect",true)
	else
		setAccountData(getPlayerAccount(client),"isArchitect",false)
	end
	if isTreasurer then
		setAccountData(getPlayerAccount(client),"isTreasurer",true)
	else
		setAccountData(getPlayerAccount(client),"isTreasurer",false)
	end
	if isTech then
		setAccountData(getPlayerAccount(client),"isTech",true)
	else
		setAccountData(getPlayerAccount(client),"isTech",false)
	end
	if isTactician then
		setAccountData(getPlayerAccount(client),"isTactician",true)
	else
		setAccountData(getPlayerAccount(client),"isTactician",false)
	end
	--setElementData(client,"isRuler",false)
	--setElementData(client,"isRecruiter",false)
	--setElementData(client,"isRegulator",false)
	--setElementData(client,"isPromoter",false)
	--setElementData(client,"isArchitect",false)
	--setElementData(client,"isTreasurer",false)
	--setElementData(client,"isTech",false)
	--setElementData(client,"isTactician",false)
	setElementData(client,"OldSave",true)
end
addEvent("savePermissions",true)
addEventHandler("savePermissions",root,savePermissions)

function loadPermissions()
local doesSaveExist = getElementData(client,"OldSave")
local getSelectedRank = getElementData(client,"selectedRank")
	if doesSaveExist then
		if getSelectedRank == "Leader" then
			isRulerA = getAccountData(getPlayerAccount(client),"isRuler")
			isRecruiterA = getAccountData(getPlayerAccount(client),"isRecruiter")
			isRegulatorA = getAccountData(getPlayerAccount(client),"isRegulator")
			isPromoterA = getAccountData(getPlayerAccount(client),"isPromoter")
			isArchitectA = getAccountData(getPlayerAccount(client),"isArchitect")
			isTreasurerA = getAccountData(getPlayerAccount(client),"isTreasurer")
			isTechA = getAccountData(getPlayerAccount(client),"isTech")
			isTacticianA = getAccountData(getPlayerAccount(client),"isTactician")
			setElementData(client,"isRuler",isRulerA)
			setElementData(client,"isRecruiter",isRecruiterA)
			setElementData(client,"isRegulator",isRegulatorA)
			setElementData(client,"isPromoter",isPromoterA)
			setElementData(client,"isArchitect",isArchitectA)
			setElementData(client,"isTreasuer",isTreasurerA)
			setElementData(client,"isTech",isTechA)
			setElementData(client,"isTactician",isTacticianA)
		elseif getSelectedRank == "Co-Leader" then
			isRulerA = getAccountData(getPlayerAccount(client),"isRuler_coleader")
			isRecruiterA = getAccountData(getPlayerAccount(client),"isRecruiter_coleader")
			isRegulatorA = getAccountData(getPlayerAccount(client),"isRegulator_coleader")
			isPromoterA = getAccountData(getPlayerAccount(client),"isPromoter_coleader")
			isArchitectA = getAccountData(getPlayerAccount(client),"isArchitect_coleader")
			isTreasurerA = getAccountData(getPlayerAccount(client),"isTreasurer_coleader")
			isTechA = getAccountData(getPlayerAccount(client),"isTech_coleader")
			isTacticianA = getAccountData(getPlayerAccount(client),"isTactician_coleader")
			setElementData(client,"isRuler",isRulerA)
			setElementData(client,"isRecruiter",isRecruiterA)
			setElementData(client,"isRegulator",isRegulatorA)
			setElementData(client,"isPromoter",isPromoterA)
			setElementData(client,"isArchitect",isArchitectA)
			setElementData(client,"isTreasuer",isTreasurerA)
			setElementData(client,"isTech",isTechA)
			setElementData(client,"isTactician",isTacticianA)
		elseif getSelectedRank == "General" then
			isRulerA = getAccountData(getPlayerAccount(client),"isRuler_general")
			isRecruiterA = getAccountData(getPlayerAccount(client),"isRecruiter_general")
			isRegulatorA = getAccountData(getPlayerAccount(client),"isRegulator_general")
			isPromoterA = getAccountData(getPlayerAccount(client),"isPromoter_general")
			isArchitectA = getAccountData(getPlayerAccount(client),"isArchitect_general")
			isTreasurerA = getAccountData(getPlayerAccount(client),"isTreasurer_general")
			isTechA = getAccountData(getPlayerAccount(client),"isTech_general")
			isTacticianA = getAccountData(getPlayerAccount(client),"isTactician_general")
			setElementData(client,"isRuler",isRulerA)
			setElementData(client,"isRecruiter",isRecruiterA)
			setElementData(client,"isRegulator",isRegulatorA)
			setElementData(client,"isPromoter",isPromoterA)
			setElementData(client,"isArchitect",isArchitectA)
			setElementData(client,"isTreasuer",isTreasurerA)
			setElementData(client,"isTech",isTechA)
			setElementData(client,"isTactician",isTacticianA)
		elseif getSelectedRank == "Officer" then
			isRulerA = getAccountData(getPlayerAccount(client),"isRuler_officer")
			isRecruiterA = getAccountData(getPlayerAccount(client),"isRecruiter_officer")
			isRegulatorA = getAccountData(getPlayerAccount(client),"isRegulator_officer")
			isPromoterA = getAccountData(getPlayerAccount(client),"isPromoter_officer")
			isArchitectA = getAccountData(getPlayerAccount(client),"isArchitect_officer")
			isTreasurerA = getAccountData(getPlayerAccount(client),"isTreasurer_officer")
			isTechA = getAccountData(getPlayerAccount(client),"isTech_officer")
			isTacticianA = getAccountData(getPlayerAccount(client),"isTactician_officer")
			setElementData(client,"isRuler",isRulerA)
			setElementData(client,"isRecruiter",isRecruiterA)
			setElementData(client,"isRegulator",isRegulatorA)
			setElementData(client,"isPromoter",isPromoterA)
			setElementData(client,"isArchitect",isArchitectA)
			setElementData(client,"isTreasuer",isTreasurerA)
			setElementData(client,"isTech",isTechA)
			setElementData(client,"isTactician",isTacticianA)
		elseif getSelectedRank == "Soldier" then
			isRulerA = getAccountData(getPlayerAccount(client),"isRuler_soldier")
			isRecruiterA = getAccountData(getPlayerAccount(client),"isRecruiter_soldier")
			isRegulatorA = getAccountData(getPlayerAccount(client),"isRegulator_soldier")
			isPromoterA = getAccountData(getPlayerAccount(client),"isPromoter_soldier")
			isArchitectA = getAccountData(getPlayerAccount(client),"isArchitect_soldier")
			isTreasurerA = getAccountData(getPlayerAccount(client),"isTreasurer_soldier")
			isTechA = getAccountData(getPlayerAccount(client),"isTech_soldier")
			isTacticianA = getAccountData(getPlayerAccount(client),"isTactician_soldier")
			setElementData(client,"isRuler",isRulerA)
			setElementData(client,"isRecruiter",isRecruiterA)
			setElementData(client,"isRegulator",isRegulatorA)
			setElementData(client,"isPromoter",isPromoterA)
			setElementData(client,"isArchitect",isArchitectA)
			setElementData(client,"isTreasuer",isTreasurerA)
			setElementData(client,"isTech",isTechA)
			setElementData(client,"isTactician",isTacticianA)
		elseif getSelectedRank == "Survivor" then
			isRulerA = getAccountData(getPlayerAccount(client),"isRuler_survivor")
			isRecruiterA = getAccountData(getPlayerAccount(client),"isRecruiter_survivor")
			isRegulatorA = getAccountData(getPlayerAccount(client),"isRegulator_survivor")
			isPromoterA = getAccountData(getPlayerAccount(client),"isPromoter_survivor")
			isArchitectA = getAccountData(getPlayerAccount(client),"isArchitect_survivor")
			isTreasurerA = getAccountData(getPlayerAccount(client),"isTreasurer_survivor")
			isTechA = getAccountData(getPlayerAccount(client),"isTech_survivor")
			isTacticianA = getAccountData(getPlayerAccount(client),"isTactician_survivor")
			setElementData(client,"isRuler",isRulerA)
			setElementData(client,"isRecruiter",isRecruiterA)
			setElementData(client,"isRegulator",isRegulatorA)
			setElementData(client,"isPromoter",isPromoterA)
			setElementData(client,"isArchitect",isArchitectA)
			setElementData(client,"isTreasuer",isTreasurerA)
			setElementData(client,"isTech",isTechA)
			setElementData(client,"isTactician",isTacticianA)
		elseif getSelectedRank == "Bandit" then
			isRulerA = getAccountData(getPlayerAccount(client),"isRuler_bandit")
			isRecruiterA = getAccountData(getPlayerAccount(client),"isRecruiter_bandit")
			isRegulatorA = getAccountData(getPlayerAccount(client),"isRegulator_bandit")
			isPromoterA = getAccountData(getPlayerAccount(client),"isPromoter_bandit")
			isArchitectA = getAccountData(getPlayerAccount(client),"isArchitect_bandit")
			isTreasurerA = getAccountData(getPlayerAccount(client),"isTreasurer_bandit")
			isTechA = getAccountData(getPlayerAccount(client),"isTech_bandit")
			isTacticianA = getAccountData(getPlayerAccount(client),"isTactician_bandit")
			setElementData(client,"isRuler",isRulerA)
			setElementData(client,"isRecruiter",isRecruiterA)
			setElementData(client,"isRegulator",isRegulatorA)
			setElementData(client,"isPromoter",isPromoterA)
			setElementData(client,"isArchitect",isArchitectA)
			setElementData(client,"isTreasuer",isTreasurerA)
			setElementData(client,"isTech",isTechA)
			setElementData(client,"isTactician",isTacticianA)
		end
	else
		outputDebugString("Error. Was unable to load Permissions Set.")
	end
end
addEvent("loadPermissions",true)
addEventHandler("loadPermissions",root,loadPermissions)

PermissionsTable = {
	["Leader"] = {
		{"Ruler",true},
		{"Recruiter",true},
		{"Regulator",true},
		{"Promoter",true},
		{"Architect",true},
		{"Treasurer",true},
		{"Tech",true},
		{"Tactician",true},
	},
	
	["Co-Leader"] = {
		{"Ruler",false},
		{"Recruiter",true},
		{"Regulator",true},
		{"Promoter",true},
		{"Architect",true},
		{"Treasurer",true},
		{"Tech",true},
		{"Tactician",true},
	},
	
	["General"] = {
		{"Ruler",false},
		{"Recruiter",true},
		{"Regulator",true},
		{"Promoter",false},
		{"Architect",true},
		{"Treasurer",true},
		{"Tech",true},
		{"Tactician",true},
	},
	
	["Officer"] = {
		{"Ruler",false},
		{"Recruiter",true},
		{"Regulator",true},
		{"Promoter",false},
		{"Architect",false},
		{"Treasurer",true},
		{"Tech",false},
		{"Tactician",false},
	},
	
	["Soldier"] = {
		{"Ruler",false},
		{"Recruiter",true},
		{"Regulator",false},
		{"Promoter",false},
		{"Architect",false},
		{"Treasurer",true},
		{"Tech",false},
		{"Tactician",false},
	},
	
	["Survivor"] = {
		{"Ruler",false},
		{"Recruiter",false},
		{"Regulator",false},
		{"Promoter",false},
		{"Architect",false},
		{"Treasurer",true},
		{"Tech",false},
		{"Tactician",false},
	},
	
	["Bandit"] = {
		{"Ruler",false},
		{"Recruiter",false},
		{"Regulator",false},
		{"Promoter",false},
		{"Architect",false},
		{"Treasurer",false},
		{"Tech",false},
		{"Tactician",false},
	},
}

function saveRankToPlayer()
local getName = getElementData(client,"selectedMember")
--local getTheAccount = getAccount(getName)
--local account = getAccountPlayer(getTheAccount)
local rank = getElementData(getPlayerFromName(getName),"group_rank")
	setAccountData(getAccount(getName),"group_rank",rank)
end
addEvent("saveRankToPlayer",true)
addEventHandler("saveRankToPlayer",root,saveRankToPlayer)

function convertAccountToPlayerName()
local getName = getElementData(client,"selectedMember")
local getTheAccount = getAccount(getName)		-- if false then no account exists
local account = getAccountPlayer(getTheAccount) -- if false then player is not logged in
	if not account then
		setElementData(client,"selectedMember",false)
	else
		setElementData(client,"selectedMember",account)
		outputDebugString("Account has been converted to playername!")
	end
end
addEvent("convertAccountToPlayerName",true)
addEventHandler("convertAccountToPlayerName",root,convertAccountToPlayerName)

function testRank(commandName)
local getTheAccount = getAccount("Test")		-- if false then no account exists
local account = getAccountPlayer(getTheAccount) -- if false then player is not logged in
local rank = getAccountData(getTheAccount,"group_rank")
outputChatBox("Account: "..tostring(account)..", Rank: "..rank,playersource,255,0,0,true)
end
addCommandHandler("name",testRank)

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

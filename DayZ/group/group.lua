------------------------------------------------------------------------------------
--  PROJECT:   	 N/A
--  RIGHTS:      All rights reserved by developers
--  FILE:        groupSystem/group.lua
--  DEVELOPER:  Sebbe (Smart)
------------------------------------------------------------------------------------


local invited = {}
local got = {}
local c = {}
local validRank = {}
local permForRank = {}


function makeGUI()
	window = guiCreateWindow(0.14, 0.16, 0.72, 0.68, "Encampment System", true)
	guiWindowSetSizable(window, false)
	guiSetAlpha(window, 1.00)
	guiSetVisible(window, false)

	mainPanel = guiCreateTabPanel(0.02, 0.05, 0.96, 0.83, true, window)

	minePanel = guiCreateTab("Core", mainPanel)

	myGroupLabel = guiCreateLabel(0.02, 0.01, 0.50, 0.12, "My Encampment: ", true, minePanel)
	guiSetFont(myGroupLabel, "clear-normal")
	myGroupRankLabel = guiCreateLabel(0.02, 0.13, 0.50, 0.11, "Encampment Rank: ", true, minePanel)
	guiSetFont(myGroupRankLabel, "clear-normal")
	dateJoinedLabel = guiCreateLabel(0.02, 0.25, 0.51, 0.10, "Date Joined: ", true, minePanel)
	guiSetFont(dateJoinedLabel, "clear-normal")
	mineListInvites = guiCreateGridList(0.01, 0.35, 0.97, 0.50, true, minePanel)
	guiGridListAddColumn(mineListInvites, "Encampment", 0.3)
	guiGridListAddColumn(mineListInvites, "Sent by", 0.3)
	guiGridListAddColumn(mineListInvites, "Time", 0.3)
	rejectInviteButton = guiCreateButton(0.02, 0.87, 0.16, 0.09, "Reject Invite", true, minePanel)
	acceptInviteButton = guiCreateButton(0.82, 0.87, 0.16, 0.09, "Accept Invite", true, minePanel)
	createGroupButton = guiCreateButton(0.84, 0.02, 0.14, 0.10, "Create", true, minePanel)
	createGroupEdit = guiCreateEdit(0.53, 0.01, 0.30, 0.10, "Encampment Name", true, minePanel)
	leaveGroupButton = guiCreateButton(0.78, 0.13, 0.20, 0.11, "Leave My Encampment", true, minePanel)
	groupListButton = guiCreateButton(0.52, 0.13, 0.20, 0.11, "Encampment List", true, minePanel)
	
	adminPanel = guiCreateTab("Management", mainPanel)

	adminMembsList = guiCreateGridList(0.01, 0.08, 0.95, 0.50, true, adminPanel)
	guiGridListAddColumn(adminMembsList, "Name", 0.2)
	guiGridListAddColumn(adminMembsList, "Account", 0.2)
	guiGridListAddColumn(adminMembsList, "Rank", 0.2)
	guiGridListAddColumn(adminMembsList, "Last Time Online", 0.2)
	guiGridListAddColumn(adminMembsList, "Warning Level", 0.2)
	viewSetRankButton = guiCreateButton(0.01, 0.59, 0.17, 0.10, "Set Rank", true, adminPanel)
	logButton = guiCreateButton(0.20, 0.59, 0.17, 0.10, "View Log", true, adminPanel)
	viewAdminInviteButton = guiCreateButton(0.40, 0.59, 0.17, 0.10, "Invite Player", true, adminPanel)
	groupBankButton = guiCreateButton(0.60, 0.59, 0.17, 0.10, "Group Vault", true, adminPanel)
	manageRanksButton = guiCreateButton(0.80, 0.59, 0.17, 0.10, "Manage Ranks", true, adminPanel)
	viewWarnsButton = guiCreateButton(0.01, 0.70, 0.17, 0.10, "Warn Player", true, adminPanel)
	viewMessageButton = guiCreateButton(0.20, 0.70, 0.17, 0.10, "Set Message", true, adminPanel)
	--kickPlayerButton = guiCreateButton(0.40, 0.70, 0.17, 0.10, "Kick Player", true, adminPanel)
	
	messageWindow = guiCreateWindow(0.23, 0.13, 0.57, 0.58, "Encampment Board", true)
	guiWindowSetSizable(messageWindow, false)
	guiSetAlpha(messageWindow, 1.00)

	messageMemo = guiCreateMemo(0.02, 0.05, 0.96, 0.81, "Welcome to our encampment!", true, messageWindow)
	messageCloseButton = guiCreateButton(0.36, 0.89, 0.24, 0.08, "Close", true, messageWindow)
	messageSaveButton = guiCreateButton(0.02, 0.89, 0.24, 0.08, "Save", true, messageWindow)
	guiSetVisible(messageWindow, false)
	
	messageOTD = guiCreateLabel(0.01,0.83,0.95, 0.30, "Message of the Day:\n",true,adminPanel)
	guiLabelSetHorizontalAlign(messageOTD,"left",true)
	
	inviteWindow = guiCreateWindow(0.32, 0.15, 0.38, 0.69, "Invite Player", true)
	guiWindowSetSizable(inviteWindow, false)
	guiSetAlpha(inviteWindow, 1.00)
	inviteSearchEdit = guiCreateEdit(0.03, 0.06, 0.94, 0.08, "", true, inviteWindow)
	inviteList = guiCreateGridList(0.04, 0.15, 0.93, 0.73, true, inviteWindow)
	guiGridListAddColumn(inviteList, "Name", 0.5)
	inviteCloseButton = guiCreateButton(0.04, 0.90, 0.26, 0.08, "Close", true, inviteWindow)
	inviteButton = guiCreateButton(0.71, 0.90, 0.26, 0.07, "Invite", true, inviteWindow)
	guiSetVisible(inviteWindow, false)

	listWindow = guiCreateWindow(0.32, 0.20, 0.37, 0.62, "Encampment List", true)
	guiWindowSetSizable(listWindow, false)
	guiSetAlpha(listWindow, 1.00)
	listEdit = guiCreateEdit(0.03, 0.06, 0.94, 0.09, "", true, listWindow)
	groupListGrid = guiCreateGridList(0.03, 0.16, 0.94, 0.73, true, listWindow)
	guiGridListAddColumn(groupListGrid, "Encampment", 0.4)
	guiGridListAddColumn(groupListGrid, "Founder", 0.3)
	guiGridListAddColumn(groupListGrid, "Members", 0.2)
	closeGroupList = guiCreateButton(0.03, 0.90, 0.93, 0.08, "Close", true, listWindow)
	guiSetVisible(listWindow, false)

	warnWindow = guiCreateWindow(0.32, 0.26, 0.35, 0.28, "", true)
	guiWindowSetSizable(warnWindow, false)
	guiSetAlpha(warnWindow, 1.00)

	warningReasonEdit = guiCreateEdit(0.03, 0.16, 0.92, 0.23, "Reason", true, warnWindow)
	warningLevelEdit = guiCreateEdit(0.03, 0.44, 0.92, 0.23, "Warning Level", true, warnWindow)
	warningCloseButton = guiCreateButton(0.03, 0.78, 0.31, 0.16, "Close", true, warnWindow)
	warnButton = guiCreateButton(0.64, 0.79, 0.31, 0.15, "Warn", true, warnWindow)
	guiSetVisible(warnWindow, false)
	
	permWindow = guiCreateWindow(0.33, 0.13, 0.34, 0.74, "Rank Management", true)
	guiWindowSetSizable(permWindow, false)
	guiSetAlpha(permWindow, 1.00)

	rankCombo = guiCreateComboBox(0.03, 0.05, 0.87, 0.34, "Select Rank", true, permWindow)
	--permEdit = guiCreateEdit(9, 23, 254, 36, "", false, permWindow)
	permEditButton = guiCreateButton(0.03, 0.90, 0.26, 0.07, "Edit", true, permWindow)
	permDeleteButton = guiCreateButton(0.36, 0.90, 0.26, 0.07, "Delete", true, permWindow)
	permCloseButton = guiCreateButton(0.67, 0.90, 0.26, 0.07, "Close", true, permWindow)
	rankScrollPanel = guiCreateScrollPane(0.03, 0.11, 0.91, 0.69, true, permWindow) 
	permAddEdit = guiCreateEdit(0.04, 0.82, 0.58, 0.05, "", true, permWindow)
	addRankButton = guiCreateButton(0.67, 0.81, 0.26, 0.05, "Add Rank", true, permWindow)
	guiSetVisible(permWindow, false)

	setRankWindow = guiCreateWindow(0.39, 0.21, 0.36, 0.44, "Set Rank", true)
	guiWindowSetSizable(setRankWindow, false)
	guiSetAlpha(setRankWindow, 1.00)
	setRankCombo = guiCreateComboBox(0.07, 0.35, 0.86, 0.61, "Select Rank", true, setRankWindow)
	setRankLabel1 = guiCreateLabel(-0.06, 0.29, 1.16, 0.50, "Set the rank of account: to : ", true, setRankCombo)
	guiLabelSetColor(setRankLabel1, 0, 255, 0)
	guiSetFont(setRankLabel1, "clear-normal")
	guiLabelSetHorizontalAlign(setRankLabel1, "center", false)
	setRankClose = guiCreateButton(0.07, 0.84, 0.25, 0.12, "Cancel", true, setRankWindow)
	setRankButton = guiCreateButton(0.68, 0.84, 0.25, 0.12, "Set Rank", true, setRankWindow)
	accountSelectedRank = guiCreateLabel(0.00, 0.08, 1.02, 0.21, "Account Selected:\nCurrent Rank:\nWL:", true, setRankWindow)
	guiSetFont(accountSelectedRank, "clear-normal")
	guiLabelSetColor(accountSelectedRank, 0, 255, 0)
	guiLabelSetHorizontalAlign(accountSelectedRank, "center", false)
	guiSetVisible(setRankWindow, false)
	
	--addEventHandler("onClientGUIClick", kickPlayerButton, kickFromGroup, false)
	addEventHandler("onClientGUIClick", addRankButton, addRank, false)
	addEventHandler("onClientGUIClick", setRankButton, setRank, false)
	addEventHandler("onClientGUIClick", viewSetRankButton, viewSetRank, false)
	addEventHandler("onClientGUIClick", setRankCombo, clickOnRankCombo, false)
	addEventHandler("onClientGUIClick", permEditButton, editRank, false)
	addEventHandler("onClientGUIClick", closeGroupList, function() guiSetVisible(listWindow, false) end, false)
	addEventHandler("onClientGUIClick", permCloseButton, function() guiSetVisible(permWindow, false) end, false)
	addEventHandler("onClientGUIClick", setRankClose, function() guiSetVisible(setRankWindow, false) end, false)
	addEventHandler("onClientGUIClick", groupListButton, showGroupList, false)
	addEventHandler("onClientGUIClick", warnButton, warnAccount, false)
	addEventHandler("onClientGUIClick", manageRanksButton, showRanks, false)
	addEventHandler("onClientGUIClick", viewWarnsButton, showWarn, false)
	--addEventHandler("onClientGUIClick", closeWindowButton, closeWindow, false)
	addEventHandler("onClientGUIClick", rankCombo, selectRank, false)
	addEventHandler("onClientGUIClick", viewMessageButton, function() guiSetVisible(messageWindow, true) guiBringToFront(messageWindow) end, false)
	addEventHandler("onClientGUIClick", messageCloseButton, function() guiSetVisible(messageWindow, false) end, false)
	addEventHandler("onClientGUIClick", warningCloseButton, function() guiSetVisible(warnWindow, false) end, false)
	addEventHandler("onClientGUIClick", messageSaveButton, saveMessage, false)
	addEventHandler("onClientGUIClick", logButton, function() triggerServerEvent("groupSystem.showLog", root) end, false)
	addEventHandler("onClientGUIClick", viewAdminInviteButton, function() guiSetVisible(inviteWindow, true) guiBringToFront(inviteWindow) openInviteSearch() end, false)
	addEventHandler("onClientGUIClick", inviteCloseButton, function() guiSetVisible(inviteWindow, false) end, false)
	addEventHandler("onClientGUIClick", leaveGroupButton, confirmDelete, false)
	addEventHandler("onClientGUIClick", permDeleteButton, deleteGroupRankAttempt, false)
	
	addEventHandler("onClientGUIClick", inviteButton, invitePlayer, false)
	addEventHandler("onClientGUIChanged", inviteSearchEdit, searchInvite, false)
	addEventHandler("onClientGUIChanged", listEdit, searchGroupList, false)
	addEventHandler("onClientGUIClick", rejectInviteButton, rejectInvite, false)
	addEventHandler("onClientGUIClick", acceptInviteButton, acceptInvite, false)
	addEventHandler("onClientGUIClick", createGroupButton, makeGroup, false)
	addEventHandler("onClientGUIClick", createGroupEdit, function() if (guiGetText(source) == "Group Name") then guiSetText(source, "") end end, false)
	addEventHandler("onClientGUIClick", warningReasonEdit, function() if (guiGetText(source) == "Reason") then guiSetText(source, "") end end, false)
	addEventHandler("onClientGUIClick", warningLevelEdit, function() if (guiGetText(source) == "Warning Level") then guiSetText(source, "") end end, false)
	addEventHandler("onClientGUIClick", inviteSearchEdit, function() if (guiGetText(source) == "Search..") then guiSetText(source, "") end end, false)
	
	--addEventHandler("onClientGUIClick", groupBankWithdrawButton, withdrawMoney, false)
	--addEventHandler("onClientGUIDoubleClick", groupBankWindow, function() guiSetVisible(groupBankWindow, false) end, false)
	--addEventHandler("onClientGUIClick", groupBankDepositButton, depositMoney, false)
	addEventHandler("onClientGUIClick", groupBankButton, function() openGroupVault() end, false)
	
end
addEventHandler("onClientResourceStart", resourceRoot, makeGUI)

local permissions = {
	[1] = "Can invite players to the encampment",
	[2] = "Can promote encampment members",
	[3] = "Can demote encampment members",
	[4] = "Can kick encampment members",
	[5] = "Can warn encampment members",
	[6] = "Can delete the encampment",
	[7] = "Can deposit items in encampment vault",
	[8] = "Can items from encampment vault",
	[9] = "Can edit encampment board",
	[10] = "Can view encampment log",
	[11] = "Can view encampment blacklist",
	[12] = "Can add players in encampment blacklist ",
	[13] = "Can create/accept alliance",
	[14] = "Can add/edit/remove ranks",
}

function boolean(var)
	return (not (not var))
end

function viewSetRank()
	triggerServerEvent("groupSystem.getMyRanks", root)
end

function withdrawMoney()
	triggerServerEvent("groupsys.doSomethingWithBank", root, "withdraw", guiGetText(groupBankEdit))
end

function depositMoney()
	triggerServerEvent("groupsys.doSomethingWithBank", root, "deposit", guiGetText(groupBankEdit))
end

function printTheRanks(ranks)
	guiComboBoxClear(setRankCombo)
	guiSetVisible(setRankWindow, true)
	guiBringToFront(setRankWindow)
	
	for ind, data in pairs(ranks) do
		validRank[ind] = true
		guiComboBoxAddItem(setRankCombo, tostring(ind))
	end
	
	local account = guiGridListGetItemText(adminMembsList, guiGridListGetSelectedItem(adminMembsList), 2)
	local rank = guiGridListGetItemText(adminMembsList, guiGridListGetSelectedItem(adminMembsList), 3)
	local wl = guiGridListGetItemText(adminMembsList, guiGridListGetSelectedItem(adminMembsList), 5)
	guiSetText(accountSelectedRank, "Account: "..tostring(account).."\nRank: "..tostring(rank).."\nWL: "..tostring(wl))
	guiLabelSetColor(accountSelectedRank, 0, 255, 0)
end
addEvent("groupSystem.printTheRanks", true)
addEventHandler("groupSystem.printTheRanks", root, printTheRanks)

function clickOnRankCombo()
	local irrelevant = guiComboBoxGetSelected(setRankCombo)
	local name = guiComboBoxGetItemText(setRankCombo, irrelevant)
	local account = guiGridListGetItemText(adminMembsList, guiGridListGetSelectedItem(adminMembsList), 2)
	if (validRank[name] and name ~= "Select Rank") then
		guiSetText(setRankLabel1, "Set the rank of account: "..tostring(account).."\n to rank: "..name)
	end
end

function setRank()
	local irrelevant = guiComboBoxGetSelected(setRankCombo)
	local rank = guiComboBoxGetItemText(setRankCombo, irrelevant)
	--if (not validRank[name]) then return end
	local account = guiGridListGetItemText(adminMembsList, guiGridListGetSelectedItem(adminMembsList), 2)
	if (not account) then return end
	triggerServerEvent("groupSystem.setTheRank", root, rank, account)
end

function kickFromGroup()
	local account = guiGridListGetItemText(adminMembsList, guiGridListGetSelectedItem(adminMembsList), 2)
	if (not account) then outputChatBox("Please select a player!",255,0,0) return end
	triggerServerEvent("groupSystem.kickFromGroup", root, account)
end

function showRanks()
	triggerServerEvent("groupSystem.showRanks", root)
end

function addRank()
	local name = guiGetText(permAddEdit)
	if (name:len() >= 20 or name:len() < 1) then
		outputChatBox("Invalid rank name", 255, 0, 0)
		return
	end
	triggerServerEvent("groupSystem.addTheRank", root, name)
end

function deleteGroupRankAttempt()
	local irrelevant = guiComboBoxGetSelected(rankCombo)
	local name = guiComboBoxGetItemText(rankCombo, irrelevant)
	if (not permForRank[name] and name ~= "Select Rank") then return end
	deleteGroupRank()
	--exports.misc:confirmAction("You're about to delete rank:\n"..tostring(name).." are you sure?", "groupSystem.deleteGroupRank", "client")
end

function deleteGroupRank()
	local irrelevant = guiComboBoxGetSelected(rankCombo)
	local name = guiComboBoxGetItemText(rankCombo, irrelevant)
	if (not permForRank[name] and name ~= "Select Rank") then return end
	triggerServerEvent("groupSystem.deleteRank", root, name)
end
addEvent("groupSystem.deleteGroupRank", true)
addEventHandler("groupSystem.deleteGroupRank", root, deleteGroupRank)

function editRank()
	local irrelevant = guiComboBoxGetSelected(rankCombo)
	local newPermissions = {}
	local name = guiComboBoxGetItemText(rankCombo, irrelevant)
	if (permForRank[name] and check and type(check) == "table") then
		for ind, value in pairs(check) do
			table.insert(newPermissions, guiCheckBoxGetSelected(check[ind]))
		end
	end
	triggerServerEvent("groupSystem.editRank", root, name, newPermissions, irrelevant)
end

function doneWithRanks(ranksTable, selected)
	guiComboBoxClear(rankCombo)
	local id = {}
	for ind, data in pairs(ranksTable) do
		permForRank[ind] = data
		id[ind] = guiComboBoxAddItem(rankCombo, tostring(ind))
	end
	guiSetVisible(permWindow, true)
	guiBringToFront(permWindow, true)
	
	if (selected) then
		local newRank = id[selected]
		guiComboBoxSetSelected(rankCombo, newRank)
		deleteCheckBoxes(rankScrollPanel)
		check = createCheckBoxes(rankScrollPanel)
	end
end
addEvent("groupSystem.doneWithRanks", true)
addEventHandler("groupSystem.doneWithRanks", root, doneWithRanks)

function selectRank()
	deleteCheckBoxes(rankScrollPanel)
	check = createCheckBoxes(rankScrollPanel)
	local irrelevant = guiComboBoxGetSelected(rankCombo)
	local name = guiComboBoxGetItemText(rankCombo, irrelevant)
	if (permForRank[name] and name ~= "Select Rank") then
		for ind, v in pairs(permForRank[name]) do
			if (v and isElement(check[ind])) then
				guiCheckBoxSetSelected(check[ind], true)
			end
		end
	end
end

function createCheckBoxes(scrollPane)
	local stuffCount = 1
	local offset = 0.06
	local checkboxes = {}
	for k, v in ipairs(permissions) do
		--table.insert(checkboxes, guiCreateCheckBox(0, stuffCount*19, 287, 70, v, false, false, scrollPane))
		table.insert(checkboxes, guiCreateCheckBox(0.00, -0.06+offset, 1.0, 0.05, v, false, true, scrollPane))
		stuffCount = stuffCount + 1
		offset = offset+0.06
	end
	return checkboxes
end

function deleteCheckBoxes(scrollPane)
	for k, v in ipairs(getElementsByType("gui-checkbox", resourceRoot)) do
		if (getElementParent(v) == scrollPane) then
			destroyElement(v)
		end
	end
end

function showWarn()
	local account = guiGridListGetItemText(adminMembsList, guiGridListGetSelectedItem(adminMembsList), 2)
	if (not account or account == "") then return end
	guiSetVisible(warnWindow, true)
	guiSetText(warnWindow, "Warn "..account)
	guiBringToFront(warnWindow)
end

function warnAccount()
	local lvl = guiGetText(warningLevelEdit)
	local reason = guiGetText(warningReasonEdit)
	local account = guiGridListGetItemText(adminMembsList, guiGridListGetSelectedItem(adminMembsList), 2)
	if (not account or account == "") then return end
	if (not tonumber(lvl)) then
		outputChatBox("Invalid warning level entered", 255, 0, 0)
		return
	end
	triggerServerEvent("groupSystem.warnAccount", root, account, lvl, reason)
end

function confirmDelete()
	triggerServerEvent("groupSystem.leaveGroup", root)
end
addEvent("groupSystem.confirmDelete", true)
addEventHandler("groupSystem.confirmDelete", root, confirmDelete)

function closeWindow()
	guiSetVisible(window, false)
	showCursor(false)
end

function openWindowAndSend()
	if (guiGetVisible(window)) then
		guiSetVisible(window, false)
		showCursor(false)
		guiSetInputEnabled(false)
	else
		showCursor(true)
		guiSetVisible(window, true)
		guiSetInputEnabled(true)
		triggerServerEvent("groupSystem.viewWindow", root)
	end
end
addCommandHandler("group", openWindowAndSend)
bindKey("F2", "down", openWindowAndSend)

function showGroupList()
	guiSetVisible(listWindow, true)
	guiBringToFront(listWindow)
	triggerServerEvent("groupSystem.getGroupList", root)
end

function addGroupList(group, count)
	gTable = group
	guiGridListClear(groupListGrid)
	for ind, data in pairs(group) do
		local row = guiGridListAddRow(groupListGrid)
		guiGridListSetItemText(groupListGrid, row, 1, tostring(ind), false, false)
		guiGridListSetItemText(groupListGrid, row, 2, tostring(data[1]), false, false)
		guiGridListSetItemText(groupListGrid, row, 3, tostring(count[ind]), false, false)
		c[ind] = count[ind]
	end
end
addEvent("groupSystem.addGroupList", true)
addEventHandler("groupSystem.addGroupList", root, addGroupList)

function searchGroupList()
	guiGridListClear(groupListGrid)
	
	local text = guiGetText(source)
	
	if (not text or text == "") then
		triggerServerEvent("groupSystem.getGroupList", root)
		return
	end
	
	for ind, data in pairs(gTable) do
		if (string.find(ind:lower(), text:lower(), 1, true)) then
			local row = guiGridListAddRow(groupListGrid)
			guiGridListSetItemText(groupListGrid, row, 1, tostring(ind), false, false)
			guiGridListSetItemText(groupListGrid, row, 2, tostring(data[1]), false, false)
			guiGridListSetItemText(groupListGrid, row, 3, tostring(c[ind]), false, false)
		end
	end
end

function viewWindow(group, rank, datejoined, msg, perms, money)
	if (not group) then
		guiSetText(myGroupLabel, "My Encampment: N/A")
		guiSetText(myGroupRankLabel, "Encampment Rank: N/A")
		guiSetText(dateJoinedLabel, "Date Joined: N/A")
		guiSetEnabled(createGroupEdit, true)
		guiSetEnabled(createGroupButton, true)
		guiSetEnabled(adminPanel, false)
		guiSetEnabled(leaveGroupButton, false)
	else
		guiSetEnabled(leaveGroupButton, true)
		guiSetEnabled(createGroupEdit, false)
		guiSetEnabled(createGroupButton, false)
		guiSetEnabled(adminPanel, true)
		guiSetText(createGroupEdit, tostring(group))
		guiSetText(dateJoinedLabel, "Date Joined: "..tostring(datejoined))
		guiSetText(myGroupLabel, "My Encampment: "..tostring(group))
		guiSetText(myGroupRankLabel, "Encampment Rank: "..tostring(rank))
		--guiSetText(groupBankAmountLabel, "Encampment Vault Amount: "..tostring(money))
		printManagment()
		guiGridListClear(adminMembsList)
	end
	
	if (perms and type(perms) == "table") then
		local manageRanks = false
		if (perms[2] or perms[3]) then
			manageRanks = true
		end
			
		if (perms[4] or perms[5]) then
			warn = true
		end
		guiSetEnabled(viewSetRankButton, manageRanks)
		guiSetEnabled(logButton, boolean(perms[10]))
		guiSetEnabled(viewAdminInviteButton, boolean(perms[1]))
		--guiSetEnabled(blackListButton, boolean(perms[12]))
		guiSetEnabled(viewWarnsButton, warn)
		guiSetEnabled(viewMessageButton, boolean(perms[9]))
		--guiSetEnabled(groupBankWithdrawButton, boolean(perms[16]))
	end
	guiSetText(messageMemo, tostring(msg))
	guiSetText(messageOTD,"Message of the Day:\n"..tostring(msg))
end
addEvent("groupSystem.done", true)
addEventHandler("groupSystem.done", root, viewWindow)

function printManagment()
	triggerServerEvent("groupSystem.print", root)
end

function addToList(account, rank, warning, joined, lastTime, nick, online)
	local row = guiGridListAddRow(adminMembsList)
	guiGridListSetItemText(adminMembsList, row, 1, tostring(nick), false, false)
	guiGridListSetItemText(adminMembsList, row, 2, tostring(account), false, false)
	guiGridListSetItemText(adminMembsList, row, 3, tostring(rank), false, false)
	guiGridListSetItemText(adminMembsList, row, 4, tostring(lastTime), false, false)
	guiGridListSetItemText(adminMembsList, row, 5, tostring(warning), false, false)
	
	if (online) then
		guiGridListSetItemColor(adminMembsList, row, 1, 0, 255, 0)
		guiGridListSetItemColor(adminMembsList, row, 2, 0, 255, 0)
		guiGridListSetItemColor(adminMembsList, row, 3, 0, 255, 0)
		guiGridListSetItemColor(adminMembsList, row, 4, 0, 255, 0)
		guiGridListSetItemColor(adminMembsList, row, 5, 0, 255, 0)
	else
		guiGridListSetItemColor(adminMembsList, row, 1, 255, 0, 0)
		guiGridListSetItemColor(adminMembsList, row, 2, 255, 0, 0)
		guiGridListSetItemColor(adminMembsList, row, 3, 255, 0, 0)
		guiGridListSetItemColor(adminMembsList, row, 4, 255, 0, 0)
		guiGridListSetItemColor(adminMembsList, row, 5, 255, 0, 0)
	end
end
addEvent("groupSystem.addToList", true)
addEventHandler("groupSystem.addToList", root, addToList)

function saveMessage()
	local message = guiGetText(messageMemo)
	guiSetText(messageOTD,"Message of the Day:\n"..tostring(message))
	triggerServerEvent("groupSystem.updateMessage", root, message)
end

function makeGroup()
	if (not guiGetEnabled(createGroupEdit)) then
		outputChatBox("You must leave your current encampment first!", 255, 0, 0, "default-bold", true, 0.15)
		return
	end
	
	local name = guiGetText(createGroupEdit)
	local name = string.gsub(name, " ", "_")
	if (name and name ~= "" and name:len() > 2) then
		triggerServerEvent("groupSystem.attemptMakeGroup", root, name)
	end
end

function openInviteSearch()
	guiGridListClear(inviteList)
	for ind, plr in pairs(getElementsByType("player")) do
		if (not getElementData(plr, "Group")) then
			local name = getPlayerName(plr)
			local row = guiGridListAddRow(inviteList)
			local r, g, b = getPlayerNametagColor(plr)
			guiGridListSetItemText(inviteList, row, 1, tostring(name), false, false)
			guiGridListSetItemColor(inviteList, row, 1, r or 255, g or 255, b or 255)
		end
	end
end

function searchInvite()
	local text = guiGetText(source)
	guiGridListClear(inviteList)
	
	if (not text or text == "") then
		openInviteSearch()
		return
	end
	
	
	for _, plr in pairs(getElementsByType("player")) do
		local name = getPlayerName(plr)
		local foundString = string.find(name:lower(), text:lower(), 1, true)
		if (foundString and not getElementData(plr, "Group")) then
			local row = guiGridListAddRow(inviteList)
			local r, g, b = getPlayerNametagColor(plr)
			guiGridListSetItemText(inviteList, row, 1, tostring(name), false, false)
			guiGridListSetItemColor(inviteList, row, 1, r or 255, g or 255, b or 255)
		end
	end
end

function invitePlayer()
	local name = guiGridListGetItemText(inviteList, guiGridListGetSelectedItem(inviteList), 1)
	if (not name or not getPlayerFromName(name)) then return end
	local selected = getPlayerFromName(name)
	for ind, data in pairs(invited) do
		if (data == selected) then
			outputChatBox("You cannot invite this player again!", 255, 0, 0)
			return
		end
	end
	table.insert(invited, selected)
	triggerServerEvent("groupSystem.makeInvite", root, selected)
end

function addInviteToList(group, sender, time)
	for ind, data in pairs(got) do
		if (data == group) then
			return
		end
	end
	table.insert(got, group)
	local row = guiGridListAddRow(mineListInvites)
	guiGridListSetItemText(mineListInvites, row, 1, tostring(group), false, false)
	guiGridListSetItemText(mineListInvites, row, 2, tostring(sender), false, false)
	guiGridListSetItemText(mineListInvites, row, 3, tostring(time), false, false)
end
addEvent("groupSystem.addInviteToList", true)
addEventHandler("groupSystem.addInviteToList", root, addInviteToList)

function rejectInvite()
	local group = guiGridListGetItemText(mineListInvites, guiGridListGetSelectedItem(mineListInvites), 1)
	if (not group) then return end
	guiGridListRemoveRow(mineListInvites, guiGridListGetSelectedItem(mineListInvites))
end

function acceptInvite()
	local group = guiGridListGetItemText(mineListInvites, guiGridListGetSelectedItem(mineListInvites), 1)
	if (not group) then return end
	guiGridListRemoveRow(mineListInvites, guiGridListGetSelectedItem(mineListInvites))
	triggerServerEvent("groupSystem.accepInvite", root, group)
end


--GPS
playerBlibs = {}
amouunt = 0
function updateGPS()
	amouunt = 0
	local gangname = getElementData(getLocalPlayer(),"Group")
	for i, blip in ipairs(playerBlibs) do
		if isElement(blip) then
			destroyElement(blip)
		end
	end
	if not getElementData(localPlayer,"Group") then return end	
	playerBlibs = {}	
	for i, player in ipairs(getElementsByType("player")) do
		if gangname == getElementData(player,"Group") and player ~= localPlayer then
			amouunt = amouunt+1
			playerBlibs[amouunt] = createBlipAttachedTo(player,0,2,22,255,22)
			setBlipVisibleDistance(playerBlibs[amouunt],1000)
		end
	end
end
setTimer(updateGPS,10000,0)

--[[
function openGroupVault()
	local r = getPlayerRotation ( localPlayer )
	x = x - math.sin ( math.rad ( r ) ) * 20
	y = y + math.cos ( math.rad ( r ) ) * 20
	groupvaultobject = createObject (2332,x,y,z)
	groupvaultcol = createColSphere(x,y,z,1)
	attachElements(groupvaultcol, groupvaultobject)
	outputChatBox("Vault has been created. You have 10 seconds to access it before the object is destroyed!",255,0,0)
	setTimer(
		function() 
			destroyElement(groupvaultobject) 
			destroyElement(groupvaultcol) 
			outputChatBox("Destroyed") 
		end,10000,1)
end
]]
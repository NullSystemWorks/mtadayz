local gangGUI = {}
gangGUI.main = {}
gangGUI.gang_panel = {}
gangGUI.gang_invite = {}
gangGUI.gang_list = {}
gangGUI.confirmation = {}
gangGUI.gang_subleaders = {}
local confirmation

addEventHandler("onClientResourceStart", resourceRoot, function()
	gangGUI.main.window = guiCreateWindow(301, 191, 415, 318, "Gang System", false)
	guiWindowSetSizable(gangGUI.main.window, false)
	centerWindow(gangGUI.main.window)
	gangGUI.gang_panel.memberList = guiCreateGridList(9, 21, 194, 288, false, gangGUI.main.window)
	guiGridListAddColumn(gangGUI.gang_panel.memberList, "Member account:", 0.45)
	guiGridListAddColumn(gangGUI.gang_panel.memberList, "Added by:", 0.45)
	guiGridListSetSortingEnabled(gangGUI.gang_panel.memberList, false)
	gangGUI.gang_panel.invite_player = guiCreateButton(214, 29, 190, 28, "Invite player", false, gangGUI.main.window)
	gangGUI.gang_panel.kick_member = guiCreateButton(214, 68, 190, 28, "Kick member", false, gangGUI.main.window)
	gangGUI.gang_panel.add_subleader = guiCreateButton(214, 107, 190, 28, "Add as sub leader", false, gangGUI.main.window)
	gangGUI.gang_panel.sub_leaders = guiCreateButton(214, 146, 190, 28, "Sub Leaders", false, gangGUI.main.window)
	gangGUI.gang_panel.leave_gang = guiCreateButton(214, 185, 190, 28, "Leave gang", false, gangGUI.main.window)
	gangGUI.gang_panel.destroy_gang = guiCreateButton(214, 224, 190, 28, "Destroy gang", false, gangGUI.main.window)
	gangGUI.gang_panel.panel_close = guiCreateButton(214, 280, 190, 28, "Close", false, gangGUI.main.window)
	gangGUI.gang_invite.playerList = guiCreateGridList(9, 21, 194, 288, false, gangGUI.main.window)
	guiGridListAddColumn(gangGUI.gang_invite.playerList, "Player name:", 0.9)
	guiGridListSetSortingEnabled(gangGUI.gang_invite.playerList, false)
	gangGUI.gang_invite.invite_send = guiCreateButton(214, 29, 190, 28, "Send invitation", false, gangGUI.main.window)
	gangGUI.gang_invite.invite_cancel = guiCreateButton(214, 280, 190, 28, "Cancel", false, gangGUI.main.window)
	gangGUI.gang_list.gangList = guiCreateGridList(9, 21, 400, 260, false, gangGUI.main.window)
	guiGridListAddColumn(gangGUI.gang_list.gangList, "Gang name:", 0.35)
	guiGridListAddColumn(gangGUI.gang_list.gangList, "Gang leader:", 0.35)
	guiGridListAddColumn(gangGUI.gang_list.gangList, "Gang members:", 0.25)
	guiGridListSetSortingEnabled(gangGUI.gang_list.gangList, false)
	gangGUI.gang_list.close = guiCreateButton(144, 287, 128, 20, "Close", false, gangGUI.main.window)
	gangGUI.confirmation.window = guiCreateWindow(432, 212, 221, 114, "Confirmation", false)
	guiWindowSetSizable(gangGUI.confirmation.window, false)
	guiSetProperty(gangGUI.confirmation.window, "AlwaysOnTop", "true")
	centerWindow(gangGUI.confirmation.window)
	gangGUI.confirmation.label = guiCreateLabel(11, 25, 197, 42, "", false, gangGUI.confirmation.window)
	guiLabelSetHorizontalAlign(gangGUI.confirmation.label, "center", true)
	gangGUI.confirmation.accept = guiCreateButton(23, 70, 60, 30, "Yes", false, gangGUI.confirmation.window)
	gangGUI.confirmation.decline = guiCreateButton(139, 70, 60, 30, "No", false, gangGUI.confirmation.window)
	gangGUI.gang_subleaders.subLeadersList = guiCreateGridList(9, 21, 194, 288, false, gangGUI.main.window)
	guiGridListAddColumn(gangGUI.gang_subleaders.subLeadersList, "Member account:", 0.9)
	guiGridListSetSortingEnabled(gangGUI.gang_subleaders.subLeadersList, false)
	gangGUI.gang_subleaders.remove = guiCreateButton(214, 29, 190, 28, "Remove sub leader", false, gangGUI.main.window)
	gangGUI.gang_subleaders.close = guiCreateButton(214, 280, 190, 28, "Close", false, gangGUI.main.window)
	setGUIPanelVisible("all", false)
end)

addEvent("gangSystem:openGangList", true)
addEventHandler("gangSystem:openGangList", root, function(gangList)
	setGUIPanelVisible("gang_list", true)
	showCursor(true)
	guiGridListClear(gangGUI.gang_list.gangList)
	for index, gang in ipairs(gangList) do
		local row = guiGridListAddRow(gangGUI.gang_list.gangList)
		guiGridListSetItemText(gangGUI.gang_list.gangList, row, 1, tostring(gang.gang_name), false, false)
		guiGridListSetItemText(gangGUI.gang_list.gangList, row, 2, tostring(gang.gang_leader), false, false)
		guiGridListSetItemText(gangGUI.gang_list.gangList, row, 3, tostring(gang.gang_members), false, false)
	end
end)

addEvent("gangSystem:openGangPanel", true)
addEventHandler("gangSystem:openGangPanel", root, function(memberList)
	setGUIPanelVisible("gang_panel", true)
	showCursor(true)
	guiGridListClear(gangGUI.gang_panel.memberList)
	if guiGetVisible(gangGUI.main.window) then
		for index, member in ipairs(memberList) do
			local row = guiGridListAddRow(gangGUI.gang_panel.memberList)
			guiGridListSetItemText(gangGUI.gang_panel.memberList, row, 1, tostring(member.member_account), false, false)
			guiGridListSetItemText(gangGUI.gang_panel.memberList, row, 2, tostring(member.added_by), false, false)
		end
	end
end)

addEvent("gangSystem:returnSubLeaders", true)
	addEventHandler("gangSystem:returnSubLeaders", root, function(subLeaders)
	guiGridListClear(gangGUI.gang_subleaders.subLeadersList)
	for index, subLeader in ipairs(fromJSON(subLeaders)) do
		local row = guiGridListAddRow(gangGUI.gang_subleaders.subLeadersList)
		guiGridListSetItemText(gangGUI.gang_subleaders.subLeadersList, row, 1, tostring(subLeader), false, false)
	end
end)

addEventHandler("onClientGUIClick", root, function()
	if source == gangGUI.gang_panel.invite_player then
		setGUIPanelVisible("gang_invite", true)
		addPlayersToGrid()
	elseif source == gangGUI.gang_invite.invite_send then
		local row, col = guiGridListGetSelectedItem(gangGUI.gang_invite.playerList)
		if row and col and row ~= -1 and col ~= -1 then
			local playerName = guiGridListGetItemText(gangGUI.gang_invite.playerList, row, 1)
			triggerServerEvent("gangSystem:invitePlayer", localPlayer, playerName)
		end
	elseif source == gangGUI.gang_invite.invite_cancel then
		setGUIPanelVisible("gang_invite", false)
		setGUIPanelVisible("gang_panel", true)
	elseif source == gangGUI.gang_panel.kick_member then
		local row, col = guiGridListGetSelectedItem(gangGUI.gang_panel.memberList)
		if row and col and row ~= -1 and col ~= -1 then
			local memberAccount = guiGridListGetItemText(gangGUI.gang_panel.memberList, row, 1)
			triggerServerEvent("gangSystem:kickMember", localPlayer, memberAccount)
		end
	elseif source == gangGUI.gang_panel.add_subleader then
		local row, col = guiGridListGetSelectedItem(gangGUI.gang_panel.memberList)
		if row and col and row ~= -1 and col ~= -1 then
			local memberAccount = guiGridListGetItemText(gangGUI.gang_panel.memberList, row, 1)
			triggerServerEvent("gangSystem:addSubLeader", localPlayer, memberAccount)
		end
	elseif source == gangGUI.gang_panel.sub_leaders then
		setGUIPanelVisible("gang_subleaders", true)
		triggerServerEvent("gangSystem:getSubLeaders", localPlayer)
	elseif source == gangGUI.gang_panel.leave_gang then
		local gangName = getElementData(localPlayer, "gang")
			if gangName and gangName ~= "None" then
			setGUIPanelVisible("all", false)
			guiSetText(gangGUI.confirmation.label, "Are you sure you want to leave the gang: " .. gangName .. "?")
			setGUIPanelVisible("confirmation", true)
			confirmation = "leave gang"
		end
	elseif source == gangGUI.gang_panel.destroy_gang then
		local gangName = getElementData(localPlayer, "gang")
		if gangName and gangName ~= "None" then
			setGUIPanelVisible("all", false)
			guiSetText(gangGUI.confirmation.label, "Are you sure you want to destroy the gang: " .. gangName .. "?")
			setGUIPanelVisible("confirmation", true)
			confirmation = "destroy gang"
		end
	elseif source == gangGUI.gang_panel.panel_close then
		setGUIPanelVisible("all", false)
		showCursor(false)
	elseif source == gangGUI.confirmation.accept then
		if confirmation == "destroy gang" then
			triggerServerEvent("gangSystem:destroyGang", localPlayer)
		elseif confirmation == "leave gang" then
			triggerServerEvent("gangSystem:leaveGang", localPlayer)
		end
		setGUIPanelVisible("confirmation", false)
		showCursor(false)
		elseif source == gangGUI.confirmation.decline then
		showCursor(false)
		setGUIPanelVisible("confirmation", false)
	elseif source == gangGUI.gang_subleaders.remove then
		local row, col = guiGridListGetSelectedItem(gangGUI.gang_subleaders.subLeadersList)
		if row and col and row ~= -1 and col ~= -1 then
			local subLeader = guiGridListGetItemText(gangGUI.gang_subleaders.subLeadersList, row, 1)
			triggerServerEvent("gangSystem:removeSubLeader", localPlayer, subLeader)
		end
	elseif source == gangGUI.gang_subleaders.close then
		setGUIPanelVisible("all", false)
		setGUIPanelVisible("gang_panel", true)
	elseif source == gangGUI.gang_list.close then
		setGUIPanelVisible("gang_list", false)
		showCursor(false)
	end
end)

function addPlayersToGrid()
	guiGridListClear(gangGUI.gang_invite.playerList)
	for index, player in pairs(getElementsByType("player")) do
		local gangName = getElementData(player, "gang")
		if gangName == "None" or not gangName then
			local row = guiGridListAddRow(gangGUI.gang_invite.playerList)
			guiGridListSetItemText(gangGUI.gang_invite.playerList, row, 1, tostring(getPlayerName(player)), false, false)
		end
	end
end
addEventHandler("onClientPlayerJoin", root, addPlayersToGrid)
addEventHandler("onClientPlayerQuit", root, addPlayersToGrid)
addEventHandler("onClientPlayerChangeNick", root, addPlayersToGrid)

function centerWindow(center_window)
	local screenW, screenH = guiGetScreenSize()
	local windowW, windowH = guiGetSize(center_window, false)
	local x, y = (screenW - windowW) / 2, (screenH - windowH) / 2
	guiSetPosition(center_window, x, y, false)
end

function setGUIPanelVisible(GUI, state)
	if GUI ~= "all" then
		setGUIPanelVisible("all", false)
		if state and GUI ~= "confirmation" and not guiGetVisible(gangGUI.main.window) then
			guiSetVisible(gangGUI.main.window, true)
		end
		for _, element in pairs(gangGUI[GUI]) do
			guiSetVisible(element, state)
		end
	else
		for GUI, _ in pairs(gangGUI) do
			for _, element in pairs(gangGUI[GUI]) do
				guiSetVisible(element, state)
			end
		end
	end
end

playerGroupWindow ={}

playerGroupWindow["window"] =  guiCreateWindow(0.05,0.20,0.90,0.59,"Encampment System",true)
guiSetVisible(playerGroupWindow["window"],false)

-- Encampment List
playerGroupWindow["grouplist"] = guiCreateGridList(0.02, 0.06, 0.95, 0.47,true,playerGroupWindow["window"])
playerGroupWindow["grouplist_groupname"] = guiGridListAddColumn( playerGroupWindow["grouplist"], "Group", 0.35 )
playerGroupWindow["grouplist_groupleader"] = guiGridListAddColumn( playerGroupWindow["grouplist"], "Leader", 0.3 )
playerGroupWindow["grouplist_groupmember"] = guiGridListAddColumn( playerGroupWindow["grouplist"], "Members", 0.3 )


-- Invitation List
playerGroupWindow["groupinvitelist"] = guiCreateGridList (0.02, 0.55, 0.95, 0.33,true,playerGroupWindow["window"])
playerGroupWindow["groupinvitelist_groupname"] = guiGridListAddColumn( playerGroupWindow["groupinvitelist"], "Group", 0.2 )
playerGroupWindow["groupinvitelist_groupinviter"] = guiGridListAddColumn( playerGroupWindow["groupinvitelist"], "Invited by", 0.2 )
playerGroupWindow["groupinvitelist_groupmember"] = guiGridListAddColumn( playerGroupWindow["groupinvitelist"], "Member", 0.2 )
playerGroupWindow["groupinvitelist_groupvip"] = guiGridListAddColumn( playerGroupWindow["groupinvitelist"], "VIP", 0.2 )
playerGroupWindow["groupinvite_accept"] = guiCreateButton(0.02, 0.91, 0.22, 0.05, "Accept Invitation", true, playerGroupWindow["window"] )
playerGroupWindow["groupinvite_decline"] = guiCreateButton(0.39, 0.91, 0.22, 0.05, "Decline Invitation", true, playerGroupWindow["window"])
playerGroupWindow["groupinvite_cancel"] = guiCreateButton(0.75, 0.91, 0.22, 0.05, "Cancel", true, playerGroupWindow["window"])

-- Member List
playerGroupWindow["member_window"] = guiCreateWindow(0.02, 0.07, 0.96, 0.87, "Encampment Member System", true)
guiWindowSetSizable(playerGroupWindow["member_window"], false)
guiSetVisible(playerGroupWindow["member_window"],false)

playerGroupWindow["member_list"] = guiCreateGridList(0.01, 0.06, 0.34, 0.69, true, playerGroupWindow["member_window"])
playerGroupWindow["member_list_names"] = guiGridListAddColumn(playerGroupWindow["member_list"], "Name",0.9)
playerGroupWindow["member_list_destroygroup"] = guiCreateButton(0.46, 0.88, 0.09, 0.07, "Disband Encampment", true,playerGroupWindow["member_window"])
playerGroupWindow["member_list_leavegang"] = guiCreateButton(0.35, 0.88, 0.09, 0.07, "Leave Encampment", true, playerGroupWindow["member_window"])
playerGroupWindow["member_list_inviteplayer"] = guiCreateButton(0.35, 0.79, 0.09, 0.07, "Invite New Player", true, playerGroupWindow["member_window"])
playerGroupWindow["member_list_kickplayer"] = guiCreateButton(0.46, 0.79, 0.09, 0.07, "Kick Player", true, playerGroupWindow["member_window"])
playerGroupWindow["member_list_groupvault"] = guiCreateButton(0.66, 0.79, 0.09, 0.07, "Group Vault", true, playerGroupWindow["member_window"])
playerGroupWindow["member_list_assignrank"] = guiCreateButton(0.56, 0.79, 0.09, 0.07, "Assign Rank", true, playerGroupWindow["member_window"])
playerGroupWindow["member_list_quests"] = guiCreateButton(0.77, 0.79, 0.09, 0.07, "Quests", true, playerGroupWindow["member_window"])
playerGroupWindow["member_list_encampmentstatus"] = guiCreateButton(0.87, 0.79, 0.09, 0.07, "Encampment", true, playerGroupWindow["member_window"])
playerGroupWindow["member_list_online"] = guiCreateLabel(0.40, 0.09, 0.15, 0.03, "Online Status:", true, playerGroupWindow["member_window"])
playerGroupWindow["member_list_daysalive"] = guiCreateLabel(0.40, 0.14, 0.15, 0.03, "Days Alive:", true, playerGroupWindow["member_window"])
playerGroupWindow["member_list_murders"] = guiCreateLabel(0.40, 0.19, 0.15, 0.03, "Murders Committed:", true, playerGroupWindow["member_window"])
playerGroupWindow["member_list_bandits"] = guiCreateLabel(0.40, 0.24, 0.15, 0.03, "Bandits Killed:", true, playerGroupWindow["member_window"])
playerGroupWindow["member_list_humanity"] = guiCreateLabel(0.40, 0.29, 0.15, 0.03, "Humanity:", true, playerGroupWindow["member_window"])
playerGroupWindow["member_list_location"] = guiCreateLabel(0.40, 0.34, 0.15, 0.03, "Current Location:", true, playerGroupWindow["member_window"])
playerGroupWindow["member_list_rank"] = guiCreateLabel(0.40, 0.39, 0.15, 0.03, "Rank:", true, playerGroupWindow["member_window"])
playerGroupWindow["member_list_timesdied"] = guiCreateLabel(0.40, 0.44, 0.15, 0.03, "Times Died:", true, playerGroupWindow["member_window"])
playerGroupWindow["member_list_online_1"] = guiCreateLabel(0.62, 0.09, 0.15, 0.03, "", true, playerGroupWindow["member_window"])
playerGroupWindow["member_list_daysalive_1"] = guiCreateLabel(0.62, 0.14, 0.15, 0.03, "", true, playerGroupWindow["member_window"])
playerGroupWindow["member_list_murders_1"] = guiCreateLabel(0.62, 0.19, 0.15, 0.03, "", true, playerGroupWindow["member_window"])
playerGroupWindow["member_list_bandits_1"] = guiCreateLabel(0.62, 0.24, 0.15, 0.03, "", true, playerGroupWindow["member_window"])
playerGroupWindow["member_list_humanity_1"] = guiCreateLabel(0.62, 0.29, 0.15, 0.03, "", true, playerGroupWindow["member_window"])
playerGroupWindow["member_list_location_1"] = guiCreateLabel(0.62, 0.34, 0.15, 0.03, "", true, playerGroupWindow["member_window"])
playerGroupWindow["member_list_rank_1"] = guiCreateLabel(0.62, 0.39, 0.15, 0.03, "", true, playerGroupWindow["member_window"])
playerGroupWindow["member_list_timesdied_1"] = guiCreateLabel(0.62, 0.44, 0.15, 0.03, "", true, playerGroupWindow["member_window"])

-- Rank Assignment
playerGroupWindow["member_list_rank_window"] = guiCreateWindow(0.32, 0.12, 0.36, 0.76, "Rank Assignment", true)
guiSetVisible(playerGroupWindow["member_list_rank_window"],false)
guiWindowSetSizable(playerGroupWindow["member_list_rank_window"], false)
playerGroupWindow["member_list_rank_gridlist"] = guiCreateGridList(0.08, 0.08, 0.84, 0.73, true, playerGroupWindow["member_list_rank_window"])
guiGridListAddColumn(playerGroupWindow["member_list_rank_gridlist"], "Name", 0.5)
guiGridListAddColumn(playerGroupWindow["member_list_rank_gridlist"], "Rank", 0.4)
playerGroupWindow["member_list_rank_giverank"] = guiCreateButton(0.08, 0.87, 0.26, 0.08, "Give Rank", true, playerGroupWindow["member_list_rank_window"])
playerGroupWindow["member_list_rank_managepermissions"] = guiCreateButton(0.36, 0.87, 0.26, 0.08, "Manage Permissions", true, playerGroupWindow["member_list_rank_window"])
playerGroupWindow["member_list_rank_closebutton"] = guiCreateButton(0.65, 0.87, 0.26, 0.08, "Cancel", true, playerGroupWindow["member_list_rank_window"])

-- Give Rank Window
playerGroupWindow["member_list_rank_assign"] = guiCreateWindow(0.33, 0.23, 0.32, 0.57, "Assign Rank to Player", true)
guiSetVisible(playerGroupWindow["member_list_rank_assign"],false)
guiWindowSetMovable(playerGroupWindow["member_list_rank_assign"], false)
guiWindowSetSizable(playerGroupWindow["member_list_rank_assign"], false)
playerGroupWindow["member_list_rank_combobox"] = guiCreateComboBox(0.08, 0.36, 0.84, 0.41, "Leader", true, playerGroupWindow["member_list_rank_assign"])
guiComboBoxAddItem(playerGroupWindow["member_list_rank_combobox"], "Leader")
guiComboBoxAddItem(playerGroupWindow["member_list_rank_combobox"], "Co-Leader")
guiComboBoxAddItem(playerGroupWindow["member_list_rank_combobox"], "General")
guiComboBoxAddItem(playerGroupWindow["member_list_rank_combobox"], "Officer")
guiComboBoxAddItem(playerGroupWindow["member_list_rank_combobox"], "Soldier")
guiComboBoxAddItem(playerGroupWindow["member_list_rank_combobox"], "Survivor")
guiComboBoxAddItem(playerGroupWindow["member_list_rank_combobox"], "Bandit")
playerGroupWindow["member_list_rank_combobox_label1"] = guiCreateLabel(0.08, 0.17, 0.44, 0.04, "Current Rank:", true, playerGroupWindow["member_list_rank_assign"])
guiSetFont(playerGroupWindow["member_list_rank_combobox_label1"], "default-bold-small")
playerGroupWindow["member_list_rank_combobox_label2"] = guiCreateLabel(0.52, 0.17, 0.44, 0.04, "\"RANK\"", true, playerGroupWindow["member_list_rank_assign"])
guiSetFont(playerGroupWindow["member_list_rank_combobox_label2"], "default-bold-small")
playerGroupWindow["member_list_rank_combobox_confirm"] = guiCreateButton(0.16, 0.87, 0.29, 0.10, "Confirm", true, playerGroupWindow["member_list_rank_assign"])
playerGroupWindow["member_list_rank_combobox_cancel"] = guiCreateButton(0.55, 0.87, 0.29, 0.10, "Cancel", true, playerGroupWindow["member_list_rank_assign"])

-- Manage Permissions Window
playerGroupWindow["member_list_manage_permissions"] = guiCreateWindow(0.09, 0.12, 0.82, 0.76, "Manage Permissions", true)
guiSetVisible(playerGroupWindow["member_list_manage_permissions"],false)
guiWindowSetMovable(playerGroupWindow["member_list_manage_permissions"], false)
guiWindowSetSizable(playerGroupWindow["member_list_manage_permissions"], false)

playerGroupWindow["member_list_manage_permissions_combobox"] = guiCreateComboBox(0.01, 0.13, 0.32, 0.31, "", true, playerGroupWindow["member_list_manage_permissions"])
guiComboBoxAddItem(playerGroupWindow["member_list_manage_permissions_combobox"], "Leader")
guiComboBoxAddItem(playerGroupWindow["member_list_manage_permissions_combobox"], "Co-Leader")
guiComboBoxAddItem(playerGroupWindow["member_list_manage_permissions_combobox"], "General")
guiComboBoxAddItem(playerGroupWindow["member_list_manage_permissions_combobox"], "Officer")
guiComboBoxAddItem(playerGroupWindow["member_list_manage_permissions_combobox"], "Soldier")
guiComboBoxAddItem(playerGroupWindow["member_list_manage_permissions_combobox"], "Survivor")
guiComboBoxAddItem(playerGroupWindow["member_list_manage_permissions_combobox"], "Bandit")
playerGroupWindow["member_list_manage_permissions_combobox_confirm"] = guiCreateButton(0.73, 0.89, 0.11, 0.08, "Confirm", true, playerGroupWindow["member_list_manage_permissions"])
playerGroupWindow["member_list_manage_permissions_combobox_cancel"] = guiCreateButton(0.87, 0.89, 0.11, 0.08, "Cancel", true, playerGroupWindow["member_list_manage_permissions"])
playerGroupWindow["member_list_manage_permissions_combobox_label1"] = guiCreateLabel(0.12, 0.07, 0.16, 0.03, "Select Rank", true, playerGroupWindow["member_list_manage_permissions"])
guiSetFont(playerGroupWindow["member_list_manage_permissions_combobox_label1"], "default-bold-small")
playerGroupWindow["member_list_manage_permissions_combobox_perms"] = guiCreateComboBox(0.01, 0.49, 0.66, 0.36, "", true, playerGroupWindow["member_list_manage_permissions"])
guiComboBoxAddItem(playerGroupWindow["member_list_manage_permissions_combobox_perms"], "Ruler: Can edit permissions and set MOTD")
guiComboBoxAddItem(playerGroupWindow["member_list_manage_permissions_combobox_perms"], "Recruiter: Can invite other players")
guiComboBoxAddItem(playerGroupWindow["member_list_manage_permissions_combobox_perms"], "Regulator: Can kick other members")
guiComboBoxAddItem(playerGroupWindow["member_list_manage_permissions_combobox_perms"], "Promoter: Can promote players")
guiComboBoxAddItem(playerGroupWindow["member_list_manage_permissions_combobox_perms"], "Architect: Can build & destroy buildings at encampment")
guiComboBoxAddItem(playerGroupWindow["member_list_manage_permissions_combobox_perms"], "Treasurer: Can access Encampment Vault")
guiComboBoxAddItem(playerGroupWindow["member_list_manage_permissions_combobox_perms"], "Tech: Can queue research projects")
guiComboBoxAddItem(playerGroupWindow["member_list_manage_permissions_combobox_perms"], "Tactician: Can deploy, rearrange and destroy barricades, soldiers etc.")
playerGroupWindow["member_list_manage_permissions_combobox_perms_label1"] = guiCreateLabel(0.26, 0.45, 0.23, 0.04, "Select Permission", true, playerGroupWindow["member_list_manage_permissions"])
guiSetFont(playerGroupWindow["member_list_manage_permissions_combobox_perms_label1"], "default-bold-small")
playerGroupWindow["member_list_manage_permissions_combobox_label2"] = guiCreateLabel(0.58, 0.13, 0.39, 0.28, "This window allows you to edit the permission set for each rank.\nNote that you have to press \"Confirm\" before you can edit the next rank, otherwise all your work will be lost!", true, playerGroupWindow["member_list_manage_permissions"])
guiSetFont(playerGroupWindow["member_list_manage_permissions_combobox_label2"], "default-bold-small")
guiLabelSetColor(playerGroupWindow["member_list_manage_permissions_combobox_label2"], 255,255,255)
guiLabelSetHorizontalAlign(playerGroupWindow["member_list_manage_permissions_combobox_label2"], "center", true, playerGroupWindow["member_list_manage_permissions"])
playerGroupWindow["member_list_manage_permissions_add"] = guiCreateButton(0.02, 0.89, 0.16, 0.08, "Add", true, playerGroupWindow["member_list_manage_permissions"])
playerGroupWindow["member_list_manage_permissions_remove"] = guiCreateButton(0.21, 0.89, 0.16, 0.08, "Remove", true, playerGroupWindow["member_list_manage_permissions"])
playerGroupWindow["member_list_manage_permissions_gridlist"] = guiCreateGridList(0.70, 0.49, 0.28, 0.37, true, playerGroupWindow["member_list_manage_permissions"])
playerGroupWindow["member_list_manage_permissions_gridlist_column"] = guiGridListAddColumn(playerGroupWindow["member_list_manage_permissions_gridlist"], "Permission", 0.9)

-- Encampment (TO DO)

-- Group Vault (TO DO)



-- Disband Encampment Prompt
playerGroupWindow["member_list_destroygroup_reclick_window"] = guiCreateWindow(0.25,0.2,0.5,0.6,"Disband Encampment?",true)
guiSetVisible(playerGroupWindow["member_list_destroygroup_reclick_window"],false)
playerGroupWindow["member_list_destroygroup_reclick_yes"] = guiCreateButton(0.2,0.675,0.2,0.2, "Yes", true, playerGroupWindow["member_list_destroygroup_reclick_window"] )
playerGroupWindow["member_list_destroygroup_reclick_cancel"] = guiCreateButton(0.6,0.675,0.2,0.2, "Cancel", true, playerGroupWindow["member_list_destroygroup_reclick_window"] )
playerGroupWindow["member_list_destroygroup_reclick_text"] = guiCreateLabel(0.05,0.1,0.95,0.3,"Do you really wish to disband your encampment?",true,playerGroupWindow["member_list_destroygroup_reclick_window"])
guiSetFont (playerGroupWindow["member_list_destroygroup_reclick_text"], "default-bold-small" )

--Player Invitation List
playerGroupWindow["invite_member_list_window"] = guiCreateWindow(0.25,0.2,0.5,0.6,"Select Player",true)
guiSetVisible(playerGroupWindow["invite_member_list_window"],false)
playerGroupWindow["invite_member_list"] = guiCreateGridList ( 0.025,0.05,0.95,0.65,true,playerGroupWindow["invite_member_list_window"])
playerGroupWindow["invite_member_list_name"] = guiGridListAddColumn( playerGroupWindow["invite_member_list"], "Name", 1 )
playerGroupWindow["invite_member_list_invite"] = guiCreateButton(0.2,0.775,0.6,0.15, "Invite Player", true, playerGroupWindow["invite_member_list_window"] )

-- Error Windows
playerGroupWindow["error_selectplayer"] = guiCreateWindow(0.34, 0.37, 0.31, 0.22, "Error", true)
guiSetVisible(playerGroupWindow["error_selectplayer"],false)
guiWindowSetMovable(playerGroupWindow["error_selectplayer"], false)
guiWindowSetSizable(playerGroupWindow["error_selectplayer"], false)
playerGroupWindow["error_selectplayer_label1"] = guiCreateLabel(0.26, 0.26, 0.50, 0.11, "Please select a player!", true, playerGroupWindow["error_selectplayer"])
playerGroupWindow["error_selectplayer_ok"] = guiCreateButton(0.37, 0.59, 0.25, 0.27, "OK", true, playerGroupWindow["error_selectplayer"])

playerGroupWindow["error_cannotchangerank"] = guiCreateWindow(0.34, 0.37, 0.31, 0.22, "Error", true)
guiSetVisible(playerGroupWindow["error_cannotchangerank"],false)
guiWindowSetMovable(playerGroupWindow["error_cannotchangerank"], false)
guiWindowSetSizable(playerGroupWindow["error_cannotchangerank"], false)
playerGroupWindow["error_cannotchangerank_label1"] = guiCreateLabel(0.26, 0.26, 0.50, 0.11, "Cannot change rank!", true, playerGroupWindow["error_cannotchangerank"])
playerGroupWindow["error_cannotchangerank_ok"] = guiCreateButton(0.37, 0.59, 0.25, 0.27, "OK", true, playerGroupWindow["error_cannotchangerank"])

playerGroupWindow["error_insufficientpermission"] = guiCreateWindow(0.34, 0.37, 0.31, 0.22, "Error", true)
guiSetVisible(playerGroupWindow["error_insufficientpermission"],false)
guiWindowSetMovable(playerGroupWindow["error_insufficientpermission"], false)
guiWindowSetSizable(playerGroupWindow["error_insufficientpermission"], false)
playerGroupWindow["error_insufficientpermission_label1"] = guiCreateLabel(0.26, 0.26, 0.50, 0.11, "Insufficient permission!", true, playerGroupWindow["error_insufficientpermission"])
playerGroupWindow["error_insufficientpermission_ok"] = guiCreateButton(0.37, 0.59, 0.25, 0.27, "OK", true, playerGroupWindow["error_insufficientpermission"])

playerGroupWindow["error_selectrank"] = guiCreateWindow(0.34, 0.37, 0.31, 0.22, "Error", true)
guiSetVisible(playerGroupWindow["error_selectrank"],false)
guiWindowSetMovable(playerGroupWindow["error_selectrank"], false)
guiWindowSetSizable(playerGroupWindow["error_selectrank"], false)
playerGroupWindow["error_selectrank_label1"] = guiCreateLabel(0.26, 0.26, 0.50, 0.11, "Insufficient permission!", true, playerGroupWindow["error_selectrank"])
playerGroupWindow["error_selectrank_ok"] = guiCreateButton(0.37, 0.59, 0.25, 0.27, "OK", true, playerGroupWindow["error_selectrank"])

playerGroupWindow["error_nextversion"] = guiCreateWindow(0.34, 0.37, 0.31, 0.22, "Error", true)
guiSetVisible(playerGroupWindow["error_nextversion"],false)
guiWindowSetMovable(playerGroupWindow["error_nextversion"], false)
guiWindowSetSizable(playerGroupWindow["error_nextversion"], false)
playerGroupWindow["error_nextversion_label1"] = guiCreateLabel(0.26, 0.26, 0.50, 0.11, "This feature is not available!", true, playerGroupWindow["error_selectrank"])
playerGroupWindow["error_nextversion_ok"] = guiCreateButton(0.37, 0.59, 0.25, 0.27, "OK", true, playerGroupWindow["error_selectrank"])

playerGroupWindow["error_notloggedin"] = guiCreateWindow(0.34, 0.37, 0.31, 0.22, "Error", true)
guiSetVisible(playerGroupWindow["error_notloggedin"],false)
guiWindowSetMovable(playerGroupWindow["error_notloggedin"], false)
guiWindowSetSizable(playerGroupWindow["error_notloggedin"], false)
playerGroupWindow["error_notloggedin_label1"] = guiCreateLabel(0.26, 0.26, 0.50, 0.11, "Player is not logged in!", true, playerGroupWindow["error_selectrank"])
playerGroupWindow["error_notloggedin_ok"] = guiCreateButton(0.37, 0.59, 0.25, 0.27, "OK", true, playerGroupWindow["error_selectrank"])

function openPlayerGroupWindow ()
	if not getElementData(getLocalPlayer(),"gang") == "logedin" then return end
	local showing = guiGetVisible(playerGroupWindow["window"])
	if showing == false then
		if isPlayerKeySpamming() then return end
		triggerServerEvent("refreshClientGangList", localPlayer)
		guiSetVisible(playerGroupWindow["member_window"],false)
		guiSetVisible(playerGroupWindow["invite_member_list_window"],false)
	end
	guiSetVisible(playerGroupWindow["window"],not showing)
	showCursor(not showing)
end
bindKey("F1","down",openPlayerGroupWindow)

function openMemberGroupWindow ()
	if getElementData(getLocalPlayer(),"gang") == "None" then return end
	local showing = guiGetVisible(playerGroupWindow["member_window"])
	if showing == false then
		--if isPlayerKeySpamming() then return end
		guiSetVisible(playerGroupWindow["window"],false)
		refreshGangMemberTable()
	else
		guiSetVisible(playerGroupWindow["invite_member_list_window"],false)
	end
	guiSetVisible(playerGroupWindow["member_window"],not showing)
	showCursor(not showing)
	refreshGangMemberTable()
end
bindKey("F2","down",openMemberGroupWindow)

function refreshGangList (ganglist)
	guiGridListClear(playerGroupWindow["grouplist"])
	for i, group in ipairs(ganglist) do
		local row = guiGridListAddRow ( playerGroupWindow["grouplist"] )
		guiGridListSetItemText ( playerGroupWindow["grouplist"], row, playerGroupWindow["grouplist_groupname"], group[1], false, false )
		guiGridListSetItemText ( playerGroupWindow["grouplist"], row, playerGroupWindow["grouplist_groupleader"],group[2] , false, false )
		guiGridListSetItemText ( playerGroupWindow["grouplist"], row, playerGroupWindow["grouplist_groupmember"],group[3].."/"..group[4] , false, false )
		if group[4] > 12 then
			guiGridListSetItemColor ( playerGroupWindow["grouplist"], row, playerGroupWindow["grouplist_groupname"], 22, 255, 22 )
			guiGridListSetItemColor ( playerGroupWindow["grouplist"], row, playerGroupWindow["grouplist_groupleader"], 22, 255, 22 )
			guiGridListSetItemColor ( playerGroupWindow["grouplist"], row, playerGroupWindow["grouplist_groupmember"], 22, 255, 22 )
		end
	end	
	refreshPlayerInvites()
end
addEvent("refreshGangListToClient", true)
addEventHandler("refreshGangListToClient", root, refreshGangList)

--Actions
function refreshGangMemberTable()
	triggerServerEvent("refreshPlayerGangMemberList",getLocalPlayer())
end 

function refreshGangMemberTable2 (gangtable)	
	guiGridListClear(playerGroupWindow["member_list"])
	guiGridListClear(playerGroupWindow["member_list_rank_gridlist"])
	for i, gangmember in ipairs(gangtable) do
		local row = guiGridListAddRow ( playerGroupWindow["member_list"] )
		local row2 = guiGridListAddRow (playerGroupWindow["member_list_rank_gridlist"])
		local player = gangmember[4]
		if gangmember[2] then
			gangmember[1] = gangmember[1].." (Leader)"
		else
			gangmember[1] = gangmember[1]
		end
		--[[
		if gangmember[3] then
			guiGridListSetItemText ( playerGroupWindow["member_list"], row, playerGroupWindow["member_list_alivetime"],getElementData(player,"online") , false, false )
			guiGridListSetItemText ( playerGroupWindow["member_list"], row, playerGroupWindow["member_list_murders"], getElementData(player,"murders"), false, false )
			guiGridListSetItemText ( playerGroupWindow["member_list"], row, playerGroupWindow["member_list_daysonline"],getElementData(player,"alivetime") , false, false )
			guiGridListSetItemText ( playerGroupWindow["member_list"], row, playerGroupWindow["member_list_alivetime"],getElementData(player,"alivetime") , false, false )
			guiGridListSetItemText ( playerGroupWindow["member_list"], row, playerGroupWindow["member_list_alivetime"],getElementData(player,"alivetime") , false, false )
			guiGridListSetItemText ( playerGroupWindow["member_list"], row, playerGroupWindow["member_list_alivetime"],getElementData(player,"alivetime") , false, false )
			guiGridListSetItemText ( playerGroupWindow["member_list"], row, playerGroupWindow["member_list_alivetime"],getElementData(player,"alivetime") , false, false )
			guiGridListSetItemText ( playerGroupWindow["member_list"], row, playerGroupWindow["member_list_alivetime"],getElementData(player,"alivetime") , false, false )
		else
			guiGridListSetItemText ( playerGroupWindow["member_list"], row, playerGroupWindow["member_list_murders"], "-", false, false )
			guiGridListSetItemText ( playerGroupWindow["member_list"], row, playerGroupWindow["member_list_alivetime"],"-" , false, false )
			guiGridListSetItemText ( playerGroupWindow["member_list"], row, playerGroupWindow["member_list_movestate"],"-" , false, false )
		end
		]]
		
		if not getElementData(player,"logedin") then
			r,g,b = 255,22,22
		else
			r,g,b = 22,255,22
		end
		guiGridListSetItemText ( playerGroupWindow["member_list"], row,playerGroupWindow["member_list_names"], gangmember[1], false, false )
		guiGridListSetItemColor ( playerGroupWindow["member_list"], row, playerGroupWindow["member_list_names"], r, g, b )
		
		guiGridListSetItemText (playerGroupWindow["member_list_rank_gridlist"], row2,playerGroupWindow["member_list_names"], gangmember[1], false, false )
	end	
end
addEvent("refreshGangMemberTableToClient", true)
addEventHandler("refreshGangMemberTableToClient", root, refreshGangMemberTable2)

function refreshPlayerInvites()
	triggerServerEvent("refreshPlayerInvite",getLocalPlayer())
end

function updatePlayerInvites(name,inviter,member,vip)
	guiGridListClear(playerGroupWindow["groupinvitelist"])
	local row = guiGridListAddRow ( playerGroupWindow["groupinvitelist"])
	guiGridListSetItemText ( playerGroupWindow["groupinvitelist"], row, playerGroupWindow["groupinvitelist_groupname"],name, false, false )
	guiGridListSetItemText ( playerGroupWindow["groupinvitelist"], row, playerGroupWindow["groupinvitelist_groupinviter"],inviter, false, false )
	guiGridListSetItemText ( playerGroupWindow["groupinvitelist"], row, playerGroupWindow["groupinvitelist_groupmember"],member, false, false )
	if vip > 12 then
		guiGridListSetItemText ( playerGroupWindow["groupinvitelist"], row, playerGroupWindow["groupinvitelist_groupvip"],"YES", false, false )
	else
		guiGridListSetItemText ( playerGroupWindow["groupinvitelist"], row, playerGroupWindow["groupinvitelist_groupvip"],"NO", false, false )
	end	
end
addEvent("updatePlayerInvites",true)
addEventHandler("updatePlayerInvites",getRootElement(),updatePlayerInvites)

function removePlayerInvites()
	guiGridListClear(playerGroupWindow["groupinvitelist"])
end
addEvent("removePlayerInvites",true)
addEventHandler("removePlayerInvites",getRootElement(),removePlayerInvites)

function refreshPlayerInviteList ()
	guiGridListClear(playerGroupWindow["invite_member_list"])
	for i, player in ipairs(getElementsByType("player")) do
		if getElementData(player,"gang") == "None" then
			local row = guiGridListAddRow ( playerGroupWindow["invite_member_list"] )
			guiGridListSetItemText ( playerGroupWindow["invite_member_list"], row, playerGroupWindow["invite_member_list_name"],getPlayerName(player), false, false )
		end
	end
end

function setPerms()
	triggerServerEvent("setPermissionsFirstTime",localPlayer)
end
addCommandHandler("sets",setPerms)

function check()
local playerName = guiGridListGetItemText(playerGroupWindow["member_list"],guiGridListGetSelectedItem (playerGroupWindow["member_list"]),1)
	if guiGridListGetItemText(playerGroupWindow["member_list"], guiGridListGetSelectedItem(playerGroupWindow["member_list"]), 1) ~= "" then
		--guiSetEnabled(w.button.zone,true)
		onlinestatus = getElementData(getPlayerFromName(playerName),"logedin")
		daysalive = getElementData(getPlayerFromName(playerName),"daysalive")
		x,y,z = getElementPosition(getPlayerFromName(playerName))
		location = getZoneName(x,y,z)
		murders = getElementData(getPlayerFromName(playerName),"murders")
 		bandit = getElementData(getPlayerFromName(playerName),"bandit")
 		humanity = getElementData(getPlayerFromName(playerName),"humanity")
		group_rank = getElementData(getPlayerFromName(playerName),"group_rank")
		timesdied = getElementData(getPlayerFromName(playerName),"timesdied")

			if onlinestatus then
				guiSetText(playerGroupWindow["member_list_online_1"],"Online")
				guiLabelSetColor(playerGroupWindow["member_list_online_1"],0,255,0)
			else
				guiSetText(playerGroupWindow["member_list_online_1"],"Offline")
				guiLabelSetColor(playerGroupWindow["member_list_online_1"],255,0,0)
			end

		guiSetText(playerGroupWindow["member_list_daysalive_1"],daysalive)
		guiSetText(playerGroupWindow["member_list_location_1"],location)
		guiSetText(playerGroupWindow["member_list_murders_1"],murders)
		guiSetText(playerGroupWindow["member_list_bandits_1"],bandit)
		guiSetText(playerGroupWindow["member_list_humanity_1"],humanity)
		guiSetText(playerGroupWindow["member_list_rank_1"],group_rank)
		guiSetText(playerGroupWindow["member_list_timesdied_1"],timesdied)
	end
end

function checkForPermissions()
local item = guiComboBoxGetSelected(playerGroupWindow["member_list_manage_permissions_combobox"])
local text = guiComboBoxGetItemText(playerGroupWindow["member_list_manage_permissions_combobox"], item)
local teamName = getElementData(localPlayer,"gang")
local doesSaveExist = getElementData(localPlayer,"OldSave")

end
addEventHandler("onClientGUIClick",playerGroupWindow["member_list_manage_permissions_combobox"],checkForPermissions,false)

function addPermission()
local rank = guiComboBoxGetSelected(playerGroupWindow["member_list_manage_permissions_combobox"])
local text = guiComboBoxGetItemText(playerGroupWindow["member_list_manage_permissions_combobox"], rank)
local permission = guiComboBoxGetSelected(playerGroupWindow["member_list_manage_permissions_combobox_perms"])
local permissiontext = guiComboBoxGetItemText(playerGroupWindow["member_list_manage_permissions_combobox_perms"], permission)
	if text == "Leader" then
		if permissiontext == "Ruler: Can edit permissions and set MOTD" then
			setElementData(localPlayer,"isRuler",true)
		elseif permissiontext == "Recruiter: Can invite other players" then
			setElementData(localPlayer,"isRecruiter",true)
		elseif permissiontext == "Regulator: Can kick other members" then
			setElementData(localPlayer,"isRegulator",true)
		elseif permissiontext == "Promoter: Can promote players" then
			setElementData(localPlayer,"isPromoter",true)
		elseif permissiontext == "Architect: Can build & destroy buildings at encampment" then
			setElementData(localPlayer,"isArchitect",true)
		elseif permissiontext == "Treasurer: Can access Encampment Vault" then
			setElementData(localPlayer,"isTreasurer",true)
		elseif permissiontext == "Tech: Can queue research projects" then
			setElementData(localPlayer,"isTech",true)
		elseif permissiontext == "Tactician: Can deploy, rearrange and destroy barricades, soldiers etc." then
			setElementData(localPlayer,"isTactician",true)
		end
	elseif text == "Co-Leader" then
		if permissiontext == "Ruler: Can edit permissions and set MOTD" then
			setElementData(localPlayer,"isRuler",true)
		elseif permissiontext == "Recruiter: Can invite other players" then
			setElementData(localPlayer,"isRecruiter",true)
		elseif permissiontext == "Regulator: Can kick other members" then
			setElementData(localPlayer,"isRegulator",true)
		elseif permissiontext == "Promoter: Can promote players" then
			setElementData(localPlayer,"isPromoter",true)
		elseif permissiontext == "Architect: Can build & destroy buildings at encampment" then
			setElementData(localPlayer,"isArchitect",true)
		elseif permissiontext == "Treasurer: Can access Encampment Vault" then
			setElementData(localPlayer,"isTreasurer",true)
		elseif permissiontext == "Tech: Can queue research projects" then
			setElementData(localPlayer,"isTech",true)
		elseif permissiontext == "Tactician: Can deploy, rearrange and destroy barricades, soldiers etc." then
			setElementData(localPlayer,"isTactician",true)
		end
	elseif text == "General" then
		if permissiontext == "Ruler: Can edit permissions and set MOTD" then
			setElementData(localPlayer,"isRuler",true)
		elseif permissiontext == "Recruiter: Can invite other players" then
			setElementData(localPlayer,"isRecruiter",true)
		elseif permissiontext == "Regulator: Can kick other members" then
			setElementData(localPlayer,"isRegulator",true)
		elseif permissiontext == "Promoter: Can promote players" then
			setElementData(localPlayer,"isPromoter",true)
		elseif permissiontext == "Architect: Can build & destroy buildings at encampment" then
			setElementData(localPlayer,"isArchitect",true)
		elseif permissiontext == "Treasurer: Can access Encampment Vault" then
			setElementData(localPlayer,"isTreasurer",true)
		elseif permissiontext == "Tech: Can queue research projects" then
			setElementData(localPlayer,"isTech",true)
		elseif permissiontext == "Tactician: Can deploy, rearrange and destroy barricades, soldiers etc." then
			setElementData(localPlayer,"isTactician",true)
		end
	elseif text == "Officer" then
		if permissiontext == "Ruler: Can edit permissions and set MOTD" then
			setElementData(localPlayer,"isRuler",true)
		elseif permissiontext == "Recruiter: Can invite other players" then
			setElementData(localPlayer,"isRecruiter",true)
		elseif permissiontext == "Regulator: Can kick other members" then
			setElementData(localPlayer,"isRegulator",true)
		elseif permissiontext == "Promoter: Can promote players" then
			setElementData(localPlayer,"isPromoter",true)
		elseif permissiontext == "Architect: Can build & destroy buildings at encampment" then
			setElementData(localPlayer,"isArchitect",true)
		elseif permissiontext == "Treasurer: Can access Encampment Vault" then
			setElementData(localPlayer,"isTreasurer",true)
		elseif permissiontext == "Tech: Can queue research projects" then
			setElementData(localPlayer,"isTech",true)
		elseif permissiontext == "Tactician: Can deploy, rearrange and destroy barricades, soldiers etc." then
			setElementData(localPlayer,"isTactician",true)
		end
	elseif text == "Soldier" then
		if permissiontext == "Ruler: Can edit permissions and set MOTD" then
			setElementData(localPlayer,"isRuler",true)
		elseif permissiontext == "Recruiter: Can invite other players" then
			setElementData(localPlayer,"isRecruiter",true)
		elseif permissiontext == "Regulator: Can kick other members" then
			setElementData(localPlayer,"isRegulator",true)
		elseif permissiontext == "Promoter: Can promote players" then
			setElementData(localPlayer,"isPromoter",true)
		elseif permissiontext == "Architect: Can build & destroy buildings at encampment" then
			setElementData(localPlayer,"isArchitect",true)
		elseif permissiontext == "Treasurer: Can access Encampment Vault" then
			setElementData(localPlayer,"isTreasurer",true)
		elseif permissiontext == "Tech: Can queue research projects" then
			setElementData(localPlayer,"isTech",true)
		elseif permissiontext == "Tactician: Can deploy, rearrange and destroy barricades, soldiers etc." then
			setElementData(localPlayer,"isTactician",true)
		end
	elseif text == "Survivor" then
		if permissiontext == "Ruler: Can edit permissions and set MOTD" then
			setElementData(localPlayer,"isRuler",true)
		elseif permissiontext == "Recruiter: Can invite other players" then
			setElementData(localPlayer,"isRecruiter",true)
		elseif permissiontext == "Regulator: Can kick other members" then
			setElementData(localPlayer,"isRegulator",true)
		elseif permissiontext == "Promoter: Can promote players" then
			setElementData(localPlayer,"isPromoter",true)
		elseif permissiontext == "Architect: Can build & destroy buildings at encampment" then
			setElementData(localPlayer,"isArchitect",true)
		elseif permissiontext == "Treasurer: Can access Encampment Vault" then
			setElementData(localPlayer,"isTreasurer",true)
		elseif permissiontext == "Tech: Can queue research projects" then
			setElementData(localPlayer,"isTech",true)
		elseif permissiontext == "Tactician: Can deploy, rearrange and destroy barricades, soldiers etc." then
			setElementData(localPlayer,"isTactician",true)
		end
	elseif text == "Bandit" then
		if permissiontext == "Ruler: Can edit permissions and set MOTD" then
			setElementData(localPlayer,"isRuler",true)
		elseif permissiontext == "Recruiter: Can invite other players" then
			setElementData(localPlayer,"isRecruiter",true)
		elseif permissiontext == "Regulator: Can kick other members" then
			setElementData(localPlayer,"isRegulator",true)
		elseif permissiontext == "Promoter: Can promote players" then
			setElementData(localPlayer,"isPromoter",true)
		elseif permissiontext == "Architect: Can build & destroy buildings at encampment" then
			setElementData(localPlayer,"isArchitect",true)
		elseif permissiontext == "Treasurer: Can access Encampment Vault" then
			setElementData(localPlayer,"isTreasurer",true)
		elseif permissiontext == "Tech: Can queue research projects" then
			setElementData(localPlayer,"isTech",true)
		elseif permissiontext == "Tactician: Can deploy, rearrange and destroy barricades, soldiers etc." then
			setElementData(localPlayer,"isTactician",true)
		end
	end
end
addEventHandler("onClientGUIClick",playerGroupWindow["member_list_manage_permissions_add"],addPermission,false)

function removePermission()
local rank = guiComboBoxGetSelected(playerGroupWindow["member_list_manage_permissions_combobox"])
local text = guiComboBoxGetItemText(playerGroupWindow["member_list_manage_permissions_combobox"], rank)
local permission = guiComboBoxGetSelected(playerGroupWindow["member_list_manage_permissions_combobox_perms"])
local permissiontext = guiComboBoxGetItemText(playerGroupWindow["member_list_manage_permissions_combobox_perms"], permission)
	if text == "Leader" then
		if permissiontext == "Ruler: Can edit permissions and set MOTD" then
			setElementData(localPlayer,"isRuler",false)
		elseif permissiontext == "Recruiter: Can invite other players" then
			setElementData(localPlayer,"isRecruiter",false)
		elseif permissiontext == "Regulator: Can kick other members" then
			setElementData(localPlayer,"isRegulator",false)
		elseif permissiontext == "Promoter: Can promote players" then
			setElementData(localPlayer,"isPromoter",false)
		elseif permissiontext == "Architect: Can build & destroy buildings at encampment" then
			setElementData(localPlayer,"isArchitect",false)
		elseif permissiontext == "Treasurer: Can access Encampment Vault" then
			setElementData(localPlayer,"isTreasurer",false)
		elseif permissiontext == "Tech: Can queue research projects" then
			setElementData(localPlayer,"isTech",false)
		elseif permissiontext == "Tactician: Can deploy, rearrange and destroy barricades, soldiers etc." then
			setElementData(localPlayer,"isTactician",false)
		end
	elseif text == "Co-Leader" then
		if permissiontext == "Ruler: Can edit permissions and set MOTD" then
			setElementData(localPlayer,"isRuler",false)
		elseif permissiontext == "Recruiter: Can invite other players" then
			setElementData(localPlayer,"isRecruiter",false)
		elseif permissiontext == "Regulator: Can kick other members" then
			setElementData(localPlayer,"isRegulator",false)
		elseif permissiontext == "Promoter: Can promote players" then
			setElementData(localPlayer,"isPromoter",false)
		elseif permissiontext == "Architect: Can build & destroy buildings at encampment" then
			setElementData(localPlayer,"isArchitect",false)
		elseif permissiontext == "Treasurer: Can access Encampment Vault" then
			setElementData(localPlayer,"isTreasurer",false)
		elseif permissiontext == "Tech: Can queue research projects" then
			setElementData(localPlayer,"isTech",false)
		elseif permissiontext == "Tactician: Can deploy, rearrange and destroy barricades, soldiers etc." then
			setElementData(localPlayer,"isTactician",false)
		end
	elseif text == "General" then
		if permissiontext == "Ruler: Can edit permissions and set MOTD" then
			setElementData(localPlayer,"isRuler",false)
		elseif permissiontext == "Recruiter: Can invite other players" then
			setElementData(localPlayer,"isRecruiter",false)
		elseif permissiontext == "Regulator: Can kick other members" then
			setElementData(localPlayer,"isRegulator",false)
		elseif permissiontext == "Promoter: Can promote players" then
			setElementData(localPlayer,"isPromoter",false)
		elseif permissiontext == "Architect: Can build & destroy buildings at encampment" then
			setElementData(localPlayer,"isArchitect",false)
		elseif permissiontext == "Treasurer: Can access Encampment Vault" then
			setElementData(localPlayer,"isTreasurer",false)
		elseif permissiontext == "Tech: Can queue research projects" then
			setElementData(localPlayer,"isTech",false)
		elseif permissiontext == "Tactician: Can deploy, rearrange and destroy barricades, soldiers etc." then
			setElementData(localPlayer,"isTactician",false)
		end
	elseif text == "Officer" then
		if permissiontext == "Ruler: Can edit permissions and set MOTD" then
			setElementData(localPlayer,"isRuler",false)
		elseif permissiontext == "Recruiter: Can invite other players" then
			setElementData(localPlayer,"isRecruiter",false)
		elseif permissiontext == "Regulator: Can kick other members" then
			setElementData(localPlayer,"isRegulator",false)
		elseif permissiontext == "Promoter: Can promote players" then
			setElementData(localPlayer,"isPromoter",false)
		elseif permissiontext == "Architect: Can build & destroy buildings at encampment" then
			setElementData(localPlayer,"isArchitect",false)
		elseif permissiontext == "Treasurer: Can access Encampment Vault" then
			setElementData(localPlayer,"isTreasurer",false)
		elseif permissiontext == "Tech: Can queue research projects" then
			setElementData(localPlayer,"isTech",false)
		elseif permissiontext == "Tactician: Can deploy, rearrange and destroy barricades, soldiers etc." then
			setElementData(localPlayer,"isTactician",false)
		end
	elseif text == "Soldier" then
		if permissiontext == "Ruler: Can edit permissions and set MOTD" then
			setElementData(localPlayer,"isRuler",false)
		elseif permissiontext == "Recruiter: Can invite other players" then
			setElementData(localPlayer,"isRecruiter",false)
		elseif permissiontext == "Regulator: Can kick other members" then
			setElementData(localPlayer,"isRegulator",false)
		elseif permissiontext == "Promoter: Can promote players" then
			setElementData(localPlayer,"isPromoter",false)
		elseif permissiontext == "Architect: Can build & destroy buildings at encampment" then
			setElementData(localPlayer,"isArchitect",false)
		elseif permissiontext == "Treasurer: Can access Encampment Vault" then
			setElementData(localPlayer,"isTreasurer",false)
		elseif permissiontext == "Tech: Can queue research projects" then
			setElementData(localPlayer,"isTech",false)
		elseif permissiontext == "Tactician: Can deploy, rearrange and destroy barricades, soldiers etc." then
			setElementData(localPlayer,"isTactician",false)
		end
	elseif text == "Survivor" then
		if permissiontext == "Ruler: Can edit permissions and set MOTD" then
			setElementData(localPlayer,"isRuler",false)
		elseif permissiontext == "Recruiter: Can invite other players" then
			setElementData(localPlayer,"isRecruiter",false)
		elseif permissiontext == "Regulator: Can kick other members" then
			setElementData(localPlayer,"isRegulator",false)
		elseif permissiontext == "Promoter: Can promote players" then
			setElementData(localPlayer,"isPromoter",false)
		elseif permissiontext == "Architect: Can build & destroy buildings at encampment" then
			setElementData(localPlayer,"isArchitect",false)
		elseif permissiontext == "Treasurer: Can access Encampment Vault" then
			setElementData(localPlayer,"isTreasurer",false)
		elseif permissiontext == "Tech: Can queue research projects" then
			setElementData(localPlayer,"isTech",false)
		elseif permissiontext == "Tactician: Can deploy, rearrange and destroy barricades, soldiers etc." then
			setElementData(localPlayer,"isTactician",false)
		end
	elseif text == "Bandit" then
		if permissiontext == "Ruler: Can edit permissions and set MOTD" then
			setElementData(localPlayer,"isRuler",false)
		elseif permissiontext == "Recruiter: Can invite other players" then
			setElementData(localPlayer,"isRecruiter",false)
		elseif permissiontext == "Regulator: Can kick other members" then
			setElementData(localPlayer,"isRegulator",false)
		elseif permissiontext == "Promoter: Can promote players" then
			setElementData(localPlayer,"isPromoter",false)
		elseif permissiontext == "Architect: Can build & destroy buildings at encampment" then
			setElementData(localPlayer,"isArchitect",false)
		elseif permissiontext == "Treasurer: Can access Encampment Vault" then
			setElementData(localPlayer,"isTreasurer",false)
		elseif permissiontext == "Tech: Can queue research projects" then
			setElementData(localPlayer,"isTech",false)
		elseif permissiontext == "Tactician: Can deploy, rearrange and destroy barricades, soldiers etc." then
			setElementData(localPlayer,"isTactician",false)
		end
	end
end
addEventHandler("onClientGUIClick",playerGroupWindow["member_list_manage_permissions_remove"],removePermission,false)

function savePermissionsClient()
triggerServerEvent("savePermissions",localPlayer)
end
addEventHandler("onClientGUIClick",playerGroupWindow["member_list_manage_permissions_combobox_confirm"],savePermissionsClient)

function playerGroupSystemButton (button,state)
if not button == "mouse1" and not state == "down" then return end
if source == playerGroupWindow["groupinvite_accept"] then
	triggerServerEvent("acceptGroupInvite",getLocalPlayer())
	guiGridListClear(playerGroupWindow["groupinvitelist"])
	guiSetVisible(playerGroupWindow["window"],false)
	showCursor(false)
elseif source == playerGroupWindow["member_list_destroygroup"] then
	guiSetVisible(playerGroupWindow["member_list_destroygroup_reclick_window"],true)
	guiBringToFront(playerGroupWindow["member_list_destroygroup_reclick_window"])
elseif source == playerGroupWindow["member_list_destroygroup_reclick_yes"] then
	triggerServerEvent("destroyGroup",getLocalPlayer())
	guiSetVisible(playerGroupWindow["member_list_destroygroup_reclick_window"],false)
	guiSetVisible(playerGroupWindow["member_window"],false)
	showCursor(false)
elseif source == playerGroupWindow["member_list_destroygroup_reclick_cancel"] then
	guiSetVisible(playerGroupWindow["member_list_destroygroup_reclick_window"],false)
elseif source == playerGroupWindow["member_list_leavegang"] then
	triggerServerEvent("leaveGroup",getLocalPlayer())
	guiSetVisible(playerGroupWindow["member_window"],false)
	showCursor(false)
elseif source == playerGroupWindow["member_list_inviteplayer"] then
	guiSetVisible(playerGroupWindow["invite_member_list_window"],true)
	guiBringToFront(playerGroupWindow["invite_member_list_window"])
	refreshPlayerInviteList()
elseif source == playerGroupWindow["invite_member_list_invite"] then
	local playerName = guiGridListGetItemText ( playerGroupWindow["invite_member_list"], guiGridListGetSelectedItem ( playerGroupWindow["invite_member_list"] ), 1 )
	triggerServerEvent("invitePlayerToGroup",getLocalPlayer(),playerName)
	guiSetVisible(playerGroupWindow["invite_member_list_window"],true)
elseif source == playerGroupWindow["member_list_kickplayer"] then
	local playerName = guiGridListGetItemText ( playerGroupWindow["member_list"], guiGridListGetSelectedItem ( playerGroupWindow["member_list"] ), 1 )
	triggerServerEvent("kickGroupMember",getLocalPlayer(),playerName)
	guiSetVisible(playerGroupWindow["member_window"],false)
	showCursor(false)
elseif source == playerGroupWindow["member_list_groupvault"] then
	guiSetVisible(playerGroupWindow["groupvault_window"],true)
	guiBringToFront(playerGroupWindow["groupvault_window"])
elseif source == playerGroupWindow["member_list_quests"] then
	guiSetVisible(playerGroupWindow["groupquests_window"],true)
	guiBringToFront(playerGroupWindow["groupquests_window"])
elseif source == playerGroupWindow["member_list_assignrank"] then
	guiSetVisible(playerGroupWindow["member_list_rank_window"],true)
	guiBringToFront(playerGroupWindow["member_list_rank_window"])
elseif source == playerGroupWindow["member_list_rank_giverank"] then
	if (guiGridListGetSelectedItem(playerGroupWindow["member_list_rank_gridlist"]) == -1) then
		guiSetVisible(playerGroupWindow["error_selectplayer"],true)
		guiBringToFront(playerGroupWindow["error_selectplayer"])
	else
		local playerName = guiGridListGetItemText (playerGroupWindow["member_list_rank_gridlist"], guiGridListGetSelectedItem (playerGroupWindow["member_list_rank_gridlist"]), 1 )
		if string.find(playerName,"(Leader)") then
			guiSetVisible(playerGroupWindow["error_cannotchangerank"],true)
			guiBringToFront(playerGroupWindow["error_cannotchangerank"])
		else
			setElementData(localPlayer,"selectedMember",playerName)
			--local rank = getElementData(getPlayerFromName(playerName),"group_rank")
			guiSetVisible(playerGroupWindow["member_list_rank_assign"],true)
			guiBringToFront(playerGroupWindow["member_list_rank_assign"])
			--guiSetText(playerGroupWindow["member_list_rank_combobox_label2"],rank)
		end
	end
elseif source == playerGroupWindow["member_list_rank_managepermissions"] then
	--[[	if getElementData(localPlayer,"isRuler") then
			guiSetVisible(playerGroupWindow["member_list_manage_permissions"],true)
			guiBringToFront(playerGroupWindow["member_list_manage_permissions"])
		else
			guiSetVisible(playerGroupWindow["error_insufficientpermission"],true)
			guiBringToFront(playerGroupWindow["error_insufficientpermission"])
		end
		]]
		outputChatBox("Will be available in the next version!",255,0,0)
elseif source == playerGroupWindow["member_list_encampmentstatus"] then
	guiSetVisible(playerGroupWindow["member_list_encampmentstatus_window"],true)
	guiBringToFront(playerGroupWindow["member_list_encampmentstatus_window"])
elseif source == playerGroupWindow["member_list_rank_closebutton"] then
	guiSetVisible(playerGroupWindow["member_list_rank_window"],false)
elseif source == playerGroupWindow["member_list_rank_combobox_cancel"] then
	guiSetVisible(playerGroupWindow["member_list_rank_assign"],false)
elseif source == playerGroupWindow["member_list_rank_combobox_confirm"] then
	triggerServerEvent("convertAccountToPlayerName",localPlayer)
	local item = guiComboBoxGetSelected(playerGroupWindow["member_list_rank_combobox"])
	local text = guiComboBoxGetItemText(playerGroupWindow["member_list_rank_combobox"], item)
	local isRuler = getElementData(localPlayer,"isRuler")
	local getName = getElementData(localPlayer,"selectedMember")
		if text ~= " " then
			if isRuler then
				if getName then
					guiSetVisible(playerGroupWindow["error_selectrank"],true)
					guiBringToFront(playerGroupWindow["error_selectrank"])
				else
					setElementData(getPlayerFromName(getName),"group_rank",text)
					outputDebugString("Group Rank has been set: "..getName)
					triggerServerEvent("saveRankToPlayer",localPlayer)
				end
			else
				guiSetVisible(playerGroupWindow["error_insufficientpermission"],true)
				guiBringToFront(playerGroupWindow["error_insufficientpermission"])
			end
		else
			guiSetVisible(playerGroupWindow["error_selectrank"],true)
			guiBringToFront(playerGroupWindow["error_selectrank"])
		end
elseif source == playerGroupWindow["member_list_manage_permissions_combobox_cancel"] then
	guiSetVisible(playerGroupWindow["member_list_manage_permissions"],false)
elseif source == playerGroupWindow["member_list_manage_permissions_combobox_confirm"] then
	guiSetVisible(playerGroupWindow["member_list_manage_permissions"],false)
elseif source == playerGroupWindow["error_cannotchangerank_ok"] then
	guiSetVisible(playerGroupWindow["error_cannotchangerank"],false)
elseif source == playerGroupWindow["error_selectplayer_ok"] then
	guiSetVisible(playerGroupWindow["error_selectplayer"],false)
elseif source == playerGroupWindow["error_selectrank_ok"] then
	guiSetVisible(playerGroupWindow["error_selectrank"],false)
elseif source == playerGroupWindow["error_insufficientpermission_ok"] then
	guiSetVisible(playerGroupWindow["error_insufficientpermission"],false)
elseif source == playerGroupWindow["error_nextversion_ok"] then
	guiSetVisible(playerGroupWindow["error_nextversion"],false)
elseif source == playerGroupWindow["error_notloggedin_ok"] then
	guiSetVisible(playerGroupWindow["error_notloggedin"],false)
end
end
addEventHandler("onClientGUIClick",playerGroupWindow["groupinvite_accept"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["member_list_destroygroup"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["member_list_leavegang"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["member_list_inviteplayer"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["member_list_kickplayer"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["member_list_groupvault"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["member_list_quests"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["member_list_encampmentstatus"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["member_list_destroygroup_reclick_cancel"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["member_list_destroygroup_reclick_yes"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["invite_member_list_invite"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["member_list"],check)
addEventHandler("onClientGUIClick",playerGroupWindow["member_list_assignrank"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["member_list_rank_giverank"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["member_list_rank_closebutton"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["member_list_rank_managepermissions"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["member_list_manage_permissions_combobox_confirm"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["member_list_rank_combobox_cancel"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["member_list_rank_combobox_confirm"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["member_list_manage_permissions_combobox_cancel"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["error_selectplayer_ok"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["error_cannotchangerank_ok"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["error_nextversion_ok"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["error_insufficientpermission_ok"],playerGroupSystemButton,false)
addEventHandler("onClientGUIClick",playerGroupWindow["error_notloggedin_ok"],playerGroupSystemButton,false)


--

local openGangTick = getTickCount()

function isPlayerKeySpamming()
	local passed = getTickCount() - openGangTick
	if passed < 3000 then
		outputChatBox("You have to wait "..math.floor((3000-passed)/1000+1).." more seconds before you can open the group panel!", 255, 255, 0,true)
		return true
	else
		openGangTick = getTickCount()
		return false
	end
end

--GPS
playerBlibs = {}
amouunt = 0
function updateGPS ()
	amouunt = 0
	local gangname = getElementData(getLocalPlayer(),"gang")
	for i, blip in ipairs(playerBlibs) do
		if isElement(blip) then
			destroyElement(blip)
		end
	end
	if getElementData(getLocalPlayer(),"gang") == "None" then return end	
	playerBlibs = {}	
	for i, player in ipairs(getElementsByType("player")) do
		if gangname == getElementData(player,"gang") and player ~= localPlayer then
			amouunt = amouunt+1
			playerBlibs[amouunt] = createBlipAttachedTo(player,0,2,22,255,22)
			setBlipVisibleDistance(playerBlibs[amouunt],1000)
		end
	end
end
setTimer(updateGPS,10000,0)
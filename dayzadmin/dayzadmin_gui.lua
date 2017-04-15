--[[
/**
	Name: DayZ Admin Panel
	Author: L
	Version: 1.0.0
	Description: Comprehensive administration tool for MTA DayZ
*/
]]


local isItemSelected = false
addEventHandler("onClientResourceStart",root,
function()
	adminpanel.window[1] = guiCreateWindow(0.08, 0.06, 0.83, 0.86, "DayZ Admin Panel", true)
	guiWindowSetSizable(adminpanel.window[1], false)
	guiSetAlpha(adminpanel.window[1], 1.00)

	adminpanel.tabpanel[1] = guiCreateTabPanel(0.02, 0.05, 0.97, 0.93, true, adminpanel.window[1])

	-- Players
	adminpanel.tab[1] = guiCreateTab("Players", adminpanel.tabpanel[1])
	adminpanel.gridlist[1] = guiCreateGridList(0.02, 0.07, 0.26, 0.91, true, adminpanel.tab[1])
	adminpanel.column[1] = guiGridListAddColumn(adminpanel.gridlist[1], "Players", 0.9)
	adminpanel.label[1] = guiCreateLabel(0.02, 0.03, 0.25, 0.03, "List of Players", true, adminpanel.tab[1])
	guiLabelSetHorizontalAlign(adminpanel.label[1], "center", false)
	guiLabelSetVerticalAlign(adminpanel.label[1], "center")
	adminpanel.label[2] = guiCreateLabel(0.31, 0.07, 0.15, 0.03, "Player Details:", true, adminpanel.tab[1])
	guiSetFont(adminpanel.label[2], "default-bold-small")
	guiLabelSetColor(adminpanel.label[2], 245, 0, 0)
	adminpanel.label[3] = guiCreateLabel(0.31, 0.12, 0.13, 0.03, "Blood:", true, adminpanel.tab[1])
	adminpanel.label[4] = guiCreateLabel(0.31, 0.17, 0.13, 0.03, "Hunger:", true, adminpanel.tab[1])
	adminpanel.label[5] = guiCreateLabel(0.31, 0.22, 0.13, 0.03, "Thirst:", true, adminpanel.tab[1])
	adminpanel.label[6] = guiCreateLabel(0.31, 0.27, 0.13, 0.03, "Temperature:", true, adminpanel.tab[1])
	adminpanel.label[7] = guiCreateLabel(0.31, 0.32, 0.13, 0.03, "Humanity:", true, adminpanel.tab[1])
	adminpanel.label[8] = guiCreateLabel(0.31, 0.37, 0.13, 0.03, "Bandit:", true, adminpanel.tab[1])
	adminpanel.label[9] = guiCreateLabel(0.31, 0.42, 0.13, 0.03, "Zombies killed:", true, adminpanel.tab[1])
	adminpanel.label[10] = guiCreateLabel(0.31, 0.47, 0.13, 0.03, "Alivetime:", true, adminpanel.tab[1])
	adminpanel.label[11] = guiCreateLabel(0.31, 0.52, 0.13, 0.03, "Days alive:", true, adminpanel.tab[1])
	adminpanel.label[12] = guiCreateLabel(0.31, 0.57, 0.13, 0.03, "Backpack:", true, adminpanel.tab[1])
	adminpanel.label[13] = guiCreateLabel(0.31, 0.62, 0.13, 0.03, "Murders:", true, adminpanel.tab[1])
	adminpanel.label[14] = guiCreateLabel(0.31, 0.67, 0.13, 0.03, "Headshots:", true, adminpanel.tab[1])
	adminpanel.label[15] = guiCreateLabel(0.31, 0.72, 0.13, 0.03, "Skin:", true, adminpanel.tab[1])
	adminpanel.label[35] = guiCreateLabel(0.31, 0.77, 0.13, 0.03, "Weapons:", true, adminpanel.tab[1])
	adminpanel.label[30] = guiCreateLabel(0.31, 0.82, 0.13, 0.03, "Vehicle:", true, adminpanel.tab[1])
	adminpanel.label[33] = guiCreateLabel(0.31, 0.87, 0.13, 0.03, "Position:", true, adminpanel.tab[1])
	adminpanel.label[16] = guiCreateLabel(0.45, 0.12, 0.23, 0.03, "", true, adminpanel.tab[1])
	adminpanel.label[17] = guiCreateLabel(0.45, 0.17, 0.23, 0.03, "", true, adminpanel.tab[1])
	adminpanel.label[18] = guiCreateLabel(0.45, 0.22, 0.23, 0.03, "", true, adminpanel.tab[1])
	adminpanel.label[19] = guiCreateLabel(0.45, 0.27, 0.23, 0.03, "", true, adminpanel.tab[1])
	adminpanel.label[20] = guiCreateLabel(0.45, 0.32, 0.23, 0.03, "", true, adminpanel.tab[1])
	adminpanel.label[21] = guiCreateLabel(0.45, 0.37, 0.23, 0.03, "", true, adminpanel.tab[1])
	adminpanel.label[22] = guiCreateLabel(0.45, 0.42, 0.23, 0.03, "", true, adminpanel.tab[1])
	adminpanel.label[23] = guiCreateLabel(0.45, 0.47, 0.23, 0.03, "", true, adminpanel.tab[1])
	adminpanel.label[24] = guiCreateLabel(0.45, 0.52, 0.23, 0.03, "", true, adminpanel.tab[1])
	adminpanel.label[25] = guiCreateLabel(0.45, 0.57, 0.23, 0.03, "", true, adminpanel.tab[1])
	adminpanel.label[26] = guiCreateLabel(0.45, 0.62, 0.23, 0.03, "", true, adminpanel.tab[1])
	adminpanel.label[27] = guiCreateLabel(0.45, 0.67, 0.23, 0.03, "", true, adminpanel.tab[1])
	adminpanel.label[28] = guiCreateLabel(0.45, 0.72, 0.23, 0.03, "", true, adminpanel.tab[1])
	adminpanel.label[29] = guiCreateLabel(0.45, 0.77, 0.23, 0.03, "", true, adminpanel.tab[1])
	adminpanel.label[31] = guiCreateLabel(0.45, 0.82, 0.23, 0.03, "", true, adminpanel.tab[1])
	adminpanel.label[34] = guiCreateLabel(0.45, 0.87, 0.23, 0.03, "", true, adminpanel.tab[1])
	
	adminpanel.button[1] = guiCreateButton(0.69, 0.12, 0.09, 0.06, "Set Stat", true, adminpanel.tab[1])
	adminpanel.button[2] = guiCreateButton(0.79, 0.12, 0.09, 0.06, "Kill", true, adminpanel.tab[1])
	adminpanel.button[3] = guiCreateButton(0.89, 0.12, 0.09, 0.06, "Heal", true, adminpanel.tab[1])
	adminpanel.button[4] = guiCreateButton(0.69, 0.32, 0.29, 0.06, "Warp to [PN]", true, adminpanel.tab[1])
	adminpanel.button[5] = guiCreateButton(0.69, 0.20, 0.09, 0.06, "Set Skin", true, adminpanel.tab[1])
	adminpanel.button[6] = guiCreateButton(0.79, 0.20, 0.09, 0.06, "Fix Veh.", true, adminpanel.tab[1])
	adminpanel.button[7] = guiCreateButton(0.89, 0.20, 0.09, 0.06, "Give Veh.", true, adminpanel.tab[1])
	
	adminpanel.label[32] = guiCreateLabel(0.71, 0.48, 0.25, 0.03, "Inventory", true, adminpanel.tab[1])
	adminpanel.gridlist[2] = guiCreateGridList(0.69, 0.53, 0.29, 0.45, true, adminpanel.tab[1])
	adminpanel.column[5] = guiGridListAddColumn(adminpanel.gridlist[2], "Item", 0.75)
	adminpanel.column[6] = guiGridListAddColumn(adminpanel.gridlist[2], "", 0.2)
	guiLabelSetHorizontalAlign(adminpanel.label[32], "center", false)
	guiLabelSetVerticalAlign(adminpanel.label[32], "center")

	-- Vehicles
	adminpanel.tab[2] = guiCreateTab("Vehicles", adminpanel.tabpanel[1])
	adminpanel.gridlist[3] = guiCreateGridList(0.02, 0.07, 0.26, 0.91, true, adminpanel.tab[2])
	adminpanel.column[2] = guiGridListAddColumn(adminpanel.gridlist[3], "Vehicles", 0.7)
	adminpanel.column[8] = guiGridListAddColumn(adminpanel.gridlist[3], "ID", 0.2)
	adminpanel.label[36] = guiCreateLabel(0.02, 0.03, 0.26, 0.04, "List of Vehicles", true, adminpanel.tab[2])
	guiLabelSetHorizontalAlign(adminpanel.label[36], "center", false)
	adminpanel.label[37] = guiCreateLabel(0.31, 0.07, 0.15, 0.03, "Vehicle Details:", true, adminpanel.tab[2])
	guiSetFont(adminpanel.label[37], "default-bold-small")
	guiLabelSetColor(adminpanel.label[37], 255, 0, 0)
	adminpanel.label[38] = guiCreateLabel(0.31, 0.12, 0.13, 0.03, "Health:", true, adminpanel.tab[2])
	adminpanel.label[39] = guiCreateLabel(0.31, 0.17, 0.13, 0.03, "Slots:", true, adminpanel.tab[2])
	adminpanel.label[40] = guiCreateLabel(0.31, 0.23, 0.13, 0.03, "Tires:", true, adminpanel.tab[2])
	adminpanel.label[41] = guiCreateLabel(0.31, 0.28, 0.13, 0.03, "Engine:", true, adminpanel.tab[2])
	adminpanel.label[42] = guiCreateLabel(0.31, 0.33, 0.13, 0.03, "Parts:", true, adminpanel.tab[2])
	adminpanel.label[43] = guiCreateLabel(0.31, 0.38, 0.13, 0.03, "Windscreen:", true, adminpanel.tab[2])
	adminpanel.label[44] = guiCreateLabel(0.31, 0.44, 0.13, 0.03, "Rotary Parts:", true, adminpanel.tab[2])
	adminpanel.label[45] = guiCreateLabel(0.31, 0.49, 0.13, 0.03, "Model ID:", true, adminpanel.tab[2])
	adminpanel.label[46] = guiCreateLabel(0.31, 0.54, 0.13, 0.03, "Fuel:", true, adminpanel.tab[2])
	adminpanel.label[47] = guiCreateLabel(0.31, 0.59, 0.13, 0.03, "Max Fuel:", true, adminpanel.tab[2])
	adminpanel.label[48] = guiCreateLabel(0.31, 0.65, 0.13, 0.03, "Position:", true, adminpanel.tab[2])
	adminpanel.label[49] = guiCreateLabel(0.31, 0.70, 0.13, 0.03, "Rotation:", true, adminpanel.tab[2])
	adminpanel.label[50] = guiCreateLabel(0.45, 0.12, 0.23, 0.03, "", true, adminpanel.tab[2])
	adminpanel.label[51] = guiCreateLabel(0.45, 0.17, 0.23, 0.03, "", true, adminpanel.tab[2])
	adminpanel.label[52] = guiCreateLabel(0.45, 0.23, 0.23, 0.03, "", true, adminpanel.tab[2])
	adminpanel.label[53] = guiCreateLabel(0.45, 0.28, 0.23, 0.03, "", true, adminpanel.tab[2])
	adminpanel.label[54] = guiCreateLabel(0.45, 0.33, 0.23, 0.03, "", true, adminpanel.tab[2])
	adminpanel.label[55] = guiCreateLabel(0.45, 0.38, 0.23, 0.03, "", true, adminpanel.tab[2])
	adminpanel.label[56] = guiCreateLabel(0.45, 0.44, 0.23, 0.03, "", true, adminpanel.tab[2])
	adminpanel.label[57] = guiCreateLabel(0.45, 0.49, 0.23, 0.03, "", true, adminpanel.tab[2])
	adminpanel.label[58] = guiCreateLabel(0.45, 0.54, 0.23, 0.03, "", true, adminpanel.tab[2])
	adminpanel.label[59] = guiCreateLabel(0.45, 0.59, 0.23, 0.03, "", true, adminpanel.tab[2])
	adminpanel.label[60] = guiCreateLabel(0.45, 0.65, 0.23, 0.03, "", true, adminpanel.tab[2])
	adminpanel.label[61] = guiCreateLabel(0.45, 0.70, 0.23, 0.03, "", true, adminpanel.tab[2])
	adminpanel.button[8] = guiCreateButton(0.70, 0.12, 0.09, 0.06, "Set Stat", true, adminpanel.tab[2])
	adminpanel.button[9] = guiCreateButton(0.80, 0.12, 0.09, 0.06, "Blow", true, adminpanel.tab[2])
	adminpanel.button[10] = guiCreateButton(0.90, 0.12, 0.09, 0.06, "Fix", true, adminpanel.tab[2])
	adminpanel.button[11] = guiCreateButton(0.69, 0.32, 0.29, 0.05, "Warp to Vehicle", true, adminpanel.tab[2])
	adminpanel.gridlist[4] = guiCreateGridList(0.69, 0.53, 0.29, 0.45, true, adminpanel.tab[2])
	adminpanel.column[9] = guiGridListAddColumn(adminpanel.gridlist[4], "Item", 0.7)
	adminpanel.column[10] = guiGridListAddColumn(adminpanel.gridlist[4], "", 0.2)
	adminpanel.label[62] = guiCreateLabel(0.71, 0.48, 0.25, 0.03, "Inventory", true, adminpanel.tab[2])
	guiLabelSetHorizontalAlign(adminpanel.label[62], "center", false)

	-- Inventory Editor
	adminpanel.tab[3] = guiCreateTab("Inventory Editor", adminpanel.tabpanel[1])
	adminpanel.gridlist[5] = guiCreateGridList(0.02, 0.07, 0.26, 0.91, true, adminpanel.tab[3])
	adminpanel.column[3] = guiGridListAddColumn(adminpanel.gridlist[5], "Players", 0.9)
	adminpanel.label[65] = guiCreateLabel(0.02, 0.03, 0.25, 0.03, "List of Players", true, adminpanel.tab[3])
	guiLabelSetHorizontalAlign(adminpanel.label[65], "center", false)
	adminpanel.gridlist[6] = guiCreateGridList(0.30, 0.07, 0.27, 0.30, true, adminpanel.tab[3])
	adminpanel.column[4] = guiGridListAddColumn(adminpanel.gridlist[6], "Items", 0.7)
	adminpanel.column[7] = guiGridListAddColumn(adminpanel.gridlist[6],"",0.2)
	adminpanel.label[66] = guiCreateLabel(0.31, 0.03, 0.25, 0.03, "Inventory", true, adminpanel.tab[3])
	guiLabelSetHorizontalAlign(adminpanel.label[66], "center", false)
	adminpanel.button[12] = guiCreateButton(0.30, 0.50, 0.15, 0.08, "Give Player", true, adminpanel.tab[3])
	adminpanel.button[13] = guiCreateButton(0.30, 0.39, 0.15, 0.08, "Take Item from Player", true, adminpanel.tab[3]) 
	adminpanel.combobox[1] = guiCreateComboBox(0.58, 0.07, 0.18, 0.29, "", true, adminpanel.tab[3])
	adminpanel.label[67] = guiCreateLabel(0.55, 0.03, 0.25, 0.03, "Category", true, adminpanel.tab[3])
	guiLabelSetHorizontalAlign(adminpanel.label[67], "center", false)
	adminpanel.combobox[2] = guiCreateComboBox(0.78, 0.07, 0.18, 0.29, "", true, adminpanel.tab[3])
	adminpanel.label[68] = guiCreateLabel(0.76, 0.03, 0.25, 0.03, "Item", true, adminpanel.tab[3])
	guiLabelSetHorizontalAlign(adminpanel.label[68], "center", false)
	adminpanel.editbox[1] = guiCreateEdit(0.49, 0.44, 0.07, 0.07, "", true, adminpanel.tab[3])
	
	for key, value in pairs (items) do
		if type(value) == "table" then
			guiComboBoxAddItem(adminpanel.combobox[1], key)
		end
	end

	-- Admin Access (Soon)
	adminpanel.tab[4] = guiCreateTab("Admin Access", adminpanel.tabpanel[1])
	adminpanel.accessgridlist[1] = guiCreateGridList(10, 24, 622, 247, false, adminpanel.tab[4])
	adminpanel.accesscolumn[1] = guiGridListAddColumn(adminpanel.accessgridlist[1], "Setting", 0.4)
	adminpanel.accesscolumn[2] = guiGridListAddColumn(adminpanel.accessgridlist[1], "Value", 0.2)
	adminpanel.accesscolumn[3] = guiGridListAddColumn(adminpanel.accessgridlist[1], "Default", 0.2)
	adminpanel.accesscolumn[4] = guiGridListAddColumn(adminpanel.accessgridlist[1], "Environment", 0.2)
	adminpanel.accessbutton[1] = guiCreateButton(0.02, 0.63, 0.12, 0.07, "Edit Setting", true, adminpanel.tab[4])
	adminpanel.accessbutton[2] = guiCreateButton(0.02, 0.72, 0.12, 0.07, "Reset Setting", true, adminpanel.tab[4])
	adminpanel.accessmemo[1] = guiCreateMemo(0.59, 0.62, 0.39, 0.36, "", true, adminpanel.tab[4])
	guiMemoSetReadOnly(adminpanel.accessmemo[1], true)
	adminpanel.accesslabel[1] = guiCreateLabel(0.02, 0.85, 0.56, 0.10, "In \"Admin Access\", various settings of DayZ can be altered. Exercise extreme caution when editing these settings! \nSettings changed here will not be saved!", true, adminpanel.tab[4])
	guiSetFont(adminpanel.accesslabel[1], "default-bold-small")
	guiLabelSetColor(adminpanel.accesslabel[1], 255, 0, 0)
	guiLabelSetHorizontalAlign(adminpanel.accesslabel[1], "left", true)
	
	-- Admin Access Edit Setting
	adminpanel.accesseditwindow[1] = guiCreateWindow(0.25, 0.38, 0.46, 0.27, "Edit Setting: [SETTING]", true)
	guiWindowSetSizable(adminpanel.accesseditwindow[1], false)
	guiSetAlpha(adminpanel.accesseditwindow[1], 1.00)

	adminpanel.accessedit[1] = guiCreateEdit(0.03, 0.36, 0.59, 0.16, "", true, adminpanel.accesseditwindow[1])
	adminpanel.accesseditlabel[1] = guiCreateLabel(0.03, 0.15, 0.57, 0.21, "Allowed values: [VALUES]", true, adminpanel.accesseditwindow[1])
	guiLabelSetVerticalAlign(adminpanel.label[1], "center")
	adminpanel.accesseditbutton[1] = guiCreateButton(0.89, 0.76, 0.08, 0.17, "x", true, adminpanel.accesseditwindow[1])
	adminpanel.accesseditbutton[2] = guiCreateButton(0.03, 0.76, 0.20, 0.17, "Save", true, adminpanel.accesseditwindow[1])
	adminpanel.accesseditlabel[2] = guiCreateLabel(0.65, 0.16, 0.32, 0.57, "Be careful when editing settings - giving them the wrong value may result in the game breaking!", true, adminpanel.accesseditwindow[1])
	guiSetFont(adminpanel.accesseditlabel[2], "default-bold-small")
	guiLabelSetColor(adminpanel.accesseditlabel[2], 255, 0, 0)
	guiLabelSetHorizontalAlign(adminpanel.accesseditlabel[2], "left", true) 

	-- Live Map
	adminpanel.tab[5] = guiCreateTab("Live Map", adminpanel.tabpanel[1])
	adminpanel.map[1] = guiCreateStaticImage(0.02, 0.02, 0.73, 0.96, "images/map.png", true, adminpanel.tab[5])
	adminpanel.label[70] = guiCreateLabel(0.79, 0.04, 0.17, 0.03, "Map Settings", true, adminpanel.tab[5])
	guiSetFont(adminpanel.label[70], "default-bold-small")
	guiLabelSetColor(adminpanel.label[70], 245, 0, 0)
	guiLabelSetHorizontalAlign(adminpanel.label[70], "center", false)
	adminpanel.checkbox[1] = guiCreateCheckBox(0.76, 0.10, 0.02, 0.03, "", false, true, adminpanel.tab[5])
	adminpanel.checkbox[2] = guiCreateCheckBox(0.76, 0.15, 0.02, 0.03, "", false, true, adminpanel.tab[5])
	adminpanel.checkbox[3] = guiCreateCheckBox(0.76, 0.20, 0.02, 0.03, "", false, true, adminpanel.tab[5])
	adminpanel.label[71] = guiCreateLabel(0.80, 0.10, 0.19, 0.03, "Show Players", true, adminpanel.tab[5])
	adminpanel.label[72] = guiCreateLabel(0.80, 0.15, 0.19, 0.03, "Show Vehicles", true, adminpanel.tab[5])
	adminpanel.label[73] = guiCreateLabel(0.80, 0.20, 0.19, 0.03, "Show Loot", true, adminpanel.tab[5])
	adminpanel.label[74] = guiCreateLabel(0.79, 0.54, 0.17, 0.03, "WARNING", true, adminpanel.tab[5])
	guiSetFont(adminpanel.label[74], "default-bold-small")
	guiLabelSetColor(adminpanel.label[74], 245, 0, 0)
	guiLabelSetHorizontalAlign(adminpanel.label[74], "center", false)
	adminpanel.label[75] = guiCreateLabel(0.77, 0.58, 0.21, 0.37, "The \"Show Loot\" \nsetting will lag older \nand weaker computers. \n\nUse with caution!", true, adminpanel.tab[5])
	
	-- Search (Soon)
	adminpanel.tab[6] = guiCreateTab("Search", adminpanel.tabpanel[1])
	adminpanel.label[76] = guiCreateLabel(0.01, 0.02, 0.37, 0.41, "SOON", true, adminpanel.tab[6])
	
	

	-- Leaderboard (Soon)
	adminpanel.tab[7] = guiCreateTab("Leaderboard", adminpanel.tabpanel[1])
	adminpanel.label[77] = guiCreateLabel(0.01, 0.02, 0.37, 0.39, "SOON", true, adminpanel.tab[7])

	-- View Chat
	adminpanel.tab[8] = guiCreateTab("View Chat", adminpanel.tabpanel[1])
	adminpanel.memo[1] = guiCreateMemo(0.02, 0.05, 0.68, 0.93, "", true, adminpanel.tab[8])
	guiMemoSetReadOnly(adminpanel.memo[1], true)
	adminpanel.label[78] = guiCreateLabel(0.72, 0.05, 0.27, 0.03, "Chat Settings", true, adminpanel.tab[8])
	guiSetFont(adminpanel.label[78], "default-bold-small")
	guiLabelSetColor(adminpanel.label[78], 255, 0, 0)
	guiLabelSetHorizontalAlign(adminpanel.label[78], "center", false)
	adminpanel.checkbox[4] = guiCreateCheckBox(0.72, 0.10, 0.25, 0.05, "Show all [LOCAL] Chat", false, true, adminpanel.tab[8])
	adminpanel.checkbox[5] = guiCreateCheckBox(0.72, 0.15, 0.25, 0.05, "Show all [GROUP] Chat", false, true, adminpanel.tab[8])
	adminpanel.checkbox[6] = guiCreateCheckBox(0.72, 0.20, 0.25, 0.05, "Show all [RADIO] Chat", false, true, adminpanel.tab[8])
	adminpanel.label[82] = guiCreateLabel(0.72, 0.40, 0.27, 0.03, "Global Message", true, adminpanel.tab[8])
	adminpanel.button[14] = guiCreateButton(0.72, 0.55, 0.25, 0.08, "Send global message", true, adminpanel.tab[8])
	adminpanel.editbox[2] = guiCreateEdit(0.72, 0.45, 0.25, 0.07, "", true, adminpanel.tab[8])
	adminpanel.button[15] = guiCreateButton(0.72, 0.75, 0.25, 0.08, "Empy Chatlog", true, adminpanel.tab[8])
	guiSetFont(adminpanel.label[82], "default-bold-small")
	guiLabelSetColor(adminpanel.label[82], 255, 0, 0)
	guiLabelSetHorizontalAlign(adminpanel.label[82], "center", false)
	
	-- Set Stat Window (Players)
	adminpanel.statwindow[1] = guiCreateWindow(0.28, 0.27, 0.45, 0.51, "Set Stat of [PN]", true)
	guiWindowSetSizable(adminpanel.statwindow[1], false)
	guiSetAlpha(adminpanel.statwindow[1], 1.00)

	adminpanel.statcombobox[1] = guiCreateComboBox(0.45, 0.19, 0.52, 0.56, "", true, adminpanel.statwindow[1])
	guiComboBoxAddItem(adminpanel.statcombobox[1], "Blood")
	guiComboBoxAddItem(adminpanel.statcombobox[1], "Food")
	guiComboBoxAddItem(adminpanel.statcombobox[1], "Thirst")
	guiComboBoxAddItem(adminpanel.statcombobox[1], "Temperature")
	guiComboBoxAddItem(adminpanel.statcombobox[1], "Humanity")
	guiComboBoxAddItem(adminpanel.statcombobox[1], "Zombieskilled")
	guiComboBoxAddItem(adminpanel.statcombobox[1], "Alivetime")
	guiComboBoxAddItem(adminpanel.statcombobox[1], "hoursalive")
	guiComboBoxAddItem(adminpanel.statcombobox[1], "DaysAlive")
	guiComboBoxAddItem(adminpanel.statcombobox[1], "Murders")
	guiComboBoxAddItem(adminpanel.statcombobox[1], "Headshots")
	adminpanel.statedit[1] = guiCreateEdit(0.62, 0.74, 0.17, 0.09, "", true, adminpanel.statwindow[1])
	adminpanel.statgridlist[1] = guiCreateGridList(0.03, 0.13, 0.40, 0.84,true, adminpanel.statwindow[1])
	adminpanel.statcolumn[1] = guiGridListAddColumn(adminpanel.statgridlist[1], "Players", 0.9)
	adminpanel.statlabel[1] = guiCreateLabel(0.46, 0.12, 0.48, 0.06, "Select Stat", true, adminpanel.statwindow[1])
	guiLabelSetHorizontalAlign(adminpanel.statlabel[1], "center", false)
	adminpanel.statlabel[2] = guiCreateLabel(0.46, 0.69, 0.48, 0.06, "Value", true, adminpanel.statwindow[1])
	guiLabelSetHorizontalAlign(adminpanel.statlabel[2], "center", false)
	adminpanel.statbutton[1] = guiCreateButton(0.49, 0.87, 0.16, 0.10, "Accept", true, adminpanel.statwindow[1])
	adminpanel.statbutton[2] = guiCreateButton(0.77, 0.87, 0.16, 0.10, "Close", true, adminpanel.statwindow[1])
	
	-- Set Stat Window (Vehicles)
	adminpanel.statvwindow[1] = guiCreateWindow(0.28, 0.27, 0.45, 0.51, "Set Stat of [VN]", true)
	guiWindowSetSizable(adminpanel.statvwindow[1], false)
	guiSetAlpha(adminpanel.statvwindow[1], 1.00)

	adminpanel.statvcombobox[1] = guiCreateComboBox(0.45, 0.19, 0.52, 0.56, "", true, adminpanel.statvwindow[1])
	guiComboBoxAddItem(adminpanel.statvcombobox[1], "Health")
	guiComboBoxAddItem(adminpanel.statvcombobox[1], "Tires")
	guiComboBoxAddItem(adminpanel.statvcombobox[1], "Engine")
	guiComboBoxAddItem(adminpanel.statvcombobox[1], "Windscreen")
	guiComboBoxAddItem(adminpanel.statvcombobox[1], "Rotary Parts")
	guiComboBoxAddItem(adminpanel.statvcombobox[1], "Fuel")
	adminpanel.statvedit[1] = guiCreateEdit(0.62, 0.74, 0.17, 0.09, "", true, adminpanel.statvwindow[1])
	adminpanel.statvgridlist[1] = guiCreateGridList(0.03, 0.13, 0.40, 0.84,true, adminpanel.statvwindow[1])
	guiGridListAddColumn(adminpanel.statvgridlist[1], "Vehicles", 0.9)
	adminpanel.statvlabel[1] = guiCreateLabel(0.46, 0.12, 0.48, 0.06, "Select Stat", true, adminpanel.statwindow[1])
	guiLabelSetHorizontalAlign(adminpanel.statvlabel[1], "center", false)
	adminpanel.statvlabel[2] = guiCreateLabel(0.46, 0.69, 0.48, 0.06, "Value", true, adminpanel.statvwindow[1])
	guiLabelSetHorizontalAlign(adminpanel.statvlabel[2], "center", false)
	adminpanel.statvbutton[1] = guiCreateButton(0.49, 0.87, 0.16, 0.10, "Accept", true, adminpanel.statvwindow[1])
	adminpanel.statvbutton[2] = guiCreateButton(0.77, 0.87, 0.16, 0.10, "Close", true, adminpanel.statvwindow[1])
	
	-- Set Skin Window (Players)
	adminpanel.skinwindow[1] = guiCreateWindow(0.28, 0.27, 0.45, 0.51, "Set Skin of [PN]", true)
	guiWindowSetSizable(adminpanel.skinwindow[1], false)
	guiSetAlpha(adminpanel.skinwindow[1], 1.00)

	adminpanel.skincombobox[1] = guiCreateComboBox(0.45, 0.19, 0.52, 0.47, "", true, adminpanel.skinwindow[1])
	guiComboBoxAddItem(adminpanel.skincombobox[1], "Survivor")
	guiComboBoxAddItem(adminpanel.skincombobox[1], "Civilian")
	guiComboBoxAddItem(adminpanel.skincombobox[1], "Ghillie Suit")
	guiComboBoxAddItem(adminpanel.skincombobox[1], "Camouflage")
	guiComboBoxAddItem(adminpanel.skincombobox[1], "Survivor (Female)")
	guiComboBoxAddItem(adminpanel.skincombobox[1], "Civilian (Female)")
	adminpanel.skingridlist[1] = guiCreateGridList(0.03, 0.13, 0.40, 0.84,true, adminpanel.skinwindow[1])
	adminpanel.skincolumn[1] = guiGridListAddColumn(adminpanel.skingridlist[1], "Players", 0.9)
	adminpanel.skinlabel[1] = guiCreateLabel(0.46, 0.12, 0.48, 0.06, "Select Skin", true, adminpanel.skinwindow[1])
	guiLabelSetHorizontalAlign(adminpanel.skinlabel[1], "center", false)
	adminpanel.skinbutton[1] = guiCreateButton(0.49, 0.87, 0.16, 0.10, "Accept", true, adminpanel.skinwindow[1])
	adminpanel.skinbutton[2] = guiCreateButton(0.77, 0.87, 0.16, 0.10, "Close", true, adminpanel.skinwindow[1])
	
	
	-- Give Vehicle (Players)
	adminpanel.vehwindow[1] = guiCreateWindow(0.28, 0.27, 0.45, 0.51, "Give Vehicle to [PN]", true)
	guiWindowSetSizable(adminpanel.vehwindow[1], false)
	guiSetAlpha(adminpanel.vehwindow[1], 1.00)

	adminpanel.vehcombobox[1] = guiCreateComboBox(0.45, 0.19, 0.52, 0.47, "", true, adminpanel.vehwindow[1])
	adminpanel.vehgridlist[1] = guiCreateGridList(0.03, 0.13, 0.40, 0.84, true, adminpanel.vehwindow[1])
	adminpanel.vehcolumn[1] = guiGridListAddColumn(adminpanel.vehgridlist[1], "Players", 0.9)
	adminpanel.vehlabel[1] = guiCreateLabel(0.46, 0.12, 0.48, 0.06, "Select Vehicle", true, adminpanel.vehwindow[1])
	guiLabelSetHorizontalAlign(adminpanel.vehlabel[1], "center", false)
	adminpanel.vehbutton[1] = guiCreateButton(0.49, 0.87, 0.16, 0.10, "Accept", true, adminpanel.vehwindow[1])
	adminpanel.vehbutton[2] = guiCreateButton(0.77, 0.87, 0.16, 0.10, "Close", true, adminpanel.vehwindow[1])
	
	for key, value in pairs (vehicleInfo) do
		if type(value) == "table" then
			guiComboBoxAddItem(adminpanel.vehcombobox[1], value[12])
		end
	end
	
	guiSetVisible(adminpanel.window[1],false)
	guiSetVisible(adminpanel.statwindow[1],false)
	guiSetVisible(adminpanel.statvwindow[1],false)
	guiSetVisible(adminpanel.skinwindow[1],false)
	guiSetVisible(adminpanel.vehwindow[1],false)
	guiSetVisible(adminpanel.accesseditwindow[1],false)
	
	guiSetEnabled(adminpanel.button[12],false)
	guiSetEnabled(adminpanel.button[13],false)
	guiSetEnabled(adminpanel.statbutton[1],false)
	guiSetEnabled(adminpanel.statvbutton[1],false)
	guiSetEnabled(adminpanel.skinbutton[1],false)
	--guiSetEnabled(adminpanel.tab[2],false)
	guiSetEnabled(adminpanel.tab[4],true)
	guiSetEnabled(adminpanel.tab[6],false)
	guiSetEnabled(adminpanel.tab[7],false)
	
	guiCheckBoxSetSelected(adminpanel.checkbox[1],false)
	guiCheckBoxSetSelected(adminpanel.checkbox[2],false)
	guiCheckBoxSetSelected(adminpanel.checkbox[3],false)
	
	-- Utility Functions
	addEventHandler("onClientGUIChanged", adminpanel.editbox[1], 
	function()
		guiSetText(source, guiGetText(source):gsub("[^0-9]",""))
		checkIfRequirementsMet()
	end)
	
	addEventHandler("onClientGUIChanged", adminpanel.statedit[1], 
	function()
		guiSetText(source, guiGetText(source):gsub("[^0-9]",""))
		checkIfStatSelected()
	end)

	addEventHandler("onClientGUIComboBoxAccepted", adminpanel.combobox[1],
	function()
		local text = guiComboBoxGetItemText(adminpanel.combobox[1], guiComboBoxGetSelected(adminpanel.combobox[1]))
		guiComboBoxClear(adminpanel.combobox[2])
		for i, st in ipairs(items[text]) do
			guiComboBoxAddItem(adminpanel.combobox[2], st)
		end
	end)
	
	addEventHandler("onClientGUIComboBoxAccepted", adminpanel.combobox[2],
	function()
		isItemSelected = true
		checkIfRequirementsMet()
	end )
	
	addEventHandler("onClientGUIComboBoxAccepted", adminpanel.statcombobox[1],
	function()
		checkIfStatSelected()
	end )
	
	addEventHandler("onClientGUIComboBoxAccepted", adminpanel.skincombobox[1],
	function()
		checkIfSkinSelected()
	end )
	
	addEventHandler("onClientGUIComboBoxAccepted", adminpanel.vehcombobox[1],
	function()
		checkIfVehicleSelected()
	end )
	
	addEventHandler ( "onClientGUIClick", adminpanel.button[12], 
	function()
		local playerName = guiGridListGetItemText(adminpanel.gridlist[5], guiGridListGetSelectedItem(adminpanel.gridlist[5]), 1)
		local item = guiComboBoxGetItemText(adminpanel.combobox[2], guiComboBoxGetSelected(adminpanel.combobox[2]))
		local giver = getPlayerName(localPlayer)
		if (getPlayerFromName(playerName)) then
			triggerServerEvent("onAdminPanelEditInventory", localPlayer, playerName, item, tonumber(guiGetText(adminpanel.editbox[1])),"give")
			isItemSelected = false
		else
			outputChatBox("Player disconnected or changed name!", 255, 0, 0)
		end
	end, false)
	
	addEventHandler ( "onClientGUIClick", adminpanel.button[13], 
	function()
		local playerName = guiGridListGetItemText(adminpanel.gridlist[5], guiGridListGetSelectedItem(adminpanel.gridlist[5]), 1)
		local item = guiGridListGetItemText(adminpanel.gridlist[6], guiGridListGetSelectedItem(adminpanel.gridlist[6]), 1)
		local taker = getPlayerName(localPlayer)
		if (getPlayerFromName(playerName)) then
			triggerServerEvent("onAdminPanelEditInventory", localPlayer, playerName, item, tonumber(guiGetText(adminpanel.editbox[1])),"take")
			guiGridListClear(adminpanel.gridlist[6])
			setTimer(showPlayerInventory,100,1)
		else
			outputChatBox("Player disconnected or changed name!", 255, 0, 0)
		end
	end, false)
	
	addEventHandler("onClientGUIClick", adminpanel.statbutton[1],
	function()
		local playerName = guiGridListGetItemText(adminpanel.statgridlist[1], guiGridListGetSelectedItem(adminpanel.statgridlist[1]), 1)
		local stat = guiComboBoxGetItemText(adminpanel.statcombobox[1], guiComboBoxGetSelected(adminpanel.statcombobox[1]))
		if (getPlayerFromName(playerName)) then
			triggerServerEvent("onAdminPanelSetPlayerStat", localPlayer, playerName, stat, tonumber(guiGetText(adminpanel.statedit[1])))
		else
			outputChatBox("Player disconnected or changed name!",255,0,0)
		end
	end, false)
	
	addEventHandler("onClientGUIClick", adminpanel.skinbutton[1],
	function()
		local playerName = guiGridListGetItemText(adminpanel.skingridlist[1], guiGridListGetSelectedItem(adminpanel.skingridlist[1]), 1)
		local skin = guiComboBoxGetItemText(adminpanel.skincombobox[1], guiComboBoxGetSelected(adminpanel.skincombobox[1]))
		if (getPlayerFromName(playerName)) then
			triggerServerEvent("onAdminPanelSetPlayerSkin", localPlayer, playerName, skin)
		else
			outputChatBox("Player disconnected or changed name!",255,0,0)
		end
	end, false)
	
	addEventHandler("onClientGUIClick", adminpanel.vehbutton[1],
	function()
		local playerName = guiGridListGetItemText(adminpanel.vehgridlist[1], guiGridListGetSelectedItem(adminpanel.vehgridlist[1]), 1)
		local vehicle = guiComboBoxGetItemText(adminpanel.vehcombobox[1], guiComboBoxGetSelected(adminpanel.vehcombobox[1]))
		local x,y,z = getElementPosition(getPlayerFromName(playerName))
		if (getPlayerFromName(playerName)) then
			-- DO NOT UNCOMMENT! triggerServerEvent("onAdminPanelSpawnVehicle", localPlayer, playerName, vehicle, x,y,z)
			outputChatBox("This feature is currently bugged!",255,0,0)
		else
			outputChatBox("Player disconnected or changed name!",255,0,0)
		end
	end, false)
	
	addEventHandler("onClientGUIClick", adminpanel.accessbutton[1],
	function()
		local setting = guiGridListGetItemText(adminpanel.accessgridlist[1], guiGridListGetSelectedItem(adminpanel.accessgridlist[1]), 1)
		local value = guiGridListGetItemText(adminpanel.accessgridlist[1], guiGridListGetSelectedItem(adminpanel.accessgridlist[1]), 2)
		local environment = guiGridListGetItemText(adminpanel.accessgridlist[1], guiGridListGetSelectedItem(adminpanel.accessgridlist[1]), 4)
		if setting ~= "" then
			guiSetVisible(adminpanel.accesseditwindow[1],true)
			guiSetText(adminpanel.accesseditwindow[1],"Edit Setting: "..tostring(setting).." ("..tostring(environment)..")")
			for i, value in ipairs(variablesConversionTable) do
				if setting == value[2] then
					guiSetText(adminpanel.accesseditlabel[1],"Allowed Values: "..tostring(value[6]))
					break
				end
			end
			guiBringToFront(adminpanel.accesseditwindow[1])
		end
	end, false)
	
	addEventHandler("onClientGUIClick", adminpanel.accessbutton[2],
	function()
		local setting = guiGridListGetItemText(adminpanel.accessgridlist[1], guiGridListGetSelectedItem(adminpanel.accessgridlist[1]), 1)
		local value = guiGridListGetItemText(adminpanel.accessgridlist[1], guiGridListGetSelectedItem(adminpanel.accessgridlist[1]), 2)
		local environment = guiGridListGetItemText(adminpanel.accessgridlist[1], guiGridListGetSelectedItem(adminpanel.accessgridlist[1]), 4)
		if setting ~= "" then
			for i, value in ipairs(variablesConversionTable) do
				if setting == value[2] then
					if environment == "Server" then
						triggerServerEvent("onServerSideChangeSetting",root,tostring(setting),value[4])
					elseif environment == "Client" then
						exports.DayZ:setGameplayVariable(tostring(setting),value[4])
					elseif environment == "Shared" then
						triggerServerEvent("onServerSideChangeSetting",root,tostring(setting),value[4])
						exports.DayZ:setGameplayVariable(tostring(setting),value[4])
					end
					outputChatBox("Setting "..tostring(setting).." has been reset to: "..tostring(value[4]))
				end
			end
		end
	end, false)
	
	addEventHandler("onClientGUIClick", adminpanel.accesseditbutton[2],
	function()
		local setting = guiGridListGetItemText(adminpanel.accessgridlist[1], guiGridListGetSelectedItem(adminpanel.accessgridlist[1]), 1)
		local environment = guiGridListGetItemText(adminpanel.accessgridlist[1], guiGridListGetSelectedItem(adminpanel.accessgridlist[1]), 4)
		local editedSetting = guiGetText(adminpanel.accessedit[1])
		if editedSetting ~= "" then
			editGameplayVariable(setting,environment,editedSetting)
			guiSetVisible(adminpanel.accesseditwindow[1],false)
		end
	end, false)
	
	addEventHandler("onClientGUIClick", adminpanel.button[14],
	function()
		local message = tostring(guiGetText(adminpanel.editbox[2]))
		if message ~= "" then
			triggerServerEvent("onAdminPanelSendGlobalMessage", localPlayer, message)
			triggerEvent("onPlayerMessageEditMemo", localPlayer, localPlayer, message, 3)
		end
	end, false)
	
	addEventHandler("onClientGUIClick", adminpanel.checkbox[1],
	function()
		if guiCheckBoxGetSelected(adminpanel.checkbox[1]) then
			if not playerBlipsVisible then
				playerBlipsVisible = true
				setTimer(function() addEventHandler("onClientRender",root,onAdminPanelUpdateLiveMapPlayer) end,500,1)
			end
		else
			if playerBlipsVisible then
				playerBlipsVisible = false
				setTimer(function() removeEventHandler("onClientRender",root, onAdminPanelUpdateLiveMapPlayer) end,1000,1)
			end
		end
	end, false)
	
	addEventHandler("onClientGUIClick", adminpanel.checkbox[2],
	function()
		if guiCheckBoxGetSelected(adminpanel.checkbox[2]) then
			if not vehicleBlipsVisible then
				vehicleBlipsVisible = true
				setTimer(function() addEventHandler("onClientRender",root,onAdminPanelUpdateLiveMapVehicles) end,500,1)
			end
		else
			if vehicleBlipsVisible then
				vehicleBlipsVisible = false
				setTimer(function() removeEventHandler("onClientRender",root, onAdminPanelUpdateLiveMapVehicles) end,1000,1)
			end
		end
	end, false)
	
	addEventHandler("onClientGUIClick", adminpanel.checkbox[3],
	function()
		if guiCheckBoxGetSelected(adminpanel.checkbox[3]) then
			if not lootBlipsVisible then
				lootBlipsVisible = true
				setTimer(function() addEventHandler("onClientRender",root,onAdminPanelUpdateLiveMapLoot) end,500,1)
			end
		else
			if lootBlipsVisible then
				lootBlipsVisible = false
				setTimer(function() removeEventHandler("onClientRender",root, onAdminPanelUpdateLiveMapLoot) end,1000,1)
			end
		end
	end, false)
	
	addEventHandler("onClientGUIClick", adminpanel.checkbox[4],
	function()
		if guiCheckBoxGetSelected(adminpanel.checkbox[4]) then
			if not localChatLogEnabled then
				localChatLogEnabled = true
			end
		else
			if localChatLogEnabled then
				localChatLogEnabled = false
			end
		end
	end, false)
	
	addEventHandler("onClientGUIClick", adminpanel.checkbox[5],
	function()
		if guiCheckBoxGetSelected(adminpanel.checkbox[5]) then
			if not groupChatLogEnabled then
				groupChatLogEnabled = true
			end
		else
			if groupChatLogEnabled then
				groupChatLogEnabled = false
			end
		end
	end, false)
	
	addEventHandler("onClientGUIClick",adminpanel.gridlist[1],function() guiGridListClear(adminpanel.gridlist[2]) populateStatsOnPlayerSelect() end,false)
	addEventHandler("onClientGUIClick",adminpanel.accessgridlist[1],changeDescriptionOnClick,false)
	addEventHandler("onClientGUIClick", adminpanel.accesseditbutton[1],function() guiSetVisible(adminpanel.accesseditwindow[1],false) end,false)
	addEventHandler("onClientGUIClick",adminpanel.gridlist[5],function() guiGridListClear(adminpanel.gridlist[6]) showPlayerInventory() end,false)
	addEventHandler("onClientGUIClick",adminpanel.gridlist[3],populateStatsOnVehicleSelect,false)
	addEventHandler("onClientGUIClick",adminpanel.gridlist[5],checkIfRequirementsMet,false)
	addEventHandler("onClientGUIClick",adminpanel.button[1],function() guiSetVisible(adminpanel.statwindow[1],true) guiBringToFront(adminpanel.statwindow[1],true) end, false)
	addEventHandler("onClientGUIClick",adminpanel.button[2],killPlayerOnButtonClick, false)
	addEventHandler("onClientGUIClick",adminpanel.button[3],healPlayerOnButtonClick, false)
	addEventHandler("onClientGUIClick",adminpanel.button[4],warpToPlayerOnButtonClick,false)
	addEventHandler("onClientGUIClick",adminpanel.button[11],warpToVehicleOnButtonClick,false)
	addEventHandler("onClientGUIClick",adminpanel.button[9],killVehicleOnButtonClick, false)
	addEventHandler("onClientGUIClick",adminpanel.button[5],function() guiSetVisible(adminpanel.skinwindow[1],true) guiBringToFront(adminpanel.skinwindow[1],true) end, false)
	addEventHandler("onClientGUIClick",adminpanel.skinbutton[2],function() guiSetVisible(adminpanel.skinwindow[1],false) end,false)
	addEventHandler("onClientGUIClick",adminpanel.statgridlist[1],checkIfStatSelected, false)
	addEventHandler("onClientGUIClick",adminpanel.statbutton[2],function() guiSetVisible(adminpanel.statwindow[1],false) end, false)
	addEventHandler("onClientGUIClick",adminpanel.button[6], fixPlayerVehicleOnButtonClick,false)
	addEventHandler("onClientGUIClick",adminpanel.button[7], function() guiSetVisible(adminpanel.vehwindow[1],true) guiBringToFront(adminpanel.vehwindow[1],true) end,false)
	addEventHandler("onClientGUIClick",adminpanel.vehbutton[2],function() guiSetVisible(adminpanel.vehwindow[1],false) end, false)
	addEventHandler("onClientGUIClick",adminpanel.map[1], function() guiMoveToBack(adminpanel.map[1]) guiBringToFront(adminpanel.window[1]) end, false)
	addEventHandler("onClientGUIClick",adminpanel.checkbox[6], function() outputChatBox("This feature is not available yet.",255,0,0) guiCheckBoxSetSelected(adminpanel.checkbox[6],false) end, false)
	addEventHandler("onClientGUIClick",adminpanel.button[15], function() guiSetText(adminpanel.memo[1],"") end, false)
	
	guiSetInputMode("no_binds_when_editing")
end)

function checkIfRequirementsMet()
	if guiGetText(adminpanel.editbox[1]) ~= "" and isItemSelected and guiGridListGetItemText(adminpanel.gridlist[5], guiGridListGetSelectedItem(adminpanel.gridlist[5]), 1) ~= "" then
		guiSetEnabled(adminpanel.button[12], true)
	elseif guiGetText(adminpanel.editbox[1]) ~= "" and guiGridListGetItemText(adminpanel.gridlist[5], guiGridListGetSelectedItem(adminpanel.gridlist[5]), 1) ~= "" and guiGridListGetItemText(adminpanel.gridlist[6], guiGridListGetSelectedItem(adminpanel.gridlist[6]), 1) ~= "" then
		guiSetEnabled(adminpanel.button[13],true)
	end
end

function checkIfStatSelected()
	if guiGetText(adminpanel.statedit[1]) ~= "" and guiGridListGetItemText(adminpanel.statgridlist[1], guiGridListGetSelectedItem(adminpanel.statgridlist[1]), 1) ~= "" then
		guiSetEnabled(adminpanel.statbutton[1], true)
	end
end

function checkIfSkinSelected()
	if guiGridListGetItemText(adminpanel.skingridlist[1], guiGridListGetSelectedItem(adminpanel.skingridlist[1]), 1) ~= "" then
		guiSetEnabled(adminpanel.skinbutton[1], true)
	end
end

function checkIfVehicleSelected()
	if guiGridListGetItemText(adminpanel.vehgridlist[1], guiGridListGetSelectedItem(adminpanel.vehgridlist[1]), 1) ~= "" then
		guiSetEnabled(adminpanel.vehbutton[1], true)
	end
end
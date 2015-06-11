--[[
/**
	@ name: Give-an-Item Panel (GIP)
	@ author: Renkon
	@ version: 1.0
	@ type: DayZ Addon
	@ description: Panel which lets you give items to any player connected to your server.
*/
]]

addEvent("onGIPOpened", true)

local sW, sH = guiGetScreenSize() -- // Variables needed to know the width and height.
local w = 
{ 	
	gridList = {},
	label = {},
	editBox = {},
	button = {},
	comboBox = {}
}
	
local items = 
{
	["Weapons"] = {
		"M4",
		"AK-47",
		"Lee Enfield",
		"CZ 550",
		"MP5A5",
		"PDW",
		"SPAZ-12 Combat Shotgun",
		"Sawn-Off Shotgun",
		"Winchester 1866",
		"M9 SD",
		"M1911",
		"Blaze 95 Double Rifle",
		"Remington 870",
		"Sporter 22",
		"Revolver",
		"Bizon PP-19",
		"FN FAL",
		"G36C",
		"Sa58V CCO",
		"DMR",
		"SVD Dragunov",
		"SKS",
		"Crossbow",
		"Desert Eagle",
		"Binoculars",
		"Tear Gas",
		"Grenade",
		"Satchel",
		"Baseball Bat",
		"Shovel",
		"Golf Club",
		"Hunting Knife",
		"Hatchet"
	},
	
	["Ammo"] = {
		"5.56x45mm Cartridge",
		"5.45x39mm Cartridge",
		"9x18mm Cartridge",
		"9x19mm Cartridge",
		"9x19mm SD Cartridge",
		"9.3x62mm Cartridge",
		".45 ACP Cartridge",
		"Gauge 12 Pellet",
		"2Rnd. Slug",
		"1866 Slug",
		".303 British Cartridge",
		"Bolt",
		
	},
	
	["Food/Drinks"] = {
		"Baked Beans",
		"Pasta",
		"Sardines",
		"Frank & Beans",
		"Can (Corn)",
		"Can (Peas)",
		"Can (Pork)",
		"Can (Stew)",
		"Can (Ravioli)",
		"Can (Fruit)",
		"Can (Chowder)",
		"MRE",
		"Pistachios",
		"Trail Mix",
		"Water Bottle",
		"Soda Can (Pepsi)",
		"Soda Can (Cola)",
		"Soda Can (Mountain Dew)",
		"Can (Milk)",
		"Raw Meat",
		"Cooked Meat",
	},
	
	["Backpacks"] = {
		"Assault Pack (ACU)",
		"Czech Vest Pouch",
		"ALICE Pack",
		"Survival ACU",
		"British Assault Pack",
		"Backpack (Coyote)",
		"Czech Backpack",
	},
	
	["Toolbelt"] = {
		"Box of Matches",
		"IR Goggles",
		"NV Goggles",
		"GPS",
		"Map",
		"Toolbox",
		"Watch",
		"Radio Device",
		"Compass"
	},
	
	["Medical Items"] = {
		"Bandage",
		"Morphine",
		"Heat Pack",
		"Blood Bag",
		"Painkiller",
	},
	
	["Car Parts"] = {
		"Tire",
		"Engine",
		"Tank Parts",
	},
	
	["Clothes"] = {
		"Survivor Clothing",
		"Civilian Clothing",
		"Camouflage Clothing",
		"Ghillie Suit",
	},
	
	["Blueprints"] = {
		"M4 Blueprint",
		"CZ 550 Blueprint",
		"Winchester '66 Blueprint",
		"SPAZ-12 C. Shtgn. Blueprint",
		"Sawn-Off Shtgn. Blueprint",
		"AK-47 Blueprint",
		"Lee Enfield Blueprint",
		"Sporter 22 Blueprint",
		"Mosin 9130 Blueprint",
		"Crossbow Blueprint",
		"SKS Blueprint",
		"Blaze 95 D. R. Blueprint",
		"Remington 870 Blueprint",
		"FN FAL Blueprint",
		"G36C Blueprint",
		"Sa58V Blueprint",
		"SVD Blueprint",
		"DMR Blueprint",
		"M1911 Blueprint",
		"M9 SD Blueprint",
		"PDW Blueprint",
		"G17 Blueprint",
		"MP5A5 Blueprint",
		"Bizon PP-19 Blueprint",
		"Revolver Blueprint",
		"Desert Eagle Blueprint",
		"Hunting Knife Blueprint",
		"Hatchet Blueprint",
		"Baseball Bat Blueprint",
		"Shovel Blueprint",
		"Golf Club Blueprint",
		"Crowbar Blueprint",
		"Parachute Blueprint",
		"Grenade Blueprint",
		"Binoculars Blueprint",
		".45 ACP Cartridge Blueprint",
		"9x19mm SD Cartridge Blueprint",
		"9x19mm Cartridge Blueprint",
		"9x18mm Cartridge Blueprint",
		"5.45x39mm Cartridge Blueprint",
		"5.56x45mm Cartridge Blueprint",
		"1866 Slug Blueprint",
		"2Rnd. Slug Blueprint",
		"12 Gauge Pellet Blueprint",
		"9.3x62mm Cartridge Blueprint",
		".303 British Cartridge Blueprint",
		"Bolt Blueprint",
		"Wire Fence Blueprint",
		"Tent Blueprint",
		"Camouflage Clthng. Blueprint",
		"Survivor Clthng. Blueprint",
		"Civilian Clthng. Blueprint",
		"Ghillie Suit Blueprint",
		"Road Flare Blueprint",
		"Toolbox Blueprint",
		"Radio Device Blueprint",
		"IR Goggles Blueprint",
		"NV Goggles Blueprint",
	},
	
	["Blueprint Parts"] = {
		"Gun Barrel",
		"Short Gun Barrel",
		"Gun Stock",
		"Thread",
		"Cloth",
		"Gun Powder",
		"Mechanical Supplies",
		"Cables",
		"Nails",
		"Sheet",
		"Barbed Wire",
		"Duct Tape",
		"Glue",
		"Drugs",
		"Bandaid",
		"Vitamins",
		"Tissue",
		"Small Box",
		"String",
		"Needle",
		"Microchips",
		"Optics",
		"Sharp Metal",
		"Handle",
		"Wooden Stick",
		"Hand Saw",
		"Metal Plate",
		"Metallic Stick",
		"Small Casing",
	},
	
	["Other"] = {
		"Wood Pile",
		"Empty Gas Canister",
		"Full Gas Canister",
		"Road Flare",	
		"Wire Fence",
		"Tent"
	},
}

local isItemSelected = false

-- // Window creation code --
addEventHandler("onClientResourceStart", resourceRoot,
function()
	w.main = guiCreateWindow(sW/2 - 179, sH/2 - 165, 358, 330, "Give-an-Item Panel (GIP)", false)
	guiWindowSetSizable(w.main, false)
	guiSetAlpha(w.main, 1.00)

	w.gridList.main = guiCreateGridList(10, 26, 151, 291, false, w.main)
	w.gridList.column = guiGridListAddColumn( w.gridList.main, "Player", 0.85 )
	
	w.label.desc = guiCreateLabel(176, 26, 178, 22, "Choose a player from the gridlist!", false, w.main)
	guiSetFont(w.label.desc, "default-bold-small")
	w.label.desc2 = guiCreateLabel(233, 210, 60, 22, "Quantity", false, w.main)
	guiSetFont(w.label.desc2, "default-bold-small")

	w.comboBox.category = guiCreateComboBox(171, 65, 266, 160, "-- Choose a category --", false, w.main)
	w.comboBox.itemList = guiCreateComboBox(171, 145, 266, 50, "-- Choose an item --", false, w.main)
	
	w.editBox.quantity = guiCreateEdit(231, 234, 55, 26, "", false, w.main)
	w.button.give = guiCreateButton(176, 280, 77, 37, "Give", false, w.main)
	w.button.close = guiCreateButton(263, 280, 77, 37, "Close", false, w.main)
	guiSetFont(w.button.give, "default-bold-small")
	guiSetProperty(w.button.give, "NormalTextColour", "FFAAAAAA")
	guiSetFont(w.button.close, "default-bold-small")
	guiSetProperty(w.button.close, "NormalTextColour", "FFAAAAAA")
	
	guiSetVisible(w.main, false)
	guiSetEnabled(w.button.give, false)
	
	for key, value in pairs (items) do
		if type(value) == "table" then
			guiComboBoxAddItem(w.comboBox.category, key)
		end
	end
	
	-- // Making quantity be only edited by numbers --
	addEventHandler("onClientGUIChanged", w.editBox.quantity, 
	function()
		guiSetText(source, guiGetText(source):gsub("[^0-9]","")) -- // We remove everything which is not a number
		check()
	end)
	
	-- // Changing second combobox items when first one changes --
	addEventHandler("onClientGUIComboBoxAccepted", w.comboBox.category,
	function()
		local text = guiComboBoxGetItemText(w.comboBox.category, guiComboBoxGetSelected(w.comboBox.category))
		guiComboBoxClear(w.comboBox.itemList)
		for i, st in ipairs(items[text]) do
			guiComboBoxAddItem(w.comboBox.itemList, st)
		end
		guiComboBoxAdjustHeight(w.comboBox.itemList, #items[text])
	end )
	
	-- // Showing item when second one was accepted. --
	addEventHandler("onClientGUIComboBoxAccepted", w.comboBox.itemList,
	function()
		isItemSelected = true
		check()
	end )
	
	-- // Handling button that closes. --
	addEventHandler ( "onClientGUIClick", w.button.close, 
	function()
		guiSetVisible(w.main, false)
		showCursor(false)
	end, false )
	
	-- // Handling give button. --
	addEventHandler ( "onClientGUIClick", w.button.give, 
	function()
		local playerName = guiGridListGetItemText(w.gridList.main, guiGridListGetSelectedItem(w.gridList.main), 1)
		local item = guiComboBoxGetItemText(w.comboBox.itemList, guiComboBoxGetSelected(w.comboBox.itemList))
		local giver = getPlayerName(localPlayer)
		if (getPlayerFromName(playerName)) then
			triggerServerEvent("onGIPGive", localPlayer, playerName, item, tonumber(guiGetText(w.editBox.quantity)))
		else
			outputChatBox("Player disconnected or changed name!", 255, 0, 0)
				end
		guiSetVisible(w.main, true)
		showCursor(true)
	end, false )

	addEventHandler("onClientGUIClick", w.gridList.main, check)
end )

-- // Remi-X function. Sets height depending on item quantity --
function guiComboBoxAdjustHeight ( combobox, itemcount )
    local width = guiGetSize ( combobox, false )
    return guiSetSize ( combobox, width, ( itemcount * 20 ) + 20, false )
end

-- // Handling when the administrator opens the panel --
-- // Handling when the administrator opens the panel --
addEventHandler("onGIPOpened", root,
function()
	guiGridListClear ( w.gridList.main )
	guiSetEnabled(w.button.give, false)  
	isItemSelected = false
	for id, player in ipairs(getElementsByType("player")) do
		if player ~= localplayer then
			local row = guiGridListAddRow ( w.gridList.main )
			guiGridListSetItemText ( w.gridList.main, row, w.gridList.column, getPlayerName ( player ), false, false )
		end
	end
	guiSetVisible(w.main, true)
	showCursor(true)
end )

function check()
	if guiGetText(w.editBox.quantity) ~= "" and isItemSelected and guiGridListGetItemText(w.gridList.main, guiGridListGetSelectedItem(w.gridList.main), 1) ~= "" then -- // If there's quantity
		guiSetEnabled(w.button.give, true) -- // We enable the button
	end
end
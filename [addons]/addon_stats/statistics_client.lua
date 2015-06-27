--[[

	Resource Name: Statistics Window for DayZ
	Author: L
	Version: 1.0.0
	Description: Allows one to see other players statistics, such as blood, humanity, skin, etc.
    VERSION TYPE: PREMIUM

]]

local playerDataTable = {
-- [[ Weapons ]] --
{"M4"},
{"CZ 550"},
{"Winchester 1866"},
{"SPAZ-12 Combat Shotgun"},
{"Sawn-Off Shotgun"},
{"AK-47"},
{"Lee Enfield"},
{"Sporter 22"},
{"Mosin 9130"},
{"Crossbow"},
{"SKS"},
{"Blaze 95 Double Rifle"},
{"Remington 870"},
{"FN FAL"},
{"G36C"},
{"Sa58V CCO"},
{"SVD Dragunov"},
{"DMR"},
{"M1911"},
{"M9 SD"},
{"PDW"},
{"G17"},
{"MP5A5"},
{"Desert Eagle"},
{"Bizon PP-19"},
{"Revolver"},
{"Hunting Knife"},
{"Hatchet"},
{"Baseball Bat"},
{"Shovel"},
{"Golf Club"},
{"Machete"},
{"Crowbar"},
{"Parachute"},
{"Tear Gas"},
{"Grenade"},
{"Binoculars"},

-- [[ Ammo ]] --
{".45 ACP Cartridge"},
{"9x19mm SD Cartridge"},
{"9x19mm Cartridge"},
{"9x18mm Cartridge"},
{"5.45x39mm Cartridge"},
{"5.56x45mm Cartridge"},
{"1866 Slug"},
{"2Rnd. Slug"},
{"12 Gauge Pellet"},
{"9.3x62mm Cartridge"},
{".303 British Cartridge"},
{"Bolt"},

-- [[ Food / Drinks ]] --
{"Baked Beans"},
{"Pasta"},
{"Sardines"},
{"Frank & Beans"},
{"Can (Corn)"},
{"Can (Peas)"},
{"Can (Pork)"},
{"Can (Stew)"},
{"Can (Ravioli)"},
{"Can (Fruit)"},
{"Can (Chowder)"},
{"Pistachios"},
{"Trail Mix"},
{"MRE"},
{"Water Bottle"},
{"Soda Can (Pepsi)"},
{"Soda Can (Cola)"},
{"Soda Can (Mountain Dew)"},
{"Can (Milk)"},

-- [[ Items ]] --

{"Wood Pile"},
{"Bandage"},
{"Road Flare"},
{"Empty Gas Canister"},
{"Full Gas Canister"},
{"Medic Kit"},
{"Heat Pack"},
{"Painkiller"},
{"Morphine"},
{"Blood Bag"},
{"Wire Fence"},
{"Raw Meat"},
{"Tire"},
{"Engine"},
{"Tank Parts"},
{"Tent"},
{"Box of Matches"},
{"Watch"},
{"GPS"},
{"Map"},
{"Toolbox"},
{"IR Goggles"},
{"NV Goggles"},
{"Cooked Meat"},
{"Radio Device"},
{"Compass"},
{"Camouflage Clothing"},
{"Civilian Clothing"},
{"Survivor Clothing"},
{"Ghillie Suit"},
{"Empty Water Bottle"},
{"Empty Soda Can"},
{"Assault Pack (ACU)"},
{"ALICE Pack"},
{"British Assault Pack"},
{"Czech Vest Pouch"},
{"Backpack (Coyote)"},
{"Czech Backpack"},
{"Survival ACU"},

-- [[ Blueprints ]] --
{"M4 Blueprint"},
{"CZ 550 Blueprint"},
{"Winchester 1866 Blueprint"},
{"SPAZ-12 C. Shtgn. Blueprint"},
{"Sawn-Off Shtgn. Blueprint"},
{"AK-47 Blueprint"},
{"Lee Enfield Blueprint"},
{"Sporter 22 Blueprint"},
{"Mosin 9130 Blueprint"},
{"Crossbow Blueprint"},
{"SKS Blueprint"},
{"Blaze 95 D. R. Blueprint"},
{"Remington 870 Blueprint"},
{"FN FAL Blueprint"},
{"G36C Blueprint"},
{"Sa58V CCO Blueprint"},
{"SVD Dragunov Blueprint"},
{"DMR Blueprint"},
{"M1911 Blueprint"},
{"M9 SD Blueprint"},
{"PDW Blueprint"},
{"G17 Blueprint"},
{"MP5A5 Blueprint"},
{"Bizon PP-19 Blueprint"},
{"Revolver Blueprint"},
{"Desert Eagle Blueprint"},
{"Hunting Knife Blueprint"},
{"Hatchet Blueprint"},
{"Baseball Bat Blueprint"},
{"Shovel Blueprint"},
{"Golf Club Blueprint"},
{"Machete Blueprint"},
{"Crowbar Blueprint"},
{"Parachute Blueprint"},
{"Tear Gas Blueprint"},
{"Grenade Blueprint"},
{"Binoculars Blueprint"},
{".45 ACP Cartridge Blueprint"},
{"9x19mm SD Cartridge Blueprint"},
{"9x19mm Cartridge Blueprint"},
{"9x18mm Cartridge Blueprint"},
{"5.45x39mm Cartridge Blueprint"},
{"5.56x45mm Cartridge Blueprint"},
{"1866 Slug Blueprint"},
{"2Rnd. Slug Blueprint"},
{"12 Gauge Pellet Blueprint"},
{"9.3x62mm Cartridge Blueprint"},
{".303 British Cartridge Blueprint"},
{"Bolt Blueprint"},
{"Medic Kit Blueprint"},
{"Wire Fence Blueprint"},
{"Tent Blueprint"},
{"Camouflage Clthng. Blueprint"},
{"Survivor Clthng. Blueprint"},
{"Civilian Clthng. Blueprint"},
{"Ghillie Suit Blueprint"},
{"Road Flare Blueprint"},
{"Toolbox Blueprint"},
{"Radio Device Blueprint"},
{"IR Goggles Blueprint"},
{"NV Goggles Blueprint"},
{"Gun Barrel"},
{"Short Gun Barrel"},
{"Gun Stock"},
{"Thread"},
{"Cloth"},
{"Gun Powder"},
{"Mechanical Supplies"},
{"Cables"},
{"Nails"},
{"Sheet"},
{"Barbed Wire"},
{"Duct Tape"},
{"Glue"},
{"Drugs"},
{"Bandaid"},
{"Vitamins"},
{"Tissue"},
{"Small Box"},
{"String"},
{"Needle"},
{"Microchips"},
{"Optics"},
{"Sharp Metal"},
{"Handle"},
{"Wooden Stick"},
{"Hand Saw"},
{"Metal Plate"},
{"Metallic Stick"},
{"Small Casing"},
}



addEvent("onStatsOpen", true)

local sW, sH = guiGetScreenSize()
local w = 
{ 	
	gridList = {},
	label = {},
	button = {},
}


getStatistic = {}



addEventHandler("onClientResourceStart", resourceRoot,
function()
	w.main = guiCreateWindow(0.03, 0.04, 0.94, 0.88, "Statistics Window for DayZ", true)
        guiWindowSetSizable(w.main, false)
        guiSetAlpha(w.main, 1.00)

        w.gridList.main = guiCreateGridList(0.02, 0.05, 0.19, 0.93, true, w.main)
        w.gridList.column = guiGridListAddColumn(w.gridList.main, "Player", 0.9)
        w.label.desc = guiCreateLabel(0.30, 0.05, 0.38, 0.08, "Click a player to see his \nstatistics", true, w.main)
        guiSetFont(w.label.desc, "default-bold-small")
        w.label.blood = guiCreateLabel(0.22, 0.15, 0.10, 0.04, "Blood:", true, w.main)
        w.label.getBlood = guiCreateLabel(0.33, 0.15, 0.31, 0.04, "", true, w.main)
        w.label.humanity = guiCreateLabel(0.22, 0.21, 0.10, 0.04, "Humanity:", true, w.main)
        w.label.getHumanity = guiCreateLabel(0.33, 0.21, 0.31, 0.04, "", true, w.main)
        w.label.bandit = guiCreateLabel(0.22, 0.27, 0.10, 0.04, "Bandit:", true, w.main)
        w.label.getBandit = guiCreateLabel(0.33, 0.27, 0.31, 0.04, "", true, w.main)
        w.label.skin = guiCreateLabel(0.22, 0.33, 0.10, 0.04, "Skin:", true, w.main)
        w.label.getSkin = guiCreateLabel(0.33, 0.33, 0.31, 0.04, "", true, w.main)
        w.label.temp = guiCreateLabel(0.22, 0.39, 0.10, 0.04, "Temp.:", true, w.main)
        w.label.getTemp = guiCreateLabel(0.33, 0.39, 0.31, 0.04, "", true, w.main)
        w.label.slots = guiCreateLabel(0.22, 0.45, 0.10, 0.04, "Slots:", true, w.main)
        w.label.getSlots = guiCreateLabel(0.33, 0.45, 0.31, 0.04, "", true, w.main)
        w.label.hunger = guiCreateLabel(0.22, 0.51, 0.10, 0.04, "Hunger:", true, w.main)
        w.label.getHunger = guiCreateLabel(0.33, 0.51, 0.31, 0.04, "", true, w.main)
        w.label.thirst = guiCreateLabel(0.22, 0.57, 0.10, 0.04, "Thirst:", true, w.main)
        w.label.getThirst = guiCreateLabel(0.33, 0.57, 0.31, 0.04, "", true, w.main)
        w.label.login = guiCreateLabel(0.22, 0.63, 0.10, 0.04, "Logged In?:", true, w.main)
        w.label.getLogin = guiCreateLabel(0.33, 0.63, 0.31, 0.04, "", true, w.main)
        w.label.weapon = guiCreateLabel(0.22, 0.69, 0.10, 0.04, "Weapon:", true, w.main)
        w.label.getWeapon = guiCreateLabel(0.33, 0.69, 0.31, 0.04, "", true, w.main)
        w.button.close = guiCreateButton(0.89, 0.92, 0.10, 0.06, "Close", true, w.main)
        guiSetFont(w.button.close, "default-bold-small")
        guiSetProperty(w.button.close, "NormalTextColour", "FFAAAAAA")
        w.button.zone = guiCreateButton(0.22, 0.92, 0.10, 0.06, "Location?", true, w.main)
        guiSetFont(w.button.zone, "default-bold-small")
        guiSetProperty(w.button.zone, "NormalTextColour", "FFAAAAAA")
        w.gridList.inventory = guiCreateGridList(0.65, 0.05, 0.33, 0.86, true, w.main)
        w.gridList.inventoryItem = guiGridListAddColumn(w.gridList.inventory, "Item", 0.7)
		w.gridList.inventoryAmount = guiGridListAddColumn(w.gridList.inventory, "Amount", 0.2)		
	
	guiSetVisible(w.main, false)
	guiSetEnabled(w.button.zone,false)
	

	addEventHandler ( "onClientGUIClick", w.button.close, 
	function()
		guiSetVisible(w.main, false)
		showCursor(false)
	end, false )


	addEventHandler ( "onClientGUIClick", w.button.zone, 
	function()
		local playerName = guiGridListGetItemText(w.gridList.main, guiGridListGetSelectedItem(w.gridList.main), 1)
		if (getPlayerFromName(playerName)) then
			local x,y,z = getElementPosition(getPlayerFromName(playerName))
                        positionX = x
                        positionY = y
                        positionZ = z
			local zone = getZoneName(x,y,z)
			outputChatBox("Current Zone: " ..zone,255,0,0,true)
                        outputChatBox("Exact Position: X = "..positionX..", Y = " ..positionY..", Z = " ..positionZ,255,0,0,true)
		else
			outputChatBox("Player disconnected or changed name", 255, 0, 0)
				end
		guiSetVisible(w.main, true)
		showCursor(true)
	end, false )
	
	addEventHandler("onClientGUIClick", w.gridList.main,
	function()
		guiGridListClear ( w.gridList.inventory )
		local playerName = guiGridListGetItemText ( w.gridList.main, guiGridListGetSelectedItem ( w.gridList.main ), 1 )
		for i,data in ipairs(playerDataTable) do
			local row2 = guiGridListAddRow ( w.gridList.inventory )
			if getElementData(getPlayerFromName(playerName),data[1]) and getElementData(getPlayerFromName(playerName),data[1]) > 0 then
				guiGridListSetItemText ( w.gridList.inventory, row2, w.gridList.inventoryItem, tostring(data[1]), false, false )
				guiGridListSetItemText ( w.gridList.inventory, row2, w.gridList.inventoryAmount, getElementData(getPlayerFromName(playerName),data[1]), false, false )
			end
		end
	end)


	addEventHandler("onClientGUIClick", w.gridList.main, check)
end )


		


addEventHandler("onStatsOpen", root,
function()
	guiGridListClear ( w.gridList.main )
        guiSetEnabled(w.button.zone,false)
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
	local playerName = guiGridListGetItemText ( w.gridList.main, guiGridListGetSelectedItem ( w.gridList.main ), 1 )
	if guiGridListGetItemText(w.gridList.main, guiGridListGetSelectedItem(w.gridList.main), 1) ~= "" then
	    guiSetEnabled(w.button.zone,true)
		getStatistic["blood"] = getElementData(getPlayerFromName(playerName),"blood")
		getStatistic["humanity"] = getElementData(getPlayerFromName(playerName),"humanity")
		getStatistic["bandit"] = getElementData(getPlayerFromName(playerName),"bandit")
 		getStatistic["skin"] = getElementData(getPlayerFromName(playerName),"skin")
 		getStatistic["temp"] = getElementData(getPlayerFromName(playerName),"temperature")
		getStatistic["slots"] = getElementData(getPlayerFromName(playerName),"MAX_Slots")
		getStatistic["hunger"] = getElementData(getPlayerFromName(playerName),"food")
		getStatistic["thirst"] = getElementData(getPlayerFromName(playerName),"thirst")
 		getStatistic["login"] = getElementData(getPlayerFromName(playerName),"logedin")
 		getStatistic["weapon"] = getElementData(getPlayerFromName(playerName),"currentweapon_1")
 		getStatistic["weapon2"] = getElementData(getPlayerFromName(playerName),"currentweapon_2")

 		guiSetText(w.label.getBlood,getStatistic["blood"])
                if getStatistic["blood"] >= 7999 then
 			guiLabelSetColor(w.label.getBlood,0,255,0)
                elseif getStatistic["blood"] >= 3999 then
                        guiLabelSetColor(w.label.getBlood,255,255,0)
                elseif getStatistic["blood"] < 3999 then
                        guiLabelSetColor(w.label.getBlood,255,0,0)
                end

		guiSetText(w.label.getHumanity,getStatistic["humanity"])
                if getStatistic["humanity"] >= 1680 then
			guiLabelSetColor(w.label.getHumanity,0,255,0)
                elseif getStatistic["humanity"] >= 834 then
                        guiLabelSetColor(w.label.getHumanity,255,255,0)
                elseif getStatistic["humanity"] < 834 then
                        guiLabelSetColor(w.label.getHumanity,255,0,0)
                end

		guiSetText(w.label.getSkin,getStatistic["skin"])

		guiSetText(w.label.getTemp,getStatistic["temp"])
                if getStatistic["temp"] >= 36.1 then
			guiLabelSetColor(w.label.getTemp,0,255,0)
                elseif getStatistic["temp"] >= 34.1 then
                        guiLabelSetColor(w.label.getTemp,255,255,0)
                elseif getStatistic["temp"] < 34 then
                        guiLabelSetColor(w.label.getTemp,0,0,255)
                end
		guiSetText(w.label.getSlots,getStatistic["slots"])

		guiSetText(w.label.getHunger,getStatistic["hunger"])
                if getStatistic["hunger"] >= 66.6 then
			guiLabelSetColor(w.label.getHunger,0,255,0)
                elseif getStatistic["hunger"] >= 33.3 then
                        guiLabelSetColor(w.label.getHunger,255,255,0)
                elseif getStatistic["hunger"] < 33.3 then
                        guiLabelSetColor(w.label.getHunger,255,0,0)
                end

		guiSetText(w.label.getThirst,getStatistic["thirst"])
                if getStatistic["thirst"] >= 66.6 then
			guiLabelSetColor(w.label.getThirst,0,255,0)
                elseif getStatistic["thirst"] >= 33.3 then
                        guiLabelSetColor(w.label.getThirst,255,255,0)
                elseif getStatistic["thirst"] < 33.3 then
                        guiLabelSetColor(w.label.getThirst,255,0,0)
                end

		if getStatistic["weapon"] == false and getStatistic["weapon2"] == false then
			guiSetText(w.label.getWeapon,"N/A, N/A ")
		elseif getStatistic["weapon"] == false then
			guiSetText(w.label.getWeapon,"N/A, "..getStatistic["weapon2"])
		elseif getStatistic["weapon2"] == false then
			guiSetText(w.label.getWeapon,getStatistic["weapon"]..", N/A")
                else
			guiSetText(w.label.getWeapon,getStatistic["weapon"]..", "..getStatistic["weapon2"])
                end

		if getStatistic["bandit"] == true then
			guiSetText(w.label.getBandit,"True")
                        guiLabelSetColor(w.label.getBandit,255,0,0)
		else 
			guiSetText(w.label.getBandit,"False")
                        guiLabelSetColor(w.label.getBandit,0,255,0)
		end

		if getStatistic["login"] == true then
			guiSetText(w.label.getLogin,"Yes")
                        guiLabelSetColor(w.label.getLogin,0,255,0)
		else
			guiSetText(w.label.getLogin,"No")
                        guiLabelSetColor(w.label.getLogin,255,0,0)
		end
		
	end
end

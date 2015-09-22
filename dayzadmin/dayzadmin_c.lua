--[[
/**
	Name: DayZ Admin Panel
	Author: L
	Version: 1.0.0
	Description: Comprehensive administration tool for MTA DayZ
*/
]]
function onAdminPanelOpen()
	for i = 1, 6 do
		guiGridListClear(adminpanel.gridlist[i])
	end
	guiGridListClear(adminpanel.statgridlist[1])
	guiGridListClear(adminpanel.statvgridlist[1])
	guiGridListClear(adminpanel.skingridlist[1])
	guiGridListClear(adminpanel.vehgridlist[1])
	-- Populate the players gridlists
	for id, player in ipairs(getElementsByType("player")) do
		local row = guiGridListAddRow(adminpanel.gridlist[1])
		local row2 = guiGridListAddRow(adminpanel.gridlist[5])
		local row3 = guiGridListAddRow(adminpanel.statgridlist[1])
		local row4 = guiGridListAddRow(adminpanel.skingridlist[1])
		local row5 = guiGridListAddRow(adminpanel.vehgridlist[1])
		guiGridListSetItemText (adminpanel.gridlist[1], row, adminpanel.column[1], getPlayerName(player),false,false)
		guiGridListSetItemText (adminpanel.gridlist[5], row2, adminpanel.column[3], getPlayerName(player),false,false)
		guiGridListSetItemText (adminpanel.statgridlist[1], row3, adminpanel.statcolumn[1], getPlayerName(player),false,false)
		guiGridListSetItemText (adminpanel.skingridlist[1], row4, adminpanel.skincolumn[1], getPlayerName(player),false,false)
		guiGridListSetItemText (adminpanel.vehgridlist[1], row5, adminpanel.vehcolumn[1], getPlayerName(player),false,false)
	end
	-- Populate the vehicle gridlists
	for id, vehicle in ipairs(getElementsByType("vehicle")) do
		local row = guiGridListAddRow(adminpanel.gridlist[3])
		if getElementData(vehicle,"parent") then
			guiGridListSetItemText (adminpanel.gridlist[3], row, adminpanel.column[2], tostring(getElementData(getElementData(vehicle,"parent"),"vehicle_name")),false,false)
			guiGridListSetItemText (adminpanel.gridlist[3], row, adminpanel.column[8], getElementID(getElementData(vehicle,"parent")),false,false)
		end
	end
	guiSetVisible(adminpanel.window[1],true)
	guiSetEnabled(adminpanel.button[12],false)
	guiSetEnabled(adminpanel.button[13],false)
	guiSetEnabled(adminpanel.statbutton[1],false)
	guiSetInputEnabled( true )
	showCursor(true)
end
addEvent("onAdminPanelOpen",true)
addEventHandler("onAdminPanelOpen",root,onAdminPanelOpen)

function onAdminPanelUpdateLiveMapPlayer()
	for id, player in ipairs(getElementsByType("player")) do
		if playerBlipsVisible then
			if not adminpanel.image[player] then
				adminpanel.image[player] = guiCreateStaticImage(0.488,0.488,0.01,0.01, player == localPlayer and "images/playerblip.png" or "images/playerblip.png", true, adminpanel.tab[5])
				adminpanel.label[player] = guiCreateLabel(0.488,0.488,0.1,0.03, getPlayerName(player), true, adminpanel.tab[5])
			else
				guiSetVisible(adminpanel.image[player],true)
				guiSetVisible(adminpanel.label[player],true)
			end
			local x, y = getElementPosition(player)
			local mX,mY = guiGetSize(adminpanel.map[1],false)
			x = math.floor((x + 3000) * mX / 6000) + 10
			y = math.floor((3000 - y) * mY / 6000) + 10
			guiSetPosition(adminpanel.image[player], x, y, false)
			guiSetPosition(adminpanel.label[player], x+10, y-10, false)
		else
			guiSetVisible(adminpanel.image[player],false)
			guiSetVisible(adminpanel.label[player],false)
		end
	end
end

function onAdminPanelUpdateLiveMapVehicles()
	for id, vehicle in ipairs(getElementsByType("vehicle")) do
		if vehicleBlipsVisible then
			if not adminpanel.image[vehicle] then
				adminpanel.image[vehicle] = guiCreateStaticImage(0.488,0.488,0.01,0.01, vehicle and "images/carblip.png", true, adminpanel.tab[5])
			else
				guiSetVisible(adminpanel.image[vehicle],true)
			end
			local x, y = getElementPosition(vehicle)
			local mX,mY = guiGetSize(adminpanel.map[1],false)
			x = math.floor((x + 3000) * mX / 6000) + 10
			y = math.floor((3000 - y) * mY / 6000) + 10
			guiSetPosition(adminpanel.image[vehicle], x, y, false)
		else
			guiSetVisible(adminpanel.image[vehicle],false)
		end
	end
end

function onAdminPanelUpdateLiveMapLoot()
	for id, loot in ipairs(getElementsByType("colshape")) do
		if getElementData(loot,"itemloot") then
			if lootBlipsVisible then
				if not adminpanel.image[loot] then
					adminpanel.image[loot] = guiCreateStaticImage(0.488,0.488,0.01,0.01, loot and "images/lootblip.png", true, adminpanel.tab[5])
				else
					guiSetVisible(adminpanel.image[loot],true)
				end
				local x, y = getElementPosition(loot)
				local mX,mY = guiGetSize(adminpanel.map[1],false)
				x = math.floor((x + 3000) * mX / 6000) + 10
				y = math.floor((3000 - y) * mY / 6000) + 10
				guiSetPosition(adminpanel.image[loot], x, y, false)
			else
				guiSetVisible(adminpanel.image[loot],false)
			end
		end
	end
end

function onAdminPanelClose()
	guiSetVisible(adminpanel.window[1],false)
	guiSetVisible(adminpanel.statwindow[1],false)
	guiSetVisible(adminpanel.statvwindow[1],false)
	guiSetVisible(adminpanel.skinwindow[1],false)
	guiSetInputEnabled( false )
	showCursor(false)
end
addEvent("onAdminPanelClose",true)
addEventHandler("onAdminPanelClose",root,onAdminPanelClose)

-- View Chat Functions
function onPlayerMessageEditMemo(player,msg,msgType)
	if msg then
		if msgType == 0 then
			if localChatLogEnabled then
				guiSetText ( adminpanel.memo[1], guiGetText (adminpanel.memo[1]).."[LOCAL]"..getPlayerName (player)..": "..msg)
				guiSetProperty ( adminpanel.memo[1], "CaratIndex", tostring ( string.len ( guiGetText ( adminpanel.memo[1]) ) ) )
			end
		elseif msgType == 2 then
			if groupChatLogEnabled then
				guiSetText ( adminpanel.memo[1], guiGetText (adminpanel.memo[1]).."[CAMP]"..getPlayerName (player)..": "..msg)
				guiSetProperty ( adminpanel.memo[1], "CaratIndex", tostring ( string.len ( guiGetText ( adminpanel.memo[1]) ) ) )
			end
		elseif msgType == 3 then
			guiSetText ( adminpanel.memo[1], guiGetText (adminpanel.memo[1]).."[GLOBAL MESSAGE]"..getPlayerName (player)..": "..msg)
			guiSetProperty ( adminpanel.memo[1], "CaratIndex", tostring ( string.len ( guiGetText ( adminpanel.memo[1]) ) ) )
		else
			guiSetText ( adminpanel.memo[1], guiGetText (adminpanel.memo[1]).."[UNKNOWN]"..getPlayerName (player)..": "..msg)
			guiSetProperty ( adminpanel.memo[1], "CaratIndex", tostring ( string.len ( guiGetText ( adminpanel.memo[1]) ) ) )
		end
	end
end
addEvent("onPlayerMessageEditMemo",true)
addEventHandler("onPlayerMessageEditMemo",root,onPlayerMessageEditMemo)

-- For Tab: "Players"
function populateStatsOnPlayerSelect()
local playerName = guiGridListGetItemText (adminpanel.gridlist[1], guiGridListGetSelectedItem (adminpanel.gridlist[1]),1)
	if guiGridListGetItemText(adminpanel.gridlist[1], guiGridListGetSelectedItem(adminpanel.gridlist[1]), 1) ~= "" then
		if not getElementData(getPlayerFromName(playerName),"logedin") then return end
		local text = ""
		local x,y,z = getElementPosition(getPlayerFromName(playerName))
		local bandit = ""
		guiSetText(adminpanel.label[16],tostring(getElementData(getPlayerFromName(playerName),"blood")))
		guiSetText(adminpanel.label[17],tostring(getElementData(getPlayerFromName(playerName),"food")))
		guiSetText(adminpanel.label[18],tostring(getElementData(getPlayerFromName(playerName),"thirst")))
		guiSetText(adminpanel.label[19],tostring(getElementData(getPlayerFromName(playerName),"temperature")))
		guiSetText(adminpanel.label[20],tostring(getElementData(getPlayerFromName(playerName),"humanity")))
		if not getElementData(getPlayerFromName(playerName),"bandit") then
			bandit = "No"
		else
			bandit = "Yes"
		end
		guiSetText(adminpanel.label[21],bandit)
		guiSetText(adminpanel.label[22],tostring(getElementData(getPlayerFromName(playerName),"zombieskilled")))
		guiSetText(adminpanel.label[23],tostring(getElementData(getPlayerFromName(playerName),"alivetime")))
		guiSetText(adminpanel.label[24],tostring(getElementData(getPlayerFromName(playerName),"daysalive")))
		guiSetText(adminpanel.label[25],tostring(getElementData(getPlayerFromName(playerName),"MAX_Slots")))
		guiSetText(adminpanel.label[26],tostring(getElementData(getPlayerFromName(playerName),"murders")))
		guiSetText(adminpanel.label[27],tostring(getElementData(getPlayerFromName(playerName),"headshots")))
		guiSetText(adminpanel.label[28],tostring(getElementData(getPlayerFromName(playerName),"skin")))
		guiSetText(adminpanel.label[29],tostring(getElementData(getPlayerFromName(playerName),"currentweapon_1") or "N/A"))
		if not getPedOccupiedVehicle(getPlayerFromName(playerName)) then
			text = "On Foot"
		else
			text = getVehicleName(getPedOccupiedVehicle(getPlayerFromName(playerName)))
		end
		guiSetText(adminpanel.label[31],text)
		guiSetText(adminpanel.label[34],tostring(math.floor(x)..", "..math.floor(y)..", "..math.floor(z)))
		
		guiSetText(adminpanel.button[4],"Warp to "..playerName)
		
		for i, data in ipairs (playerDataTable) do
			if getElementData(getPlayerFromName(playerName),data[1]) and getElementData(getPlayerFromName(playerName),data[1]) > 0 then
				local row = guiGridListAddRow(adminpanel.gridlist[2])
				guiGridListSetItemText (adminpanel.gridlist[2], row, adminpanel.column[5], tostring(data[1]),false,false)
				guiGridListSetItemText (adminpanel.gridlist[2], row, adminpanel.column[6], getElementData(getPlayerFromName(playerName),data[1]),false,false)
			end
		end
	end
end

-- For Tab: "Vehicles"
function populateStatsOnVehicleSelect()
-- Trigger a server event that pulls all vehicle elements from the table in vehicle_spawns (vehTable) so we can use that to get the necessary data
local vehicleID = guiGridListGetItemText (adminpanel.gridlist[3], guiGridListGetSelectedItem (adminpanel.gridlist[3]),2)
	if guiGridListGetItemText(adminpanel.gridlist[3], guiGridListGetSelectedItem(adminpanel.gridlist[3]), 2) ~= "" then
		guiSetText(adminpanel.label[50],tostring(getElementHealth(getElementData(getElementByID(vehicleID),"parent"))).."%")
		guiSetText(adminpanel.label[51],tostring(getElementData(getElementByID(vehicleID),"MAX_Slots")))
		guiSetText(adminpanel.label[52],tostring(getElementData(getElementByID(vehicleID),"Tire_inVehicle")))
		guiSetText(adminpanel.label[53],tostring(getElementData(getElementByID(vehicleID),"Engine_inVehicle")))
		guiSetText(adminpanel.label[54],tostring(getElementData(getElementByID(vehicleID),"Parts_inVehicle")))
		guiSetText(adminpanel.label[55],tostring(getElementData(getElementByID(vehicleID),"Glass_inVehicle")))
		guiSetText(adminpanel.label[56],tostring(getElementData(getElementByID(vehicleID),"Rotary_inVehicle")))
		guiSetText(adminpanel.label[57],tostring(getElementModel(getElementData(getElementByID(vehicleID),"parent"))))
		guiSetText(adminpanel.label[58],tostring(getElementData(getElementByID(vehicleID),"fuel")))
		guiSetText(adminpanel.label[59],tostring(getElementData(getElementByID(vehicleID),"maxfuel")))
		local x,y,z = getElementPosition(getElementData(getElementByID(vehicleID),"parent"))
		local rX,rY,rZ = getElementRotation(getElementData(getElementByID(vehicleID),"parent"))
		guiSetText(adminpanel.label[60],"X: "..tostring(math.floor(x)).." , Y: "..tostring(math.floor(y)).." Z: "..tostring(math.floor(z)))
		guiSetText(adminpanel.label[61],tostring(rX)..", "..tostring(rY)..", "..tostring(rZ))
		guiGridListClear(adminpanel.gridlist[4])
		for i, data in ipairs (playerDataTable) do
			if getElementData(getElementByID(vehicleID),data[1]) and getElementData(getElementByID(vehicleID),data[1]) > 0 then
				local row = guiGridListAddRow(adminpanel.gridlist[4])
				guiGridListSetItemText (adminpanel.gridlist[4], row, adminpanel.column[9], tostring(data[1]),false,false)
				guiGridListSetItemText (adminpanel.gridlist[4], row, adminpanel.column[10], getElementData(getElementByID(vehicleID),data[1]),false,false)
			end
		end
		guiSetText(adminpanel.button[11],"Warp to "..tostring(getElementData(getElementByID(vehicleID),"vehicle_name")))
	end
end

-- For Tab: "Inventory Editor"
function showPlayerInventory()
local playerName = guiGridListGetItemText (adminpanel.gridlist[5], guiGridListGetSelectedItem (adminpanel.gridlist[5]),1)
	if guiGridListGetItemText(adminpanel.gridlist[5], guiGridListGetSelectedItem(adminpanel.gridlist[5]), 1) ~= "" then
		for i, data in ipairs (playerDataTable) do
			if getElementData(getPlayerFromName(playerName),data[1]) and getElementData(getPlayerFromName(playerName),data[1]) > 0 then
				local row = guiGridListAddRow(adminpanel.gridlist[6])
				guiGridListSetItemText (adminpanel.gridlist[6], row, adminpanel.column[4], tostring(data[1]),false,false)
				guiGridListSetItemText (adminpanel.gridlist[6], row, adminpanel.column[7], getElementData(getPlayerFromName(playerName),data[1]),false,false)
			end
		end
	end
end

function killPlayerOnButtonClick()
local playerName = guiGridListGetItemText (adminpanel.gridlist[1], guiGridListGetSelectedItem (adminpanel.gridlist[1]),1)
	if guiGridListGetItemText(adminpanel.gridlist[1], guiGridListGetSelectedItem(adminpanel.gridlist[1]), 1) ~= "" then
		if not getElementData(getPlayerFromName(playerName),"logedin") then return end
		triggerServerEvent("onAdminPanelKillPlayer",localPlayer, playerName)
	end
end

function healPlayerOnButtonClick()
local playerName = guiGridListGetItemText (adminpanel.gridlist[1], guiGridListGetSelectedItem (adminpanel.gridlist[1]),1)
	if guiGridListGetItemText(adminpanel.gridlist[1], guiGridListGetSelectedItem(adminpanel.gridlist[1]), 1) ~= "" then
		if not getElementData(getPlayerFromName(playerName),"logedin") then return end
		triggerServerEvent("onAdminPanelHealPlayer",localPlayer, playerName)
	end
end

function fixPlayerVehicleOnButtonClick()
local playerName = guiGridListGetItemText (adminpanel.gridlist[1], guiGridListGetSelectedItem (adminpanel.gridlist[1]),1)
	if guiGridListGetItemText(adminpanel.gridlist[1], guiGridListGetSelectedItem(adminpanel.gridlist[1]), 1) ~= "" then
		if not getElementData(getPlayerFromName(playerName),"logedin") then return end
		vehicle = getPedOccupiedVehicle(getPlayerFromName(playerName))
		if vehicle then
			triggerServerEvent("onAdminPanelFixVehicle",localPlayer,vehicle,playerName)
		else
			outputChatBox("Player is not in a vehicle!",255,0,0)
		end
	end
end

function warpToPlayerOnButtonClick()
local playerName = guiGridListGetItemText (adminpanel.gridlist[1], guiGridListGetSelectedItem (adminpanel.gridlist[1]),1)
	if guiGridListGetItemText(adminpanel.gridlist[1], guiGridListGetSelectedItem(adminpanel.gridlist[1]), 1) ~= "" then
		local x,y,z = getElementPosition(getPlayerFromName(playerName))
		setElementPosition(localPlayer,x,y+2,z+1)
		outputChatBox("You have been warped to "..playerName,0,255,0)
	end
end

function warpToVehicleOnButtonClick()
local vehicleID = guiGridListGetItemText (adminpanel.gridlist[3], guiGridListGetSelectedItem (adminpanel.gridlist[3]),2)
	if guiGridListGetItemText(adminpanel.gridlist[3], guiGridListGetSelectedItem(adminpanel.gridlist[3]), 2) ~= "" then
		local x,y,z = getElementPosition(getElementData(getElementByID(vehicleID),"parent"))
		setElementPosition(localPlayer,x,y+2,z+1)
		outputChatBox("You have been warped to the "..tostring(getElementData(getElementByID(vehicleID),"vehicle_name")),0,255,0)
	end
end

function killVehicleOnButtonClick()
local vehicleID = guiGridListGetItemText (adminpanel.gridlist[3], guiGridListGetSelectedItem (adminpanel.gridlist[3]),2)
	if guiGridListGetItemText(adminpanel.gridlist[3], guiGridListGetSelectedItem(adminpanel.gridlist[3]), 2) ~= "" then
		triggerServerEvent("onAdminPanelKillVehicle",localPlayer, vehicleID)
	end
end

function getVehicleInfos(id)
	for i,veh in ipairs(vehicleInfo) do
		if veh[1] == id then
			return veh[2],veh[3], veh[4], veh[5], veh[6], veh[7],veh[8],veh[9], veh[10], veh[11], veh[12]
		end
	end
end
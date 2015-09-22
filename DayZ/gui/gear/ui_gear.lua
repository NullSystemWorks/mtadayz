--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: ui_gear.lua							*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: CLIENT														*----
#-----------------------------------------------------------------------------#
]]

local screenWidth,screenHeight = guiGetScreenSize()
local button = dxCreateTexture ( ":DayZ/gui/gear/inventory/butoff.png" )
local button2 = dxCreateTexture ( ":DayZ/gui/gear/inventory/butclick.png" )
local buttArrow = dxCreateTexture ( ":DayZ/gui/gear/inventory/buttArrow.png" )
local buttArrowDown = dxCreateTexture ( ":DayZ/gui/gear/inventory/buttArrowDown.png" )
local inventoryShow = false
bX, bY = screenWidth/2,screenHeight/2

inventory = {}
inventoryWeap = {}
inventoryWeap.main = {}
inventoryWeap.addit = {}
inventoryWeap.spec = {}
inventoryWeap.ammo = {}

foodInventory={}
toolInventory={}
itemsInventory={}
ammoInventory={}
gearName = ""
isCarryingWeapon = false
isHoldingWeapon = false
isOpeningBackpack = false
loot = false

prevY = 0
prevYPos = 0
itOff = 0
heightLabel = ((screenHeight/2-90)-5*(#inventory-9))-(screenHeight/2-235)

local clicked=false
scrollLabelSelected = false

mainWeaponSelection = false
additWeaponSelection = false
selectedMainWeapon = 0
selectedAdditWeapon = 0
selectedItemLabel = 0
selectedItemLabelID = 0
selectedAmmoLabelID = 0
selectedToolLabelID = 0
selectedSpecLabelID = 0
rightItemLabelSelected = false
ammoLabelSelected = false
specLabelSelected = false
toolLabelSelected = false

itemLabels = {}
itemLabelsButtons ={}
ammoLabelsButtons={}
toolLabelsButtons={}
rightItemLabelButtons = {}
weaponLabelsButtons = {}
weaponStatusLabelsButtons = {}
itemLabelID = {}

languageCode = getLocalization()["code"]

function checkTheLanguage()
	if languageCode == "en_US" then
		languageCode = "en_US"
	elseif languageCode == "de" then
		languageCode = "de"
	elseif languageCode == "cs" then
		languageCode = "cs"
	elseif languageCode == "nl" then
		languageCode = "nl"
	elseif languageCode == "pt_BR" then
		languageCode = "pt_BR"
	elseif languageCode == "zh" then
		languageCode = "zh"
	elseif languageCode == "es" then
		languageCode = "es"
	elseif languageCode == "fr" then
		languageCode = "fr"
	elseif languageCode == "ro" then
		languageCode = "ro"
	elseif languageCode == "pl" then
		languageCode = "pl"
	else
		languageCode = "en_US"
	end
end
addEventHandler("onClientResourceStart",root,checkTheLanguage)

local languageTable = {
{"en","en_US"},
{"de","de"},
{"cs","cs"},
{"nl","nl"},
{"br","pt_BR"},
{"zh","zh"},
{"es","es"},
{"fr","fr"},
{"ro","ro"},
{"pl","pl"},
}

function changeLanguageOnCommand(playerSource,language)
	if language then
		for i, lang in ipairs(languageTable) do
			if language == lang[1] then
				languageCode = lang[2]
				outputChatBox("New language: "..tostring(languageCode),0,255,0)
			end
		end
	else
		outputChatBox("Please specify a language. Possible values: en, de, cs, nl, br, zh, es, fr, ro, pl.",255,0,0)
	end
end
addCommandHandler("language",changeLanguageOnCommand)

function getPlayerCurrentSlots()
local current_SLOTS = 0
	for id,item in ipairs(itemWeightTable) do
		if getElementData(localPlayer, item[1]) and getElementData(localPlayer, item[1]) >= 1 then
			current_SLOTS = current_SLOTS + item[2] * getElementData(localPlayer, item[1])
		end
	end
	if isCarryingWeapon then
		setElementData(localPlayer,"CURRENT_Slots",math.floor(current_SLOTS))
		--current_SLOTS = math.floor(current_SLOTS)
	elseif isHoldingWeapon then
		setElementData(localPlayer,"CURRENT_Slots",math.floor(current_SLOTS)-10)
		--current_SLOTS = math.floor(current_SLOTS)-10
	else
		setElementData(localPlayer,"CURRENT_Slots",math.floor(current_SLOTS))
		--current_SLOTS = math.floor(current_SLOTS)
	end
	return getElementData(localPlayer,"CURRENT_Slots") --math.floor(current_SLOTS)
end

function getLootCurrentSlots(loot)
	if isElement ( loot ) then
		local current_SLOTS = 0
		for id,item in ipairs(itemWeightTable) do
			if getElementData(loot, item[1]) and getElementData(loot, item[1]) >= 1 then
				current_SLOTS = current_SLOTS + item[2] * getElementData(loot, item[1])
			end
		end
		return math.floor(current_SLOTS)
	else
		return false
	end
end

function getItemSlots(theItem)
local current_SLOTS = 0
	for id,item in ipairs(itemWeightTable) do
		if theItem == item[1] then
			return item[2]
		end
	end
	return false
end

--[[
function getPlayerCurrentSlots()
local current_SLOTS = 0
	for id,item in ipairs(languageTextTable[languageCode]["Weapons"]["Primary Weapon"]) do
		if getElementData(localPlayer, item[1]) and getElementData(localPlayer, item[1]) >= 1 then
			current_SLOTS = current_SLOTS + item[2] * getElementData(localPlayer, item[1])
		end
	end
	for id,item in ipairs(languageTextTable[languageCode]["Weapons"]["Secondary Weapon"]) do
		if getElementData(localPlayer, item[1]) and getElementData(localPlayer, item[1]) >= 1 then
			current_SLOTS = current_SLOTS + item[2] * getElementData(localPlayer, item[1])
		end
	end
	for id,item in ipairs(languageTextTable[languageCode]["Weapons"]["Specially Weapon"]) do
		if getElementData(localPlayer, item[1]) and getElementData(localPlayer, item[1]) >= 1 then
			current_SLOTS = current_SLOTS + item[2] * getElementData(localPlayer, item[1])
		end
	end
	for id,item in ipairs(languageTextTable[languageCode]["Ammo"]) do
		if getElementData(localPlayer, item[1]) and getElementData(localPlayer, item[1]) >= 1 then
			current_SLOTS = current_SLOTS + item[2] * getElementData(localPlayer, item[1])
		end
	end
	for id,item in ipairs(languageTextTable[languageCode]["Food"]) do
		if getElementData(localPlayer, item[1]) and getElementData(localPlayer, item[1]) >= 1 then
			current_SLOTS = current_SLOTS + item[2] * getElementData(localPlayer, item[1])
		end
	end
	for id,item in ipairs(languageTextTable[languageCode]["Items"]) do
		if getElementData(localPlayer, item[1]) and getElementData(localPlayer, item[1]) >= 1 then
			current_SLOTS = current_SLOTS + item[2] * getElementData(localPlayer, item[1])
		end
	end
	if isCarryingWeapon then
		setElementData(localPlayer,"CURRENT_Slots",math.floor(current_SLOTS))
	elseif isHoldingWeapon then
		setElementData(localPlayer,"CURRENT_Slots",math.floor(current_SLOTS)-10)
	else
		setElementData(localPlayer,"CURRENT_Slots",math.floor(current_SLOTS))
	end
return getElementData(localPlayer,"CURRENT_Slots") --math.floor(current_SLOTS)
end


function getLootCurrentSlots(loot)
	if isElement ( loot ) then
	  local current_SLOTS = 0
	  for id,item in ipairs(languageTextTable[languageCode]["Weapons"]["Primary Weapon"]) do
		if getElementData(loot, item[1]) and getElementData(loot, item[1]) >= 1 then
		  current_SLOTS = current_SLOTS + item[2] * getElementData(loot, item[1])
		end
	  end
	  for id,item in ipairs(languageTextTable[languageCode]["Weapons"]["Secondary Weapon"]) do
		if getElementData(loot, item[1]) and getElementData(loot, item[1]) >= 1 then
		  current_SLOTS = current_SLOTS + item[2] * getElementData(loot, item[1])
		end
	  end
	  for id,item in ipairs(languageTextTable[languageCode]["Weapons"]["Specially Weapon"]) do
		if getElementData(loot, item[1]) and getElementData(loot, item[1]) >= 1 then
		  current_SLOTS = current_SLOTS + item[2] * getElementData(loot, item[1])
		end
	  end
	  for id,item in ipairs(languageTextTable[languageCode]["Ammo"]) do
		if getElementData(loot, item[1]) and getElementData(loot, item[1]) >= 1 then
		  current_SLOTS = current_SLOTS + item[2] * getElementData(loot, item[1])
		end
	  end
	  for id,item in ipairs(languageTextTable[languageCode]["Food"]) do
		if getElementData(loot, item[1]) and getElementData(loot, item[1]) >= 1 then
		  current_SLOTS = current_SLOTS + item[2] * getElementData(loot, item[1])
		end
	  end
	  for id,item in ipairs(languageTextTable[languageCode]["Items"]) do
		if getElementData(loot, item[1]) and getElementData(loot, item[1]) >= 1 then
		  current_SLOTS = current_SLOTS + item[2] * getElementData(loot, item[1])
		end
	  end
	  return math.floor(current_SLOTS)
	else
		return false
	end
end

function getItemSlots(itema)
local current_SLOTS = 0
	for id,item in ipairs(languageTextTable[languageCode]["Weapons"]["Primary Weapon"]) do
		if itema == item[1] then
			return item[2]
		end
	end
	for id,item in ipairs(languageTextTable[languageCode]["Weapons"]["Secondary Weapon"]) do
		if itema == item[1] then
			return item[2]
		end
	end
	for id,item in ipairs(languageTextTable[languageCode]["Weapons"]["Specially Weapon"]) do
		if itema == item[1] then
			return item[2]
		end
	end
	for id,item in ipairs(languageTextTable[languageCode]["Ammo"]) do
		if itema == item[1] then
			return item[2]
		end
	end
	for id,item in ipairs(languageTextTable[languageCode]["Food"]) do
		if itema == item[1] then
			return item[2]
		end
	end
	for id,item in ipairs(languageTextTable[languageCode]["Items"]) do
		if itema == item[1] then
			return item[2]
		end
	end
return false
end
]]

function isToolbeltItem(theItem)
local current_SLOTS = 0
	for id,item in ipairs(itemWeightTable) do
		if theItem == item[1] and item[2] == 0 then
			return true
		end
	end
	return false
end

function getThisItemInLoot (name)
	local loot = isPlayerInLoot()
	if isElement(loot) then
		local item = getElementData ( loot, name )
		return item or 0
	else
		return 0
	end
end

function removeItemFromInventory (name)
	for i, weap in ipairs ( inventoryWeap.main ) do
		if name == weap[1] then
			if selectedMainWeapon == i then
				selectedMainWeapon = 0
			elseif selectedMainWeapon > i then
				selectedMainWeapon = selectedMainWeapon-1
			end
			table.remove ( inventoryWeap.main, i ) 
		end
	end
	for i, weap in ipairs ( inventoryWeap.addit ) do
		if name == weap[1] then
			if selectedMainWeapon == i then
				selectedMainWeapon = 0
			elseif selectedMainWeapon > i then
				selectedMainWeapon = selectedMainWeapon-1
			end
			table.remove ( inventoryWeap.addit, i ) 
		end
	end
	for i, weap in ipairs ( inventoryWeap.spec ) do
		if name == weap[1] then
			table.remove ( inventoryWeap.spec, i )
		end
	end
	for i, weap in ipairs ( foodInventory ) do
		if name == weap[1] then
			table.remove ( foodInventory, i )
		end
	end
	for i, weap in ipairs ( toolInventory ) do
		if name == weap[1] then
			table.remove ( toolInventory, i )
		end
	end
	for i, weap in ipairs(itemsInventory) do
		if name == weap[1] then
			table.remove(itemsInventory, i)
		end
	end
	for i, weap in ipairs(ammoInventory) do
		if name == weap[1] then
			table.remove(ammoInventory, i)
		end
	end
end

function checkIfPlayerHasWeapon()
	setTimer(function(source)
		if getElementData(source,"currentweapon_1") then
			isCarryingWeapon = false
			isHoldingWeapon = true
		else
			isCarryingWeapon = false
			isHoldingWeapon = false
		end
	end, 500,1,source)
end
addEventHandler("onClientPlayerSpawn",localPlayer,checkIfPlayerHasWeapon)

function placeItemsInInventory()
	local loot = isPlayerInLoot()
	inventory = {}
	inventoryWeap = {}
	inventoryWeap.main = {}
	inventoryWeap.addit = {}
	inventoryWeap.spec = {}
	
	foodInventory={}
	toolInventory={}
	itemsInventory={}
	ammoInventory={}
		for i, weap in ipairs ( languageTextTable[languageCode]["Weapons"]["Primary Weapon"] ) do
			local inLoot = getThisItemInLoot (weap[1])
			local inInventory = getElementData ( localPlayer, weap[1] ) or 0
			if inLoot > 0 or inInventory > 0 then
				table.insert ( inventory, {weap[1],inLoot,inInventory,weap[3],weap[4],weap[5],weap[6],weap[7],weap[8]} )
			end
		end
		for i, weap in ipairs ( languageTextTable[languageCode]["Weapons"]["Primary Weapon"] ) do
			if getElementData ( localPlayer, weap[1] ) and getElementData ( localPlayer, weap[1] ) >= 1 then
				table.insert ( inventoryWeap.main, {weap[1],weap[3],weap[4],weap[5]} )
				if getElementData(localPlayer, "currentweapon_1") == weap[1] then
					selectedMainWeapon = #inventoryWeap.main
				end
			end
		end
		for i, weap in ipairs ( languageTextTable[languageCode]["Weapons"]["Secondary Weapon"] ) do
			local inLoot = getThisItemInLoot (weap[1])
			local inInventory = getElementData ( localPlayer, weap[1] ) or 0
			if inLoot > 0 or inInventory > 0 then
				table.insert ( inventory, {weap[1],inLoot,inInventory,weap[3],weap[4],weap[5],weap[6],weap[7],weap[8]} )
			end
		end
		for i, weap in ipairs ( languageTextTable[languageCode]["Weapons"]["Secondary Weapon"] ) do
			if getElementData ( localPlayer, weap[1] ) and getElementData ( localPlayer, weap[1] ) >= 1 then
				table.insert ( inventoryWeap.addit, {weap[1],weap[3],weap[4],weap[5],weap[6],weap[7],weap[8]} )
				if getElementData(localPlayer, "currentweapon_2") == weap[1] then
					selectedAdditWeapon = #inventoryWeap.addit
				end
			end
		end
		for i, weap in ipairs ( languageTextTable[languageCode]["Weapons"]["Specially Weapon"] ) do
			local inLoot = getThisItemInLoot (weap[1])
			local inInventory = getElementData ( localPlayer, weap[1] ) or 0
			if inLoot > 0 or inInventory > 0 then
				table.insert ( inventory, {weap[1],inLoot,inInventory,weap[3],weap[4],weap[5],weap[6],weap[7],weap[8]} )
			end
		end
		for i, weap in ipairs ( languageTextTable[languageCode]["Weapons"]["Specially Weapon"] ) do
			if getElementData ( localPlayer, weap[1] ) and getElementData ( localPlayer, weap[1] ) >= 1 then
				table.insert ( inventoryWeap.addit, {weap[1],weap[3],weap[4],weap[5],weap[6],weap[7],weap[8]} )
				if getElementData(localPlayer, "currentweapon_2") == weap[1] then
					selectedAdditWeapon = #inventoryWeap.addit
				end
			end
		end
		for i, weap in ipairs ( languageTextTable[languageCode]["Ammo"] ) do
			local inLoot = getThisItemInLoot (weap[1])
			local inInventory = getElementData ( localPlayer, weap[1] ) or 0
			if inLoot > 0 or inInventory > 0 then
				table.insert ( inventory, {weap[1],inLoot,inInventory,weap[3],weap[4],weap[5],weap[6],weap[7],weap[8]} )
			end
		end
		for i, weap in ipairs ( languageTextTable[languageCode]["Food"] ) do
			if getElementData ( localPlayer, weap[1] ) and getElementData ( localPlayer, weap[1] ) >= 1 then
				table.insert(itemsInventory, {weap[1],weap[3],weap[4],weap[5],weap[6],weap[7],weap[8]})
			end
		end
		for i, weap in ipairs ( languageTextTable[languageCode]["Ammo"] ) do
			if getElementData ( localPlayer, weap[1] ) and getElementData ( localPlayer, weap[1] ) >= 1 then
				if weap[1] == "11.43x23mm Cartridge" or weap[1] == "9x19mm Cartridge" or weap[1] == "9x18mm Cartridge" then
					table.insert(ammoInventory, {weap[1],weap[3],weap[4],weap[5],weap[6],weap[7],weap[8]})
				else
					table.insert(itemsInventory, {weap[1],weap[3],weap[4],weap[5],weap[6],weap[7],weap[8]})
				end
			end
		end
		for i, weap in ipairs ( languageTextTable[languageCode]["Items"] ) do
			if getElementData ( localPlayer, weap[1] ) and getElementData ( localPlayer, weap[1] ) >= 1 then
				if weap[1] == "Bandage" then
					table.insert(ammoInventory, {weap[1],weap[3],weap[4],weap[5],weap[6],weap[7],weap[8]})
				else
					table.insert(itemsInventory, {weap[1],weap[3],weap[4],weap[5],weap[6],weap[7],weap[8]})
				end
			end
		end
		for i, weap in ipairs ( languageTextTable[languageCode]["Toolbelt"] ) do
			if getElementData ( localPlayer, weap[1] ) and getElementData ( localPlayer, weap[1] ) >= 1 then
				table.insert ( toolInventory, {weap[1],weap[3],weap[4],weap[5],weap[6],weap[7],weap[8]} )
			end
		end
		for i, weap in ipairs ( languageTextTable[languageCode]["Food"] ) do
			local inLoot = getThisItemInLoot (weap[1])
			local inInventory = getElementData ( localPlayer, weap[1] ) or 0
			if inLoot > 0 or inInventory > 0 then
				table.insert ( inventory, {weap[1],inLoot,inInventory,weap[3],weap[4],weap[5],weap[6],weap[7],weap[8]} )
			end
		end
		for i, weap in ipairs ( languageTextTable[languageCode]["Items"] ) do
			local inLoot = getThisItemInLoot (weap[1])
			local inInventory = getElementData ( localPlayer, weap[1] ) or 0
			if inLoot > 0 or inInventory > 0 then
				table.insert ( inventory, {weap[1],inLoot,inInventory,weap[3],weap[4],weap[5],weap[6],weap[7],weap[8]} )
			end
		end
		for i, weap in ipairs ( languageTextTable[languageCode]["Toolbelt"] ) do
			local inLoot = getThisItemInLoot (weap[1])
			local inInventory = getElementData ( localPlayer, weap[1] ) or 0
			if inLoot > 0 or inInventory > 0 then
				table.insert ( inventory, {weap[1],inLoot,inInventory,weap[3],weap[4],weap[5],weap[6],weap[7],weap[8]} )
			end
		end
end

function testoLabClick (but, state, x, y)
	clicked = false
end

addEventHandler( "onClientMouseWheel", root,
    function ( up_down )
        if up_down == 1 then
			if itOff > 0 then
				itOff = itOff-1
				prevY = prevY+5
				guiSetPosition ( testoLab, screenWidth/2-13, screenHeight/2-235-prevY, false )
			end
		else
			if itOff+9 < #inventory then
				itOff = itOff+1
				prevY = prevY-5
				guiSetPosition ( testoLab, screenWidth/2-13, screenHeight/2-235-prevY, false )
			end
		end
    end
)

function testoLabMove (x,y)
	if clicked then
		local newPrevY = prevY+prevYPos-y
		local tempVal = math.abs(prevY)-math.abs(newPrevY)
		if ( ( tempVal > 0 and prevY <= 0 ) or ( tempVal < 0 and itOff+9<#inventory ) ) and tempVal ~= 0 and prevY < 3 and prevY+newPrevY < 0 then
			prevY=newPrevY
			itOff = math.floor(math.abs(prevY/5))
			prevYPos = y
			guiSetPosition ( testoLab, screenWidth/2-13, screenHeight/2-235-prevY, false )
		end
	end
end

function buttonLabelEntered ( )
	if getElementData ( source, 'scrollLabel' )then
		scrollLabelSelected = true
		if selectedItemLabel ~= 0 then
			exports.imageButton:setImageButtonVisible ( itemLabelsButtons[selectedItemLabel][1].name, false )
			exports.imageButton:setImageButtonVisible ( itemLabelsButtons[selectedItemLabel][2].name, false )
			selectedItemLabel = 0
		end
	end
end

function buttonLabelLeaved ( )
	if getElementData ( source, 'scrollLabel' ) then
		scrollLabelSelected = false
	end
end

function checkOnButton ()
	if scrollLabelSelected then
		local screenx, screeny, worldx, worldy, worldz = getCursorPosition()
		prevYPos = screeny*screenHeight
		clicked = true
	end
end

local inventoryButtAllowed = true

function showInventoryManual ()
	if not inventoryShow then
		initInventory ()
	end
end

function initInventory ()
	if inventoryButtAllowed and getElementData(getLocalPlayer(), "logedin") then
		inventoryButtAllowed = false
		setTimer ( function () inventoryButtAllowed = true end, 500, 1 )
		if not inventoryShow then
			inventoryShow = true
			placeItemsInInventory ()
			loot = isPlayerInLoot()
			if loot then
				gearName = getElementData(getLocalPlayer(), "lootname")
			end
			testoLab = guiCreateLabel ( screenWidth/2-16, screenHeight/2-235, 15, heightLabel, '', false )
			setElementData ( testoLab, 'scrollLabel', true )
			bindKey ( 'mouse1', 'down', checkOnButton )
			bindKey ( 'mouse1', 'up', testoLabClick )
			heightLabel = ((screenHeight/2-90)-5*(#inventory-9))-(screenHeight/2-235)
			addEventHandler ( "onClientMouseMove", testoLab, testoLabMove, false )
			addEventHandler( "onClientMouseEnter", testoLab, buttonLabelEntered, false )
			addEventHandler( "onClientMouseLeave", testoLab, buttonLabelLeaved, false )
			local numberInventory = math.random(0,4)
			setSoundVolume(playSound (":DayZ/sounds/items/backpack_"..numberInventory..".ogg",false), .3)
			triggerEvent("disableMenu",localPlayer)
			triggerEvent("hideDebugMonitor",localPlayer)
			triggerEvent("hideGPSOnInventoryOpen",localPlayer)
			addEventHandler ( "onClientRender", root, renderDisplay )
			
			local backpackLabel = guiCreateLabel(bX+330,bY-250,38,97,"",false)
			setElementData ( backpackLabel, 'backpackLabel', true )
			setElementData ( backpackLabel, 'status', false )
			addEventHandler( "onClientMouseEnter", backpackLabel, itemLabelEntered, false )
			addEventHandler( "onClientMouseLeave", backpackLabel, itemLabelLeaved, false )
			--addEventHandler ( "onClientGUIClick", backpackLabel, itemLabelClicked, false )
			
			local carryLabel = guiCreateLabel(bX+330,bY-150,38,97,"",false)
			setElementData ( carryLabel, 'toCarryLabel', true )
			setElementData ( carryLabel, 'status', true )
			addEventHandler( "onClientMouseEnter", carryLabel, itemLabelEntered, false )
			addEventHandler( "onClientMouseLeave", carryLabel, itemLabelLeaved, false )
			addEventHandler ( "onClientGUIClick", carryLabel, changeWeaponStatus, false )
			
			local holdLabel = guiCreateLabel(bX+330,bY-50,38,97,"",false)
			setElementData ( holdLabel, 'toHoldLabel', true )
			setElementData ( holdLabel, 'status', true )
			addEventHandler( "onClientMouseEnter", holdLabel, itemLabelEntered, false )
			addEventHandler( "onClientMouseLeave", holdLabel, itemLabelLeaved, false )
			addEventHandler ( "onClientGUIClick", holdLabel, changeWeaponStatus, false )
			
			table.insert(weaponStatusLabelsButtons,{backpackLabel,holdLabel,carryLabel})
			
			local yOff = 0
			--// Left Side Items
			for i = 1, 9 do
				local createdLabel = guiCreateLabel ( bX-390, bY-230+yOff, 370, 25, '', false )
				setElementData ( createdLabel, 'itemLabel', true )
				setElementData ( createdLabel, 'id', i )
				addEventHandler( "onClientMouseEnter", createdLabel, itemLabelEntered, false )
				addEventHandler( "onClientMouseLeave", createdLabel, itemLabelLeaved, false )
				addEventHandler ( "onClientGUIClick", createdLabel, itemLabelClicked, false )
				local butt1 = exports.imageButton:createImageButton ( 'arrow'..i, bX-380, bY-230+yOff, 23, 23, 0, ':DayZ/gui/gear/inventory/buttArrow.png', ':DayZ/gui/gear/inventory/buttArrowDown.png' )
				local butt2 = exports.imageButton:createImageButton ( 'arrowRev'..i, bX-50, bY-230+yOff, 23, 23, 180, ':DayZ/gui/gear/inventory/buttArrow.png', ':DayZ/gui/gear/inventory/buttArrowDown.png' )
				exports.imageButton:setImageButtonVisible ( 'arrow'..i, false )
				exports.imageButton:setImageButtonVisible ( 'arrowRev'..i, false )
				table.insert ( itemLabelsButtons, { butt1, butt2 } )
				table.insert ( itemLabels, createdLabel )
				table.insert ( itemLabelID, {createdLabel})
				yOff = yOff+30
			end
			--// Right Side Items
			local xOff = 20
			local yOff = 0
			for i = 1, 12 do
				yPos = bY-250-yOff
				if i%2 == 0 then
					xPos = bX+55
					yOff = yOff-50
				else
					xPos = bX+5
				end
				local createdLabel = guiCreateLabel ( xPos, yPos, 45, 45, '', false )
				setElementData ( createdLabel, 'rightItemLabel', true )
				setElementData ( createdLabel, 'id', i )
				addEventHandler( "onClientMouseEnter", createdLabel, itemLabelEntered, false )
				addEventHandler( "onClientMouseLeave", createdLabel, itemLabelLeaved, false )
				addEventHandler ( "onClientGUIClick", createdLabel, rightItemClicked, false )
				table.insert ( rightItemLabelButtons, createdLabel )
			end
			local yOff = 350
			for i=1, 4 do
				if i ~= 4 then
					yOff = yOff-100
					local createdLabel = guiCreateLabel(bX+105,bY-yOff,220,97,'',false)
					setElementData ( createdLabel, 'stuffLabel', true )
					setElementData ( createdLabel, 'id', i )
					addEventHandler( "onClientMouseEnter", createdLabel, itemLabelEntered, false )
					addEventHandler( "onClientMouseLeave", createdLabel, itemLabelLeaved, false )
					addEventHandler ( "onClientGUIClick", createdLabel, rightItemClicked, false )
					table.insert ( weaponLabelsButtons, createdLabel )
				elseif i == 4 then
					local createdLabel = guiCreateLabel(bX+5,bY+50,100,100,'',false)
					setElementData ( createdLabel, 'stuffLabel', true )
					setElementData ( createdLabel, 'id', i )
					addEventHandler( "onClientMouseEnter", createdLabel, itemLabelEntered, false )
					addEventHandler( "onClientMouseLeave", createdLabel, itemLabelLeaved, false )
					addEventHandler ( "onClientGUIClick", createdLabel, rightItemClicked, false )
					table.insert ( weaponLabelsButtons, createdLabel )
				end
			end
			local offX = 55
			local offY = 50
			for i = 1, 10 do
				offX = offX+50
				if i == 6 then
					offY = 100
					offX = 105
				end
				local createdLabel = guiCreateLabel ( bX+offX, bY+offY, 45, 45, '', false )
				setElementData ( createdLabel, 'ammoLabel', true )
				setElementData ( createdLabel, 'id', i )
				addEventHandler( "onClientMouseEnter", createdLabel, itemLabelEntered, false )
				addEventHandler( "onClientMouseLeave", createdLabel, itemLabelLeaved, false )
				addEventHandler ( "onClientGUIClick", createdLabel, rightItemClicked, false )
				table.insert ( ammoLabelsButtons, createdLabel )
			end
			local offX = -45
			local offY = 150
			for i = 1, 14 do
				offX = offX+50
				if i == 8 then
					offY = 200
					offX = 5
				end
				local createdLabel = guiCreateLabel ( bX+offX, bY+offY, 45, 45, '', false )
				setElementData ( createdLabel, 'toolLabel', true )
				setElementData ( createdLabel, 'id', i )
				addEventHandler( "onClientMouseEnter", createdLabel, itemLabelEntered, false )
				addEventHandler( "onClientMouseLeave", createdLabel, itemLabelLeaved, false )
				addEventHandler ( "onClientGUIClick", createdLabel, rightItemClicked, false )
				table.insert ( toolLabelsButtons, createdLabel )
			end
			showCursor (true)
			showChat(false)
		else
			closeInventory ()
		end
	end
end

function closeInventory() 
	showCursor ( false )
	showChat(true)
	triggerEvent("showDebugMonitor",localPlayer)
	triggerEvent("showGPSOnInventoryClose",localPlayer)
	unbindKey ( 'mouse1', 'down', checkOnButton )
	unbindKey ( 'mouse1', 'up', testoLabClick )
	if isElement(testolab) then
		destroyElement ( testoLab )
	end
	for i, label in ipairs ( itemLabels ) do
		if isElement ( label ) then
			destroyElement ( label )
		end
	end
	for i, label in ipairs ( itemLabelsButtons ) do
		if isElement ( label ) then
			destroyElement ( label )
		end
	end
	for i, label in ipairs ( rightItemLabelButtons ) do
		if isElement ( label ) then
			destroyElement ( label )
		end
	end
	for i, label in ipairs ( ammoLabelsButtons ) do
		if isElement ( label ) then
			destroyElement ( label )
		end
	end
	for i, label in ipairs ( toolLabelsButtons ) do
		if isElement ( label ) then
			destroyElement ( label )
		end
	end
	for i, label in ipairs ( weaponLabelsButtons ) do
		if isElement ( label ) then
			destroyElement ( label )
		end
	end
	for i, label in ipairs (weaponStatusLabelsButtons) do
		if isElement(label) then
			destroyElement(label)
		end
	end
	for i = 1, 9 do
		exports.imagebutton:destroyImageButtonByName('arrow'..i)
		exports.imagebutton:destroyImageButtonByName('arrowRev'..i)
	end	
	removeEventHandler ( "onClientRender", root, renderDisplay )
	exports.imagebutton:destroyImageButtonByName ('mainWeap')
	exports.imagebutton:destroyImageButtonByName ('secWeap')
	inventory = {}
	inventoryWeap = {}
	inventoryWeap.main = {}
	inventoryWeap.addit = {}
	inventoryWeap.spec = {}
	foodInventory={}
	toolInventory={}
	itemsInventory={}
	ammoInventory={}
	prevY = 0
	prevYPos = 0
	itOff = 0
	loot = false
	clicked= false
	scrollLabelSelected = false
	mainWeaponSelection = false
	additWeaponSelection = false
	selectedMainWeapon = 0
	selectedAdditWeapon = 0
	selectedItemLabel = 0
	selectedAmmoLabelID = 0
	selectedToolLabelID = 0
	selectedSpecLabelID = 0
	itemLabelSelected = false
	ammoLabelSelected = false
	specLabelSelected = false
	toolLabelSelected = false
	itemLabels = {}
	itemLabelsButtons = {}
	weaponStatusLabelsButtons = {}
	rightItemLabelButtons={}
	ammoLabelsButtons={}
	toolLabelsButtons={}
	inventoryShow = false
	itemLabelID={}
	gearName = ""
	hideRightClickInventoryMenu()
end

function getInventoryInfosForRightClickMenu(itemName)
	for i,itemInfo in ipairs(languageTextTable[languageCode]["Food"]) do
		if itemName == itemInfo[1] then
			if not isPlayerInLoot() then
				if itemInfo[1] == "Water Bottle" or itemInfo[1] == "Soda Can (Pepsi)" or itemInfo[1] == "Soda Can (Cola)" or itemInfo[1] == "Soda Can (Mountain Dew)" or itemInfo[1] == "Can (Milk)" then
					info = "Drink"
					description = "Drink "..itemName
				elseif itemInfo[1] == "Baked Beans" or itemInfo[1] == "Pasta" or itemInfo[1] == "Frank & Beans" or itemInfo[1] == "Sardines" or itemInfo[1] == "Can (Corn)" or itemInfo[1] == "Can (Peas)" or itemInfo[1] == "Can (Stew)" or itemInfo[1] == "Can (Pork)" or itemInfo[1] == "Can (Ravioli)" or itemInfo[1] == "Can (Fruit)" or itemInfo[1] == "Can (Chowder)" or itemInfo[1] == "Pistachios" or itemInfo[1] == "Trail Mix" or itemInfo[1] == "MRE" then
					info = "Eat"
					description = "Eat "..itemName
				end
			end
			return itemName, info, description
		end
	end
	for i,itemInfo in ipairs(languageTextTable[languageCode]["Weapons"]["Primary Weapon"]) do
		if itemName == itemInfo[1] then
			if not isPlayerInLoot() then
				info = "Equip Primary Weapon"
				description = "Equip "..itemName
			end
			return itemName, info, description
		end
	end
	for i,itemInfo in ipairs(languageTextTable[languageCode]["Weapons"]["Secondary Weapon"]) do
		if itemName == itemInfo[1] then
			if not isPlayerInLoot() then
				info = "Equip Secondary Weapon"
				description = "Equip "..itemName
			end
			return itemName, info, description
		end
	end
	for i,itemInfo in ipairs(languageTextTable[languageCode]["Weapons"]["Specially Weapon"]) do
		if itemName == itemInfo[1] then
			if not isPlayerInLoot() then
				info = "Equip Special Weapon"
				description = "Equip "..itemName
			end
			return itemName, info, description
		end
	end
	for i,itemInfo in ipairs(languageTextTable[languageCode]["Items"]) do
		if itemName == itemInfo[1] then
			if not isPlayerInLoot() then
				if #itemInfo >= 9 then
					return itemName, itemInfo[9], "Use "..itemName
				end
				break
			end
		end
	end
	for i,itemInfo in ipairs(languageTextTable[languageCode]["Toolbelt"]) do
		if itemName == itemInfo[1] then
			if not isPlayerInLoot() then
				if #itemInfo >= 9 then
					if itemName == "Box of Matches" then
						return itemName, itemInfo[9], "Create a fire"
					elseif itemName == "Flashlight" then
						return itemName, itemInfo[9], "Equip Flashlight"
					else
						return itemName, itemInfo[9], ""
					end
				end
				break
			end
		end
	end
	return itemName, false, false
end

function itemLabelClicked(button)
	if button == "right" then
		if getElementData ( source, 'itemLabel' ) then
			local name, info, description = getInventoryInfosForRightClickMenu ( inventory[getElementData ( source, 'id' )+itOff][1] )
			if name == "Box of Matches" and getElementData(getLocalPlayer(), "Wood Pile") == 0 then
				return true 
			end
			if name == "Bandage" and getElementData(getLocalPlayer(), "bleeding") == 0 then
				return true 
			end
			if name == "Medic Kit" and getElementData(getLocalPlayer(), "blood") > 10500 then
				return true 
			end
			if name == "Heat Pack" and getElementData(getLocalPlayer(), "temperature") > 35 then
				return true 
			end
			if name == "Painkiller" and not getElementData(getLocalPlayer(), "pain") then
				return true 
			end
			if name == "Morphine" and not getElementData(getLocalPlayer(), "brokenbone") then
				return true 
			end
			if info then
				--playerUseItem(name, info)
				--setTimer(placeItemsInInventory, 200, 2)
				showRightClickMenu(name,info,description)
			end
		end
	end
	guiMoveToBack(source)
end

function changeWeaponStatus()
local itemName = getElementData(localPlayer,"currentweapon_1")
	if itemName then
		if getElementData(source,"toCarryLabel") then
			if getPlayerCurrentSlots() + getItemSlots(itemName) <= getPlayerMaxAviableSlots() then
				isCarryingWeapon = true
				isHoldingWeapon = false
				triggerServerEvent("onPlayerTakeWeapon",localPlayer,itemName,1,"toCarry")
			else
				startRollMessage2("Weapon","Not enough slots to carry weapon!",255,0,0)
				return
			end
		elseif getElementData(source,"toHoldLabel") then
			isCarryingWeapon = false
			isHoldingWeapon = true
			triggerServerEvent("onPlayerTakeWeapon",localPlayer,itemName,1,"toHold")
		end
	end
end

rightClick = {}

rightClick["window"] = guiCreateStaticImage(0, 0, 0.05, 0.0215, ":DayZ/gui/gear/items/window_bg.png", true)
rightClick["label"] = guiCreateLabel(0, 0, 1, 1, "", true, rightClick["window"])
guiLabelSetHorizontalAlign(rightClick["label"], "center")
guiLabelSetVerticalAlign(rightClick["label"], "center")
guiSetFont(rightClick["label"], "default-bold-small")
guiSetVisible(rightClick["window"], false)

function hideRightClickInventoryMenu()
  guiSetVisible(rightClick["window"], false)
end

function showRightClickMenu(itemName, itemInfo,itemDescription)
	if itemInfo then
		local screenx, screeny, worldx, worldy, worldz = getCursorPosition()
		guiSetVisible(rightClick["window"], true)
		guiSetText(rightClick["label"], itemDescription)
		local width = guiLabelGetTextExtent(rightClick["label"])
		guiSetPosition(rightClick["window"], screenx, screeny, true)
		local x, y = guiGetSize(rightClick["window"], false)
		guiSetSize(rightClick["window"], width+10, y, false)
		guiBringToFront(rightClick["window"])
		setElementData(rightClick["window"], "iteminfo", {itemName, itemInfo})
		if isTimer(hideTimer) then 
			killTimer(hideTimer)
			hideTimer = setTimer(hideRightClickInventoryMenu,5000,1)
		else
			hideTimer = setTimer(hideRightClickInventoryMenu,5000,1)
		end
	end
end

function onPlayerRightClickMenu(button, state)
  if button == "left" then
    local itemName, itemInfo = getElementData(rightClick["window"], "iteminfo")[1], getElementData(rightClick["window"], "iteminfo")[2]
    hideRightClickInventoryMenu()
    playerUseItem(itemName, itemInfo)
	setTimer(placeItemsInInventory,200,2)
	for i, weap in ipairs(languageTextTable[languageCode]["Weapons"]["Primary Weapon"]) do
		if itemName == weap[1] then
			isCarryingWeapon = false
			isHoldingWeapon = true
		end
	end
  end
end
addEventHandler("onClientGUIClick", rightClick["label"], onPlayerRightClickMenu, false)

function rightItemClicked ()
	local id = getElementData ( source, 'id' )
	if getElementData ( source, 'rightItemLabel' ) and not isPlayerInLoot() then
		local name = itemsInventory[id][1]
		if name == "Water Bottle" or name == "Soda Can (Pepsi)" or name == "Soda Can (Cola)" or name == "Soda Can (Mountain Dew)" or name == "Can (Milk)" then
			playerUseItem ( name, "Drink" )
		elseif name == "Baked Beans" or name == "Pasta" or name == "Frank & Beans" or name == "Can (Corn)" or name == "Can (Peas)" or name == "Can (Pork)" or name == "Can (Stew)" or name == "Can (Ravioli)" or name == "Can (Fruit)" or name == "Can (Chowder)" or name == "Pistachios" or name == "Trail Mix" or name == "MRE" then
			playerUseItem ( name, "Eat" )
		else
			for i, itemInfo in ipairs(languageTextTable[languageCode]["Items"]) do
				if name == itemInfo[1] then
					if name == "Box of Matches" and getElementData(getLocalPlayer(), "Wood Pile") == 0 then
						return true 
					end
					if name == "Bandage" and getElementData(getLocalPlayer(), "bleeding") == 0 then
						return true 
					end
					if name == "Medic Kit" and getElementData(getLocalPlayer(), "blood") > 10500 then
						return true 
					end
					if name == "Heat Pack" and getElementData(getLocalPlayer(), "temperature") > 35 then
						return true 
					end
					if name == "Painkiller" and not getElementData(getLocalPlayer(), "pain") then
						return true 
					end
					if name == "Morphine" and not getElementData(getLocalPlayer(), "brokenbone") then
						return true 
					end
					if #itemInfo >= 9 then
						playerUseItem (name,itemInfo[9])
					end
				end
			end
		setTimer(placeItemsInInventory, 200, 2)
		end
	elseif getElementData ( source, 'toolLabel' ) then
		local name = toolInventory[id][1]
		for i,itemInfo in ipairs(languageTextTable[languageCode]["Toolbelt"]) do
			if name == itemInfo[1] then
				if #itemInfo >= 9 then
					playerUseItem ( name, itemInfo[9] )
				end
			end
		end
	end
end

function itemLabelEntered ()
	if getElementData ( source, 'itemLabel' ) then
		local id = getElementData ( source, 'id' )
		if selectedItemLabel ~= 0 then
			exports.imageButton:setImageButtonVisible ( itemLabelsButtons[selectedItemLabel][1].name, false )
			exports.imageButton:setImageButtonVisible ( itemLabelsButtons[selectedItemLabel][2].name, false )
		end
		if id <= #inventory then
			selectedItemLabel = id
			exports.imageButton:setImageButtonVisible ( itemLabelsButtons[id][1].name, true )
			exports.imageButton:setImageButtonVisible ( itemLabelsButtons[id][2].name, true )
		end
	elseif getElementData(source,"rightItemLabel") then
		rightItemLabelSelected = true
		selectedItemLabelID = getElementData(source, 'id')
	elseif getElementData ( source, 'toolLabel' ) then
		toolLabelSelected = true
		selectedToolLabelID = getElementData ( source, 'id' )
	elseif getElementData ( source, 'ammoLabel' ) then
		ammoLabelSelected = true
		selectedAmmoLabelID = getElementData ( source, 'id' )
	elseif getElementData(source,"toHoldLabel") then
		holdLabelSelected = true
		setElementData(source,"status",holdLabelSelected)
	elseif getElementData(source,"toCarryLabel") then
		carryLabelSelected = true
		setElementData(source,"status",carryLabelSelected)
	elseif getElementData(source,"backpackLabel") then
		backpackLabelSelected = true
		setElementData(source,"status",backpackLabelSelected)
	end
end

function itemLabelLeaved ()
	if getElementData ( source, 'itemLabel' ) then
		--local id = getElementData ( source, 'id' )
		--exports.imageButton:setImageButtonVisible ( itemLabelsButtons[id][1].name, false )
		--exports.imageButton:setImageButtonVisible ( itemLabelsButtons[id][2].name, false )
		--selectedItemLabel = 0
	elseif getElementData(source,"rightItemLabel") then
		rightItemLabelSelected = false
		selectedItemLabelID = 0
	elseif getElementData ( source, 'toolLabel' ) then
		toolLabelSelected = false
		selectedToolLabelID = 0
	elseif getElementData ( source, 'ammoLabel' ) then
		ammoLabelSelected = false
		selectedAmmoLabelID = 0
	elseif getElementData(source,"toHoldLabel") then
		holdLabelSelected = false
		setElementData(source,"status",holdLabelSelected)
	elseif getElementData(source,"toCarryLabel") then
		carryLabelSelected = false
		setElementData(source,"status",carryLabelSelected)
	elseif getElementData(source,"backpackLabel") then
		backpackLabelSelected = false
		setElementData(source,"status",backpackLabelSelected)
	end
end

local font = {}
font[1] = dxCreateFont(":DayZ/fonts/bitstream.ttf",10)

function renderDisplay()
	dxDrawImage(bX-400, bY-300,800,565,":DayZ/gui/gear/inventory/inventory_bg.png")
	if loot then
		local curLootItems = getLootCurrentSlots(loot) or 0 
		local maxLootItems = getLootMaxAviableSlots(loot) or 0
		if maxLootItems > 0 then
			dxDrawText ( "SLOTS: " .. curLootItems .. "/" .. maxLootItems, bX-375, bY-280, bX-300,  bY-280, tocolor ( 0,0,0,255), 1, font[1] )
		end
	end
	dxDrawText ( 'SLOTS: ' .. getPlayerCurrentSlots() .. '/' .. getPlayerMaxAviableSlots(), bX-130, bY-280, bX-300,  bY-200, tocolor ( 0,0,0,255), 1, font[1] )
	dxDrawText (gearName, bX-375, bY-260, bX-200,  bY-200, tocolor ( 0,0,0,255), 1,  font[1] )
	
	local itScroll = (bY-90)-5*(#inventory-9)
	dxDrawImage(bX-20,bY-235-prevY,bX-bX+10,itScroll-prevY,":DayZ/gui/gear/inventory/scrollbar.png")
	
	--dxDrawLine ( bX-10, bY-235-prevY, bX-10, itScroll-prevY, tocolor ( 0,0,0, 255 ), 15 )

	-- // Left Side Gear
	if selectedItemLabel > 0 then
		if selectedItemLabel <= #inventory then
			dxDrawText ( inventory[selectedItemLabel+itOff][9], bX-370, bY+60, screenWidth, screenHeight, tocolor ( 85,47,68,255), 1, font[1] ) 	-- Item Name
			dxDrawText ( inventory[selectedItemLabel+itOff][7], bX-370, bY+80, screenWidth, screenHeight, tocolor ( 0,0,0,255), 1, font[1] )			-- Item Type
			dxDrawText ( inventory[selectedItemLabel+itOff][8], bX-370, bY+100, screenWidth, screenHeight, tocolor ( 0,0,0,255), 1, font[1] )			-- Item Description
			local sizeX = 128
			local offX = -32
			if inventory[selectedItemLabel+itOff][5]/inventory[selectedItemLabel+itOff][6] == 1 then
				offX = 0
				sizeX = 64
			end
			dxDrawImage ( bX-100+offX, bY+180, sizeX, 64, ':DayZ/gui/gear/icons/'..inventory[selectedItemLabel+itOff][4] )
		end
	-- // Right Side Gear
	elseif rightItemLabelSelected then
		if selectedItemLabelID <= #itemsInventory then
			dxDrawText ( itemsInventory[selectedItemLabelID][7], bX-370, bY+60, screenWidth, screenHeight, tocolor ( 85,47,68,255), 1, font[1] )
			dxDrawText ( itemsInventory[selectedItemLabelID][5], bX-370, bY+80, screenWidth, screenHeight, tocolor ( 0,0,0,255), 1, font[1] )
			dxDrawText ( itemsInventory[selectedItemLabelID][6], bX-370, bY+100, screenWidth, screenHeight, tocolor (0,0,0,255), 1, font[1] )
			dxDrawImage ( bX-100, bY+180, 64, 64, ':DayZ/gui/gear/icons/'..itemsInventory[selectedItemLabelID][2] )
		end
	elseif toolLabelSelected then
		if selectedToolLabelID <= #toolInventory then
			dxDrawText ( toolInventory[selectedToolLabelID][7], bX-370, bY+60, screenWidth, screenHeight, tocolor ( 85,47,68,255), 1, font[1] )
			dxDrawText ( toolInventory[selectedToolLabelID][5], bX-370, bY+80, screenWidth, screenHeight, tocolor ( 0,0,0,255), 1, font[1] )
			dxDrawText ( toolInventory[selectedToolLabelID][6], bX-370, bY+100, screenWidth, screenHeight, tocolor ( 0,0,0,255), 1, font[1] )
			dxDrawImage ( bX-100, bY+180, 64, 64, ':DayZ/gui/gear/icons/'..toolInventory[selectedToolLabelID][2] )
		end
	elseif ammoLabelSelected then
		if selectedAmmoLabelID <= #ammoInventory then
			dxDrawText ( ammoInventory[selectedAmmoLabelID][7], bX-370, bY+60, screenWidth, screenHeight, tocolor ( 85,47,68,255), 1, font[1] )
			dxDrawText ( ammoInventory[selectedAmmoLabelID][5], bX-370, bY+80, screenWidth, screenHeight, tocolor ( 0,0,0,255), 1, font[1] )
			dxDrawText ( ammoInventory[selectedAmmoLabelID][6], bX-370, bY+100, screenWidth, screenHeight, tocolor ( 0,0,0,255), 1, font[1] )
			dxDrawImage ( bX-100, bY+180, 64, 64, ':DayZ/gui/gear/icons/'..ammoInventory[selectedAmmoLabelID][2] )
		end
	end
	
	--// Normal items + consumables
	dxDrawImage (bX+5, bY-250, 45, 45, ':DayZ/gui/gear/inventory/brown_deselect.png') 
	dxDrawImage (bX+55, bY-250, 45, 45, ':DayZ/gui/gear/inventory/brown_deselect.png') 
	dxDrawImage (bX+5, bY-200, 45, 45, ':DayZ/gui/gear/inventory/brown_deselect.png') 
	dxDrawImage (bX+55, bY-200, 45, 45, ':DayZ/gui/gear/inventory/brown_deselect.png') 
	dxDrawImage (bX+5, bY-150, 45, 45, ':DayZ/gui/gear/inventory/brown_deselect.png') 
	dxDrawImage (bX+55, bY-150, 45, 45, ':DayZ/gui/gear/inventory/brown_deselect.png')
	dxDrawImage (bX+5, bY-100, 45, 45, ':DayZ/gui/gear/inventory/brown_deselect.png')
	dxDrawImage (bX+55, bY-100, 45, 45, ':DayZ/gui/gear/inventory/brown_deselect.png')
	dxDrawImage (bX+5, bY-50, 45, 45, ':DayZ/gui/gear/inventory/brown_deselect.png')
	dxDrawImage (bX+55, bY-50, 45, 45, ':DayZ/gui/gear/inventory/brown_deselect.png')
	dxDrawImage (bX+5, bY-0, 45, 45, ':DayZ/gui/gear/inventory/brown_deselect.png')
	dxDrawImage (bX+55, bY-0, 45, 45, ':DayZ/gui/gear/inventory/brown_deselect.png')
	
	dxDrawImage(bX+105,bY-250,249,97,":DayZ/gui/gear/inventory/backpack.png")
	dxDrawImage(bX+105,bY-150,249,97,":DayZ/gui/gear/inventory/holding.png")
	dxDrawImage(bX+105,bY-50,249,97,":DayZ/gui/gear/inventory/carrying.png")
	
	--// Secondary Ammo + Bandages
	dxDrawImage(bX+5,bY+50,100,100,":DayZ/gui/gear/inventory/pistol.png")
	dxDrawImage(bX+105, bY+50,45,45,":DayZ/gui/gear/inventory/green_deselect.png")
	dxDrawImage(bX+155, bY+50,45,45,":DayZ/gui/gear/inventory/green_deselect.png")
	dxDrawImage(bX+205, bY+50,45,45,":DayZ/gui/gear/inventory/green_deselect.png")
	dxDrawImage(bX+255, bY+50,45,45,":DayZ/gui/gear/inventory/green_deselect.png")
	dxDrawImage(bX+305, bY+50,45,45,":DayZ/gui/gear/inventory/green_deselect.png")
	dxDrawImage(bX+105, bY+100,45,45,":DayZ/gui/gear/inventory/green_deselect.png")
	dxDrawImage(bX+155, bY+100,45,45,":DayZ/gui/gear/inventory/green_deselect.png")
	dxDrawImage(bX+205, bY+100,45,45,":DayZ/gui/gear/inventory/green_deselect.png")
	dxDrawImage(bX+255, bY+100,45,45,":DayZ/gui/gear/inventory/green_deselect.png")
	dxDrawImage(bX+305, bY+100,45,45,":DayZ/gui/gear/inventory/green_deselect.png")
	
	--// Toolbelt
	dxDrawImage(bX+5, bY+150,45,45,":DayZ/gui/gear/inventory/brown_deselect.png")
	dxDrawImage(bX+55, bY+150,45,45,":DayZ/gui/gear/inventory/brown_deselect.png")
	dxDrawImage(bX+105, bY+150,45,45,":DayZ/gui/gear/inventory/brown_deselect.png")
	dxDrawImage(bX+155, bY+150,45,45,":DayZ/gui/gear/inventory/brown_deselect.png")
	dxDrawImage(bX+205, bY+150,45,45,":DayZ/gui/gear/inventory/brown_deselect.png")
	dxDrawImage(bX+255, bY+150,45,45,":DayZ/gui/gear/inventory/brown_deselect.png")
	dxDrawImage(bX+305, bY+150,45,45,":DayZ/gui/gear/inventory/brown_deselect.png")
	dxDrawImage(bX+5, bY+200,45,45,":DayZ/gui/gear/inventory/brown_deselect.png")
	dxDrawImage(bX+55, bY+200,45,45,":DayZ/gui/gear/inventory/brown_deselect.png")
	dxDrawImage(bX+105, bY+200,45,45,":DayZ/gui/gear/inventory/brown_deselect.png")
	dxDrawImage(bX+155, bY+200,45,45,":DayZ/gui/gear/inventory/brown_deselect.png")
	dxDrawImage(bX+205, bY+200,45,45,":DayZ/gui/gear/inventory/brown_deselect.png")
	dxDrawImage(bX+255, bY+200,45,45,":DayZ/gui/gear/inventory/brown_deselect.png")
	dxDrawImage(bX+305, bY+200,45,45,":DayZ/gui/gear/inventory/brown_deselect.png")
	yOff = 0
	local itemsMax = 12
	if itemsMax > #itemsInventory then itemsMax = #itemsInventory end
	xOff = 20
	yOff = 0
	for i = 1, itemsMax do
		yPos = bY-250-yOff
		if i%2 == 0 then
			xPos = bX+55
			yOff = yOff-50
		else
			xPos = bX+5
		end
		if getElementData(localPlayer,itemsInventory[i][1]) then
			local itemAmount = 0.42*tonumber(getElementData(localPlayer,itemsInventory[i][1]))
			if itemAmount > 42 then
				itemAmount = 42
			end
			dxDrawRectangle(xPos, yPos, 4, itemAmount, tocolor(39, 236, 18, 255))
		end
		dxDrawImage(xPos, yPos,45,45,":DayZ/gui/gear/icons/"..itemsInventory[i][2])
	end
	
	local whatBackpack = getElementData(localPlayer,"MAX_Slots")
	if whatBackpack == 12 then
		dxDrawImage(bX+180,bY-250,96,96,":DayZ/gui/gear/icons/acu.png")
	elseif whatBackpack == 13 then
		dxDrawImage(bX+180,bY-250,96,96,":DayZ/gui/gear/icons/czechpouch.png")
	elseif whatBackpack == 16 then
		dxDrawImage(bX+180,bY-250,96,96,":DayZ/gui/gear/icons/alice.png")
	elseif whatBackpack == 17 then
		dxDrawImage(bX+180,bY-250,96,96,":DayZ/gui/gear/icons/survival.png")
	elseif whatBackpack == 18 then
		dxDrawImage(bX+180,bY-250,96,96,":DayZ/gui/gear/icons/britishpack.png")
	elseif whatBackpack == 24 then
		dxDrawImage(bX+180,bY-250,96,96,":DayZ/gui/gear/icons/coyote.png")
	elseif whatBackpack == 30 then
		dxDrawImage(bX+180,bY-250,96,96,":DayZ/gui/gear/icons/czech.png")
	end
	
	if isOpeningBackpack then
		dxDrawImage(bX+330,bY-250,38,97,":DayZ/gui/gear/inventory/backpack_open_press.png")
	else
		dxDrawImage(bX+330,bY-250,38,97,":DayZ/gui/gear/inventory/backpack_open.png")
	end
	
	local toolMax = 14
	if toolMax > #toolInventory then toolMax = #toolInventory end
	xOff = 5
	yOff = 150
	for i = 1, toolMax do 
		if i == 8 then
			yOff = 200
			xOff = 5
		end
		if i ~= 1 and i ~= 8 then
			xOff = xOff+50
		end
		dxDrawImage ( bX+xOff, bY+yOff, 45, 45, ':DayZ/gui/gear/icons/'..toolInventory[i][2] )
	end
	
	local ammoMax = 10
	if ammoMax > #ammoInventory then ammoMax = #ammoInventory end
	xOff = 105
	yOff = 50
	for i = 1, ammoMax do
		if i == 6 then
			yOff = 100
			xOff = 105
		end
		if i~= 1 and i~= 6 then
			xOff = xOff+50
		end
		if getElementData(localPlayer,ammoInventory[i][1]) then
			local itemAmount = 0.42*tonumber(getElementData(localPlayer,ammoInventory[i][1]))
			if itemAmount > 42 then
				itemAmount = 42
			end
			dxDrawRectangle(bX+xOff, bY+yOff, 4, itemAmount, tocolor(39, 236, 18, 255))
		end
		dxDrawImage ( bX+xOff, bY+yOff, 45, 45, ':DayZ/gui/gear/icons/'..ammoInventory[i][2] )
	end
	local moveX = 140
	if isCarryingWeapon then
		dxDrawImage(bX+330,bY-50,38,97,":DayZ/gui/gear/inventory/uptohold.png")
		dxDrawImage(bX+330,bY-150,38,97,":DayZ/gui/gear/inventory/downtocarry_disabled.png")
		moveX = 40
	elseif isHoldingWeapon then
		dxDrawImage(bX+330,bY-150,38,97,":DayZ/gui/gear/inventory/downtocarry.png")
		dxDrawImage(bX+330,bY-50,38,97,":DayZ/gui/gear/inventory/uptohold_disabled.png")
		moveX = 140
	else
		dxDrawImage(bX+330,bY-150,38,97,":DayZ/gui/gear/inventory/downtocarry_disabled.png")
		dxDrawImage(bX+330,bY-50,38,97,":DayZ/gui/gear/inventory/uptohold_disabled.png")
		moveX = 140
	end
	if selectedMainWeapon > 0 then
		dxDrawImage ( bX+135, bY-moveX, 170, 80, ':DayZ/gui/gear/icons/'..inventoryWeap.main[selectedMainWeapon][2] )
	end
	
	if selectedAdditWeapon > 0 then
		if inventoryWeap.addit[selectedAdditWeapon] then
			local sizeX = 128
			local offX = -32
			if inventoryWeap.addit[selectedAdditWeapon][3]/inventoryWeap.addit[selectedAdditWeapon][4] == 1 then
				sizeX = 64
				offX = 0
			end
			dxDrawImage ( bX+20, bY+70, sizeX, 64, ':DayZ/gui/gear/icons/'..inventoryWeap.addit[selectedAdditWeapon][2] )
		else
			selectedAdditWeapon = 0
		end
	end
	xOff = -50
	--[[
	for i = 1, #inventoryWeap.spec do
		xOff = xOff+70
		dxDrawImage ( bX+xOff, bY+120, 64, 64, ':DayZ/gui/gear/icons/'..inventoryWeap.spec[i][2] )
	end
	]]
	
	yOff = 0
	local mainMax = 9
	if mainMax > #inventory then mainMax = #inventory end
	for i = 1, mainMax do
		if inventory[i+itOff][2] == 0 and inventory[i+itOff][3] == 0 then inventory[i+itOff][2] = 1 end
		if inventory[i+itOff][5]/inventory[i+itOff][6] == 1 then
			offX = 16
		else
			offX = 32
		end
		dxDrawImage ( bX-320, bY-230+yOff, offX, 16, ':DayZ/gui/gear/icons/'..inventory[i+itOff][4] )
		if inventory[i+itOff][2] > 0 then
			dxDrawText ( inventory[i+itOff][9], bX-306+offX, bY-230+yOff, screenWidth, screenHeight, tocolor ( 255,255,255,255), 1, font[1] )
			dxDrawText ( inventory[i+itOff][2], bX-355, bY-230+yOff, screenWidth, screenHeight, tocolor (255,255,255,255), 1, font[1] )
		end
		if inventory[i+itOff][3] > 0 then
			dxDrawText ( inventory[i+itOff][9], bX-306+offX, bY-230+yOff, screenWidth, screenHeight, tocolor ( 0,0,0,255), 1, font[1] )
			dxDrawText ( inventory[i+itOff][3], bX-75, bY-230+yOff, screenWidth, screenHeight, tocolor (0,0,0,255), 1, font[1] )
		end
		if selectedItemLabel == i then
			dxDrawRectangle (bX-395, bY-230+yOff, 370, 25, tocolor ( 10, 10, 10, 30 ) )
		end
		yOff = yOff+30
	end
end
mainWeapSelectionLabels = {}
additWeapSelectionLabels = {}

function moveItemsBetweenInventory(button)
	if string.find(button.name, 'arrowRev' ) then
		if loot then
			if inventory [selectedItemLabel+itOff][2] > 0 then
				moveItemInInventory ()
			end
		end
	elseif string.find(button.name, 'arrow' ) then
		if inventory [selectedItemLabel+itOff][3] > 0 then
			moveItemOutOfInventory ( inventory [selectedItemLabel+itOff][1] )
		end
	end
end

addEvent ( "imageButtonClicked", true )
addEventHandler ( 'imageButtonClicked', root, moveItemsBetweenInventory)

function moveItemInInventory()
	local itemName = inventory [selectedItemLabel+itOff][1]
	if not isToolbeltItem(itemName) then
		if getElementData(localPlayer,"CURRENT_Slots") + getItemSlots(itemName) > getElementData(localPlayer,"MAX_Slots") then
			startRollMessage2("Inventory","Inventory is full!",255,0,0)
			return
		end
	end
	if isPlayerInLoot() then
		if getElementData(isPlayerInLoot(), itemName) and getElementData(isPlayerInLoot(), itemName) >= 1 then
			if isCarryingWeapon then
				if not isToolbeltItem(itemName) then
					if getPlayerCurrentSlots() + getItemSlots(itemName) <= getPlayerMaxAviableSlots() then
						if not playerMovedInInventory then
							triggerEvent("onPlayerMoveItemInInventory", getLocalPlayer(), itemName, isPlayerInLoot())
							playerMovedInInventory = true
							setTimer(function()
								playerMovedInInventory = false
							end, 700, 1)
						else
							startRollMessage2("Inventory", "Abusing exploits will result in a ban!", 255, 22, 0)
							return true
						end
					else
						startRollMessage2("Inventory", "Inventory is full!", 255, 22, 0)
						return true
					end
				else
					playerMovedInInventory = true
					 setTimer(function()
						 playerMovedInInventory = false
					end, 700, 1)
					triggerEvent("onPlayerMoveItemInInventory", getLocalPlayer(), itemName, isPlayerInLoot())
				end
			elseif isHoldingWeapon then
				if not isToolbeltItem(itemName) then
					if getPlayerCurrentSlots() + getItemSlots(itemName) <= getPlayerMaxAviableSlots() then
						if not playerMovedInInventory then
							triggerEvent("onPlayerMoveItemInInventory", getLocalPlayer(), itemName, isPlayerInLoot())
							playerMovedInInventory = true
							setTimer(function()
								playerMovedInInventory = false
							end, 700, 1)
						else
							startRollMessage2("Inventory", "Abusing exploits will result in a ban!", 255, 22, 0)
							return true
						end
					else
						startRollMessage2("Inventory", "Inventory is full!", 255, 22, 0)
						return true
					end
				else
					playerMovedInInventory = true
					 setTimer(function()
						 playerMovedInInventory = false
					end, 700, 1)
					triggerEvent("onPlayerMoveItemInInventory", getLocalPlayer(), itemName, isPlayerInLoot())
				end
			else
				if not isToolbeltItem(itemName) then
					if getPlayerCurrentSlots() + getItemSlots(itemName) <= getPlayerMaxAviableSlots() then
						if not playerMovedInInventory then
							triggerEvent("onPlayerMoveItemInInventory", getLocalPlayer(), itemName, isPlayerInLoot())
							playerMovedInInventory = true
							setTimer(function()
								playerMovedInInventory = false
							end, 700, 1)
						else
							startRollMessage2("Inventory", "Abusing exploits will result in a ban!", 255, 22, 0)
							return true
						end
					else
						startRollMessage2("Inventory", "Inventory is full!", 255, 22, 0)
						return true
					end
				else
					playerMovedInInventory = true
					 setTimer(function()
						 playerMovedInInventory = false
					end, 700, 1)
					triggerEvent("onPlayerMoveItemInInventory", getLocalPlayer(), itemName, isPlayerInLoot())
				end
			end
		end
	end
	if isPlayerInLoot() then
		local col = getElementData(getLocalPlayer(), "currentCol")
		setTimer(placeItemsInInventory, 200, 2)
	end
end

function weapSelectionLabelClicked ()
	if getElementData ( source, 'mainWeapSelection' ) then
		local id = getElementData ( source, 'id' )
		local ammoData, weapID = getWeaponAmmoFromName(inventoryWeap.main[id][1])
		if getElementData(localPlayer, ammoData) <= 0 then
			triggerEvent("displayClientInfo", getLocalPlayer(), "Weapon", "No more ammo left for this weapon!", 22, 255, 0)
			return true
		end
		mainWeaponSelection = false
		selectedMainWeapon = id
		triggerServerEvent("onPlayerRearmWeapon", getLocalPlayer(), inventoryWeap.main[id][1], 1)
		for i, label in  ipairs(mainWeapSelectionLabels) do
			if isElement ( label ) then
				destroyElement ( label )
			end
		end
	elseif getElementData ( source, 'additWeapSelection' ) then
		local id = getElementData ( source, 'id' )
		local ammoData, weapID = getWeaponAmmoFromName(inventoryWeap.addit[id][1])
		if getElementData(localPlayer, ammoData) <= 0 then
			triggerEvent("displayClientInfo", getLocalPlayer(), "Weapon", "No more ammo left for this weapon!", 22, 255, 0)
			return true
		end
		additWeaponSelection = false
		selectedAdditWeapon = id
		triggerServerEvent("onPlayerRearmWeapon", getLocalPlayer(), inventoryWeap.addit[id][1], 2)
		for i, label in  ipairs(additWeapSelectionLabels) do
			if isElement ( label ) then
				destroyElement ( label )
			end
		end
	end
end
addCommandHandler("Open Inventory",initInventory)
bindKey("J", "down", "Open Inventory")

local screenWidth,screenHeight = guiGetScreenSize()
local button = dxCreateTexture ( "images/butoff.png" )
local button2 = dxCreateTexture ( "images/butclick.png" )
local buttArrow = dxCreateTexture ( "images/buttArrow.png" )
local buttArrowDown = dxCreateTexture ( "images/buttArrowDown.png" )
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
gearName = ""
loot = false

prevY = 0
prevYPos = 0
itOff = 0
heightLabel = ((screenHeight/2+90)-5*(#inventory-11))-(screenHeight/2-235)

local clicked=false
scrollLabelSelected = false

mainWeaponSelection = false
additWeaponSelection = false
selectedMainWeapon = 0
selectedAdditWeapon = 0
selectedItemLabel = 0
selectedFoodLabelID = 0
selectedToolLabelID = 0
selectedSpecLabelID = 0
foodLabelSelected = false
specLabelSelected = false
toolLabelSelected = false

itemLabels = {}
itemLabelsButtons = {}
foodLabelsButtons={}
toolLabelsButtons={}

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
end

function placeItemsInInventory()
	local loot = isPlayerInLoot()
	inventory = {}
	inventoryWeap = {}
	inventoryWeap.main = {}
	inventoryWeap.addit = {}
	inventoryWeap.spec = {}

	foodInventory={}
	toolInventory={}
	for i, weap in ipairs ( inventoryItems["Weapons"]["Primary Weapon"] ) do
		local inLoot = getThisItemInLoot (weap[1])
		local inInventory = getElementData ( localPlayer, weap[1] ) or 0
		if inLoot > 0 or inInventory > 0 then
			table.insert ( inventory, {weap[1],inLoot,inInventory,weap[3],weap[4],weap[5],weap[6],weap[7]} )
		end
	end
	for i, weap in ipairs ( inventoryItems["Weapons"]["Primary Weapon"] ) do
		if getElementData ( localPlayer, weap[1] ) and getElementData ( localPlayer, weap[1] ) >= 1 then
			table.insert ( inventoryWeap.main, {weap[1],weap[3],weap[4],weap[5]} )
			if getElementData(localPlayer, "currentweapon_1") == weap[1] then
				selectedMainWeapon = #inventoryWeap.main
			end
		end
	end
	for i, weap in ipairs ( inventoryItems["Weapons"]["Secondary Weapon"] ) do
		local inLoot = getThisItemInLoot (weap[1])
		local inInventory = getElementData ( localPlayer, weap[1] ) or 0
		if inLoot > 0 or inInventory > 0 then
			table.insert ( inventory, {weap[1],inLoot,inInventory,weap[3],weap[4],weap[5],weap[6],weap[7]} )
		end
	end
	for i, weap in ipairs ( inventoryItems["Weapons"]["Secondary Weapon"] ) do
		if getElementData ( localPlayer, weap[1] ) and getElementData ( localPlayer, weap[1] ) >= 1 then
			table.insert ( inventoryWeap.addit, {weap[1],weap[3],weap[4],weap[5],weap[6],weap[7]} )
			if getElementData(localPlayer, "currentweapon_2") == weap[1] then
				selectedAdditWeapon = #inventoryWeap.addit
			end
		end
	end
	for i, weap in ipairs ( inventoryItems["Ammo"] ) do
		local inLoot = getThisItemInLoot (weap[1])
		local inInventory = getElementData ( localPlayer, weap[1] ) or 0
		if inLoot > 0 or inInventory > 0 then
			table.insert ( inventory, {weap[1],inLoot,inInventory,weap[3],weap[4],weap[5],weap[6],weap[7]} )
		end
	end
	for i, weap in ipairs ( inventoryItems["Food"] ) do
		if getElementData ( localPlayer, weap[1] ) and getElementData ( localPlayer, weap[1] ) >= 1 then
			table.insert ( foodInventory, {weap[1],weap[3],weap[4],weap[5],weap[6],weap[7]} )
		end
	end
	for i, weap in ipairs ( inventoryItems["Toolbelt"] ) do
		if getElementData ( localPlayer, weap[1] ) and getElementData ( localPlayer, weap[1] ) >= 1 then
			table.insert ( toolInventory, {weap[1],weap[3],weap[4],weap[5],weap[6],weap[7]} )
		end
	end
	for i, weap in ipairs ( inventoryItems["Weapons"]["Specially Weapon"] ) do
		if getElementData ( localPlayer, weap[1] ) and getElementData ( localPlayer, weap[1] ) >= 1 then
			table.insert ( inventoryWeap.spec, {weap[1],weap[3],weap[4],weap[5],weap[6],weap[7]} )
		end
	end
	for i, weap in ipairs ( inventoryItems["Weapons"]["Specially Weapon"] ) do
		local inLoot = getThisItemInLoot (weap[1])
		local inInventory = getElementData ( localPlayer, weap[1] ) or 0
		if inLoot > 0 or inInventory > 0 then
			table.insert ( inventory, {weap[1],inLoot,inInventory,weap[3],weap[4],weap[5],weap[6],weap[7]} )
		end
	end
	for i, weap in ipairs ( inventoryItems["Food"] ) do
		local inLoot = getThisItemInLoot (weap[1])
		local inInventory = getElementData ( localPlayer, weap[1] ) or 0
		if inLoot > 0 or inInventory > 0 then
			table.insert ( inventory, {weap[1],inLoot,inInventory,weap[3],weap[4],weap[5],weap[6],weap[7]} )
		end
	end
	for i, weap in ipairs ( inventoryItems["Items"] ) do
		local inLoot = getThisItemInLoot (weap[1])
		local inInventory = getElementData ( localPlayer, weap[1] ) or 0
		if inLoot > 0 or inInventory > 0 then
			table.insert ( inventory, {weap[1],inLoot,inInventory,weap[3],weap[4],weap[5],weap[6],weap[7]} )
		end
	end
	for i, weap in ipairs ( inventoryItems["Toolbelt"] ) do
		local inLoot = getThisItemInLoot (weap[1])
		local inInventory = getElementData ( localPlayer, weap[1] ) or 0
		if inLoot > 0 or inInventory > 0 then
			table.insert ( inventory, {weap[1],inLoot,inInventory,weap[3],weap[4],weap[5],weap[6],weap[7]} )
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
			if itOff+11 < #inventory then
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
		if ( ( tempVal > 0 and prevY <= 0 ) or ( tempVal < 0 and itOff+11<#inventory ) ) and tempVal ~= 0 and prevY < 3 and prevY+newPrevY < 0 then
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
			heightLabel = ((screenHeight/2+90)-5*(#inventory-11))-(screenHeight/2-235)
			addEventHandler ( "onClientMouseMove", testoLab, testoLabMove, false )
			addEventHandler( "onClientMouseEnter", testoLab, buttonLabelEntered, false )
			addEventHandler( "onClientMouseLeave", testoLab, buttonLabelLeaved, false )
			exports.imageButton:createImageButton ( 'mainWeap', screenWidth/2+300,screenHeight/2-240, 25, 64, 0, ':DayZ/images/butoff.png', ':DayZ/images/butclick.png' )
			exports.imageButton:createImageButton ( 'secWeap', screenWidth/2+300,screenHeight/2-160, 25, 64, 0, ':DayZ/images/butoff.png', ':DayZ/images/butclick.png' )
			playSound ("sounds/openinventory.mp3",false)
			triggerEvent("disableMenu",localPlayer)
			triggerEvent("hideDebugMonitor",localPlayer)
			addEventHandler ( "onClientRender", root, renderDisplay )
			local yOff = 0
			for i = 1, 11 do
				local createdLabel = guiCreateLabel ( bX-395, bY-230+yOff, 370, 25, '', false )
				setElementData ( createdLabel, 'itemLabel', true )
				setElementData ( createdLabel, 'id', i )
				addEventHandler( "onClientMouseEnter", createdLabel, itemLabelEntered, false )
				addEventHandler( "onClientMouseLeave", createdLabel, itemLabelLeaved, false )
				addEventHandler ( "onClientGUIClick", createdLabel, itemLabelClicked, false )
				local butt1 = exports.imageButton:createImageButton ( 'arrow'..i, bX-395, bY-230+yOff, 23, 23, 0, ':DayZ/images/buttArrow.png', ':DayZ/images/buttArrowDown.png' )
				local butt2 = exports.imageButton:createImageButton ( 'arrowRev'..i, bX-46, bY-230+yOff, 23, 23, 180, ':DayZ/images/buttArrow.png', ':DayZ/images/buttArrowDown.png' )
				exports.imageButton:setImageButtonVisible ( 'arrow'..i, false )
				exports.imageButton:setImageButtonVisible ( 'arrowRev'..i, false )
				table.insert ( itemLabelsButtons, { butt1, butt2 } )
				table.insert ( itemLabels, createdLabel )
				yOff = yOff+30
			end
			local offY = 240
			for i = 1, 6 do
				local offX = 20
				if i%2 == 0 then
					offX = 70
				end
				local createdLabel = guiCreateLabel ( bX+offX, bY-offY, 45, 45, '', false )
				setElementData ( createdLabel, 'foodLabel', true )
				setElementData ( createdLabel, 'id', i )
				addEventHandler( "onClientMouseEnter", createdLabel, itemLabelEntered, false )
				addEventHandler( "onClientMouseLeave", createdLabel, itemLabelLeaved, false )
				addEventHandler ( "onClientGUIClick", createdLabel, rightItemClicked, false )
				table.insert ( foodLabelsButtons, createdLabel )
				if offX == 70 then
					offY = offY-50
				end
			end
			local offX = -50
			local offY = -55
			for i = 1, 9 do
				offX = offX+70
				if i == 5 then
					offY = 20
					offX = 20
				end
				local createdLabel = guiCreateLabel ( bX+offX, bY+offY, 64, 64, '', false )
				setElementData ( createdLabel, 'toolLabel', true )
				setElementData ( createdLabel, 'id', i )
				addEventHandler( "onClientMouseEnter", createdLabel, itemLabelEntered, false )
				addEventHandler( "onClientMouseLeave", createdLabel, itemLabelLeaved, false )
				addEventHandler ( "onClientGUIClick", createdLabel, rightItemClicked, false )
				table.insert ( toolLabelsButtons, createdLabel )
			end
			local offX = -50
			local offY = 120
			for i = 1, 4 do
				offX = offX+70
				local createdLabel = guiCreateLabel ( bX+offX, bY+offY, 64, 64, '', false )
				setElementData ( createdLabel, 'specLabel', true )
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
			unbindKey ( 'mouse1', 'down', checkOnButton )
			unbindKey ( 'mouse1', 'up', testoLabClick )
			destroyElement ( testoLab )
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
			for i, label in ipairs ( foodLabelsButtons ) do
				if isElement ( label ) then
					destroyElement ( label )
				end
			end
			for i, label in ipairs ( toolLabelsButtons ) do
				if isElement ( label ) then
					destroyElement ( label )
				end
			end
			for i = 1, 11 do
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


			prevY = 0
			prevYPos = 0
			itOff = 0
			loot = false
			clicked=false
			scrollLabelSelected = false

			mainWeaponSelection = false
			additWeaponSelection = false
			selectedMainWeapon = 0
			selectedAdditWeapon = 0
			selectedItemLabel = 0
			selectedFoodLabelID = 0
			selectedToolLabelID = 0
			selectedSpecLabelID = 0
			foodLabelSelected = false
			specLabelSelected = false
			toolLabelSelected = false

			itemLabels = {}
			itemLabelsButtons = {}
			foodLabelsButtons={}
			toolLabelsButtons={}
			inventoryShow = false
end

function itemLabelClicked ()
	if getElementData ( source, 'itemLabel' ) then
		local name, info = getInventoryInfosForRightClickMenu ( inventory[getElementData ( source, 'id' )][1] )
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
		if name == "Blood Bag" then
			return true
		end
		if info then
			playerUseItem(name, info)
			setTimer(placeItemsInInventory, 200, 2)
		end
	end
end

function rightItemClicked ()
	local id = getElementData ( source, 'id' )
	if getElementData ( source, 'foodLabel' ) then
		local name = foodInventory[id][1]
		if name == "Water Bottle" or name == "Soda Can (Pepsi)" or name == "Soda Can (Cola)" or name == "Soda Can (Mountain Dew" or name == "Can (Milk)" then
			playerUseItem ( name, "Drink" )
		else
			playerUseItem ( name, "Eat" )
		end
		setTimer(placeItemsInInventory, 200, 2)
	elseif getElementData ( source, 'toolLabel' ) then
		local name = toolInventory[id][1]
		for i,itemInfo in ipairs(inventoryItems["Toolbelt"]) do
			if name == itemInfo[1] then
				if #itemInfo >= 8 then
					playerUseItem ( name, itemInfo[8] )
				end
			end
		end
	elseif getElementData ( source, 'specLabel' ) then
		triggerServerEvent("onPlayerRearmWeapon", getLocalPlayer(), inventoryWeap.spec[id][1], 3)
	end
end

function stopMainWeaponSelection ()
	mainWeaponSelection = false
	for i, label in  ipairs(mainWeapSelectionLabels) do
		if isElement ( label ) then
			destroyElement ( label )
			label = nil
		end
	end
end

function stopAdditWeaponSelection ()
	additWeaponSelection = false
	for i, label in  ipairs(additWeapSelectionLabels) do
		if isElement ( label ) then
			destroyElement ( label )
			label = nil
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
	elseif getElementData ( source, 'foodLabel' ) then
		foodLabelSelected = true
		selectedFoodLabelID = getElementData ( source, 'id' )
	elseif getElementData ( source, 'toolLabel' ) then
		toolLabelSelected = true
		selectedToolLabelID = getElementData ( source, 'id' )
	elseif getElementData ( source, 'specLabel' ) then
		specLabelSelected = true
		selectedSpecLabelID = getElementData ( source, 'id' )
	end
end

function itemLabelLeaved ()
	if getElementData ( source, 'itemLabel' ) then
		--local id = getElementData ( source, 'id' )
		--exports.imageButton:setImageButtonVisible ( itemLabelsButtons[id][1].name, false )
		--exports.imageButton:setImageButtonVisible ( itemLabelsButtons[id][2].name, false )
		--selectedItemLabel = 0
	elseif getElementData ( source, 'foodLabel' ) then
		foodLabelSelected = false
		selectedFoodLabelID = 0
	elseif getElementData ( source, 'toolLabel' ) then
		toolLabelSelected = false
		selectedToolLabelID = 0
	elseif getElementData ( source, 'specLabel' ) then
		specLabelSelected = false
		selectedSpecLabelID = 0
	end
end

function renderDisplay ( )
	--dxDrawRectangle (bX-400, bY-300, 400, 450, tocolor ( 65, 60, 30, 230 ) )
	dxDrawImage(bX-400,bY-300,400,450,"images/inventory1.png")
	if loot then
		local curLootItems = getLootCurrentSlots(loot) or 0 
		local maxLootItems = getLootMaxAviableSlots(loot) or 0
		if maxLootItems > 0 then
			dxDrawText ( 'SLOTS: ' .. curLootItems .. '/' .. maxLootItems, bX-390, bY-290, bX-300,  bY-280, tocolor ( 0,0,0,255), 1.2, 'sans' )
		end
	end
	dxDrawText ( 'SLOTS: ' .. getPlayerCurrentSlots() .. '/' .. getPlayerMaxAviableSlots(), bX-130, bY-290, bX-300,  bY-200, tocolor ( 0,0,0,255), 1.2, 'sans' )
	dxDrawText ( gearName, bX-390, bY-270, bX-200,  bY-200, tocolor ( 0,0,0,255), 1.2, 'sans' )
	dxDrawLine ( bX-390, bY-245, bX-10, bY-245, tocolor ( 255,255,255, 180 ), 3 )
	
	dxDrawLine ( bX-370, bY-235, bX-370, bY+150, tocolor ( 255,255,255, 110 ), 2 )
	dxDrawLine ( bX-330, bY-235, bX-330, bY+150, tocolor ( 255,255,255, 110 ), 2 )
	
	dxDrawLine ( bX-50, bY-235, bX-50, bY+150, tocolor ( 255,255,255, 110 ), 2 )
	dxDrawLine ( bX-90, bY-235, bX-90, bY+150, tocolor ( 255,255,255, 110 ), 2 )
	
	local itScroll = (bY+90)-5*(#inventory-11)
	dxDrawLine ( bX-10, bY-235-prevY, bX-10, itScroll-prevY, tocolor ( 0,0,0, 255 ), 15 )
	
	
	--dxDrawRectangle (bX-400, bY+100, 400, 150, tocolor ( 65,60,30,255 ) )
	dxDrawImage(bX-410,bY+100,430,150,"images/inventory2.png")
	if selectedItemLabel > 0 then
		if selectedItemLabel <= #inventory then
			dxDrawText ( inventory[selectedItemLabel+itOff][1], bX-390, bY+110, screenWidth, screenHeight, tocolor ( 114,100,47,255), 1.4, 'verdana' )
			dxDrawText ( inventory[selectedItemLabel+itOff][7], bX-390, bY+130, screenWidth, screenHeight, tocolor ( 0,0,0,255), 1.3, 'sans' )
			dxDrawText ( inventory[selectedItemLabel+itOff][8], bX-390, bY+150, screenWidth, screenHeight, tocolor ( 0,0,0,255), 1.3, 'sans' )
			local sizeX = 128
			local offX = -32
			if inventory[selectedItemLabel+itOff][5]/inventory[selectedItemLabel+itOff][6] == 1 then
				offX = 0
				sizeX = 64
			end
			dxDrawImage ( bX-100+offX, bY+180, sizeX, 64, 'icons/'..inventory[selectedItemLabel+itOff][4] )
		end
	elseif foodLabelSelected then
		if selectedFoodLabelID <= #foodInventory then
			dxDrawText ( foodInventory[selectedFoodLabelID][1], bX-390, bY+110, screenWidth, screenHeight, tocolor ( 114,100,47,255), 1.4, 'verdana' )
			dxDrawText ( foodInventory[selectedFoodLabelID][5], bX-390, bY+130, screenWidth, screenHeight, tocolor ( 0,0,0,255), 1.3, 'sans' )
			dxDrawText ( foodInventory[selectedFoodLabelID][6], bX-390, bY+150, screenWidth, screenHeight, tocolor (0,0,0,255), 1.3, 'sans' )
			dxDrawImage ( bX-100, bY+180, 64, 64, 'icons/'..foodInventory[selectedFoodLabelID][2] )
		end
	elseif toolLabelSelected then
		if selectedToolLabelID <= #toolInventory then
			dxDrawText ( toolInventory[selectedToolLabelID][1], bX-390, bY+110, screenWidth, screenHeight, tocolor ( 114,100,47,255), 1.4, 'verdana' )
			dxDrawText ( toolInventory[selectedToolLabelID][5], bX-390, bY+130, screenWidth, screenHeight, tocolor ( 0,0,0,255), 1.3, 'sans' )
			dxDrawText ( toolInventory[selectedToolLabelID][6], bX-390, bY+150, screenWidth, screenHeight, tocolor ( 0,0,0,255), 1.3, 'sans' )
			dxDrawImage ( bX-100, bY+180, 64, 64, 'icons/'..toolInventory[selectedToolLabelID][2] )
		end
	elseif specLabelSelected then
		if selectedSpecLabelID <= #inventoryWeap.spec then
			dxDrawText ( inventoryWeap.spec[selectedSpecLabelID][1], bX-390, bY+110, screenWidth, screenHeight, tocolor ( 114,100,47,255), 1.4, 'verdana' )
			dxDrawText ( inventoryWeap.spec[selectedSpecLabelID][5], bX-390, bY+130, screenWidth, screenHeight, tocolor (0,0,0,255), 1.3, 'sans' )
			dxDrawText ( inventoryWeap.spec[selectedSpecLabelID][6], bX-390, bY+150, screenWidth, screenHeight, tocolor ( 0,0,0,255), 1.3, 'sans' )
			dxDrawImage ( bX-100, bY+180, 64, 64, 'icons/'..inventoryWeap.spec[selectedSpecLabelID][2] )
		end
	end
	
	
	--dxDrawRectangle (bX, bY-300, 350, 550, tocolor ( 0,0,0, 200 ) )
	dxDrawImage(bX,bY-300,400,550,"images/inventory3.png")
	dxDrawText (getPlayerName(localPlayer), bX+20, bY-290, screenWidth, screenHeight, tocolor ( 203,199,182,255), 1.5, 'verdana' )
	dxDrawText ( 'Food/Drinks', bX+20, bY-260, screenWidth, screenHeight, tocolor ( 203,199,182,255), 1, 'verdana' )
	dxDrawImage (bX+20, bY-240, 45, 45, 'images/items.png') 
	dxDrawImage (bX+70, bY-240, 45, 45, 'images/items.png') 
	dxDrawImage (bX+20, bY-190, 45, 45, 'images/items.png') 
	dxDrawImage (bX+70, bY-190, 45, 45, 'images/items.png') 
	dxDrawImage (bX+20, bY-140, 45, 45, 'images/items.png') 
	dxDrawImage (bX+70, bY-140, 45, 45, 'images/items.png')
	--[[
	dxDrawRectangle (bX+20, bY-240, 45, 45, tocolor ( 195, 195, 195, 50 ) ) 
	dxDrawRectangle (bX+70, bY-240, 45, 45, tocolor ( 195, 195, 195, 50 ) ) 
	dxDrawRectangle (bX+20, bY-190, 45, 45, tocolor ( 195, 195, 195, 50 ) ) 
	dxDrawRectangle (bX+70, bY-190, 45, 45, tocolor ( 195, 195, 195, 50 ) ) 
	dxDrawRectangle (bX+20, bY-140, 45, 45, tocolor ( 195, 195, 195, 50 ) ) 
	dxDrawRectangle (bX+70, bY-140, 45, 45, tocolor ( 195, 195, 195, 50 ) )
	]]

	yOff = 0
	local foodMax = 6
	if foodMax > #foodInventory then foodMax = #foodInventory end
	for i = 1, foodMax do 
		yPos = bY-240+yOff
		if i%2 == 0 then
			xPos = bX+70
			yOff = yOff+50
		else
			xPos = bX+20
		end
		-- if i > 1 and i%2 == 0 then
			-- yOff = yOff+50
		-- end
		dxDrawImage ( xPos, yPos, 45, 45, 'icons/'..foodInventory[i][2] )
	end
	
	dxDrawText ( "Toolbelt", bX+20, bY-75, screenWidth, screenHeight, tocolor ( 203,199,182,255), 1, 'verdana' )
	dxDrawImage (bX+20, bY-55, 64, 64, 'images/items.png' ) 
	dxDrawImage (bX+90, bY-55, 64, 64, 'images/items.png' ) 
	dxDrawImage (bX+160, bY-55, 64, 64, 'images/items.png' ) 
	dxDrawImage (bX+230, bY-55, 64, 64, 'images/items.png' ) 
	
	dxDrawImage (bX+20, bY+20, 64, 64, 'images/items.png' )
	dxDrawImage (bX+90, bY+20, 64, 64, 'images/items.png' ) 
	dxDrawImage (bX+160, bY+20, 64, 64, 'images/items.png' ) 
	dxDrawImage (bX+230, bY+20, 64, 64, 'images/items.png' ) 
	--[[
	dxDrawRectangle (bX+20, bY-55, 64, 64, tocolor (80,52,20, 50 ) ) 
	dxDrawRectangle (bX+90, bY-55, 64, 64, tocolor ( 80,52,20, 50 ) ) 
	dxDrawRectangle (bX+160, bY-55, 64, 64, tocolor ( 80,52,20, 50 ) ) 
	dxDrawRectangle (bX+230, bY-55, 64, 64, tocolor ( 80,52,20, 50 ) ) 
	
	dxDrawRectangle (bX+20, bY+20, 64, 64, tocolor ( 80,52,20, 50 ) )
	dxDrawRectangle (bX+90, bY+20, 64, 64, tocolor ( 80,52,20, 50 ) ) 
	dxDrawRectangle (bX+160, bY+20, 64, 64, tocolor (80,52,20, 50 ) ) 
	dxDrawRectangle (bX+230, bY+20, 64, 64, tocolor ( 80,52,20, 50 ) ) 
	]]
	local toolMax = 8
	if toolMax > #toolInventory then toolMax = #toolInventory end
	yOff = -55
	xOff = 20
	for i = 1, toolMax do 
		if i == 5 then
			yOff = 20
			xOff = 20
		end
		if i ~= 1 and i ~= 5 then
			xOff = xOff+70
		end
		dxDrawImage ( bX+xOff, bY+yOff, 64, 64, 'icons/'..toolInventory[i][2] )
	end
	
	dxDrawText ( "Primary Weapon", bX+125, bY-260, screenWidth, screenHeight, tocolor ( 203,199,182,255), 1, 'sans' )
	dxDrawImage(bX+125,bY-240,170,62,'images/primary.png')
	dxDrawText ( "Secondary Weapon", bX+125, bY-177, screenWidth, screenHeight, tocolor ( 203,199,182,255), 1, 'sans' )
	dxDrawImage(bX+125, bY-160, 170, 62,'images/secondary.png')
	if selectedMainWeapon > 0 then
		dxDrawImage ( bX+125, bY-245, 170, 80, 'icons/'..inventoryWeap.main[selectedMainWeapon][2] )
	end
	if selectedAdditWeapon > 0 then
		if inventoryWeap.addit[selectedAdditWeapon] then
			local sizeX = 128
			local offX = -32
			if inventoryWeap.addit[selectedAdditWeapon][3]/inventoryWeap.addit[selectedAdditWeapon][4] == 1 then
				sizeX = 64
				offX = 0
			end
			dxDrawImage ( bX+165+offX, bY-160, sizeX, 64, 'icons/'..inventoryWeap.addit[selectedAdditWeapon][2] )
		else
			selectedAdditWeapon = 0
		end
	end
	if mainWeaponSelection then
		local yOff = 35
		for i = 1, #inventoryWeap.main do
			yOff = yOff+35
			dxDrawRectangle (bX+125, bY-240+yOff, 170, 32, tocolor ( 136, 128, 98, 240 ) ) -- Weapon Selection Primary
			dxDrawText ( inventoryWeap.main[i][1], bX+130, bY-235+yOff, screenWidth, screenHeight, tocolor ( 20,20,20,255), 1.4, 'sans' )
		end
	end
	if additWeaponSelection then
		local yOff = 35
		for i = 1, #inventoryWeap.addit do
			yOff = yOff+35
			dxDrawRectangle (bX+125, bY-160+yOff, 170, 32, tocolor ( 136, 128, 98, 240 ) ) -- Weapon Selection Secondary
			dxDrawText ( inventoryWeap.addit[i][1], bX+125, bY-160+yOff, screenWidth, screenHeight, tocolor ( 20,20,20,255), 1.4, 'sans' )
		end
	end
	dxDrawText ( "Special Weapon", bX+20, bY+100, screenWidth, screenHeight, tocolor ( 203,199,182,255), 1, 'sans' )
	dxDrawImage (bX+20, bY+120, 64, 64, 'images/items.png')
	dxDrawImage (bX+90, bY+120, 64, 64, 'images/items.png') 
	dxDrawImage (bX+160, bY+120, 64, 64, 'images/items.png') 
	dxDrawImage (bX+230, bY+120, 64, 64, 'images/items.png')
	xOff = -50
	for i = 1, #inventoryWeap.spec do
		xOff = xOff+70
		dxDrawImage ( bX+xOff, bY+120, 64, 64, 'icons/'..inventoryWeap.spec[i][2] )
	end
	
	yOff = 0
	local mainMax = 11
	if mainMax > #inventory then mainMax = #inventory outputChatBox("mainMax: "..mainMax) end
	for i = 1, mainMax do
		if inventory[i+itOff][2] == 0 and inventory[i+itOff][3] == 0 then inventory[i+itOff][2] = 1 end
		if inventory[i+itOff][5]/inventory[i+itOff][6] == 1 then
			offX = 16
		else
			offX = 32
		end
		dxDrawImage ( bX-320, bY-230+yOff, offX, 16, 'icons/'..inventory[i+itOff][4] )
		dxDrawText ( inventory[i+itOff][1], bX-306+offX, bY-230+yOff, screenWidth, screenHeight, tocolor ( 0,0,0,255), 1.4, 'sans' )
		if inventory[i+itOff][2] > 0 then
			dxDrawText ( inventory[i+itOff][2], bX-355, bY-230+yOff, screenWidth, screenHeight, tocolor (0,0,0,255), 1.4, 'sans' )
		end
		if inventory[i+itOff][3] > 0 then
			dxDrawText ( inventory[i+itOff][3], bX-75, bY-230+yOff, screenWidth, screenHeight, tocolor (0,0,0,255), 1.4, 'sans' )
		end
		if selectedItemLabel == i then
			dxDrawRectangle (bX-395, bY-230+yOff, 370, 25, tocolor ( 10, 10, 10, 30 ) )
		end
		yOff = yOff+30
	end
end
mainWeapSelectionLabels = {}
additWeapSelectionLabels = {}

function showWeaponSelect (button)
	if button.name == 'mainWeap' then
		if not mainWeaponSelection then
			stopAdditWeaponSelection ()
			if #inventoryWeap.main > 1 or selectedMainWeapon == 0 then
				mainWeaponSelection = true
				yOff = 35
				for i = 1, #inventoryWeap.main do
					yOff = yOff+35
					local createdLabel = guiCreateLabel ( bX+125, bY-240+yOff, 170, 32, '', false )
					setElementData ( createdLabel, 'mainWeapSelection', true )
					setElementData ( createdLabel, 'id', i )
					addEventHandler ( "onClientGUIClick", createdLabel, weapSelectionLabelClicked, false )
					table.insert ( mainWeapSelectionLabels, createdLabel )
				end
			end
		else
			stopMainWeaponSelection ()
		end
	elseif button.name == 'secWeap' then
		if not additWeaponSelection then
			stopMainWeaponSelection ()
			if #inventoryWeap.addit > 1 or selectedAdditWeapon == 0 then
				additWeaponSelection = true
				yOff = 35
				for i = 1, #inventoryWeap.addit do
					yOff = yOff+35
					local createdLabel = guiCreateLabel ( bX+125, bY-160+yOff, 170, 32, '', false )
					setElementData ( createdLabel, 'additWeapSelection', true )
					setElementData ( createdLabel, 'id', i )
					addEventHandler ( "onClientGUIClick", createdLabel, weapSelectionLabelClicked, false )
					table.insert ( additWeapSelectionLabels, createdLabel )
				end
			end
		else
			stopAdditWeaponSelection()
		end
	elseif string.find(button.name, 'arrowRev' ) then
		if loot then
			stopAdditWeaponSelection ()
			stopMainWeaponSelection ()
			if inventory [selectedItemLabel+itOff][2] > 0 then
				moveItemInInventory ()
			end
		end
	elseif string.find(button.name, 'arrow' ) then
		stopAdditWeaponSelection ()
		stopMainWeaponSelection ()
		if inventory [selectedItemLabel+itOff][3] > 0 then
			moveItemOutOfInventory ( inventory [selectedItemLabel+itOff][1] )
		end
	end
end

addEvent ( "imageButtonClicked", true )
addEventHandler ( 'imageButtonClicked', root, showWeaponSelect)

function moveItemInInventory()
	local itemName = inventory [selectedItemLabel+itOff][1]
	if isPlayerInLoot() then
		if getElementData(isPlayerInLoot(), itemName) and getElementData(isPlayerInLoot(), itemName) >= 1 then
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
	if isPlayerInLoot() then
		local col = getElementData(getLocalPlayer(), "currentCol")
		setTimer(placeItemsInInventory, 200, 2)
	end
end
function weapSelectionLabelClicked ()
	if getElementData ( source, 'mainWeapSelection' ) then
		local id = getElementData ( source, 'id' )
		local ammoData, weapID = getWeaponAmmoTypeName(inventoryWeap.main[id][1])
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
		local ammoData, weapID = getWeaponAmmoTypeName(inventoryWeap.addit[id][1])
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

bindKey("J", "down", initInventory)
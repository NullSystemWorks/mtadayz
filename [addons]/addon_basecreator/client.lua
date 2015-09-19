--[[

	Author: CiBeR
	Version: 0.1
	Copyright: DayZ Gamemode. All rights reserved to Developers
	Info: MTA:DayZ Base Creation Addon
	Current Devs: Lawliet, CiBeR, Jboy, Remi, Renkon
	
]]--
baseCPanel = {
    edit = {},
    button = {},
    window = {},
    label = {},
	column = {},
    gridlist = {},
	tabpanel = {},
	tab = {},
}

objectTable = {
-- Hatchet is a dummy item, in case you need less parts than expected
-- DIY (Wood) or DIY (Metal) must always be the first item that is needed
{"Wooden Base", 3260, 30, "Wood", "DIY (Wood)","Log","Stone","Hatchet",1,1,2,0},
{"Wood Fence", 1460, 30, "Wood", "DIY (Wood)", "Log","Stone","Hatchet",1,1,1,0},
{"Wooden Door", 3093, 30, "Wood", "DIY (Wood)", "Log", "Stone","Hatchet",1,1,1,0},
{"Wood Structure", 16404, 30, "Wood", "DIY (Wood)", "Log", "Plank", "Nails",1,1,3,5},

{"Metal Fence", 1412, 100, "Metal", "DIY (Metal)","RSJ","Stone","Hatchet",1,1,2,0},
{"Metal Door",  3029, 100, "Metal", "DIY (Metal)","RSJ","Nails","Hatchet",1,2,2,0},
{"Shack", 1457, 100, "Metal", "DIY (Metal)","Metal Sheet (Rusted)","Plank","Hatchet",1,2,2,0}
}

function render()
    baseCPanel.window[1] = guiCreateWindow(0.00, 0.37, 0.57, 0.61, "", true)
    guiWindowSetSizable(baseCPanel.window[1], false)
	guiSetVisible(baseCPanel.window[1], false)

	baseCPanel.tabpanel[1] = guiCreateTabPanel(0.03, 0.07, 0.95, 0.90, true, baseCPanel.window[1])
	baseCPanel.tab[1] = guiCreateTab("Wood", baseCPanel.tabpanel[1])
	baseCPanel.gridlist[1] = guiCreateGridList(0.01, 0.03, 0.36, 0.94, true, baseCPanel.tab[1])
	baseCPanel.column[1] = guiGridListAddColumn(baseCPanel.gridlist[1], "Item", 0.9)
	baseCPanel.label[1] = guiCreateLabel(0.39, 0.04, 0.25, 0.06, "Item:", true, baseCPanel.tab[1])
	baseCPanel.label[2] = guiCreateLabel(0.39, 0.10, 0.25, 0.06, "Durability:", true, baseCPanel.tab[1])
	baseCPanel.label[3] = guiCreateLabel(0.59, 0.04, 0.25, 0.06, "", true, baseCPanel.tab[1])
	baseCPanel.label[4] = guiCreateLabel(0.59, 0.10, 0.25, 0.06, "", true, baseCPanel.tab[1])
	baseCPanel.label[5] = guiCreateLabel(0.39, 0.16, 0.25, 0.06, "Requires:", true, baseCPanel.tab[1])
	baseCPanel.label[6] = guiCreateLabel(0.39, 0.22, 0.25, 0.06, "", true, baseCPanel.tab[1])
	baseCPanel.label[7] = guiCreateLabel(0.39, 0.28, 0.25, 0.06, "", true, baseCPanel.tab[1])
	baseCPanel.label[8] = guiCreateLabel(0.39, 0.34, 0.25, 0.06, "", true, baseCPanel.tab[1])
	baseCPanel.label[9] = guiCreateLabel(0.39, 0.40, 0.25, 0.06, "", true, baseCPanel.tab[1])
	baseCPanel.label[10] = guiCreateLabel(0.39, 0.46, 0.25, 0.06, "", true, baseCPanel.tab[1])
	baseCPanel.label[11] = guiCreateLabel(0.39, 0.52, 0.25, 0.06, "", true, baseCPanel.tab[1])
	baseCPanel.label[12] = guiCreateLabel(0.39, 0.68, 0.25, 0.06, "", true, baseCPanel.tab[1])
	baseCPanel.button[1] = guiCreateButton(0.86, 0.88, 0.12, 0.08, "Place", true, baseCPanel.tab[1])
	
	baseCPanel.tab[2] = guiCreateTab("Metal", baseCPanel.tabpanel[1])
	baseCPanel.gridlist[2] = guiCreateGridList(0.01, 0.03, 0.36, 0.94, true, baseCPanel.tab[2])
	baseCPanel.column[2] = guiGridListAddColumn(baseCPanel.gridlist[2], "Item", 0.9)
	baseCPanel.label[13] = guiCreateLabel(0.39, 0.04, 0.25, 0.06, "Item:", true, baseCPanel.tab[2])
	baseCPanel.label[14] = guiCreateLabel(0.39, 0.10, 0.25, 0.06, "Durability:", true, baseCPanel.tab[2])
	baseCPanel.label[15] = guiCreateLabel(0.59, 0.04, 0.25, 0.06, "", true, baseCPanel.tab[2])
	baseCPanel.label[16] = guiCreateLabel(0.59, 0.10, 0.25, 0.06, "", true, baseCPanel.tab[2])
	baseCPanel.label[17] = guiCreateLabel(0.39, 0.16, 0.25, 0.06, "Requires:", true, baseCPanel.tab[2])
	baseCPanel.label[18] = guiCreateLabel(0.39, 0.22, 0.25, 0.06, "", true, baseCPanel.tab[2])
	baseCPanel.label[19] = guiCreateLabel(0.39, 0.29, 0.25, 0.06, "", true, baseCPanel.tab[2])
	baseCPanel.label[20] = guiCreateLabel(0.39, 0.35, 0.25, 0.06, "", true, baseCPanel.tab[2])
	baseCPanel.label[21] = guiCreateLabel(0.39, 0.41, 0.25, 0.06, "", true, baseCPanel.tab[2])
	baseCPanel.label[22] = guiCreateLabel(0.39, 0.48, 0.25, 0.06, "", true, baseCPanel.tab[2])
	baseCPanel.label[23] = guiCreateLabel(0.39, 0.54, 0.25, 0.06, "", true, baseCPanel.tab[2])
	baseCPanel.label[25] = guiCreateLabel(0.39, 0.60, 0.25, 0.06, "", true, baseCPanel.tab[2])
	baseCPanel.button[2] = guiCreateButton(0.86, 0.88, 0.12, 0.08, "Place", true, baseCPanel.tab[2])
	baseCPanel.tab[3] = guiCreateTab("Help", baseCPanel.tabpanel[1])   

	local row = 0
	local row2 = 0
	local name = ""
	local name2 = ""
	for i, item in ipairs(objectTable) do
		if item[4] == "Wood" then
			name = item[1]
			row = guiGridListAddRow (baseCPanel.gridlist[1])
		end
		if item[4] == "Metal" then
			name2 = item[1]
			row2 = guiGridListAddRow(baseCPanel.gridlist[2])
		end
		guiGridListSetItemText ( baseCPanel.gridlist[1], row, baseCPanel.column[1], name, false, false )
		guiGridListSetItemText ( baseCPanel.gridlist[2], row2, baseCPanel.column[2], name2, false, false )
	end
	addEventHandler("onClientGUIClick", baseCPanel.gridlist[1], function() getRequiredItems(1) end, false)
	addEventHandler("onClientGUIClick", baseCPanel.gridlist[2], function() getRequiredItems(2) end, false)
end

render()
active = false
function togPanel()
	if active then return end
	if isPedInVehicle(localPlayer) then return end
	guiSetVisible(baseCPanel.window[1], not guiGetVisible ( baseCPanel.window[1] ))
	showCursor(not isCursorShowing())
end
bindKey ("F6", "down", togPanel)

tempOb = {}
dep = 5
multip = 1
local health = 0

--[[
function updatePos()
	local ob = tempOb[localPlayer]
		if ob then
			local x, y = getCursorPosition()
			local cX, cY, cZ = getCameraMatrix()
			if getKeyState("lshift") then
				multip = 4
			else
				multip = 1
			end
			if getKeyState("arrow_u") then
				dep = dep + .1 * multip
				outputChatBox("Dep = "..tostring(dep))
			elseif getKeyState("arrow_d") then
				dep = dep - .1 * multip
			end
			local nX, nY, nZ = getWorldFromScreenPosition(x*cX, y*cY, dep)
			local aX, aY, aZ = getElementPosition(ob)
			if (aX ~= nX) or (aY ~= nY) or (aZ ~= nZ) then
					setElementPosition(ob, nX, nY, nZ)
			end
		end
end
]]
function updatePos()
	local object = tempOb[localPlayer]
	if object then
		local screenX, screenY = guiGetScreenSize()
		local x,y = getCursorPosition()
		local x,y = x*screenX,y*screenY
		local sX,sY,sZ = getWorldFromScreenPosition(x,y,0)
		local sX2,sY2,sZ2 = getWorldFromScreenPosition(x,y,20)
		local hit,oX,oY,oZ = processLineOfSight(sX,sY,sZ,sX2,sY2,sZ2,true,false,false,true,false,true,false,false,object)
		if not hit then return end
		setElementPosition(object,oX,oY,oZ + getElementDistanceFromCentreOfMassToBaseOfModel(object))
	end
end

local rotationAxis = "z"
function setRotationOfObject(button,state)
	local object = tempOb[localPlayer]
	if button == "arrow_u" or button == "arrow_d" then
		if state then
			rotationAxis="y"
		else
			rotationAxis="z"
		end
	elseif button == "arrow_r" or button == "arrow_l" then
		if state then
			rotationAxis="x"
		else
			rotationAxis="z"
		end
	end
	if not state then return end
	if button == "mouse_wheel_up" or button == "pgup" then
		if rotationAxis == "z" then
			local x,y,z = getElementRotation(object)
			setElementRotation(object,x,y,z+5)
		elseif rotationAxis == "y" then
			local x,y,z = getElementRotation(object)
			setElementRotation(object,x,y+5,z)
		elseif rotationAxis == "x" then
			local x,y,z = getElementRotation(object)
			setElementRotation(object,x+5,y,z)
		end
	elseif button == "mouse_wheel_down" or button == "pgdn" then
		if rotationAxis == "z" then
			local x,y,z = getElementRotation(object)
			setElementRotation(object,x,y,z-5)	
		elseif rotationAxis == "y" then
			local x,y,z = getElementRotation(object)
			setElementRotation(object,x,y-5,z)
		elseif rotationAxis == "x" then
			local x,y,z = getElementRotation(object)
			setElementRotation(object,x-5,y,z)
		end		
	end
end

isGui = false
addEventHandler( "onClientMouseEnter", root,
function ()
	isGui = true
end) 

addEventHandler( "onClientMouseLeave", root,
function ()
	isGui = false
end)

function checkClick(bt, state)
	if bt == "left" and state == "down" and tempOb[localPlayer] and not isGui then
		local x, y, z = getElementPosition(tempOb[localPlayer])
		local rx, ry, rz = getElementRotation(tempOb[localPlayer])
		local model = getElementModel(tempOb[localPlayer])
		removeEventHandler("onClientRender", root, updatePos)
		destroyElement(tempOb[localPlayer])
		tempOb[localPlayer] = nil
		triggerServerEvent("addon.basecreator:newObject", localPlayer, model, x, y, z, rx, ry, rz, health )
		active = false
		removeEventHandler("onClientClick", root, checkClick)
		removeEventHandler("onClientKey",root,setRotationOfObject)
		removeEventHandler("onClientClick", root, handleObDelete)
		takeItemsFromPlayer(model)
	end
end

local gridlistnumber = 0
function handleObSpawn(_, state, x, y)
	if state == "up" and not tempOb[localPlayer] then
		local theObjectName = guiGridListGetItemText ( baseCPanel.gridlist[gridlistnumber], guiGridListGetSelectedItem ( baseCPanel.gridlist[gridlistnumber] ), 1 )
		if theObjectName then
			for i, item in ipairs(objectTable) do
				if item[1] == theObjectName then
					if getElementData(localPlayer,item[5]) and getElementData(localPlayer,item[5]) >= item[9] then
						if getElementData(localPlayer,item[6]) and getElementData(localPlayer,item[6]) >= item[10] then
							if getElementData(localPlayer,item[7]) and getElementData(localPlayer,item[7]) >= item[11] then
								if getElementData(localPlayer,item[8]) and getElementData(localPlayer,item[8]) >= item[12] then
									local id = item[2]
									local pX,pY,pZ = getElementPosition(localPlayer)
									tempOb[localPlayer] = createObject(id, pX+2, pY+2, pZ, 0, 0, 0)
									health = item[3]
									if tempOb[localPlayer] then
										addEventHandler("onClientRender", root, updatePos)
										addEventHandler("onClientClick", root, checkClick)
										addEventHandler("onClientKey",root,setRotationOfObject)
										addEventHandler("onClientClick", root, handleObDelete)
										active = true
										setElementCollisionsEnabled(tempOb[localPlayer], false)
										setElementAlpha(tempOb[localPlayer],150)
									end
								else
									outputChatBox("You need "..item[8].." to build this!",255,0,0)
									return
								end
							else
								outputChatBox("You need "..item[7].." to build this!",255,0,0)
								return
							end
						else
							outputChatBox("You need "..item[6].." to build this!",255,0,0)
							return
						end
					else
						outputChatBox("You need "..item[5].." to build this!",255,0,0)
						return
					end
				end
			end
		end
	end
end

function handleObDelete(button, state)
	if button == "right" then
		removeEventHandler("onClientRender", root, updatePos)
		if tempOb[localPlayer] then
			destroyElement(tempOb[localPlayer])
		end
		removeEventHandler("onClientClick", root, checkClick)
		removeEventHandler("onClientKey",root, setRotationOfObject)
		tempOb[localPlayer] = nil
		active = false
		removeEventHandler("onClientClick", root, handleObDelete)
	end
end

function getRequiredItems(number)
local clickedItem = guiGridListGetItemText(baseCPanel.gridlist[number], guiGridListGetSelectedItem (baseCPanel.gridlist[number]),1)
	for i, item in ipairs(objectTable) do
		if clickedItem == item[1] then
			if number == 1 then
				guiSetText(baseCPanel.label[3],tostring(item[1]))
				guiSetText(baseCPanel.label[4],tostring(item[3]))
				guiSetText(baseCPanel.label[6],tostring(item[5]).." x"..tostring(item[9]))
				guiSetText(baseCPanel.label[7],tostring(item[6]).." x"..tostring(item[10]))
				guiSetText(baseCPanel.label[8],tostring(item[7]).." x"..tostring(item[11]))
				guiSetText(baseCPanel.label[9],tostring(item[8]).." x"..tostring(item[12]))
			elseif number == 2 then
				guiSetText(baseCPanel.label[15],tostring(item[1]))
				guiSetText(baseCPanel.label[16],tostring(item[3]))
				guiSetText(baseCPanel.label[18],tostring(item[5]).." x"..tostring(item[9]))
				guiSetText(baseCPanel.label[19],tostring(item[6]).." x"..tostring(item[10]))
				guiSetText(baseCPanel.label[20],tostring(item[7]).." x"..tostring(item[11]))
				guiSetText(baseCPanel.label[21],tostring(item[8]).." x"..tostring(item[12]))
			end
		end
	end
	gridlistnumber = number
end

function setTheObjectUnbreakable(object)
	setObjectBreakable(object,false)
end
addEvent("setTheObjectUnbreakable",true)
addEventHandler("setTheObjectUnbreakable",root,setTheObjectUnbreakable)

function takeItemsFromPlayer(theModel)
	for i, item in ipairs(objectTable) do
		if theModel == item[2] then
			setElementData(localPlayer,item[6],getElementData(localPlayer,item[6])-item[10])
			setElementData(localPlayer,item[7],getElementData(localPlayer,item[7])-item[11])
			setElementData(localPlayer,item[8],getElementData(localPlayer,item[8])-item[12])
		end
	end
end

function setObjectDamage(weapon,_,_,hitX,hitY,hitZ,hitElement)
	if weapon ~= 0 then
		if hitElement and getElementType(hitElement) == "object" then
			for i, object in ipairs(objectTable) do
				if getElementModel(hitElement) == object[2] then
					setElementData(hitElement,"object.health",getElementData(hitElement,"object.health")-1)
					triggerServerEvent("onObjectDamage",root,hitElement,getElementData(hitElement,"object.health"),getElementData(hitElement,"bc.ID"))
					outputChatBox("Health = "..tostring(getElementData(hitElement,"object.health")))
				end
			end
			if getElementData(hitElement,"object.health") <= 0 then
				triggerServerEvent("onObjectDestroy",root,hitElement,getElementData(hitElement,"bc.ID"))
			end
		end
	end
end
addEventHandler("onClientPlayerWeaponFire",root,setObjectDamage)

--[[Events]]--
addEventHandler ( "onClientGUIClick", baseCPanel.button[1], handleObSpawn, false )
addEventHandler ( "onClientGUIClick", baseCPanel.button[2], handleObSpawn, false )
--addEventHandler ( "onClientGUIClick", baseCPanel.button[2], handleObDelete, false )
--[[

	Author: CiBeR
	Version: 0.1
	Copyright: DayZ Gamemode. All rights reserved to Developers
	Info: MTA:DayZ Base Creation Addon
	Current Devs: Lawliet, CiBeR, Jboy, Remi
	
]]--
baseCPanel = {
    edit = {},
    button = {},
    window = {},
    label = {},
	column = {},
    gridlist = {}
}
--[[

	FORMAT: {Object Name, Object ID},
	
]]--
objectTable = {
{"Mine", 2918},
{"Wall 1", 990},
{"Trash", 1337}
}

function render()
    baseCPanel.window[1] = guiCreateWindow(10, 207, 345, 396, "DayZ Base Creator", false)
    guiWindowSetSizable(baseCPanel.window[1], false)
	guiSetVisible(baseCPanel.window[1], false)

    baseCPanel.gridlist[1] = guiCreateGridList(10, 43, 212, 328, false, baseCPanel.window[1])
    baseCPanel.column[1] = guiGridListAddColumn(baseCPanel.gridlist[1], "Object Name", 0.9)
    baseCPanel.edit[1] = guiCreateEdit(288, 53, 45, 32, "0", false, baseCPanel.window[1])
    baseCPanel.label[1] = guiCreateLabel(238, 63, 40, 17, "Rot X :", false, baseCPanel.window[1])
    guiSetFont(baseCPanel.label[1], "default-bold-small")
    baseCPanel.label[2] = guiCreateLabel(238, 107, 40, 17, "Rot Y :", false, baseCPanel.window[1])
    guiSetFont(baseCPanel.label[2], "default-bold-small")
    baseCPanel.edit[2] = guiCreateEdit(288, 97, 45, 32, "0", false, baseCPanel.window[1])
    baseCPanel.label[3] = guiCreateLabel(238, 151, 40, 17, "Rot Z :", false, baseCPanel.window[1])
    guiSetFont(baseCPanel.label[3], "default-bold-small")
    baseCPanel.edit[3] = guiCreateEdit(288, 141, 45, 32, "0", false, baseCPanel.window[1])
    baseCPanel.button[1] = guiCreateButton(231, 192, 102, 41, "Spawn Object", false, baseCPanel.window[1])
    guiSetFont(baseCPanel.button[1], "default-bold-small")
    baseCPanel.button[2] = guiCreateButton(231, 243, 102, 41, "Delete Object", false, baseCPanel.window[1])
    guiSetFont(baseCPanel.button[2], "default-bold-small")
		for i, item in ipairs(objectTable)do
			local name = item[1]
			local row = guiGridListAddRow ( baseCPanel.gridlist[1] )
			guiGridListSetItemText ( baseCPanel.gridlist[1], row, baseCPanel.column[1], name, false, false )
		end
end
render()
active = false
function togPanel()
	if active then return end
	guiSetVisible(baseCPanel.window[1], not guiGetVisible ( baseCPanel.window[1] ))
	showCursor(not isCursorShowing())
end
bindKey ("F6", "down", togPanel)
tempOb = {}
dep = 5
multip = 1
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
isGui = false
addEventHandler( "onClientMouseEnter", root,
function ()
	isGui = true
end
) 
addEventHandler( "onClientMouseLeave", root,
function ()
	isGui = false
end
) 
function checkClick(bt, state)
	if bt == "left" and state == "down" and tempOb[localPlayer] and not isGui then
		local x, y, z = getElementPosition(tempOb[localPlayer])
		local rx, ry, rz = getElementRotation(tempOb[localPlayer])
		local model = getElementModel(tempOb[localPlayer])
		removeEventHandler("onClientRender", root, updatePos)
		destroyElement(tempOb[localPlayer])
		tempOb[localPlayer] = nil
		triggerServerEvent("addon.basecreator:newObject", localPlayer, model, x, y, z, rx, ry, rz )
		active = false
		removeEventHandler("onClientClick", root, checkClick)
	end

end
function handleObSpawn(_, state, x, y)
	if state == "up" and not tempOb[localPlayer] then
		local theObjectName = guiGridListGetItemText ( baseCPanel.gridlist[1], guiGridListGetSelectedItem ( baseCPanel.gridlist[1] ), 1 )
			if theObjectName then
				for i, item in ipairs(objectTable)do
					if item[1] == theObjectName then
						local id = item[2]
						local rotX, rotY, rotZ = tonumber(guiGetText(baseCPanel.edit[1])), tonumber(guiGetText(baseCPanel.edit[2])), tonumber(guiGetText(baseCPanel.edit[3]))
						local pX,pY,pZ = getElementPosition(localPlayer)
						tempOb[localPlayer] = createObject(id, pX+2, pY+2, pZ, rotX, rotY, rotZ)
						if tempOb[localPlayer] then
							addEventHandler("onClientRender", root, updatePos)
							addEventHandler ( "onClientClick", root, checkClick )
							active = true
							setElementCollisionsEnabled(tempOb[localPlayer], false)
						end
					end
				end
			end
	end

end
function handleObDelete()
	removeEventHandler("onClientRender", root, updatePos)
	destroyElement(tempOb[localPlayer])
	removeEventHandler("onClientClick", root, checkClick)
	tempOb[localPlayer] = nil
	active = false
end
--[[Events]]--
addEventHandler ( "onClientGUIClick", baseCPanel.button[1], handleObSpawn, false )
addEventHandler ( "onClientGUIClick", baseCPanel.button[2], handleObDelete, false )
local PENDING_COLOR = tocolor(255,255,255)

local CURSOR_DEFAULT_ONE_WAY_COLOR              = tocolor(255,128,0)
local CURSOR_DEFAULT_TWO_WAY_COLOR              = tocolor(0,255,0)
local CURSOR_PATHPOINT_SELECTED_ONE_WAY_COLOR   = tocolor(255,255,0)
local CURSOR_PATHPOINT_SELECTED_TWO_WAY_COLOR   = tocolor(0,255,255)
local CURSOR_PATHPOINT_SELECT_ONE_WAY_COLOR     = PENDING_COLOR
local CURSOR_PATHPOINT_SELECT_TWO_WAY_COLOR     = PENDING_COLOR
local CURSOR_PATHPOINT_DESELECT_ONE_WAY_COLOR   = PENDING_COLOR
local CURSOR_PATHPOINT_DESELECT_TWO_WAY_COLOR   = PENDING_COLOR
local CURSOR_PATHPOINT_CONNECT_ONE_WAY_COLOR    = PENDING_COLOR
local CURSOR_PATHPOINT_CONNECT_TWO_WAY_COLOR    = PENDING_COLOR
local CURSOR_PATHPOINT_DISCONNECT_ONE_WAY_COLOR = tocolor(255,128,0)
local CURSOR_PATHPOINT_DISCONNECT_TWO_WAY_COLOR = tocolor(255,128,0)

local LINE_DEFAULT_ONE_WAY_COLOR            = tocolor(255,0,0)
local LINE_DEFAULT_TWO_WAY_COLOR            = tocolor(0,255,0)
local LINE_PATHPOINT_SELECTED_ONE_WAY_COLOR = PENDING_COLOR
local LINE_PATHPOINT_SELECTED_TWO_WAY_COLOR = PENDING_COLOR
local LINE_PATH_CREATED_ONE_WAY_COLOR       = tocolor(255,128,0)
local LINE_PATH_CREATED_TWO_WAY_COLOR       = tocolor(0,128,255)
local LINE_CONNECT_ONE_WAY_COLOR            = tocolor(255,255,0)
local LINE_CONNECT_TWO_WAY_COLOR            = tocolor(0,255,255)
local LINE_DISCONNECT_ONE_WAY_COLOR         = tocolor(255,128,128)
local LINE_DISCONNECT_TWO_WAY_COLOR         = tocolor(255,128,128)

local STATE_TEXT_FONT     = "default"
local STATE_TEXT_SCALE    = 1
local STATE_TEXT_PADDING  = 3
local STATE_TEXT_BG_COLOR = tocolor(0,0,0,200)
local STATE_TEXT_COLOR    = tocolor(255,255,255)

addEvent("sbNewMapStart",true)

local screenWidth, screenHeight = guiGetScreenSize()

local linesVisibleButton, connModeButton, oneWayButton

local pathpoints, toggle, connect, oneway, connectStart, drawConnectBegin, drawConnectEnd

local arrows = {}

function onStart()
	toggle  = true
	connect = false
	oneway  = false
	
	scanPathpoints()
	
	setTimer(replaceModels,1000,3)
	
	addCommandHandler("Fix flag models",replaceModels)
	addCommandHandler("Toggle connect mode",toggleConnect)
	addCommandHandler("Toggle line drawing",toggleRender)
	addCommandHandler("Toggle one-way connect",toggleOneWay)
	
	bindKey("g","down","Toggle connect mode")
	bindKey("h","down","Toggle one-way connect")
	bindKey("j","down","Toggle line drawing")
	bindKey("k","down","Fix flag models")
	
	bindKey("mouse1","down",handleConnect)
	bindKey("mouse2","down",handleConnect)
	
	connModeButton     = guiCreateButton(screenWidth - 170, screenHeight - 126, 150, 30, "Connection mode ("..next(getBoundKeys("Toggle connect mode"))..")", false)
		guiSetProperty(connModeButton,"NormalTextColour","FFFF0000")
	oneWayButton       = guiCreateButton(screenWidth - 170, screenHeight - 86, 150, 30, "One-way connection ("..next(getBoundKeys("Toggle one-way connect"))..")", false)
		guiSetProperty(oneWayButton,"NormalTextColour","FFFF0000")
	linesVisibleButton = guiCreateButton(screenWidth - 170, screenHeight - 46, 150, 30, "Connection lines ("..next(getBoundKeys("Toggle line drawing"))..")", false)
		guiSetProperty(linesVisibleButton,"NormalTextColour","FF00FF00")
	
	addEventHandler("sbNewMapStart",getRootElement(),scanPathpoints)
--	addEventHandler("onClientClick",getRootElement(),handleConnect)
	addEventHandler("onClientElementCreate",getRootElement(),handlePathpointCreate)
	addEventHandler("onClientElementDataChange",getRootElement(),updateConnections)
	addEventHandler("onClientElementSelect",getRootElement(),cancelElementSelect)
	addEventHandler("onClientGUIClick",linesVisibleButton,toggleRender,false)
	addEventHandler("onClientGUIClick",connModeButton,toggleConnect,false)
	addEventHandler("onClientGUIClick",oneWayButton,toggleOneWay,false)
	addEventHandler("onClientRender",getRootElement(),showNeighborsOnRender)
--	addEventHandler("onClientRender",getRootElement(),drawFPS)
end
addEventHandler("onClientResourceStart",getResourceRootElement(),onStart)

function onStop()
	removeEventHandler("sbNewMapStart",getRootElement(),scanPathpoints)
--	removeEventHandler("onClientClick",getRootElement(),handleConnect)
	removeEventHandler("onClientElementCreate",getRootElement(),handlePathpointCreate)
	removeEventHandler("onClientElementDataChange",getRootElement(),updateConnections)
	removeEventHandler("onClientElementSelect",getRootElement(),cancelElementSelect)
	removeEventHandler("onClientGUIClick",linesVisibleButton,toggleRender,false)
	removeEventHandler("onClientGUIClick",connModeButton,toggleConnect,false)
	removeEventHandler("onClientGUIClick",oneWayButton,toggleOneWay,false)
	removeEventHandler("onClientRender",getRootElement(),showNeighborsOnRender)
--	removeEventHandler("onClientRender",getRootElement(),drawFPS)
	
	unbindKey("g","down","Toggle connect mode")
	unbindKey("h","down","Toggle one-way connect")
	unbindKey("j","down","Toggle line drawing")
	unbindKey("k","down","Fix flag models")
	
	unbindKey("mouse1","down",handleConnect)
	unbindKey("mouse2","down",handleConnect)
	
	removeCommandHandler("Fix flag models",replaceModels)
	removeCommandHandler("Toggle connect mode",toggleConnect)
	removeCommandHandler("Toggle line drawing",toggleRender)
	removeCommandHandler("Toggle one-way connect",toggleOneWay)
	
	destroyElement(oneWayButton)
	destroyElement(linesVisibleButton)
	destroyElement(connModeButton)
end

function cancelElementSelect() -- Makes sure you can't select elements while in connection mode
	if connect then
		cancelEvent()
	end
end

function replaceModels()
	local txd = engineLoadTXD(":Slothbot/edf/flag/goflagx.txd")
	engineImportTXD(txd,2993)
	local dff = engineLoadDFF(":Slothbot/edf/flag/kmb_goflag.dff",0)
	local col = engineLoadCOL(":Slothbot/edf/flag/kmb_goflag.col")
	engineReplaceCOL(col,2993)
	engineReplaceModel(dff,2993)
end

function checkConnections(point,pointTable,checkOneWay)
	connectionTable = getAllConnectionElements(getElementID(point))
	
	local twoWayConnections = {}
	local oneWayConnections = {}
	
	for index,connection in ipairs(connectionTable) do
		local connectionID = getElementData(point,"PathpointID")
		
		local continue = true
		local ways = 2
		
		if checkOneWay ~= false then
			local oneWay = isConnected1Way(getElementID(point),getElementID(connection))
			
			if oneWay then
				ways = 1
			end
		end
		
		if connectionID and pathpoints[connectionID] then
			for index2,connectionOfConnection in ipairs(pathpoints[connectionID][ways+1]) do
				if connectionOfConnection==connection then
					table.remove(connectionTable,index)
					continue = false
				end
			end
		end
		
		if continue then
			if ways == 1 then
				oneWayConnections[#oneWayConnections+1]=connection
			else
				twoWayConnections[#twoWayConnections+1]=connection
			end
		end
	end
	
	pointTable[2] = twoWayConnections
	pointTable[3] = oneWayConnections
end

function handlePathpointCreate()
	newPathpoint(source,true)
end

function newPathpoint(point,checkOneWay)
	if getElementType(point)=="pathpoint" then
		local pointTable = {point}
		
		checkConnections(point,pointTable,checkOneWay)
		
		local ID = #pathpoints+1
		setElementData(point,"PathpointID",ID,false)
		
		pathpoints[ID] = pointTable
	end
end

function scanPathpoints()
	pathpoints = {}
	
	for index,point in ipairs(getElementsByType("pathpoint")) do
		newPathpoint(point,true)
	end
end

function updateConnections(name)
	if name=="neighbors" and getElementType(source)=="pathpoint" then
--[[		for index,pointTable in ipairs(pathpoints) do
			if source==pointTable[1] then
				checkConnections(source,pathpoints[getElementData(source,"PathpointID")],true)
				return
			end
		end]]
		
		scanPathpoints()
	end
end

function showNeighborsOnRender()
	local cursorX,cursorY = getCursorPosition()
	
	if cursorX then
		cursorX = cursorX * screenWidth
		cursorY = cursorY * screenHeight
	else
		cursorX = 0.5 * screenWidth
		cursorY = 0.5 * screenHeight
	end
	
	local xEnd, yEnd, zEnd                         = getWorldFromScreenPosition(cursorX, cursorY, 100)
	local camX, camY, camZ                         = getCameraMatrix()
	local collision, colX, colY, colZ, mouseTarget = processLineOfSight(camX, camY, camZ, xEnd, yEnd, zEnd)
	
	if mouseTarget then
		mouseTarget = exports.edf:edfGetAncestor(mouseTarget)
	end
	
	-------------------------------------------------------------------------------------------------------------
	
	if toggle then
		local arrow = 0
		
		for index,pointTable in ipairs(pathpoints) do
			local pointX,pointY,pointZ = exports.edf:edfGetElementPosition(pointTable[1])
			
			for neighborIndex,neighbor in ipairs(pointTable[2]) do
				local nbX,nbY,nbZ = exports.edf:edfGetElementPosition(neighbor)
				
				dxDrawLine3D(pointX,pointY,pointZ+1,nbX,nbY,nbZ+1,LINE_DEFAULT_TWO_WAY_COLOR)
			end
			
			for neighborIndex,neighbor in ipairs(pointTable[3]) do
				local nbX,nbY,nbZ = exports.edf:edfGetElementPosition(neighbor)
				
				dxDrawLine3D(pointX,pointY,pointZ+1,nbX,nbY,nbZ+1,LINE_DEFAULT_ONE_WAY_COLOR)
				
				arrow = arrow + 1
				local myArrow = arrows[arrow]
				
				if not myArrow then
					myArrow = createObject(1318,0,0,0)
						setElementDimension(myArrow,getElementDimension(getLocalPlayer()))
					arrows[#arrows+1] = myArrow
				end
				
				local midX = (pointX + nbX) / 2
				local midY = (pointY + nbY) / 2
				local midZ = (pointZ + nbZ) / 2
				
				local rotX = 90
				local rotY = 90
				local rotZ = -math.deg(math.atan2(nbX-midX,nbY-midY)) - 90
				
				setElementPosition(myArrow, midX, midY, midZ + 2)
				setElementRotation(myArrow, rotX, rotY, rotZ)
			end
		end
		
		if drawConnectBegin and drawConnectEnd then
			local startX,startY,startZ = exports.edf:edfGetElementPosition(drawConnectBegin)
			local endX,endY,endZ       = exports.edf:edfGetElementPosition(drawConnectEnd)
			
			local color
			
			if oneway then
				color = LINE_PATH_CREATED_ONE_WAY_COLOR
			else
				color = LINE_PATH_CREATED_TWO_WAY_COLOR
			end
			
			dxDrawLine3D(startX,startY,startZ+1,endX,endY,endZ+1,color)
		end
		
		if #arrows > arrow then
			for index = #arrows, arrow + 1, -1 do
				local arrow = table.remove(arrows,index)
			
				if isElement(arrow) then
					destroyElement(arrow)
				end
			end
		end
	elseif #arrows > 0 then
		for index = #arrows, 1, -1 do
			local arrow = table.remove(arrows,index)
			
			if isElement(arrow) then
				destroyElement(arrow)
			end
		end
	end
	
	if connect then
		local rectColor
		local lineColor
		local stateText
		
		-------------------------------------------------------------------------------------------------------------
		
		if connectStart then
			local xStart, yStart, zStart = exports.edf:edfGetElementPosition(connectStart)
			
			if collision and mouseTarget and getElementType(mouseTarget) == "pathpoint" and mouseTarget ~= connectStart then
				xEnd, yEnd, zEnd = exports.edf:edfGetElementPosition(mouseTarget)
				zEnd = zEnd + 1
				
				if isConnected(getElementID(mouseTarget),getElementID(connectStart)) then
					if not isConnected1Way(getElementID(mouseTarget),getElementID(connectStart)) or not isConnected1Way(getElementID(connectStart),getElementID(mouseTarget)) then
						lineColor = LINE_DISCONNECT_ONE_WAY_COLOR
					else
						lineColor = LINE_DISCONNECT_TWO_WAY_COLOR
					end
				else
					if oneway then
						lineColor = LINE_CONNECT_ONE_WAY_COLOR
					else
						lineColor = LINE_CONNECT_TWO_WAY_COLOR
					end
				end
			else
				if mouseTarget == connectStart then
					xEnd, yEnd, zEnd = exports.edf:edfGetElementPosition(mouseTarget)
					zEnd = zEnd + 1
				elseif collision then
					xEnd, yEnd, zEnd = colX, colY, colZ
				end
				
				if oneway then
					lineColor = LINE_PATHPOINT_SELECTED_ONE_WAY_COLOR
				else
					lineColor = LINE_PATHPOINT_SELECTED_TWO_WAY_COLOR
				end
			end
			
			dxDrawLine3D(xStart, yStart, zStart + 1, xEnd, yEnd, zEnd, lineColor)
		end
		
		-------------------------------------------------------------------------------------------------------------
		
		if mouseTarget and getElementType(mouseTarget) == "pathpoint" then
			if not connectStart then
				stateText = "Select"
				if oneway then
					rectColor = CURSOR_PATHPOINT_SELECT_ONE_WAY_COLOR
				else
					rectColor = CURSOR_PATHPOINT_SELECT_TWO_WAY_COLOR
				end
			elseif mouseTarget == connectStart then
				stateText = "Deselect"
				if oneway then
					rectColor = CURSOR_PATHPOINT_DESELECT_ONE_WAY_COLOR
				else
					rectColor = CURSOR_PATHPOINT_DESELECT_TWO_WAY_COLOR
				end
			elseif isConnected(getElementID(mouseTarget),getElementID(connectStart)) then
				stateText = "Disconnect"
				if not isConnected1Way(getElementID(mouseTarget),getElementID(connectStart)) or not isConnected1Way(getElementID(connectStart),getElementID(mouseTarget)) then
					rectColor = CURSOR_PATHPOINT_DISCONNECT_ONE_WAY_COLOR
				else
					rectColor = CURSOR_PATHPOINT_DISCONNECT_TWO_WAY_COLOR
				end
			else
				if oneway then
					stateText = "Connect (one-way)"
					rectColor = CURSOR_PATHPOINT_CONNECT_ONE_WAY_COLOR
				else
					stateText = "Connect (two-way)"
					rectColor = CURSOR_PATHPOINT_CONNECT_TWO_WAY_COLOR
				end
			end
		else
			if connectStart then
				if oneway then
					rectColor = CURSOR_PATHPOINT_SELECTED_ONE_WAY_COLOR
				else
					rectColor = CURSOR_PATHPOINT_SELECTED_TWO_WAY_COLOR
				end
			else
				if oneway then
					rectColor = CURSOR_DEFAULT_ONE_WAY_COLOR
				else
					rectColor = CURSOR_DEFAULT_TWO_WAY_COLOR
				end
			end
		end
		
		dxDrawRectangle(cursorX + 10, cursorY + 10, 8, 8, rectColor)
		
		if stateText then
			local width  = dxGetTextWidth(stateText,STATE_TEXT_SCALE,STATE_TEXT_FONT) + STATE_TEXT_PADDING * 2
			local height = dxGetFontHeight(STATE_TEXT_SCALE,STATE_TEXT_FONT) + STATE_TEXT_PADDING * 2
			
			local bgX = cursorX - width / 2
			
			dxDrawRectangle(bgX, cursorY + 36, width, height, STATE_TEXT_BG_COLOR)
			dxDrawText(stateText, bgX, cursorY + 36, bgX + width, cursorY + 36 + height, STATE_TEXT_COLOR, STATE_TEXT_SCALE, STATE_TEXT_FONT, "center", "center")
		end
	end
end

function handleConnect(button,state)
	if button == "mouse1" then
		local cursorX, cursorY = getCursorPosition()
		
		if not cursorX then
			cursorX = 0.5
			cursorY = 0.5
		end
		
		cursorX = cursorX * screenWidth
		cursorY = cursorY * screenHeight
		
		local cursorX, cursorY, cursorZ = getWorldFromScreenPosition(cursorX, cursorY, 100)
		local camX   , camY   , camZ    = getCameraMatrix()
		
		local collision, colX, colY, colZ, element = processLineOfSight(camX, camY, camZ, cursorX, cursorY, cursorZ)
		
		local ancestor = element and exports.edf:edfGetAncestor(element) or false
		if ancestor and getElementType(ancestor)=="pathpoint" and connect and connectStart ~= ancestor then
			if connectStart then
				local startID = getElementID(connectStart)
				local stopID  = getElementID(ancestor)
				
				if not isConnected(startID,stopID) then
					triggerServerEvent("doAttachPathpoints",getRootElement(),startID,stopID,oneway)
					
					drawConnectBegin = connectStart
					drawConnectEnd   = ancestor
					
					connectStart = ancestor
				else
					triggerServerEvent("doDetachPathpoints",getRootElement(),startID,stopID)
					
					drawConnectBegin = nil
					drawConnectEnd   = nil
					
					connectStart = nil
				end
			else
				drawConnectBegin = nil
				drawConnectEnd   = nil
				
				connectStart = ancestor
			end
		else
			connectStart = nil
			
			drawConnectBegin = nil
			drawConnectEnd   = nil
		end
	elseif button == "mouse2" then
		connectStart = nil
		
		drawConnectBegin = nil
		drawConnectEnd   = nil
	end
end

function toggleRender()
	toggle = not toggle
	
	if toggle then
		guiSetProperty(linesVisibleButton,"NormalTextColour","FF00FF00")
	else
		guiSetProperty(linesVisibleButton,"NormalTextColour","FFFF0000")
	end
end


function toggleConnect()
	connect          = not connect
	connectStart     = nil
	drawConnectBegin = nil
	drawConnectEnd   = nil
	
	if connect then
		guiSetProperty(connModeButton,"NormalTextColour","FF00FF00")
		exports.editor_main:dropElement() -- Drops the current element
	else
		guiSetProperty(connModeButton,"NormalTextColour","FFFF0000")
	end
end

function toggleOneWay()
	oneway = not oneway
	
	if oneway then
		guiSetProperty(oneWayButton,"NormalTextColour","FF00FF00")
	else
		guiSetProperty(oneWayButton,"NormalTextColour","FFFF0000")
	end
end

--[[ local MAX_THICKNESS = 0.6

function dxDrawLine3D(x1,y1,z1,x2,y2,z2,color)                       FAILED ATTEMPT TO SPEED UP LINE RENDERING; SLOWS LINE RENDERING
	local camX, camY, camZ = getCameraMatrix()
	
	local midX = (x1 + x2) / 2
	local midY = (y1 + y2) / 2
	local midZ = (z1 + z2) / 2
	
	local thickness = (100/getDistanceBetweenPoints3D(camX,camY,camZ,midX,midY,midZ)) * MAX_THICKNESS
	
	local xBegin, yBegin = getScreenFromWorldPosition(x1, y1, z1, 0.5)
	local xEnd  , yEnd   = getScreenFromWorldPosition(x2, y2, z2, 0.5)
	
	if xBegin and xEnd then
		dxDrawLine(xBegin, yBegin, xEnd, yEnd, color, thickness)
	end
end

local frameCount = 0
local frameDraw  = "-"
local lastTick   = getTickCount()

local fpsY = screenHeight-16

function drawFPS()
	local tick = getTickCount()
	if tick < lastTick + 1000 then
		frameCount = frameCount + 1
	else
		frameDraw  = "FPS: "..frameCount
		frameCount = 1
		lastTick   = tick
	end
	
	dxDrawText(frameDraw,0,fpsY)
end]]
--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: chat.lua								*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: CLIENT														*----
#-----------------------------------------------------------------------------#
]]

--[[
local chatRadius = 20
local chatEadioRadius = 250
 
function sendMessageToNearbyPlayers( message, messageType )
cancelEvent()
    if (messageType == 0) then
		local theTime = getRealTime()
		local hour = theTime.hour
		local minute = theTime.minute
		local seconds = theTime.second
		if hour < 10 then
			hour = "0"..hour
		else
			hour = theTime.hour
		end
		if minute < 10 then
			minute  = "0"..minute
		else
			minute = theTime.minute
		end
		if seconds < 10 then
			minute = "0"..seconds
		else
			seconds = theTime.second
		end
		local posX, posY, posZ = getElementPosition( source )
        local chatSphere = createColSphere( posX, posY, posZ, chatRadius )
        local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
        destroyElement( chatSphere )
        for index, nearbyPlayer in ipairs( nearbyPlayers ) do
            outputChatBox("[LOCAL]"..string.gsub((getPlayerName(source)..": "..message), '#%x%x%x%x%x%x', ''),nearbyPlayer, 244,244,244,true )
        end
		exports.DayZ:saveLog("["..hour..":"..minute..":"..seconds.."] [LOCAL]"..string.gsub((getPlayerName(source)..": "..message), '#%x%x%x%x%x%x', '').."\n","chat")
	end
end
addEventHandler( "onPlayerChat", getRootElement(), sendMessageToNearbyPlayers )

function playerRadioChat(playersource,cmd,...)
	if cmd == "radiochat" then
		local msg2 = table.concat({...}, " ")
		if (getElementData(playersource,"Radio Device") or 0) <= 0 then outputChatBox(shownInfos["noradio"],playersource) return end
        local posX, posY, posZ = getElementPosition( playersource )
        local chatSphere = createColSphere( posX, posY, posZ, chatEadioRadius )
        local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
        destroyElement( chatSphere )
        for index, nearbyPlayer in ipairs( nearbyPlayers ) do
			if getElementData(nearbyPlayer,"Radio Device") > 0 then
				outputChatBox("[RADIO]"..string.gsub((getPlayerName(playersource).." : "..msg2), '#%x%x%x%x%x%x', ''),nearbyPlayer, 238,238,0,true )
			end
        end
	end
end
--addCommandHandler( "radiochat", playerRadioChat )
 
function blockChatMessage(m,mt)
    if mt == 1 then
		cancelEvent()
	end
end
addEventHandler( "onPlayerChat", getRootElement(), blockChatMessage )
]]

local chatbox = {}
local chatSwitch = 1 -- 1 = Local, 2 = Global, 3 = Team/Group
local screenX, screenY = guiGetScreenSize()

function initChatBox()
	local layout = getChatboxLayout()
	chatbox.text = "" 
	chatbox.InputLineText = ""
	chatbox.font = dxCreateFont(":DayZ/fonts/lucida.ttf",8)
	chatbox.fontSizeX = layout["chat_scale"][1]
	chatbox.fontSizeY = layout["chat_scale"][2]
	chatbox.tabHeight = dxGetFontHeight(chatbox.fontSizeY, chatbox.font) + 2
	chatbox.tabOffset = 5
	chatbox.selectedTabIndex = 1
	chatbox.selectedTabName = "All"
	chatbox.chats = {}
	chatbox.tabs = {}
	chatbox.lines = layout["chat_lines"]
	chatbox.lineLife = layout["chat_line_life"]
	chatbox.width = 320*layout["chat_width"]
	--------LOADING POSITION
	--[[if not fileExists("settings.xml") then
		local settingsXML = xmlCreateFile("settings.xml", "settings")
		xmlNodeSetAttribute(xmlCreateChild(settingsXML, "positionX"), "x", "false")
		xmlNodeSetAttribute(xmlCreateChild(settingsXML, "positionY"), "y", "false")
		xmlSaveFile(settingsXML)
		xmlUnloadFile(settingsXML)
		chatbox.posX = screenX/2-200
		chatbox.posY = 10 + chatbox.tabHeight
	else
		local settingsXML = xmlLoadFile("settings.xml")
		local positionX = xmlFindChild(settingsXML, "positionX", 0)
		if positionX then
			local x = xmlNodeGetAttribute(positionX, "x")
			chatbox.posX = tonumber(x) or 10
		end
		local positionY = xmlFindChild(settingsXML, "positionY", 0)
		if positionY then
			local y = xmlNodeGetAttribute(positionY, "y")
			chatbox.posY = tonumber(y) or 10 + chatbox.tabHeight
		end
		xmlUnloadFile(settingsXML)
	end]]
	chatbox.posX = screenX*0.0073
	chatbox.posY = screenY*0.74
	chatbox.tabX = chatbox.posX
	chatbox.history = 100
	chatbox.scroll = 0
	chatbox.edge = 2
	chatbox.fontColorA = layout["chat_text_color"][4]
	chatbox.fontColorHex = string.format("#%02X%02X%02X", layout["chat_text_color"][1],layout["chat_text_color"][2],layout["chat_text_color"][3])
	chatbox.selectedTabFontColor = tocolor(0,255,0,255)
	chatbox.lineHeight = dxGetFontHeight(chatbox.fontSizeY, chatbox.font)
	chatbox.height = chatbox.lineHeight*chatbox.lines
	chatbox.alpha = layout["chat_color"][4]
	chatbox.color = tocolor(layout["chat_color"][1],layout["chat_color"][2],layout["chat_color"][3],chatbox.alpha)
	chatbox.tabAlertColor = tocolor(255,255,0,100)
	chatbox.postGUI = false
	chatbox.fontColor = tocolor(255,255,255,255)
	chatbox.maxTextLength = 80
	chatbox.textOffset = 4
	chatbox.inputX = chatbox.posX+chatbox.textOffset
	chatbox.inputY = chatbox.height+chatbox.posY+chatbox.edge
	chatbox.inputHeight = 3*chatbox.lineHeight
	chatbox.shown = false
	chatbox.inputShown = false
	chatbox.positioning = false
	chatbox.inputColor = tocolor(255,255,255,255)
	chatbox.textPosX = chatbox.textOffset
	chatbox.textPosY = 0
	chatbox.inputType = "Local channel"
	chatbox.fadeOut = layout["chat_css_style_background"]
	chatbox.fadeOutLines = layout["chat_css_style_text"]
	chatbox.removeTextTick = getTickCount()
	chatbox.lastMenuStatus = nil
	chatbox.isChatboxAllowed = true
	chatbox.removeTextTimer = nil
	chatbox.alertTick = getTickCount()
	chatbox.newMessageScrollValue = 0
	chatbox.newMessageScrollSpeed = 0.07
	chatbox.useNewMessageScrollAnimation = true
	chatbox.scrollSpeed = 0.2
	chatbox.extraLineForAnimation = 1		
	if chatbox.width < getMinWidth() then
		chatbox.width = getMinWidth()
	end
	chatbox.renderTarget = dxCreateRenderTarget(chatbox.width, chatbox.height, true)
	if not chatbox.renderTarget or not chatbox.useNewMessageScrollAnimation then
		chatbox.useNewMessageScrollAnimation = false
		chatbox.textPosX = chatbox.posX+chatbox.textOffset
		chatbox.textPosY = chatbox.posY
		chatbox.extraLineForAnimation = 0
	end
	if not chatbox.useNewMessageScrollAnimation then
		receiveChat("", "#ffff00Warning: Not enough Memory - Animation disabled.", "Special", 4)
	end
	toggleChatBox(true)
end
addEventHandler("onClientResourceStart", resourceRoot, initChatBox)

function toggleChatBox(state)
	if state and chatbox.shown then return end
	if state == false and not chatbox.shown then return end
	local keyName = getKeyBoundToCommand("chatbox")
	if not chatbox.shown and chatbox.isChatboxAllowed then
		addEventHandler("onClientRender", root, showChatBox)
		addEventHandler("onClientKey", root, buttonHandling)		
		bindKey(keyName, "down", toggleInput, "All")	
		bindKey("backspace", "up", resetRemoveTick)
		showChat(false)
		chatbox.shown = true
	elseif chatbox.shown then
		removeEventHandler("onClientRender", root, showChatBox)
		removeEventHandler("onClientKey", root, buttonHandling)
		unbindKey(keyName, "down", toggleInput)	
		unbindKey("backspace", "up", resetRemoveTick)
		chatbox.shown = false
		if chatbox.inputShown == true then
			removeEventHandler("onClientCharacter", root, fillInput)
			chatbox.text = ""
			chatbox.InputLineText = ""
			chatbox.inputShown = false
		end
	end
end

function toggleCommand()
	toggleChatBox()
end
addCommandHandler("chat", toggleCommand)

function showChatBox(state)
	chatbox.isChatboxAllowed = state
	toggleChatBox(state)
end
addEvent("showChatBox", true)
addEventHandler("showChatBox", root, showChatBox)

function showChatBox()
	if chatbox.lastMenuStatus ~= isMainMenuActive() then
		local layout = getChatboxLayout()
		chatbox.font = dxCreateFont(":DayZ/fonts/lucida.ttf",8)
		chatbox.width = 500*1.5
		chatbox.fontColorHex = string.format("#%02X%02X%02X", layout["chat_text_color"][1],layout["chat_text_color"][2],layout["chat_text_color"][3])
		chatbox.fontColorA = layout["chat_text_color"][4]
		chatbox.alpha = layout["chat_color"][4]
		chatbox.color = tocolor(layout["chat_color"][1],layout["chat_color"][2],layout["chat_color"][3],chatbox.alpha)
		chatbox.lines = layout["chat_lines"]
		chatbox.inputHeight = chatbox.lines*chatbox.lineHeight
		chatbox.height = chatbox.lineHeight*chatbox.lines
		chatbox.fadeOut = layout["chat_css_style_background"]
		chatbox.lineLife = layout["chat_line_life"]
		chatbox.fadeOutLines = layout["chat_css_style_text"]
		chatbox.inputY = chatbox.height+chatbox.posY+chatbox.edge
		if chatbox.renderTarget then destroyElement(chatbox.renderTarget) end
		chatbox.renderTarget = dxCreateRenderTarget(chatbox.width, chatbox.height, true)
	end
	chatbox.lastMenuStatus = isMainMenuActive()
	if chatbox.width < getMinWidth() then
		chatbox.width = getMinWidth()
		if chatbox.renderTarget then destroyElement(chatbox.renderTarget) end
		chatbox.renderTarget = dxCreateRenderTarget(chatbox.width, chatbox.height, true)
	end
	--Disable Chat
	if isChatVisible() then showChat(false) end
	if chatbox.useNewMessageScrollAnimation then
		--Scroll Up
		if getKeyState("pgup") then
			if #chatbox.chats-chatbox.lines > chatbox.scroll then
				chatbox.scroll = chatbox.scroll+chatbox.scrollSpeed	
				if chatbox.scroll > #chatbox.chats-chatbox.lines then
					chatbox.scroll = #chatbox.chats-chatbox.lines
				end	
			end	
		end
		--Scroll Down
		if getKeyState("pgdn") then
			if chatbox.scroll > 0 then
				chatbox.scroll = chatbox.scroll-chatbox.scrollSpeed	
				if chatbox.scroll < 0 then
					chatbox.scroll = 0
				end	
			end
		end	
	end
	if chatbox.useNewMessageScrollAnimation then
		dxSetRenderTarget(chatbox.renderTarget, true)
		dxSetBlendMode("modulate_add")
		if chatbox.newMessageScrollValue > 0 then
			chatbox.newMessageScrollValue = chatbox.newMessageScrollValue - chatbox.newMessageScrollSpeed 
			if chatbox.newMessageScrollValue < 0 then 
				newMessageScrollValue = 0
			end	
		end
	end
	--Lines
	if chatbox.chats then
		local r,g,b = 255,255,255
		for i, chat in ipairs(chatbox.chats) do
			if i > chatbox.scroll+chatbox.newMessageScrollValue then
				if i > chatbox.lines+chatbox.scroll+chatbox.newMessageScrollValue + chatbox.extraLineForAnimation then break end
				if getTickCount() - chat.time < chatbox.lineLife or chatbox.inputShown or chatbox.scroll ~= 0 or chatbox.fadeOutLines == 0 then
					chat.alpha = 255
				elseif chatbox.fadeOutLines == 1 then
					if chat.alpha > 0 then
						chat.alpha = chat.alpha - 1
					end
				end
				if chat.channel == 1 then
					r,g,b = 255,255,255
				elseif chat.channel == 2 then
					r,g,b = 142,229,238
				elseif chat.channel == 3 then
					r,g,b = 0,255,0
				elseif chat.channel == 4 then
					r,g,b = 255,0,0
					chat.sender = "System"
				end
				dxDrawText('('..clean(chat.sender)..'): "'..clean(chat.line)..'"', chatbox.textPosX+1, chatbox.textPosY+chatbox.height-(chatbox.lineHeight*(i-chatbox.scroll))+(chatbox.lineHeight*chatbox.newMessageScrollValue)+1, chatbox.width+1, chatbox.height+1, tocolor(0, 0, 0, chat.alpha), chatbox.fontSizeX, chatbox.fontSizeY, chatbox.font, "left", "top", false, false, false, true) 
				dxDrawText('('..chat.sender..'): "'..chat.line..'"', chatbox.textPosX, chatbox.textPosY+chatbox.height-(chatbox.lineHeight*(i-chatbox.scroll))+(chatbox.lineHeight*chatbox.newMessageScrollValue), chatbox.width, chatbox.height, tocolor(r,g,b, chat.alpha), chatbox.fontSizeX, chatbox.fontSizeY, chatbox.font, "left", "top", false, false, false, true) 
			end
		end
	end
	if chatbox.useNewMessageScrollAnimation then
		dxSetRenderTarget()
		dxSetBlendMode("add")
		dxDrawImage(chatbox.posX, chatbox.posY, chatbox.width, chatbox.height, chatbox.renderTarget, 0, 0, 0, tocolor(255,255,255,255), chatbox.postGUI)
		dxSetBlendMode("blend")
	end
	--INPUT
	if chatbox.inputShown then
		dxDrawText(chatbox.inputType..": "..chatbox.InputLineText, chatbox.posX+chatbox.textOffset+1, chatbox.posY+chatbox.height+1, chatbox.posX+chatbox.width+1, chatbox.posY+chatbox.height+chatbox.inputHeight+1, tocolor(0,0,0,255), chatbox.fontSizeX, chatbox.fontSizeY, chatbox.font, "left", "top", false, false, chatbox.postGUI) 
		dxDrawText(chatbox.inputType..": "..chatbox.InputLineText, chatbox.posX+chatbox.textOffset, chatbox.posY+chatbox.height, chatbox.posX+chatbox.width, chatbox.posY+chatbox.height+chatbox.inputHeight, chatbox.inputColor, chatbox.fontSizeX, chatbox.fontSizeY, chatbox.font, "left", "top", false, false, chatbox.postGUI) 
	end
	--Positioning
	if chatbox.positioning then 
		if isCursorShowing() then
			local absoluteX, absoluteY = getAbsoluteCursorPosition()
			chatbox.posX = absoluteX-chatbox.positioningX
			chatbox.posY = absoluteY-chatbox.positioningY
		else
			chatbox.positioning = false
		end
	end
end

function toggleInput(button, state, typ)
	if not chatbox.shown then return end
	if chatbox.inputShown then return end
	if chatSwitch == 1 then
		chatbox.inputType = "Local channel"
	elseif chatSwitch == 2 then
		chatbox.inputType = "Global channel"
	elseif chatSwitch == 3 then
		chatbox.inputType = "Team channel"
	end
	chatbox.inputShown = true
	showCursor(true)
	--Avoid input button being added
	setTimer(function() addEventHandler("onClientCharacter", root, fillInput) end, 50, 1)

end

function buttonHandling(button, press)
	if not press then return end
	if button == "pgup" then
		if chatbox.useNewMessageScrollAnimation then return end
		scrollUp()
		return
	elseif button == "pgdn" then
		if chatbox.useNewMessageScrollAnimation then return end
		scrollDown()
		return	
	end
	if button == "arrow_u" then
		if chatbox.inputShown then
			switchChannelUp()
			return
		end
	elseif button == "arrow_d" then
		if chatbox.inputShown then
			switchChannelDown()
		end
		return
	end
	--Switch Tabs
	if button then
		if button == "." then	
			if chatbox.inputShown then return end
			if chatSwitch == 1 then
				chatSwitch = 2
				chatbox.inputType = "Global channel"
				outputDebugString("Switched to global channel")
				receiveChat("","Switched to global channel","Special",4)
			elseif chatSwitch == 2 then
				chatSwitch = 3
				chatbox.inputType = "Team channel"
				outputDebugString("Switched to team channel")
				receiveChat("","Switched to team channel","Special",4)
			elseif chatSwitch == 3 then
				chatSwitch = 1 
				chatbox.inputType = "Local channel"
				outputDebugString("Switched to local channel")
				receiveChat("","Switched to local channel","Special",4)
			end
			triggerServerEvent("setVoiceChannel",localPlayer,chatSwitch)
			if chatbox.inputShown or guiGetInputEnabled() or isConsoleActive() then return end
			chatbox.selectedTabIndex = 1
			chatbox.scroll = 0
			return
		end
	end
	if not chatbox.inputShown then return end
	cancelEvent()
	if button == "escape" then
		chatbox.inputShown = false
		chatbox.text = ""
		chatbox.InputLineText = ""
		showCursor(false)
		removeEventHandler("onClientCharacter", root, fillInput)
	elseif button == "enter" or button == "num_enter" then
		if #chatbox.text > 0 then
			send(chatbox.inputType, chatbox.text)
		end
		chatbox.inputShown = false
		showCursor(false)
		chatbox.text = ""
		chatbox.InputLineText = ""
		removeEventHandler("onClientCharacter", root, fillInput)
	elseif button == "backspace" then
		removeText(500)
	end
end

function send(type, ...)
	local text = table.concat({...}," ")
	if type == "PM" then 
		text = "/pm "..text 
	end
	if isCommand(text) then
		return
	elseif #text > chatbox.maxTextLength then 
		receiveChat("", "#ffaa00Invalid Text Length.", "Local", true)
		return 
	end
	triggerServerEvent("sendText", localPlayer, text, type, chatSwitch)
end

function fillInput(char)
	if #chatbox.text >= chatbox.maxTextLength then return end
	chatbox.text = chatbox.text..char
	chatbox.InputLineText = chatbox.InputLineText..char
	local width = dxGetTextWidth(chatbox.inputType..": "..chatbox.InputLineText, chatbox.fontSizeX, chatbox.font)+chatbox.textOffset
	while width > chatbox.width do
		chatbox.InputLineText = chatbox.InputLineText:sub(2, #chatbox.InputLineText)
		width = dxGetTextWidth(chatbox.inputType..": "..chatbox.InputLineText, chatbox.fontSizeX, chatbox.font)+chatbox.textOffset
	end
end

function removeText(delay)
	if not getKeyState("backspace") or getTickCount() - chatbox.removeTextTick < delay then return end
	chatbox.text = string.sub(chatbox.text, 1, #chatbox.text-1)
	chatbox.InputLineText = string.sub(chatbox.InputLineText, 1, #chatbox.InputLineText-1)
	local widthInput = dxGetTextWidth(chatbox.inputType..": "..chatbox.InputLineText, chatbox.fontSizeX, chatbox.font)+chatbox.textOffset
	if widthInput < chatbox.width then
		chatbox.InputLineText = string.sub(chatbox.text, #chatbox.text-(#chatbox.InputLineText), #chatbox.text)
	end
	local widthInput = dxGetTextWidth(chatbox.inputType..": "..chatbox.InputLineText, chatbox.fontSizeX, chatbox.font)+chatbox.textOffset
	local widthText = dxGetTextWidth(chatbox.inputType..": "..chatbox.text, chatbox.fontSizeX, chatbox.font)+chatbox.textOffset
	while widthInput < chatbox.width and widthText > chatbox.width do
		chatbox.InputLineText = string.sub(chatbox.text, #chatbox.text-(#chatbox.InputLineText), #chatbox.text)
		widthInput = dxGetTextWidth(chatbox.inputType..": "..chatbox.InputLineText, chatbox.fontSizeX, chatbox.font)+chatbox.textOffset
		widthText = dxGetTextWidth(chatbox.inputType..": "..chatbox.text, chatbox.fontSizeX, chatbox.font)+chatbox.textOffset	
	end
	chatbox.removeTextTick = getTickCount()
	chatbox.removeTextTimer = setTimer(removeText, delay, 1, 50)
end


function resetRemoveTick() 
	chatbox.removeTextTick = 400
	if isTimer(chatbox.removeTextTimer) then killTimer(chatbox.removeTextTimer) end
end


function scrollUp()
	if not getKeyState("pgup") then return end
	if #chatbox.chats-chatbox.lines > chatbox.scroll then
		chatbox.scroll = chatbox.scroll+1
	end
	setTimer(scrollUp, 80, 1)
end

function switchChannelUp()
	if not getKeyState("arrow_u") then return end
	if chatSwitch == 1 then
		chatSwitch = 2
		chatbox.inputType = "Global channel"
		outputDebugString("Switched to global channel")
		receiveChat("","Switched to global channel","Special",4)
	elseif chatSwitch == 2 then
		chatSwitch = 3
		chatbox.inputType = "Team channel"
		outputDebugString("Switched to team channel")
		receiveChat("","Switched to team channel","Special",4)
	elseif chatSwitch == 3 then
		chatSwitch = 1 
		chatbox.inputType = "Local channel"
		outputDebugString("Switched to local channel")
		receiveChat("","Switched to local channel","Special",4)
	end
	triggerServerEvent("setVoiceChannel",localPlayer,chatSwitch)
	setTimer(switchChannelUp, 1000, 1)
end

function switchChannelDown()
	if not getKeyState("arrow_d") then return end
	if chatSwitch == 1 then
		chatSwitch = 3
		chatbox.inputType = "Team channel"
		outputDebugString("Switched to Team channel")
		receiveChat("","Switched to Team channel","Special",4)
	elseif chatSwitch == 2 then
		chatSwitch = 1
		chatbox.inputType = "Local channel"
		outputDebugString("Switched to local channel")
		receiveChat("","Switched to local channel","Special",4)
	elseif chatSwitch == 3 then
		chatSwitch = 2
		chatbox.inputType = "Global channel"
		outputDebugString("Switched to global channel")
		receiveChat("","Switched to global channel","Special",4)
	end
	triggerServerEvent("setVoiceChannel",localPlayer,chatSwitch)
	setTimer(switchChannelDown, 1000, 1)
end

function scrollDown()
	if not getKeyState("pgdn") then return end
	if chatbox.scroll > 0 then
		chatbox.scroll = chatbox.scroll-1
	end
	setTimer(scrollDown, 80, 1)
end

function receiveChat(player, text, type, channel)
	local line = text
	local lines = seperateToLines(line)
	--TYPE
	for i, line in ipairs(lines) do
		table.insert(chatbox.chats, 1, {channel = channel, sender = player, line = line, time = getTickCount(), alpha = 255})
	end
	while #chatbox.chats > chatbox.history do
		table.remove(chatbox.chats, #chatbox.chats)
	end
	if chatbox.useNewMessageScrollAnimation and chatbox.shown then
		chatbox.newMessageScrollValue = chatbox.newMessageScrollValue+#lines
	end
	outputConsole(clean(line))
end
addEvent("receiveChat", true)
addEventHandler("receiveChat", root, receiveChat)

function isCommand(text)
	local c1, c2 = string.find(text, "/")
	if not c1 or c1 ~= 1 then return false end
	text = text:sub(2, #text)
	if #text:gsub("%s", "") == 0 then return true end
	local command = text:split(" ")
	local argList = ""
	for i=2, #command do
		argList = argList.." "..command[i]
	end
	executeCommandHandler(command[1], argList)
	triggerServerEvent("executeCommand", localPlayer, command, argList)
	return true 
end

function findColorCodes(str)
	local colorCodes = {}
	local c1, c2
	local startAt = 1
	local foundCodes = 0
	repeat
		c1, c2 = string.find(str, "#%x%x%x%x%x%x", startAt)
		if c1 then
			table.insert(colorCodes, {code =  string.sub(str, c1, c2), start = c1-foundCodes*7})
			startAt = c2
			foundCodes = foundCodes + 1
		end
	until not c1
	return colorCodes
end

function seperateToLines(text)
	local tempstring = clean(text)
	local codes = findColorCodes(text)
	text = clean(text)
	local lines = {}
	local lastColorCode = ""
	local length = 0
	local usedCodesInLine = 0
	if dxGetTextWidth(tempstring, chatbox.fontSizeX, chatbox.font)+chatbox.textOffset <= chatbox.width then
		for i, c in pairs(codes) do 
			local colorCodePositon = c.start+(i-1)*7
			tempstring = tempstring:sub(1, colorCodePositon-1)..c.code..tempstring:sub(colorCodePositon)
		end
		table.insert(lines, tempstring)
		return lines
	end
	while true do 
		if dxGetTextWidth(tempstring, chatbox.fontSizeX, chatbox.font)+chatbox.textOffset > chatbox.width then
			while true do	
				tempstring = string.sub(tempstring, 1, #tempstring-1)	
				if dxGetTextWidth(tempstring, chatbox.fontSizeX, chatbox.font)+chatbox.textOffset < chatbox.width then
					tempstring = findSmoothWrapPoint(tempstring)
					break
				end
			end
			local newLineStart = #tempstring+1
			--Put in color codes
			for i, c in pairs(codes) do 
				if c.code ~= "" then
					local colorCodePositon = c.start-length+usedCodesInLine*7
					if #tempstring >= colorCodePositon then
						tempstring = tempstring:sub(1, colorCodePositon-1)..c.code..tempstring:sub(colorCodePositon)
						lastColorCode = c.code
						c.code = ""
						usedCodesInLine = usedCodesInLine + 1
					end
				end
			end
			table.insert(lines, tempstring)	
			tempstring = string.sub(text, newLineStart, #text+1)
			length = length+newLineStart-1
			table.insert(codes, 1, {code =  lastColorCode, start = length+1})
			text = tempstring
			usedCodesInLine = 0
		else
			for i, c in pairs(codes) do 
				if c.code ~= "" then
					local colorCodePositon = c.start-length+usedCodesInLine*7
					if #tempstring >= colorCodePositon then
						tempstring = tempstring:sub(1, colorCodePositon-1)..c.code..tempstring:sub(colorCodePositon)
						usedCodesInLine = usedCodesInLine + 1
					end
				end
			end
			table.insert(lines, tempstring)
			break
		end
	end
	return lines
end


function findSmoothWrapPoint(text)
	local originalText = text
	while #text > 1 do
		local lastChar = string.sub(text, #text)
		if lastChar == " " or lastChar == "." or lastChar == "," then
			return text	
		end
		text = string.sub(text, 1, #text-1)
	end
	return originalText
end


function string:split(sep)
    local sep, fields = sep or ":", {}
    local pattern = string.format("([^%s]+)", sep)
    self:gsub(pattern, function(c) fields[#fields+1] = c end)
    return fields
end


function getMinWidth()
	local width = 0
	for i, tab in pairs(chatbox.tabs) do 
		width = width + dxGetTextWidth("  "..tab.name.."  ", chatbox.fontSizeX, chatbox.font) + chatbox.tabOffset
	end
	width = width + dxGetTextWidth("  00:00:00  ", chatbox.fontSizeX, chatbox.font)
	return width
end

--[[
function getTime()
	local time = getRealTime()
	local hours = time.hour
	local minutes = time.minute
	local seconds = time.second
	if hours < 10 then hours = "0"..hours end
	if minutes < 10 then minutes = "0"..minutes end
	if seconds < 10 then seconds = "0"..seconds end
	return hours, minutes, seconds
end
]]

function clean(text)
	cleanText = string.gsub(text, '#%x%x%x%x%x%x', '')
	return cleanText
end

function catchChatMessages(text,r,g,b)
	receiveChat("", string.format("#%02X%02X%02X", r,g,b)..text, "Local", 4)
	cancelEvent()
end
addEventHandler("onClientChatMessage", root, catchChatMessages)


--Chatbox Positioning
function onChatBoxClick(button, state, absoluteX, absoluteY)
	if not isCursorShowing() or button ~= "left" then return end
	if state == "down" then
		if absoluteX < chatbox.posX or absoluteX > chatbox.posX+chatbox.width then return end
		if absoluteY < chatbox.posY or absoluteY > chatbox.posY+chatbox.height then return end	
		chatbox.positioning = true
		chatbox.positioningX = absoluteX - chatbox.posX
		chatbox.positioningY = absoluteY - chatbox.posY
	else
		chatbox.positioning = false
		if not fileExists("settings.xml") then return end
		local settingsXML = xmlLoadFile("settings.xml")
		local positionX = xmlFindChild(settingsXML, "positionX", 0)
		local positionY = xmlFindChild(settingsXML, "positionY", 0)		
		xmlNodeSetAttribute(positionX, "x", chatbox.posX)
		xmlNodeSetAttribute(positionY, "y", chatbox.posY)
		xmlSaveFile(settingsXML)
		xmlUnloadFile(settingsXML)	
	end
end
--addEventHandler("onClientClick", root, onChatBoxClick)


function getAbsoluteCursorPosition()
	local cursorX, cursorY = getCursorPosition()
	local x, y = guiGetScreenSize()
	return cursorX*x, cursorY*y
end
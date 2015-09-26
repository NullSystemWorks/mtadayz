local voiceChannel = 1

function broadcast(text, type, channel)
	if isPlayerMuted(source) then
		outputChat("#ff0000You are Muted!", source, "System", type, 4)
		return
	end
	if channel == 1 then
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
		local chatRadius = 40
        local chatSphere = createColSphere( posX, posY, posZ, chatRadius )
        local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
        destroyElement( chatSphere )
        for index, nearbyPlayer in ipairs( nearbyPlayers ) do
			outputChat(text, nearbyPlayer, getPlayerName(source), type, channel)
		end
	elseif channel == 2 then
		outputChat(text, root, getPlayerName(source), type, channel)
	elseif channel == 3 then
		if not getElementData(source, "Group") then return end
		for i, p in pairs(getElementsByType("player")) do 
			if getElementData(p, "Group") == getElementData(source, "Group") then
				outputChat(text, p, getPlayerName(source), type, channel)
			end
		end
	elseif channel == 4 then
		outputChat(text, source, "System", type, channel)
	end
end
addEvent("sendText", true)
addEventHandler("sendText", root, broadcast)

--Commands
function executeCommand(command, args)
	if not hasObjectPermissionTo(source, "command."..command[1], true) then return end
	executeCommandHandler(command[1], source, args)
end
addEvent("executeCommand", true)
addEventHandler("executeCommand", root, executeCommand)

--Output
function outputChat(msg, toElement, playerName, type, channel)
	triggerLatentClientEvent(toElement, "receiveChat", root, playerName, msg, type, channel)
	if channel == 2 then
	outputServerLog(""..playerName..": "..msg.."    " )
	end
end
addEvent("outputChat")
addEventHandler("outputChat", root, outputChat)

--Private Message
function private(p, c, t, ...)
	if t == nil then return end
	player = findPlayer(t)
	if not player then 
		outputChat("#ff0000Error: Player not found!", p, "", "PM", true, false)
		return 
	end
	local message = #{...}>0 and table.concat({...},' ') or nil
	if not message then return end
	outputChat(getPlayerName(player).."#ffffff: "..message, p, "#ffffff", "PM", true, false)
	outputChat(getPlayerName(player).."#ffffff: "..message, player, "#ffffff", "PM", true, false)
end
addCommandHandler("pm", private)

--Find a Player
function findPlayer(name)
    local name = name:lower()
    for i, p in ipairs(getElementsByType("player")) do
        local fullname = string.gsub(getPlayerName(p), '#%x%x%x%x%x%x', ''):lower()
        if string.find(fullname, name, 1, true) then
            return p
        end
    end
    return false
end

--Clean text
function clean(text)
	cleanText = string.gsub(text, '#%x%x%x%x%x%x', '')
	return cleanText
end

function setVoiceChannel(channel)
	voiceChannel = channel
end
addEvent("setVoiceChannel",true)
addEventHandler("setVoiceChannel",root,setVoiceChannel)

local nearbyPlayers = {}
function onPlayerVoiceChatStart()
	if voiceChannel == 1 then -- local voice chat
		local chatRadius = 20
		local posX, posY, posZ = getElementPosition(source)
		local chatSphere = createColSphere(posX,posY,posZ, chatRadius)
		nearbyPlayers = getElementsWithinColShape(chatSphere, "player")
		destroyElement(chatSphere)
		local empty = exports.voice:getNextEmptyChannel()
		exports.voice:setPlayerChannel(source,empty)
		for index, player in ipairs(nearbyPlayers) do
			exports.voice:setPlayerChannel(player,empty)
		end
	elseif voiceChannel == 2 then -- global voice chat
		local empty = exports.voice:getNextEmptyChannel()
		exports.voice:setPlayerChannel(source,empty)
		for index, player in pairs(getElementsByType("player")) do
			exports.voice:setPlayerChannel(player,empty)
		end
	elseif voiceChannel == 3 then -- group voice chat
		local empty = exports.voice:getNextEmptyChannel()
		exports.voice:setPlayerChannel(source,empty)
		local group = getElementData(source,"Group")
		for index, player in ipairs(getElementsByType("player")) do
			if getElementData(player,"Group") and getElementData(player,"Group") == group then
				exports.voice:setPlayerChannel(player,empty)
			end
		end
	end
end
addEventHandler("onPlayerVoiceStart",root,onPlayerVoiceChatStart)

function onPlayerVoiceChatStop()
	if voiceChannel == 1 then
		exports.voice:setPlayerChannel(source)
		for index, player in ipairs (nearbyPlayers) do
			exports.voice:setPlayerChannel(player)
		end
		nearbyPlayers = {}
	elseif voiceChannel == 2 then
		exports.voice:setPlayerChannel(source)
		for index, player in ipairs (getElementsByType("player")) do
			exports.voice:setPlayerChannel(player)
		end
	elseif voiceChannel == 3 then
		local group = getElementData(source,"Group")
		for index, player in ipairs(getElementsByType("player")) do
			if getElementData(player,"Group") and getElementData(player,"Group") == group then
				exports.voice:setPlayerChannel(player)
			end
		end
    end
end
addEventHandler("onPlayerVoiceStop",root,onPlayerVoiceChatStop)
    
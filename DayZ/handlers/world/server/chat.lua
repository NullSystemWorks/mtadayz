--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: chat.lua								*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]

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
addCommandHandler( "radiochat", playerRadioChat )
 
function blockChatMessage(m,mt)
    if mt == 1 then
		cancelEvent()
	end
end
addEventHandler( "onPlayerChat", getRootElement(), blockChatMessage )

local nearbyPlayers = {}
 
addEventHandler( 'onPlayerVoiceStart', root,
    function()
          local chatRadius = 20
          local posX, posY, posZ = getElementPosition( source )
          local chatSphere = createColSphere( posX, posY, posZ, chatRadius )
          nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
          destroyElement( chatSphere )
          local empty = exports.voice:getNextEmptyChannel ( )
          exports.voice:setPlayerChannel(source, empty)
           for index, player in ipairs (nearbyPlayers) do
                  exports.voice:setPlayerChannel(player, empty)
           end
    end)
	
addEventHandler("onPlayerVoiceStop",root,
    function()
         exports.voice:setPlayerChannel(source)
         for index, player in ipairs (nearbyPlayers) do
                  exports.voice:setPlayerChannel(player)
         end
          nearbyPlayers = {}
    end)


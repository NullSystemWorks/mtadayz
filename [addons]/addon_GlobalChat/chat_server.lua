--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- GlobalChat MTA:DayZ addon 1.0
-- Made by -ffs-Sniper
-- You are free to edit this addon
--///////////////////////////////////

--------------------------------------------------------------------
--Your Code

--Please edit the settings in the meta.xml or admin panel instead of changing those
colorCodesDefault = { }
colorCodesDefault.colorcode1 = "#AD505C"
colorCodesDefault.colorcode3 = "#AD505C"
colorCodesDefault.colorcode2 = "#DBD7D7"

colorCodes = { }
colorCodes.colorcode1 = get ( "colorcode1" ) or colorCodesDefault.colorcode1
colorCodes.colorcode2 = get ( "colorcode2" ) or colorCodesDefault.colorcode2
colorCodes.colorcode3 = get ( "colorcode3" ) or colorCodesDefault.colorcode3

--Check color code on start
for i, v in pairs ( colorCodes ) do
	if not getColorFromString ( v ) then
		colorCodes[i] = colorCodesDefault[i] --if the admin fails to enter a valid hex color code
		outputChatBox ( "Bad " .. i .. " specified at GlobalChat addon (format: #FFFFFF)", root, 255, 0, 0, false)
		outputDebugString ( "Bad " .. i .. " specified at GlobalChat addon (format: #FFFFFF)", 2 )
	end
end

outputLimit = 128 --character limit for chatbox outputs (do not change this)

messagePrefix = get ( "prefix" ) or "[GLOBAL]" --prefix for the outputs

timeBetweenMessages = tonumber ( get ( "messagedelay" ) ) or 1000 --time to wait between chat messages
playerTickTable = { } --create a table with tick counts of the most recent chat message

--The message output
function playeGlobalChat ( playersource, cmd, ... )
	if cmd == "globalchat" then
		--Check whether the player is muted first
		if isPlayerMuted ( playersource ) then
			outputChatBox("You are muted!", playersource, 255, 128, 22, true)
			return
		end
		
		local msg = table.concat ( {...} , " " ) --concat the arguments from table to a string seperated by spaces
		local msg = string.gsub ( msg, '#%x%x%x%x%x%x', '' ) --remove color-codes
		
		--Anti-spam checks
		local onlyLettersMsg = string.gsub ( msg , "%A", "" ) --extract letters only
		if onlyLettersMsg == string.upper ( onlyLettersMsg ) and #onlyLettersMsg > 6 then --check if there are more than 6 uppercase letters without any lowercase letters
			outputChatBox ( "Turn off your capslock!", playersource, 255, 0, 0 )
			return
		end
		
		if string.find ( msg, "http://" ) then --disallow links
			outputChatBox ( "Do not spam the chat with links. Please use a private message instead!", playersource, 255, 0, 0 )
			return
		end
		
		--disabled the following filter as it might cause problems with russian, chinese and other special language characters
		--you can still re-enable it if you want latin characters only in your chat
		
		--[[local onlySpecCharMsg = string.gsub( msg, "[%a%d]", "") --extract special chars only
		if #onlySpecCharMsg > 15 then --check if there are more than 10 special characters used
			outputChatBox ( "Do not spam the chat with special characters!", playersource, 255, 0, 0 )
			return
		end
		
		local var, spacesCount = string.gsub( msg, " ", "") --get the count of spaces
		if ( #msg / spacesCount ) > 20 and #msg > 20 then --check if there is at least one space per 20 or less characters
			outputChatBox ( "Do not spam the chat with long words!", playersource, 255, 0, 0 )
			return
		end
		]]
		
		if playerTickTable[playersource] then --check if a table entry for the player exists
			local tick = getTickCount ( ) --get the current tick count in ms
			local timePassed = tick - playerTickTable[playersource] --calculate the time that passed between two messages
			if timePassed <= timeBetweenMessages then
				outputChatBox ( "Please refrain from chat spam!", playersource, 255, 0, 0 )
				return
			end
		else
			playerTickTable[playersource] = getTickCount ( ) 
		end
		--End of anti-spam checks
		
		local message = messagePrefix .. colorCodes.colorcode2 .. string.gsub ( ( getPlayerName ( playersource ) .. " : " ), '#%x%x%x%x%x%x', '' ) .. colorCodes.colorcode3 .. msg --precreate the message string
		local message = string.sub ( message, 1, outputLimit ) --since the chatbox won't display messages with more than 128 characters we just drop the ones at the end
		local r, g, b = getColorFromString ( colorCodes.colorcode1 )		
		outputChatBox ( message, root, r, g, b, true )
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
		local logmessage = messagePrefix .. string.gsub((getPlayerName(playersource) .. ": "), '#%x%x%x%x%x%x', '') ..msg
		exports.DayZ:saveLog("["..hour..":"..minute..":"..seconds.."] "..logmessage.."\n","chat")
		
		playerTickTable[playersource] = getTickCount ( ) 
	end
end
addCommandHandler ( "globalchat", playeGlobalChat )

--Admin panel resource settings checks
addEventHandler ( "onSettingChange", root, 
	function ( setting, oldValue, newValue )
		local setting = gettok ( setting, 2, string.byte ( "." ) )
		if setting == "colorcode1" or setting == "colorcode2" or setting == "colorcode3" then
			if getColorFromString ( fromJSON( newValue ) ) then --if the admin fails to enter a valid hex color code
				colorCodes[setting] = fromJSON( newValue )
			else
				colorCodes[setting] = colorCodesDefault[setting]
				outputChatBox ( "Bad " .. setting .. " specified at GlobalChat addon (format: #FFFFFF)", root, 255, 0, 0, false)
				outputDebugString ( "Bad " .. setting .. " specified at GlobalChat addon (format: #FFFFFF)", 2 )
			end
		end
		if setting == "messagedelay" then --update message delay when changed
			if tonumber ( fromJSON( newValue ) ) then
				timeBetweenMessages = tonumber ( fromJSON( newValue ) ) or 1000 --maximum securtiy is usually best
			end
		end
		if setting == "prefix" then --update message prefix when changed
			if fromJSON( newValue ) then
				messagePrefix = fromJSON ( newValue ) or "[GLOBAL]" --maximum securtiy is usually best
			end
		end
	end
)

addEventHandler ( "onPlayerQuit", root,
	function ( )
		playerTickTable[source] = nil --remove a leaving player from our cached table
	end
)
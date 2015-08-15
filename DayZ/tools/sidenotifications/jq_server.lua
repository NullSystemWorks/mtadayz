--[[
+----------------------------------------------------------------------------
|   Dx Side Chat Script
|   ========================================
|   by MrTasty
|   (c) 2012-2014 | Creative Commons 3.0
|   http://creativecommons.org/licenses/by/3.0/
|   ========================================
+-----------------------------------------------------------------------------
|   You are allowed to adapt, copy, redistribute this script.
|   You are not allowed to remove the original author of this script.
+-----------------------------------------------------------------------------
]]--

function outputSideChat(message, to, r, g, b)
	triggerClientEvent(to or root, "onSCMessageSend", root, string.format("#%.2X%.2X%.2X", r,g,b)..message)
end

-- ADVANCED EXAMPLE | /scSay <message | use ~ to toggle golden colour>
-- "~" replaces "|c%%%%|" (from BF2 engine, used in BFH and BFP4F) | * % = Wildcard
function subString(str,chunkSize)
	if not str or type(str) ~= "string" or not chunkSize or type(chunkSize) ~= "number" then return false end
	local returnTable = {}
	while #str >= chunkSize do
		table.insert(returnTable,str:sub(1,chunkSize))
		str = str:sub(chunkSize+1)
		if #str < chunkSize then
			table.insert(returnTable,str)
		end
	end
	return returnTable
end

function getTextColorAtEnd(text)
	local text = text:reverse()
	if text:find("%x%x%x%x%x%x#") then
		local sp, ep = text:find("%x%x%x%x%x%x#")
		return text:sub(sp, ep):reverse() or false
	end
end

function adminSay(pla, cmd, ...)
	local message = {...}
	local messageText = table.concat(message, " ")
	while messageText:find("#%x%x%x%x%x%x") do
		messageText = messageText:gsub("#%x%x%x%x%x%x", "")
	end
	local message2 = subString(messageText,1)
	for k, v in ipairs(message2) do
		if v == "~" then
			local messageText = table.concat(message2, "")
			local color = getTextColorAtEnd(messageText)
			if color and color == "#ffffff" then
				message2[k] = "#ffffff"
			else
				message2[k] = "#ffffff"
			end
		end
	end
	local messageText = table.concat(message2, "")
	if messageText and #messageText > 0 then else return end
	local name = getPlayerName(pla)
	repeat name = name:gsub("#%x%x%x%x%x%x", "")
	until not name:find("#%x%x%x%x%x%x")
	triggerClientEvent(root, "onSCMessageSend", root, string.format("#%.2X%.2X%.2X", 255,255,255)..messageText)
end

addEventHandler("onPlayerJoin", root,
	function()
		outputSideChat("Player "..string.gsub(getPlayerName(source), '#%x%x%x%x%x%x', '' ).." connected",root,255,255,255)
	end
)

addEventHandler("onPlayerLogin", root,
	function()
		outputSideChat("Player "..string.gsub(getPlayerName(source), '#%x%x%x%x%x%x', '' ).." has logged in",root,255,255,255)
	end
)

addEventHandler("onPlayerQuit",root,
	function()
		outputSideChat("Player "..string.gsub(getPlayerName(source), '#%x%x%x%x%x%x', '' ).. " disconnected",root,255,255,255)
	end
)

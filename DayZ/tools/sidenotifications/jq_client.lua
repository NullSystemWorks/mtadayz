--[[
#---------------------------------------------------------------#
----*			DayZ MTA Script jq_client.lua				*----
----* This Script is owned by Marwin, you are not allowed to use or own it.
----* Owner: Marwin W., Germany, Lower Saxony, Otterndorf
----* Skype: xxmavxx96
----*														*----
#---------------------------------------------------------------#
]]

theTexts = {}
theTextTimer = {}
function startRollMessage(text, r, g, b)
	if #theTexts == 4 then
		destroyTextItem()
	end
	table.insert(theTexts,{text,r,g,b})
	checkTimers()
end
addEvent("onRollMessageStart", true)
addEventHandler("onRollMessageStart", getLocalPlayer(), startRollMessage)

function startRollMessage2(head,text, r, g, b)
	if #theTexts == 4 then
		destroyTextItem()
	end
	table.insert(theTexts,{text,r,g,b})
	checkTimers()
end
addEvent("displayClientInfo", true)
addEventHandler("displayClientInfo", getLocalPlayer(), startRollMessage2)

function addDayZInfoBox(text,r,g,b)
	startRollMessage(text, r, g, b)
end

function destroyTextItem ()
	table.remove(theTexts,1)
end

function checkTimers ()
	if isTimer(theTextTimer["destroy"]) then
		killTimer(theTextTimer["destroy"])
	end
	theTextTimer["destroy"] = setTimer(destroyTextItem,4000,4)
end

--Draw Part
local screenWidth, screenHeight = guiGetScreenSize()
local boxSpace = dxGetFontHeight(1,"default-bold")+dxGetFontHeight(1,"default-bold")*0.3


addEventHandler("onClientRender", getRootElement(), 
	function()
		for id, value in pairs(theTexts) do
				if #theTexts == 4 or #theTexts == 2 then
					r2,g2,b2 = 19,19,19
					if id == 1 or id == 3 then
						r2,g2,b2 = 55,55,55
					end
				elseif #theTexts == 3 or #theTexts == 1 then
					r2,g2,b2 = 55,55,55
					if id == 1 or id == 3 then
						r2,g2,b2 = 19,19,19
					end
				end
				dxDrawRectangle ( screenWidth*0.3, screenHeight-id*boxSpace, screenWidth*0.4, boxSpace, tocolor (r2,g2,b2,120) )
				dxDrawingColorText(value[1],screenWidth*0.3, screenHeight-id*boxSpace, screenWidth*0.7, screenHeight-(id-1)*boxSpace, tocolor(value[2],value[3],value[4],170),170, 1, "default-bold", "center", "center")
		end
	end
)


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

function outputSideChat(message, r, g, b)
	triggerEvent("onSCMessageSend", root, string.format("#%.2X%.2X%.2X", r,g,b)..message)
end

--The Actual Code | Do not modify unless you know what you're doing--
local sx,sy = guiGetScreenSize ()
local scState = true
local maxLines = 8
local oocMessages = {}
local bitstream = dxCreateFont("/fonts/bitstream.ttf", 9)

addEventHandler ("onClientRender",getRootElement(),
	function ()
		--if isPlayerHudComponentVisible ("radar") then
			if scState then
				local chatData = getChatboxLayout()
				local _,scale = chatData["chat_scale"]
				local bg = {chatData["chat_color"]}
				local color = --[[{205,205,205,255}]] chatData["chat_text_color"]
				local lines = chatData["chat_lines"]
				local chatX,chatY = 0.015625*sx,16 + 15*lines + 25
				for k,v in ipairs(oocMessages) do
					local tx,ty = chatX,chatY + (maxLines+1)*15 - k*15
					local vNC = v
					repeat vNC = vNC:gsub("#%x%x%x%x%x%x", "")
					until not vNC:find("#%x%x%x%x%x%x")
					dxDrawText (vNC,tx+1,ty+1,0,0,tocolor(0,0,0,255),1,bitstream,"left","top",false,false,false,false)
					dxDrawText (v,tx,ty,0,0,tocolor(color[1],color[2],color[3],color[4]),1,bitstream,"left","top",false,false,false,true)
				end
			end
		--end
	end
)

addEvent ("onSCMessageSend",true)
addEventHandler ("onSCMessageSend",getRootElement(),
	function (message)
			if message then
				local length = #oocMessages
				if #oocMessages >= maxLines then
					table.remove (oocMessages,maxLines)
				end
				local text = message
				table.insert (oocMessages,1,text)
				local textNC = text
				repeat textNC = textNC:gsub("#%x%x%x%x%x%x", "")
				until not textNC:find("#%x%x%x%x%x%x")
				outputConsole (textNC)
				if removeMssagesTimer and isTimer(removeMssagesTimer) then killTimer(removeMssagesTimer) end
				removeMssagesTimer = setTimer(function() oocMessages = {} end, 5000, 1)
			end
	end)

function isOOCChatToggled ()
	return scState
end

function toggleSideChat (state)
	if state ~= scState then
		scState = state
	end
end

function togOOCCMD (cname,arg)
	if arg:lower() == "sidechat" or arg:lower() == "sc" then
		toggleSideChat (not scState)
	end
end
--addCommandHandler ("tog",togOOCCMD)
--addCommandHandler ("toggle",togOOCCMD)



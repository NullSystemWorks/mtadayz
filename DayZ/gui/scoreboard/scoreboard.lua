--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: scoreboard.lua						*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: CLIENT														*----
#-----------------------------------------------------------------------------#
]]

function getRankingPlayer (place)
if place then
return playerRankingTable[place]["Player"]
else return 0
end
end

function getElementDataPosition(key,value)
	if key and value then
		local result = 1
		for i,player in pairs(getElementsByType("player")) do
			local data = tonumber(getElementData(player,key))
			if data then
				if data > value then 
					result = result+1
				end
			end
		end
		return result
	end
end

function positionGetElementData(key, positions)
	if key and positions then
		local Position = {}
		for index,player in pairs(getElementsByType("player")) do
			local data = tonumber(getElementData(player,key))
			if data then
				for i1=1, positions, 1 do
					if Position[tonumber(i1)] then
						if Position[tonumber(i1)]["Wert"] < tonumber(data) then
							local Position_Cache1 = Position[tonumber(i1)]["Player"]
							local Position_Cache2 = Position[tonumber(i1)]["Wert"]
							local Position_Cache3
							local Position_Cache4
							for i2=i1, positions, 1 do
								if Position[tonumber(i2)] then
									Position_Cache3 = Position[tonumber(i2)]["Player"]
									Position_Cache4 = Position[tonumber(i2)]["Wert"]
									Position[tonumber(i2)]["Player"] = Position_Cache1
									Position[tonumber(i2)]["Wert"] = Position_Cache2
									Position_Cache1 = Position_Cache3
									Position_Cache2 = Position_Cache4
								else
									Position[tonumber(i2)] = {}
									Position[tonumber(i2)]["Player"] = Position_Cache1
									Position[tonumber(i2)]["Wert"] = Position_Cache2
									break
								end
							end
							Position[tonumber(i1)] = {}
							Position[tonumber(i1)]["Player"] = player
							Position[tonumber(i1)]["Wert"] = data
							break
						end
					else
						Position[tonumber(i1)] = {}
						Position[tonumber(i1)]["Player"] = player
						Position[tonumber(i1)]["Wert"] = data
						break
					end
				end
			end
		end
		return Position
	end
end

playerRankingTable = {}

function checkTopPlayer()
	playerRankingTable = positionGetElementData("totalkills", #getElementsByType("player"))
end
checkTopPlayer()
setTimer(checkTopPlayer,10000,0)

function onQuitGame( reason )
    checkTopPlayer()
end
addEventHandler( "onClientPlayerQuit", getRootElement(), onQuitGame )

local serverName = ""
function getTheServerName(name)
	serverName = name
end
addEvent("getTheServerName",true)
addEventHandler("getTheServerName",root,getTheServerName)

local yA = 0
local recx, recy = 200, 200
local recw, rech = 560, 200
local eastype = "OutElastic"
local screenW, screenH = guiGetScreenSize()
local font = {}

font[1] = dxCreateFont(":DayZ/fonts/28dayslater.ttf", 10)
font[2] = dxCreateFont(":DayZ/fonts/etelka.ttf", 10)

local yA = 0
function performRender()
	if getElementData(localPlayer,"logedin") then
		local tick = getTickCount()
		local endTime = tickk + 3000
		local laufzeit = tick - tickk
		local dauer = endTime - tickk
		local progress = laufzeit/dauer
		local x,y = guiGetScreenSize()
		
		local recintx, recinty, _ = interpolateBetween( 0, 0, 0, x*0.0225, y*0.1667, 0 , progress, eastype)
		dxDrawImage(recintx, recinty, screenW * 0.9500, screenH * 0.5733, ":DayZ/gui/scoreboard/scoreboard.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		dxDrawText(serverName, screenW * 0.0250, screenH * 0.175, screenW * 0.9725, screenH * 0.2100, tocolor(255, 255, 255, 255), 1.00, font[1], "left", "top", false, false, true, false, false)
		dxDrawText("Player", screenW * 0.0737, screenH * 0.2267, screenW * 0.3262, screenH * 0.2767, tocolor(255, 255, 255, 255), 1.00, font[2], "center", "top", false, false, true, false, false)
		dxDrawText("#", screenW * 0.0300, screenH * 0.22, screenW * 0.0688, screenH * 0.2683, tocolor(255, 255, 255, 255), 1.50, font[2], "center", "top", false, false, true, false, false)
		
		playerInList = false
			local playerAmount = #getElementsByType("player")
			if playerAmount > 9 then
				playerAmount = 9
			end
		for i = 1, playerAmount do
			yA = 0.0466*(i-1)
			local player = getRankingPlayer(i) or false
			if not player then break end
			r,g,b = 255,255,255
			if getPlayerName(player) == getPlayerName(localPlayer) then
				r,g,b = 50, 255, 50
				playerInList = true
			end
		dxDrawText(i, screenW * 0.0300, screenH * (0.2750+yA), screenW * 0.0688, screenH * 0.3167, tocolor(r,g,b, 255), 1.00, font[2], "center", "top", false, false, true, false, false)
		dxDrawText(string.gsub(getPlayerName(player),'#%x%x%x%x%x%x', ''), screenW * 0.08, screenH * (0.2750+yA), screenW * 0.3262, screenH * 0.3233, tocolor(r,g,b, 255), 1.00, font[2], "left", "top", false, false, true, false, false)
		
		local ping = getPlayerPing(player)
		dxDrawText(tostring(ping), screenW * 0.3625, screenH * (0.2750+yA), screenW * 0.4014, screenH * 0.3183, tocolor(255, 255, 255, 255), 1.00, font[2], "center", "top", false, false, true, false, false)
		
		local murders = getElementData(player,"murders")
		dxDrawText(tostring(murders), screenW * 0.4750, screenH * (0.2750+yA), screenW * 0.5138, screenH * 0.3183, tocolor(255, 255, 255, 255), 1.00, font[2], "center", "top", false, false, true, false, false)
		
		local zombieskilled = getElementData(player,"zombieskilled")
		dxDrawText(tostring(zombieskilled), screenW * 0.5875, screenH * (0.2750+yA), screenW * 0.6262, screenH * 0.3183, tocolor(255, 255, 255, 255), 1.00, font[2], "center", "top", false, false, true, false, false)
		
		local headshots = getElementData(player,"headshots")
		dxDrawText(tostring(headshots), screenW * 0.6913, screenH * (0.2750+yA), screenW * 0.7300, screenH * 0.3183, tocolor(255, 255, 255, 255), 1.00, font[2], "center", "top", false, false, true, false, false)
		
		local daysalive = getElementData(player,"daysalive")
		dxDrawText(tostring(daysalive), screenW * 0.7963, screenH * (0.2750+yA), screenW * 0.8350, screenH * 0.3183, tocolor(255, 255, 255, 255), 1.00, font[2], "center", "top", false, false, true, false, false)
		
		local totalkills = getElementData(player,"totalkills")
		dxDrawText(tostring(totalkills), screenW * 0.9025, screenH * (0.2750+yA), screenW * 0.9413, screenH * 0.3183, tocolor(255, 255, 255, 255), 1.00, font[2], "center", "top", false, false, true, false, false)
		
		end
		if not playerInList then
			dxDrawText(string.gsub(getPlayerName(localPlayer),'#%x%x%x%x%x%x', ''), screenW * 0.08, screenH * (0.2750+(0.0466*9+0.005)), screenW * 0.3262, screenH * 0.3233, tocolor(r,g,b, 255), 1.00, font[2], "left", "top", false, false, true, false, false)
			local murders = getElementData(localPlayer,"murders")
			dxDrawText(tostring(murders), screenW * 0.4750, screenH * (0.2750+(0.0466*9+0.005)), screenW * 0.5138, screenH * 0.3183, tocolor(255, 255, 255, 255), 1.00, font[2], "center", "top", false, false, true, false, false)
			
			local zombieskilled = getElementData(localPlayer,"zombieskilled")
			dxDrawText(tostring(zombieskilled), screenW * 0.5875, screenH * (0.2750+(0.0466*9+0.005)), screenW * 0.6262, screenH * 0.3183, tocolor(255, 255, 255, 255), 1.00, font[2], "center", "top", false, false, true, false, false)
			
			local headshots = getElementData(localPlayer,"headshots")
			dxDrawText(tostring(headshots), screenW * 0.6913, screenH * (0.2750+(0.0466*9+0.005)), screenW * 0.7300, screenH * 0.3183, tocolor(255, 255, 255, 255), 1.00, font[2], "center", "top", false, false, true, false, false)
			
			local daysalive = getElementData(localPlayer,"daysalive")
			dxDrawText(tostring(daysalive), screenW * 0.7963, screenH * (0.2750+(0.0466*9+0.005)), screenW * 0.8350, screenH * 0.3183, tocolor(255, 255, 255, 255), 1.00, font[2], "center", "top", false, false, true, false, false)
			
			local totalkills = getElementData(localPlayer,"totalkills")
			dxDrawText(tostring(totalkills), screenW * 0.9025, screenH * (0.2750+(0.0466*9+0.005)), screenW * 0.9413, screenH * 0.3183, tocolor(255, 255, 255, 255), 1.00, font[2], "center", "top", false, false, true, false, false)
		end
	end
end

isScoreboardOn = false
function tabular(key, keyState, arguments)
	if not isScoreboardOn then
		tickk = getTickCount()
		addEventHandler("onClientRender",root,performRender)
		isScoreboardOn = true
	else
		removeEventHandler("onClientRender",root,performRender)
		isScoreboardOn = false
	end
end
addCommandHandler("toggle",tabular)
bindKey("tab","down","toggle","1")

--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: battldayz_client.lua					*----
----* Original Author: CiBeR96											*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: CLIENT														*----
#-----------------------------------------------------------------------------#
]]

local screenW, screenH = guiGetScreenSize()
local clientLosingConnection = false
function onPlayerIsLosingConnection(isLosingConnection)
	if isLosingConnection then
		if not clientLosingConnection then
			addEventHandler("onClientRender",root,playerLosingConnection)
			clientLosingConnection = true
		end
	else
		if clientLosingConnection then
			removeEventHandler("onClientRender",root,playerLosingConnection)
			clientLosingConnection = false
		end
	end
end
addEvent("onPlayerIsLosingConnection",true)
addEventHandler("onPlayerIsLosingConnection",root,onPlayerIsLosingConnection)


function playerLosingConnection()
	if clientLosingConnection then
		dxDrawImage(screenW * 0.8400, screenH * 0.8433, screenW * 0.0700, screenH * 0.0900, "/gui/status/misc/lc.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end
end

function createLogLabel()
	if gameplayVariables["combatlog"] then
		combatloglabel = guiCreateLabel(0.82, 0.00, 0.27, 0.04, "No Combat", true)
		guiLabelSetColor(combatloglabel, 17, 249, 5)
		guiLabelSetHorizontalAlign(combatloglabel, "center", false)
		guiLabelSetVerticalAlign(combatloglabel, "center")
	end
end
addEventHandler("onClientPlayerSpawn",root,createLogLabel)

function onPlayerActivateCombatLog(attacker)
	if gameplayVariables["combatlog"] then
		if attacker and attacker == "player" then
			local time = getRealTime()
			setElementData (source,"combattime",time.timestamp)
			outputDebugString("[BattlDayZ] "..getPlayerName(source).." is in combat")
			guiSetText(combatloglabel,"Combat")
			guiLabelSetColor(combatloglabel,255,0,0)
			setTimer(function(source)
				if getElementData(source,"combattime") then
					guiSetText(combatloglabel,"No Combat")
					guiLabelSetColor(combatloglabel,17,249,5)
					setElementData(source,"combattime",false)
				end
			end,30000,1,source)
		end
	end
end
addEventHandler("onClientPlayerDamage",root,onPlayerActivateCombatLog)    


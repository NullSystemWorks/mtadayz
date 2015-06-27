--[[

	Author: CiBeR
	Version: 0.1
	Copyright: DayZ Gamemode. All rights reserved to Developers
	Current Devs: Lawliet, CiBeR, Jboy

	
]]--
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
		dxDrawImage(screenW * 0.8400, screenH * 0.8433, screenW * 0.0700, screenH * 0.0900, "images/dayzicons/lc.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end
end
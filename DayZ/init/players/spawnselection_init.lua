--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: spawnselection.lua					*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: CLIENT														*----
#-----------------------------------------------------------------------------#
]]

spawnSelection = {

image = {},
label = {},
font = {},
text = {"Tierra Robada","Whetstone","San Fierro","Bone County","Las Venturas","Red County","Flint County","Los Santos","Random"},
}

local spawnPointName = ""
function initSpawnSelection()
	spawnSelection.image[1] = guiCreateStaticImage(0.00, 0.00, 1.00, 1.00, ":DayZ/gui/spawnselection/spawnselection.png", true)
	spawnSelection.label[1] = guiCreateLabel(0.02, 0.07, 0.19, 0.20, "", true, spawnSelection.image[1])
	spawnSelection.label[2] = guiCreateLabel(0.02, 0.52, 0.19, 0.20, "", true, spawnSelection.image[1])
	spawnSelection.label[3] = guiCreateLabel(0.21, 0.37, 0.19, 0.20, "", true, spawnSelection.image[1])
	spawnSelection.label[4] = guiCreateLabel(0.38, 0.07, 0.19, 0.20, "", true, spawnSelection.image[1])
	spawnSelection.label[5] = guiCreateLabel(0.71, 0.10, 0.19, 0.20, "", true, spawnSelection.image[1])
	spawnSelection.label[6] = guiCreateLabel(0.51, 0.37, 0.19, 0.20, "", true, spawnSelection.image[1])
	spawnSelection.label[7] = guiCreateLabel(0.39, 0.68, 0.19, 0.20, "", true, spawnSelection.image[1])
	spawnSelection.label[8] = guiCreateLabel(0.78, 0.64, 0.19, 0.20, "", true, spawnSelection.image[1])
	spawnSelection.label[9] = guiCreateLabel(0.00, 0.87, 0.36, 0.08, "", true, spawnSelection.image[1])
	
	spawnSelection.font[1] = guiCreateFont(":DayZ/fonts/needhelp.ttf",30)
	
	guiSetVisible(spawnSelection.image[1],true)
	showCursor(true)
	for i=1,9 do
		guiSetFont(spawnSelection.label[i],spawnSelection.font[1])
		guiLabelSetHorizontalAlign(spawnSelection.label[i],"center",true)
		guiLabelSetVerticalAlign(spawnSelection.label[i],"center",true)
		guiLabelSetColor(spawnSelection.label[i],255,0,0)
		addEventHandler("onClientMouseEnter",spawnSelection.label[i],function() getSelectedSpawn(i) end,false)
		addEventHandler("onClientMouseLeave",spawnSelection.label[i],function() getSelectedSpawn(i,"left") end,false)
		addEventHandler("onClientGUIClick",spawnSelection.label[i],clickSelectedSpawn,false)
	end
end
addEvent("showSpawnSelectionWindow",true)
addEventHandler("showSpawnSelectionWindow",root,initSpawnSelection)

function getSelectedSpawn(number,condition)
	for i, spawn in ipairs(spawnSelection.text) do
		if i == number then
			guiSetText(spawnSelection.label[i],spawn)
			spawnPointName = spawn
		else
			guiSetText(spawnSelection.label[i],"")
		end
	end
	if condition == "left" then
		for i=1,9 do
			guiSetText(spawnSelection.label[i],"")
		end
	end
end

function clickSelectedSpawn(button,state)
	if button == "left" then
		if state == "up" then
			local number = 0
			local x,y,z = 0,0,0
			if spawnPointName == "Random" then
				number = math.random(table.size(spawnPositions))
				x,y,z = spawnPositions[number][1],spawnPositions[number][2],spawnPositions[number][3]
				guiSetVisible(spawnSelection.image[1],false)
			else
				number = math.random(table.size(spawnPositionsSelection[spawnPointName]))		
				x,y,z = spawnPositionsSelection[spawnPointName][number][1],spawnPositionsSelection[spawnPointName][number][2],spawnPositionsSelection[spawnPointName][number][3]
				guiSetVisible(spawnSelection.image[1],false)
			end
			triggerServerEvent("onSpawnSelectionEnabled",localPlayer,x,y,z)
			showCursor(false)
		end
	end
end
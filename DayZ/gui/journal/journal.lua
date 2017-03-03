--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: journal.lua							*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: CLIENT														*----
#-----------------------------------------------------------------------------#
]]

JournalTable = {
	window = {},
	image = {},
    label = {},
	memo = {},
	button = {},
}

local font = {}
local isJournalOpen = false
local isWriting = false
font[1] = guiCreateFont(":DayZ/fonts/needhelp.ttf",30)
font[2] = guiCreateFont(":DayZ/fonts/needhelp.ttf",17)
font[3] = guiCreateFont(":DayZ/fonts/needhelp.ttf",15)

function showJournal()
	if getElementData(localPlayer,"logedin") then
		if not isJournalOpen then
			isJournalOpen = true
			showCursor(true)
			playSound(":DayZ/sounds/status/journal.wav",false)
			guiSetVisible(JournalTable.image[1],true)
			guiSetVisible(JournalTable.image[2],false)
			guiSetVisible(JournalTable.image[4],false)
			guiSetVisible(JournalTable.image[5],false)
			guiSetVisible(JournalTable.image[6],false)
			guiSetVisible(JournalTable.image[7],false)
			guiSetVisible(JournalTable.image[8],false)
			guiSetText(JournalTable.label[1],"Day "..getElementData(localPlayer,"daysalive"))
			local x,y,z = getElementPosition(localPlayer)
			guiSetText(JournalTable.label[2],getZoneName(x,y,z))
			addEventHandler("onClientMouseEnter",JournalTable.label[5],function() writeSelected(5) end,false)
			addEventHandler("onClientMouseLeave",JournalTable.label[5],function() writeDeselected(5) end,false)
			addEventHandler("onClientMouseEnter",JournalTable.label[7],function() writeSelected(7) end,false)
			addEventHandler("onClientMouseLeave",JournalTable.label[7],function() writeDeselected(7) end,false)
			addEventHandler("onClientMouseEnter",JournalTable.label[8],function() writeSelected(8) end,false)
			addEventHandler("onClientMouseLeave",JournalTable.label[8],function() writeDeselected(8) end,false)
			addEventHandler("onClientMouseEnter",JournalTable.label[9],function() writeSelected(9) end,false)
			addEventHandler("onClientMouseLeave",JournalTable.label[9],function() writeDeselected(9) end,false)
			addEventHandler("onClientGUIClick",JournalTable.label[5],openWriteJournal,false)
			addEventHandler("onClientGUIClick",JournalTable.label[7],function() nextPreviousPage(7) end,false)
			addEventHandler("onClientGUIClick",JournalTable.label[8],function() nextPreviousPage(8) end,false)
			addEventHandler("onClientGUIClick",JournalTable.label[9],function()
				guiMoveToBack(JournalTable.image[2])
				loadList()
			end,false)
			addEventHandler("onClientGUIClick",JournalTable.button[1],writeIntoJournal,false)
			addEventHandler("onClientGUIClick",JournalTable.button[2],closeWriteJournal,false)
			
			guiSetText(JournalTable.label[20],tostring(getElementData(localPlayer,"blood")).." (Type: "..tostring(getElementData(localPlayer,"bloodtypediscovered"))..")")
			guiSetText(JournalTable.label[21],tostring(math.floor(getElementData(localPlayer,"food"))))
			guiSetText(JournalTable.label[22],tostring(math.floor(getElementData(localPlayer,"thirst"))))
			guiSetText(JournalTable.label[23],tostring(math.floor(getElementData(localPlayer,"temperature"))).."°C")
			guiSetText(JournalTable.label[24],tostring(math.floor(getElementData(localPlayer,"humanity"))))
			guiSetText(JournalTable.label[25],tostring(math.floor(getElementData(getRootElement(),"zombiestotal") or 0)))
			--unbindKey("J","down",initInventory)
		else
			isJournalOpen = false
			showCursor(false)
			guiSetVisible(JournalTable.image[1],false)
			guiSetVisible(JournalTable.image[2],false)
			removeEventHandler("onClientMouseEnter",JournalTable.label[5],writeSelected)
			removeEventHandler("onClientMouseLeave",JournalTable.label[5],writeDeselected)
			removeEventHandler("onClientMouseEnter",JournalTable.label[7],writeSelected)
			removeEventHandler("onClientMouseLeave",JournalTable.label[7],writeDeselected)
			removeEventHandler("onClientMouseEnter",JournalTable.label[8],writeSelected)
			removeEventHandler("onClientMouseLeave",JournalTable.label[8],writeDeselected)
			removeEventHandler("onClientMouseEnter",JournalTable.label[9],writeSelected)
			removeEventHandler("onClientMouseLeave",JournalTable.label[9],writeDeselected)
			removeEventHandler("onClientGUIClick",JournalTable.label[5],openWriteJournal)
			removeEventHandler("onClientGUIClick",JournalTable.label[7],nextPreviousPage)
			removeEventHandler("onClientGUIClick",JournalTable.label[8],nextPreviousPage)
			removeEventHandler("onClientGUIClick",JournalTable.label[9],loadList)
			removeEventHandler("onClientGUIClick",JournalTable.button[1],writeIntoJournal)
			removeEventHandler("onClientGUIClick",JournalTable.button[2],closeWriteJournal)
			--bindKey("J","down",initInventory)
		end
	end
end
addCommandHandler("Show Journal",showJournal)
bindKey("6","down","Show Journal")

function writeSelected(number)
	guiLabelSetColor(JournalTable.label[number],255,0,0)
end

function writeDeselected (number)
	guiLabelSetColor(JournalTable.label[number],0,0,0)
end

function initJournal()
	JournalTable.image[1] = guiCreateStaticImage(0.00, 0.06, 1.00, 0.90, ":DayZ/gui/journal/images/journal_page1.png", true)
	JournalTable.image[2] = guiCreateStaticImage(0.00, 0.06, 1.00, 0.90, ":DayZ/gui/journal/images/journal_page1.png", true)
	JournalTable.image[3] = guiCreateStaticImage(0.00, 0.06, 1.00, 0.90, ":DayZ/gui/journal/images/journal_page1.png", true)
	JournalTable.image[4] = guiCreateStaticImage(0.50, 0.07, 0.41, 0.80, ":DayZ/gui/journal/images/survivor.png", true, JournalTable.image[2])
	JournalTable.image[5] = guiCreateStaticImage(0.00, 0.00, 1.00, 0.20, ":DayZ/gui/journal/images/banditskilled1.png", true, JournalTable.image[4])
	JournalTable.image[6] = guiCreateStaticImage(0.00, 0.75, 1.00, 0.20, ":DayZ/gui/journal/images/murders1.png", true, JournalTable.image[4])
	JournalTable.image[7] = guiCreateStaticImage(0.20, 0.22, 0.79, 0.14, ":DayZ/gui/journal/images/zombieskilled1.png", true, JournalTable.image[4])
	JournalTable.image[8] = guiCreateStaticImage(0.00, 0.22, 0.79, 0.14, ":DayZ/gui/journal/images/headshots1.png", true, JournalTable.image[4])   

	JournalTable.label[1] = guiCreateLabel(0.09, 0.09, 0.40, 0.06, "Day 0", true, JournalTable.image[1])
	guiLabelSetColor(JournalTable.label[1], 0, 0, 0)
	guiLabelSetHorizontalAlign(JournalTable.label[1], "left", true)
	guiSetFont(JournalTable.label[1],font[1])
	JournalTable.label[2] = guiCreateLabel(0.09, 0.15, 0.40, 0.06, "San Andreas", true, JournalTable.image[1])
	guiLabelSetColor(JournalTable.label[2], 0, 0, 0)
	guiLabelSetHorizontalAlign(JournalTable.label[2], "left", true)
	guiSetFont(JournalTable.label[2],font[1])

	JournalTable.label[3] = guiCreateLabel(0.09, 0.27, 0.40, 0.64, "", true, JournalTable.image[1])
	guiLabelSetColor(JournalTable.label[3], 0, 0, 0)
	guiLabelSetHorizontalAlign(JournalTable.label[3], "left", true)
	guiSetFont(JournalTable.label[3],font[2])

	JournalTable.label[4] = guiCreateLabel(0.51, 0.11, 0.39, 0.82, "", true, JournalTable.image[1])
	guiLabelSetColor(JournalTable.label[4],0,0,0)
	guiLabelSetHorizontalAlign(JournalTable.label[4], "left", true)
	guiSetFont(JournalTable.label[4],font[2])

	JournalTable.label[5] = guiCreateLabel(0.51, 0.89, 0.21, 0.05, "Write into Journal", true, JournalTable.image[1])
	guiLabelSetColor(JournalTable.label[5],0,0,0)
	guiLabelSetHorizontalAlign(JournalTable.label[5], "left", true)
	guiSetFont(JournalTable.label[5],font[2])

	JournalTable.label[7] = guiCreateLabel(0.75, 0.89, 0.21, 0.05, "Next Page", true, JournalTable.image[1])
	guiLabelSetColor(JournalTable.label[7],0,0,0)
	guiLabelSetHorizontalAlign(JournalTable.label[7], "left", true)
	guiSetFont(JournalTable.label[7],font[2])
	
	JournalTable.label[8] = guiCreateLabel(0.51, 0.89, 0.21, 0.05, "Previous Page", true, JournalTable.image[2])
	guiLabelSetColor(JournalTable.label[8],0,0,0)
	guiLabelSetHorizontalAlign(JournalTable.label[8], "left", true)
	guiSetFont(JournalTable.label[8],font[2])
	
	JournalTable.label[9] = guiCreateLabel(0.75, 0.89, 0.21, 0.05, "Achievements", true, JournalTable.image[2])
	guiLabelSetColor(JournalTable.label[9],0,0,0)
	guiLabelSetHorizontalAlign(JournalTable.label[9], "left", true)
	guiSetFont(JournalTable.label[9],font[2])
	
	JournalTable.label[10] = guiCreateLabel(0.13, 0.15, 0.33, 0.14, "Statistics", true, JournalTable.image[2])
	guiLabelSetColor(JournalTable.label[10],0,0,0)
	guiLabelSetHorizontalAlign(JournalTable.label[10], "center", false)
	guiLabelSetVerticalAlign(JournalTable.label[10], "center")
	guiSetFont(JournalTable.label[10],font[1])
	
	JournalTable.label[11] = guiCreateLabel(0.10, 0.42, 0.14, 0.03, "Blood/Bloodtype:", true, JournalTable.image[2])
	guiLabelSetColor(JournalTable.label[11],0,0,0)
	guiSetFont(JournalTable.label[11],font[3])
	
	JournalTable.label[12] = guiCreateLabel(0.10, 0.46, 0.14, 0.03, "Hunger:", true, JournalTable.image[2])
	guiLabelSetColor(JournalTable.label[12],0,0,0)
	guiSetFont(JournalTable.label[12],font[3])
	
	JournalTable.label[13] = guiCreateLabel(0.10, 0.50, 0.14, 0.03, "Thirst:", true, JournalTable.image[2])
	guiLabelSetColor(JournalTable.label[13],0,0,0)
	guiSetFont(JournalTable.label[13],font[3])
	
	JournalTable.label[14] = guiCreateLabel(0.10, 0.54, 0.14, 0.03, "Temperature:", true, JournalTable.image[2])
	guiLabelSetColor(JournalTable.label[14],0,0,0)
	guiSetFont(JournalTable.label[14],font[3])
	
	JournalTable.label[15] = guiCreateLabel(0.10, 0.58, 0.14, 0.03, "Humanity:", true, JournalTable.image[2])
	guiLabelSetColor(JournalTable.label[15],0,0,0)
	guiSetFont(JournalTable.label[15],font[3])
	
	JournalTable.label[16] = guiCreateLabel(0.10, 0.62, 0.14, 0.03, "Zombies:", true, JournalTable.image[2])
	guiLabelSetColor(JournalTable.label[16],0,0,0)
	guiSetFont(JournalTable.label[16],font[3])
	
	JournalTable.label[17] = guiCreateLabel(0.10, 0.77, 0.36, 0.03, "Survived: 0 Day(s)", true, JournalTable.image[2])
	guiLabelSetHorizontalAlign(JournalTable.label[17], "center", false)
	guiLabelSetColor(JournalTable.label[17],0,0,0)
	guiSetFont(JournalTable.label[17],font[3])
	
	JournalTable.label[18] = guiCreateLabel(0.10, 0.85, 0.36, 0.03, "FPS:", true, JournalTable.image[2])
	guiLabelSetColor(JournalTable.label[18],0,0,0)
	guiSetFont(JournalTable.label[18],font[3])
	
	JournalTable.label[19] = guiCreateLabel(0.13, 0.31, 0.33, 0.03, "Difficulty:", true, JournalTable.image[2])
	guiLabelSetHorizontalAlign(JournalTable.label[19], "center", false)
	guiLabelSetColor(JournalTable.label[19],0,0,0)
	guiSetFont(JournalTable.label[19],font[3])
	
	JournalTable.label[20] = guiCreateLabel(0.33, 0.42, 0.14, 0.03, "", true, JournalTable.image[2])
	guiLabelSetColor(JournalTable.label[20],0,0,0)
	guiSetFont(JournalTable.label[20],font[3])
	
	JournalTable.label[21] = guiCreateLabel(0.33, 0.46, 0.14, 0.03, "", true, JournalTable.image[2])
	guiLabelSetColor(JournalTable.label[21],0,0,0)
	guiSetFont(JournalTable.label[21],font[3])
	
	JournalTable.label[22] = guiCreateLabel(0.33, 0.50, 0.14, 0.03, "", true, JournalTable.image[2])
	guiLabelSetColor(JournalTable.label[22],0,0,0)
	guiSetFont(JournalTable.label[22],font[3])
	
	JournalTable.label[23] = guiCreateLabel(0.33, 0.54, 0.14, 0.03, "", true, JournalTable.image[2])
	guiLabelSetColor(JournalTable.label[23],0,0,0)
	guiSetFont(JournalTable.label[23],font[3])
	
	JournalTable.label[24] = guiCreateLabel(0.33, 0.58, 0.14, 0.03, "", true, JournalTable.image[2])
	guiLabelSetColor(JournalTable.label[24],0,0,0)
	guiSetFont(JournalTable.label[24],font[3])
	
	JournalTable.label[25] = guiCreateLabel(0.33, 0.62, 0.14, 0.03, "", true, JournalTable.image[2])
	guiLabelSetColor(JournalTable.label[25],0,0,0)
	guiSetFont(JournalTable.label[25],font[3])
	
	JournalTable.window[1] = guiCreateWindow(0.24, 0.14, 0.52, 0.80, "Write into Journal", true)
	guiWindowSetMovable(JournalTable.window[1], false)
	guiWindowSetSizable(JournalTable.window[1], false)

	JournalTable.memo[1] = guiCreateMemo(0.03, 0.17, 0.95, 0.59, "", true, JournalTable.window[1])
	JournalTable.label[6] = guiCreateLabel(0.04, 0.10, 0.91, 0.08, "Journal Entry:", true, JournalTable.window[1])
	guiLabelSetVerticalAlign(JournalTable.label[1], "center")
	JournalTable.button[1] = guiCreateButton(0.17, 0.92, 0.19, 0.06, "Save", true, JournalTable.window[1])
	JournalTable.button[2] = guiCreateButton(0.63, 0.92, 0.19, 0.06, "Cancel", true, JournalTable.window[1])    
	
	guiSetVisible(JournalTable.image[1],false)
	guiSetVisible(JournalTable.image[2],false)
	guiSetVisible(JournalTable.image[3],false)
	guiSetVisible(JournalTable.image[4],false)
	guiSetVisible(JournalTable.image[5],false)
	guiSetVisible(JournalTable.image[6],false)
	guiSetVisible(JournalTable.image[7],false)
	guiSetVisible(JournalTable.image[8],false)
	guiSetVisible(JournalTable.window[1],false)
	
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),initJournal)

function openWriteJournal(button, state)
	if not isWriting then
		if button == "left" and state == "up" then
			guiSetVisible(JournalTable.window[1],true)
			guiBringToFront(JournalTable.window[1])
			isWriting = true
			guiSetVisible(JournalTable.image[1],false)
			unbindKey("1","down",showJournal)
			guiSetInputEnabled(true)
		end
	else
		outputDebugString("Error")
	end
end

function closeWriteJournal()
	guiSetVisible(JournalTable.window[1],false) 
	showCursor(false) 
	isWriting = false
	isJournalOpen = false
	removeEventHandler("onClientMouseEnter",JournalTable.label[5],writeSelected)
	removeEventHandler("onClientMouseLeave",JournalTable.label[5],writeDeselected)
	removeEventHandler("onClientGUIClick",JournalTable.label[5],openWriteJournal)
	removeEventHandler("onClientGUIClick",JournalTable.button[1],writeIntoJournal)
	removeEventHandler("onClientGUIClick",JournalTable.button[2],closeWriteJournal)
	bindKey("1","down",showJournal)
	bindKey("J","down",initInventory)
	guiSetInputEnabled(false)
end

function writeIntoJournal()
	guiSetText(JournalTable.label[4],guiGetText(JournalTable.memo[1]))
	guiSetVisible(JournalTable.window[1],false)
	showCursor(false) 
	isWriting = false
	isJournalOpen = false
	removeEventHandler("onClientMouseEnter",JournalTable.label[5],writeSelected)
	removeEventHandler("onClientMouseLeave",JournalTable.label[5],writeDeselected)
	removeEventHandler("onClientGUIClick",JournalTable.label[5],openWriteJournal)
	removeEventHandler("onClientGUIClick",JournalTable.button[1],writeIntoJournal)
	removeEventHandler("onClientGUIClick",JournalTable.button[2],closeWriteJournal)
	triggerEvent("saveJournalOnQuit",localPlayer)
	bindKey("1","down",showJournal)
	guiSetInputEnabled(false)
	bindKey("J","down",initInventory)
end

function saveJournalOnQuit()
	if not fileExists("journal.txt") then
		fileCreate("journal.txt")
		local journalopen = fileOpen("journal.txt")
		fileWrite(journalopen,guiGetText(JournalTable.label[4]))
		fileClose(journalopen)
	else
		fileDelete("journal.txt")
		fileCreate("journal.txt")
		local journalopen = fileOpen("journal.txt")
		fileWrite(journalopen,guiGetText(JournalTable.label[4]))
		fileClose(journalopen)
	end
end
addEvent("saveJournalOnQuit",true)
addEventHandler("saveJournalOnQuit",root,saveJournalOnQuit)

function loadJournalOnJoin()
	if fileExists("journal.txt") then
		local journalfile = fileOpen("journal.txt")
		local journalsize = fileGetSize(journalfile)
		local journalread = fileRead(journalfile,journalsize)
		guiSetText(JournalTable.label[4],journalread)
		guiSetText(JournalTable.memo[1],journalread)
		fileClose(journalfile)
	end
end
addEventHandler("onClientPlayerSpawn",root,loadJournalOnJoin)

local fps = false
function getCurrentFPS() -- Setup the useful function
    return fps
end

local function updateFPS(msSinceLastFrame)
    -- FPS are the frames per second, so count the frames rendered per milisecond using frame delta time and then convert that to frames per second.
    fps = (1 / msSinceLastFrame) * 1000
end
addEventHandler("onClientPreRender", root, updateFPS)


function nextPreviousPage(number)
	if number then
		fpsTimer = setTimer(function()
			guiSetText(JournalTable.label[18],"FPS: "..math.floor(getCurrentFPS()))
		end,1000,0)
		if number == 7 then
			guiSetVisible(JournalTable.image[2],true)
			guiSetVisible(JournalTable.image[1],false)
			playSound(":DayZ/sounds/status/journal.wav",false)
			-- Data Check
			local humanity = getElementData(localPlayer,"humanity")
			local banditskilled = getElementData(localPlayer,"banditskilled")
			local murders = getElementData(localPlayer,"murders")
			local zombieskilled = getElementData(localPlayer,"zombieskilled")
			local headshots = getElementData(localPlayer,"headshots")
			if humanity >= 2001 and humanity <= 3000 then
				guiSetVisible(JournalTable.image[4],true)
				guiStaticImageLoadImage(JournalTable.image[4],":DayZ/gui/journal/images/survivor.png")
			elseif humanity >= 3001 and humanity <= 4000 then
				guiSetVisible(JournalTable.image[4],true)
				guiStaticImageLoadImage(JournalTable.image[4],":DayZ/gui/journal/images/hero1.png")
			elseif humanity >= 4001 and humanity < 5000 then
				guiSetVisible(JournalTable.image[4],true)
				guiStaticImageLoadImage(JournalTable.image[4],":DayZ/gui/journal/images/hero2.png")
			elseif humanity >= 5000 then
				guiSetVisible(JournalTable.image[4],true)
				guiStaticImageLoadImage(JournalTable.image[4],":DayZ/gui/journal/images/hero3.png")
			elseif humanity >= 1001 and humanity <= 2000 then
				guiSetVisible(JournalTable.image[4],true)
				guiStaticImageLoadImage(JournalTable.image[4],":DayZ/gui/journal/images/bandit1.png")
			elseif humanity >= 1 and humanity <= 1000 then
				guiSetVisible(JournalTable.image[4],true)
				guiStaticImageLoadImage(JournalTable.image[4],":DayZ/gui/journal/images/bandit2.png")
			elseif humanity <= 0 then
				guiSetVisible(JournalTable.image[4],true)
				guiStaticImageLoadImage(JournalTable.image[4],":DayZ/gui/journal/images/bandit3.png")
			end
			if banditskilled >= 1 and banditskilled <= 5 then
				guiSetVisible(JournalTable.image[5],true)
			elseif banditskilled >= 6 and banditskilled <= 10 then
				guiSetVisible(JournalTable.image[5],true)
				guiStaticImageLoadImage(JournalTable.image[5],":DayZ/gui/journal/images/banditskilled2.png")
			elseif banditskilled >= 11 and banditskilled <= 15 then
				guiSetVisible(JournalTable.image[5],true)
				guiStaticImageLoadImage(JournalTable.image[5],":DayZ/gui/journal/images/banditskilled3.png")
			elseif banditskilled >= 16 then
				guiSetVisible(JournalTable.image[5],true)
				guiStaticImageLoadImage(JournalTable.image[5],":DayZ/gui/journal/images/banditskilled4.png")
			end
			if murders >= 1 and murders <= 5 then
				guiSetVisible(JournalTable.image[6],true)
				guiStaticImageLoadImage(JournalTable.image[6],":DayZ/gui/journal/images/murders1.png")
			elseif murders >= 6 and murders <= 10 then
				guiSetVisible(JournalTable.image[6],true)
				guiStaticImageLoadImage(JournalTable.image[6],":DayZ/gui/journal/images/murders2.png")
			elseif murders >= 11 and murders <= 15 then
				guiSetVisible(JournalTable.image[6],true)
				guiStaticImageLoadImage(JournalTable.image[6],":DayZ/gui/journal/images/murders3.png")
			elseif murders >= 16 then
				guiSetVisible(JournalTable.image[6],true)
				guiStaticImageLoadImage(JournalTable.image[6],":DayZ/gui/journal/images/murders4.png")
			end
			if headshots >= 1 and headshots <= 5 then
				guiSetVisible(JournalTable.image[7],true)
				guiStaticImageLoadImage(JournalTable.image[7],":DayZ/gui/journal/images/headshots1.png")
			elseif headshots >= 6 and headshots <= 10 then
				guiSetVisible(JournalTable.image[7],true)
				guiStaticImageLoadImage(JournalTable.image[7],":DayZ/gui/journal/images/headshots2.png")
			elseif headshots >= 11 and headshots <= 15 then
				guiSetVisible(JournalTable.image[7],true)
				guiStaticImageLoadImage(JournalTable.image[7],":DayZ/gui/journal/images/headshots3.png")
			elseif headshots >= 16 then
				guiSetVisible(JournalTable.image[7],true)
				guiStaticImageLoadImage(JournalTable.image[7],":DayZ/gui/journal/images/headshots4.png")
			end
			if zombieskilled >= 1 and zombieskilled <= 5 then
				guiSetVisible(JournalTable.image[8],true)
				guiStaticImageLoadImage(JournalTable.image[7],":DayZ/gui/journal/images/zombieskilled1.png")
			elseif zombieskilled >= 6 and zombieskilled <= 10 then
				guiSetVisible(JournalTable.image[8],true)
				guiStaticImageLoadImage(JournalTable.image[8],":DayZ/gui/journal/images/zombieskilled2.png")
			elseif zombieskilled >= 11 and zombieskilled <= 15 then
				guiSetVisible(JournalTable.image[8],true)
				guiStaticImageLoadImage(JournalTable.image[8],":DayZ/gui/journal/images/zombieskilled3.png")
			elseif zombieskilled >= 16 then
				guiSetVisible(JournalTable.image[8],true)
				guiStaticImageLoadImage(JournalTable.image[8],":DayZ/gui/journal/images/zombieskilled4.png")
			end
			guiSetText(JournalTable.label[18],"FPS: "..math.floor(getCurrentFPS()))
			guiSetText(JournalTable.label[19],"Difficulty: "..tostring(gameplayVariables["difficulty"]))
			guiSetText(JournalTable.label[17],"Survived: "..tostring(getElementData(localPlayer,"daysalive")).." Day(s)")
		elseif number == 8 then
			guiSetVisible(JournalTable.image[2],false)
			guiSetVisible(JournalTable.image[1],true)
			playSound(":DayZ/sounds/status/journal.wav",false)
			killTimer(fpsTimer)
		end
	end
end

local spacer = "\n"
local spacercount = 0

function addJournalEntryOnDamage(attacker,weapon)
	if attacker then
		if getElementType(attacker) == "ped" then
			spacercount = spacercount+1
			if spacercount == 16 then
				guiSetText(JournalTable.label[3],"A zombie attacked me.")
				spacercount = 0
			else
				guiSetText(JournalTable.label[3],guiGetText(JournalTable.label[3])..""..spacer.."A zombie attacked me.")
			end
		elseif getElementType(attacker) == "player" then
			spacercount = spacercount+1
			if spacercount == 16 then
				guiSetText(JournalTable.label[3],"Someone shot me!")
				spacercount = 0
			else
				guiSetText(JournalTable.label[3],guiGetText(JournalTable.label[3])..spacer.."Someone shot me!")
			end
		end
	end
end
addEventHandler("onClientPlayerDamage",localPlayer,addJournalEntryOnDamage)

local thirststatus = false
local foodstatus = false
local bloodstatus1 = false
local bloodstatus2 = false
local bonestatus = false
local coldstatus = false
local murderstatus = false
local loginstatus = false
local humanitystatus = false

function addJournalEntryOnStatus()
	if getElementData(localPlayer,"logedin") then
		if getElementData(localPlayer,"logedin") then
			if not loginstatus then
				local hour,minutes = getTime()
				spacercount = spacercount+1
				if spacercount == 16 then
					guiSetText(JournalTable.label[3],"Woke up at "..hour..":"..minutes..". It's not just a dream...")
					loginstatus = true
					spacercount = 0
				else
					guiSetText(JournalTable.label[3],guiGetText(JournalTable.label[3])..spacer.."Woke up at "..hour..":"..minutes..". It's not just a dream...")
					loginstatus = true
				end
			end
		end
		if getElementData(localPlayer,"thirst") < 20 then
			if not thirststatus then
				spacercount = spacercount+1
				if spacercount == 16 then
					guiSetText(JournalTable.label[3],"I'm extremely thirsty.")
					thirststatus = true
					spacercount = 0
				else
					guiSetText(JournalTable.label[3],guiGetText(JournalTable.label[3])..spacer.."I'm extremely thirsty.")
					thirststatus = true
				end
			end
		else
			thirststatus = false
		end
		if getElementData(localPlayer,"food") < 20 then
			if not foodstatus then
				spacercount = spacercount+1
				if spacercount == 16 then
					guiSetText(JournalTable.label[3],"I'm about to die of starvation...")
					foodstatus = true
					spacercount = 0
				else
					guiSetText(JournalTable.label[3],guiGetText(JournalTable.label[3])..spacer.."I'm about to die of starvation...")
					foodstatus = true
				end
			end
		else
			foodstatus = false
		end
		if getElementData(localPlayer,"blood") < 6000 then
			if not bloodstatus1 then
				spacercount = spacercount+1
				if spacercount == 16 then
					guiSetText(JournalTable.label[3],"I feel dizzy.")
					bloodstatus1 = true
					spacercount = 0
				else
					guiSetText(JournalTable.label[3],guiGetText(JournalTable.label[3])..spacer.."I feel dizzy.")
					bloodstatus1 = true
				end
			end
		else
			bloodstatus1 = false
		end
		if getElementData(localPlayer,"blood") < 1000 then
			if not bloodstatus2 then
				spacercount = spacercount+1
				if spacercount == 16 then
					guiSetText(JournalTable.label[3],"Can't...carry...on...like that...")
					bloodstatus2 = true
					spacercount = 0
				else
					guiSetText(JournalTable.label[3],guiGetText(JournalTable.label[3])..spacer.."Can't...carry...on...like that...")
					bloodstatus2 = true
				end
			end
		else
			bloodstatus2 = false
		end
		if getElementData(localPlayer,"brokenbone") then
			if not bonestatus then
				spacercount = spacercount+1
				if spacercount == 16 then
					guiSetText(JournalTable.label[3],"Broke my leg. Damn.")
					bonestatus = true
					spacercount = 0
				else
					guiSetText(JournalTable.label[3],guiGetText(JournalTable.label[3])..spacer.."Broke my leg. Damn.")
					bonestatus = true
				end
			end
		else
			bonestatus = false
		end
		if getElementData(localPlayer,"cold") then
			if not coldstatus then
				spacercount = spacercount+1
				if spacercount == 16 then
					guiSetText(JournalTable.label[3],"I'm shaking like crazy. Must be a cold...")
					coldstatus = true
					spacercount = 0
				else
					guiSetText(JournalTable.label[3],guiGetText(JournalTable.label[3])..spacer.."I'm shaking like crazy. Must be a cold...")
					coldstatus = true
				end
			end
		else
			coldstatus = false
		end
		if getElementData(localPlayer,"murders") == 1 then
			if not murderstatus then
				spacercount = spacercount+1
				if spacercount == 16 then
					guiSetText(JournalTable.label[3],"Killed a human today. It felt...good. Am I going crazy?")
					murderstatus = true
					spacercount = 0
				else
					guiSetText(JournalTable.label[3],guiGetText(JournalTable.label[3])..spacer.."Killed a human today. It felt...good. Am I going crazy?")
					murderstatus = true
				end
			end
		else
			murderstatus = false
		end
		if getElementData(localPlayer,"humanity") == 5000 then
			if not humanitystatus then
				spacercount = spacercount+1
				if spacercount == 16 then
					guiSetText(JournalTable.label[3],"I feel like a hero for helping so many people.")
					humanitystatus = true
					spacercount = 0
				else
					guiSetText(JournalTable.label[3],guiGetText(JournalTable.label[3])..spacer.."I feel like a hero for helping so many people.")
					humanitystatus = true
				end
			end
		else
			humanitystatus = false
		end
	end
end
setTimer(addJournalEntryOnStatus,10000,0)
setTimer(addJournalEntryOnStatus,10000,0)
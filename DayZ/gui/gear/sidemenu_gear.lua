--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: sidemenu_gear.lua						*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: CLIENT														*----
#-----------------------------------------------------------------------------#
]]


local row = {}
local rowImage = {}
local rowText = {}
local font = {}
local number = 0
local moveDown = 0
local playerPickedUpItem = false
font[1] = guiCreateFont(":DayZ/fonts/etelka.ttf", 10)

function initSideMenu()
	for i = 1, 7 do
		number = i
		moveDown = moveDown+0.025
		row[number] = ""
		if number == 1 then
			rowImage[1] = guiCreateStaticImage(0,0.400+moveDown,0.3,0.03,":DayZ/gui/gear/items/scrollmenu_1.png",true)
		else
			rowImage[number] = guiCreateStaticImage(0,0.400+moveDown,0.3,0.03,":DayZ/gui/gear/items/scrollmenu_3.png",true)
		end
		rowText[number] = guiCreateLabel(0.05,0.05,0.995,0.95,row[number],true,rowImage[number])
		guiLabelSetColor(rowText[number],113,238,17)
		guiLabelSetColor(rowText[1],255,255,255)
		guiSetFont(rowText[number],font[1])
		guiSetVisible(rowImage[number],false)
		if number == 7 then number = 0 end
	end
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),initSideMenu)


function showClientMenuItem(arg1,arg2,arg3,arg4)
local number = 0
	if arg1 == "Take" then
		number = number+1
		guiSetVisible(rowImage[number],true)
		guiSetText(rowText[number],"Take "..arg2)
		if number == 1 then
			guiLabelSetColor (rowText[number],255,255,255)
			setElementData(rowText[number],"markedMenuItem",true)
		end
		setElementData(rowText[number],"usedItem",arg2)
	end
	if arg1 == "stop" then
		disableMenu()
		refreshLoot(false)
	end
	if arg1 == "Helicrashsite" then
		number = number+1
		guiSetVisible(rowImage[number],true)
		guiSetText(rowText[number],"Gear (Helicrash)")
		if number == 1 then
			guiLabelSetColor (rowText[number],255,255,255)
			setElementData(rowText[number],"markedMenuItem",true)
		end
		setElementData(rowText[number],"usedItem","helicrashsite")
	end
	if arg1 == "Hospitalbox" then
		number = number+1
		guiSetVisible(rowImage[number],true)
		guiSetText(rowText[number],"Gear (Hospitalbox)")
		if number == 1 then
			guiLabelSetColor (rowText[number],255,255,255)
			setElementData(rowText[number],"markedMenuItem",true)
		end
		setElementData(rowText[number],"usedItem","hospitalbox")
	end
	if arg1 == "Vehicle" then
		number = number+1
		guiSetVisible(rowImage[number],true)
		if getElementData(getElementData(arg3,"parent"),"vehicle_name") then
			name = getElementData(getElementData(arg3,"parent"),"vehicle_name")
		else
			name = "Tent"
		end
		guiSetText(rowText[number],"Gear ("..name..")")
		guiLabelSetColor (rowText[number],255,255,255)
		setElementData(rowText[number],"markedMenuItem",true)
		setElementData(rowText[number],"usedItem","vehicle")
		if getElementData(getElementData(arg3,"parent"),"tent") then
			number = number+1
			guiSetVisible(rowImage[number],true)
			guiSetText(rowText[number],"Remove Tent")
			if number == 1 then
				guiLabelSetColor (rowText[number],255,255,255)
				setElementData(rowText[number],"markedMenuItem",true)
			end
				setElementData(rowText[number],"usedItem","tent")
			return
		end
		--2
		if getElementHealth(arg3) < 1000 and getElementHealth(arg3) >= 50 and getElementData(getLocalPlayer(),"Toolbox") >= 1 then
			number = number+1
			guiSetVisible(rowImage[number],true)
			guiSetText(rowText[number],"Repair ("..getElementData(getElementData(arg3,"parent"),"vehicle_name")..")")
			setElementData(rowText[number],"usedItem","repairvehicle")
		end
		--3
		if getElementData(getElementData(arg3,"parent"),"Tire_inVehicle") > 0 and getElementData(localPlayer,"Toolbox") > 0 then
			number = number+1
			guiSetVisible(rowImage[number],true)
			guiSetText(rowText[number],"Take Wheel of "..getElementData(getElementData(arg3,"parent"),"vehicle_name"))
			setElementData(rowText[number],"usedItem","takewheel")
		end
		if getElementData(getElementData(arg3,"parent"),"Engine_inVehicle") > 0 and getElementData(localPlayer,"Toolbox") > 0 then
			number = number+1
			guiSetVisible(rowImage[number],true)
			guiSetText(rowText[number],"Take Engine of "..getElementData(getElementData(arg3,"parent"),"vehicle_name"))
			setElementData(rowText[number],"usedItem","takeengine")
		end
		if getElementData(getElementData(arg3,"parent"),"fuel") > 0 and getElementData(localPlayer,"Empty Gas Canister") > 0 then
			number = number+1
			guiSetVisible(rowImage[number],true)
			guiSetText(rowText[number],"Siphon fuel")
			setElementData(rowText[number],"usedItem","siphon")
		end
	end
	if arg1 == "Player" then
		--1
		if getElementData(arg2,"bleeding") > 0 and getElementData(getLocalPlayer(),"Bandage") >= 1 then
			number = number+1
			guiSetVisible(rowImage[number],true)
			guiSetText(rowText[number],"Give Bandage")
			guiLabelSetColor (rowText[1],255,255,255)
			setElementData(rowText[1],"markedMenuItem",true)
			setElementData(rowText[number],"usedItem","bandage")
		end	
		if getElementData(arg2,"blood") < 11900 and getElementData(getLocalPlayer(),"Blood Bag") >= 1 then
			number = number+1
			guiSetVisible(rowImage[number],true)
			guiSetText(rowText[number],"Administer Blood Bag")	
			setElementData(rowText[number],"usedItem","giveblood")
			if number == 1 then
				guiLabelSetColor (rowText[number],255,255,255) -- 113,238,17
				setElementData(rowText[number],"markedMenuItem",true)
			end
		end
		if getElementData(arg2,"brokenbone") == true and getElementData(getLocalPlayer(),"Morphine") >= 1 then
			number = number+1
			guiSetVisible(rowImage[number],true)
			guiSetText(rowText[number],"Give Morphine")	
			setElementData(rowText[number],"usedItem","morphine")
			if number == 1 then
				guiLabelSetColor (rowText[number],255,255,255) -- 113,238,17
				setElementData(rowText[number],"markedMenuItem",true)
			end
		end
		if getElementData(arg2,"cold") == true and getElementData(getLocalPlayer(),"Antibiotics") >= 1 then
			number = number+1
			guiSetVisible(rowImage[number],true)
			guiSetText(rowText[number],"Give Antibiotics")	
			setElementData(rowText[number],"usedItem","antibiotics")
			if number == 1 then
				guiLabelSetColor (rowText[number],255,255,255) -- 113,238,17
				setElementData(rowText[number],"markedMenuItem",true)
			end
		end
		if getElementData(arg2,"unconscious") == true and getElementData(getLocalPlayer(),"Epi-Pen") >= 1 then
			number = number+1
			guiSetVisible(rowImage[number],true)
			guiSetText(rowText[number],"Inject Epi-Pen")	
			setElementData(rowText[number],"usedItem","epipen")
			if number == 1 then
				guiLabelSetColor (rowText[number],255,255,255)
				setElementData(rowText[number],"markedMenuItem",true)
			end
		end
	end
	if arg1 == "Dead" then
		number = number+1
		guiSetVisible(rowImage[number],true)
		guiSetText(rowText[number],"Gear ("..arg2..")")
		if number == 1 then
			guiLabelSetColor (rowText[number],255,255,255)
			setElementData(rowText[number],"markedMenuItem",true)
		end
		setElementData(rowText[number],"usedItem","dead")
		number = number+1
		setElementData(rowText[number],"usedItem","deadreason")
		guiSetVisible(rowImage[number],true)
		guiSetText(rowText[number],"Check Body")

		setElementData(rowText[3],"usedItem","hidebody")
  		guiSetVisible(rowImage[3],true)
  		guiSetText(rowText[3],"Hide Body")
	end
	if arg1 == "Fireplace" then
		if getElementData(getLocalPlayer(),"Raw Meat") >= 1 then
		number = number+1
		guiSetVisible(rowImage[number],true)
		guiSetText(rowText[number],"Cook Meat")
		guiLabelSetColor (rowText[number],255,255,255)
		setElementData(rowText[number],"markedMenuItem",true)
		setElementData(rowText[number],"usedItem","fireplace")
		end
	end
	if arg1 == "petrol" then
		if getElementData(getLocalPlayer(),"Empty Gas Canister") >= 1 then
			number = number+1
			guiSetVisible(rowImage[number],true)
			guiSetText(rowText[number],"Refill (Empty Gas Canister)")
			if number == 1 then
				guiLabelSetColor (rowText[number],255,255,255)
				setElementData(rowText[number],"markedMenuItem",true)
			end
				setElementData(rowText[number],"usedItem","petrolstation")
		end	
	end
	if arg1 == "Wirefence" then
		if getElementData(getLocalPlayer(),"Toolbox") >= 1 then
			number = number+1
			guiSetVisible(rowImage[number],true)
			guiSetText(rowText[number],"Remove Wirefence")
			if number == 1 then
				guiLabelSetColor (rowText[number],255,255,255)
				setElementData(rowText[number],"markedMenuItem",true)
			end
				setElementData(rowText[number],"usedItem","wirefence")
		end	
	end
	if arg1 == "Gear" then
		number = number+1
		guiSetVisible(rowImage[number],true)
		guiSetText(rowText[number],"Gear")
		if number == 1 then
			guiLabelSetColor (rowText[number],255,255,255)
			setElementData(rowText[number],"markedMenuItem",true)
		end
		setElementData(rowText[number],"usedItem","itemloot")
	end
end
addEvent("showClientMenuItem",true)
addEventHandler("showClientMenuItem",getLocalPlayer(),showClientMenuItem)

function PlayerScrollMenu (key,keyState,arg)
local number = 1
if ( keyState == "down" ) then
if not guiGetVisible(rowImage[2]) then
	return
end
if arg == "up" then
	if getElementData(rowText[1],"markedMenuItem") then
		if guiGetVisible(rowImage[6]) then
			setElementData(rowText[1],"markedMenuItem",false)
			setElementData(rowText[6],"markedMenuItem",true)
			guiLabelSetColor (rowText[1],113,238,17)
			guiLabelSetColor (rowText[6],255,255,255)
			guiStaticImageLoadImage(rowImage[1],":DayZ/gui/gear/items/scrollmenu_3.png")
			guiStaticImageLoadImage(rowImage[6],":DayZ/gui/gear/items/scrollmenu_1.png")
		elseif guiGetVisible(rowImage[5]) then
			setElementData(rowText[1],"markedMenuItem",false)
			setElementData(rowText[5],"markedMenuItem",true)
			guiLabelSetColor (rowText[1],113,238,17)
			guiLabelSetColor (rowText[5],255,255,255)
			guiStaticImageLoadImage(rowImage[1],":DayZ/gui/gear/items/scrollmenu_3.png")
			guiStaticImageLoadImage(rowImage[5],":DayZ/gui/gear/items/scrollmenu_1.png")
		elseif guiGetVisible(rowImage[4]) then
			setElementData(rowText[1],"markedMenuItem",false)
			setElementData(rowText[4],"markedMenuItem",true)
			guiLabelSetColor (rowText[1],113,238,17)
			guiLabelSetColor (rowText[4],255,255,255)
			guiStaticImageLoadImage(rowImage[1],":DayZ/gui/gear/items/scrollmenu_3.png")
			guiStaticImageLoadImage(rowImage[4],":DayZ/gui/gear/items/scrollmenu_1.png")
		elseif guiGetVisible(rowImage[3]) then
			setElementData(rowText[1],"markedMenuItem",false)
			setElementData(rowText[3],"markedMenuItem",true)
			guiLabelSetColor (rowText[1],113,238,17)
			guiLabelSetColor (rowText[3],255,255,255)
			guiStaticImageLoadImage(rowImage[1],":DayZ/gui/gear/items/scrollmenu_3.png")
			guiStaticImageLoadImage(rowImage[3],":DayZ/gui/gear/items/scrollmenu_1.png")
		elseif guiGetVisible(rowImage[2]) then
			setElementData(rowText[1],"markedMenuItem",false)
			setElementData(rowText[2],"markedMenuItem",true)
			guiLabelSetColor (rowText[1],113,238,17)
			guiLabelSetColor (rowText[2],255,255,255)
			guiStaticImageLoadImage(rowImage[1],":DayZ/gui/gear/items/scrollmenu_3.png")
			guiStaticImageLoadImage(rowImage[2],":DayZ/gui/gear/items/scrollmenu_1.png")
		end
	elseif getElementData(rowText[2],"markedMenuItem") then
		if guiGetVisible(rowImage[1]) then
			setElementData(rowText[2],"markedMenuItem",false)
			setElementData(rowText[1],"markedMenuItem",true)
			guiLabelSetColor (rowText[2],113,238,17)
			guiLabelSetColor (rowText[1],255,255,255)
			guiStaticImageLoadImage(rowImage[2],":DayZ/gui/gear/items/scrollmenu_3.png")
			guiStaticImageLoadImage(rowImage[1],":DayZ/gui/gear/items/scrollmenu_1.png")
		end
	elseif getElementData(rowText[3],"markedMenuItem") then
		if guiGetVisible(rowImage[2]) then
			setElementData(rowText[3],"markedMenuItem",false)
			setElementData(rowText[2],"markedMenuItem",true)
			guiLabelSetColor (rowText[3],113,238,17)
			guiLabelSetColor (rowText[2],255,255,255)
			guiStaticImageLoadImage(rowImage[3],":DayZ/gui/gear/items/scrollmenu_3.png")
			guiStaticImageLoadImage(rowImage[2],":DayZ/gui/gear/items/scrollmenu_1.png")
		else
			setElementData(rowText[3],"markedMenuItem",false)
			setElementData(rowText[1],"markedMenuItem",true)
			guiLabelSetColor (rowText[3],113,238,17)
			guiLabelSetColor (rowText[1],255,255,255)
			guiStaticImageLoadImage(rowImage[3],":DayZ/gui/gear/items/scrollmenu_3.png")
			guiStaticImageLoadImage(rowImage[1],":DayZ/gui/gear/items/scrollmenu_1.png")
		end
	elseif getElementData(rowText[4],"markedMenuItem") then
		if guiGetVisible(rowImage[3]) then
			setElementData(rowText[4],"markedMenuItem",false)
			setElementData(rowText[3],"markedMenuItem",true)
			guiLabelSetColor (rowText[4],113,238,17)
			guiLabelSetColor (rowText[3],255,255,255)
			guiStaticImageLoadImage(rowImage[4],":DayZ/gui/gear/items/scrollmenu_3.png")
			guiStaticImageLoadImage(rowImage[3],":DayZ/gui/gear/items/scrollmenu_1.png")
		else
			setElementData(rowText[4],"markedMenuItem",false)
			setElementData(rowText[1],"markedMenuItem",true)
			guiLabelSetColor (rowText[4],113,238,17)
			guiLabelSetColor (rowText[1],255,255,255)
			guiStaticImageLoadImage(rowImage[4],":DayZ/gui/gear/items/scrollmenu_3.png")
			guiStaticImageLoadImage(rowImage[1],":DayZ/gui/gear/items/scrollmenu_1.png")
		end
	elseif getElementData(rowText[5],"markedMenuItem") then
		if guiGetVisible(rowImage[5]) then
			setElementData(rowText[5],"markedMenuItem",false)
			setElementData(rowText[4],"markedMenuItem",true)
			guiLabelSetColor (rowText[5],113,238,17)
			guiLabelSetColor (rowText[4],255,255,255)
			guiStaticImageLoadImage(rowImage[5],":DayZ/gui/gear/items/scrollmenu_3.png")
			guiStaticImageLoadImage(rowImage[4],":DayZ/gui/gear/items/scrollmenu_1.png")
		else
			setElementData(rowText[5],"markedMenuItem",false)
			setElementData(rowText[1],"markedMenuItem",true)
			guiLabelSetColor (rowText[5],113,238,17)
			guiLabelSetColor (rowText[1],255,255,255)
			guiStaticImageLoadImage(rowImage[5],":DayZ/gui/gear/items/scrollmenu_3.png")
			guiStaticImageLoadImage(rowImage[1],":DayZ/gui/gear/items/scrollmenu_1.png")
		end
	end
elseif arg == "down" then
	if getElementData(rowText[1],"markedMenuItem") then
		if guiGetVisible(rowImage[2]) then
			setElementData(rowText[1],"markedMenuItem",false)
			setElementData(rowText[2],"markedMenuItem",true)
			guiLabelSetColor (rowText[1],113,238,17)
			guiLabelSetColor (rowText[2],255,255,255)
			guiStaticImageLoadImage(rowImage[1],":DayZ/gui/gear/items/scrollmenu_3.png")
			guiStaticImageLoadImage(rowImage[2],":DayZ/gui/gear/items/scrollmenu_1.png")
		end
	elseif getElementData(rowText[2],"markedMenuItem") then
		if guiGetVisible(rowImage[3]) then
			setElementData(rowText[2],"markedMenuItem",false)
			setElementData(rowText[3],"markedMenuItem",true)
			guiLabelSetColor (rowText[2],113,238,17)
			guiLabelSetColor (rowText[3],255,255,255)
			guiStaticImageLoadImage(rowImage[2],":DayZ/gui/gear/items/scrollmenu_3.png")
			guiStaticImageLoadImage(rowImage[3],":DayZ/gui/gear/items/scrollmenu_1.png")
		else
			setElementData(rowText[2],"markedMenuItem",false)
			setElementData(rowText[1],"markedMenuItem",true)
			guiLabelSetColor (rowText[2],113,238,17)
			guiLabelSetColor (rowText[1],255,255,255)
			guiStaticImageLoadImage(rowImage[2],":DayZ/gui/gear/items/scrollmenu_3.png")
			guiStaticImageLoadImage(rowImage[1],":DayZ/gui/gear/items/scrollmenu_1.png")
		end
	elseif getElementData(rowText[3],"markedMenuItem") then
		if guiGetVisible(rowImage[4]) then
			setElementData(rowText[3],"markedMenuItem",false)
			setElementData(rowText[4],"markedMenuItem",true)
			guiLabelSetColor (rowText[3],113,238,17)
			guiLabelSetColor (rowText[4],255,255,255)
			guiStaticImageLoadImage(rowImage[3],":DayZ/gui/gear/items/scrollmenu_3.png")
			guiStaticImageLoadImage(rowImage[4],":DayZ/gui/gear/items/scrollmenu_1.png")
		else
			setElementData(rowText[3],"markedMenuItem",false)
			setElementData(rowText[1],"markedMenuItem",true)
			guiLabelSetColor (rowText[3],113,238,17)
			guiLabelSetColor (rowText[1],255,255,255)
			guiStaticImageLoadImage(rowImage[3],":DayZ/gui/gear/items/scrollmenu_3.png")
			guiStaticImageLoadImage(rowImage[1],":DayZ/gui/gear/items/scrollmenu_1.png")
		end
	elseif getElementData(rowText[4],"markedMenuItem") then
		if guiGetVisible(rowImage[5]) then
			setElementData(rowText[4],"markedMenuItem",false)
			setElementData(rowText[5],"markedMenuItem",true)
			guiLabelSetColor (rowText[4],113,238,17)
			guiLabelSetColor (rowText[5],255,255,255)
			guiStaticImageLoadImage(rowImage[4],":DayZ/gui/gear/items/scrollmenu_3.png")
			guiStaticImageLoadImage(rowImage[5],":DayZ/gui/gear/items/scrollmenu_1.png")
		else
			setElementData(rowText[4],"markedMenuItem",false)
			setElementData(rowText[1],"markedMenuItem",true)
			guiLabelSetColor (rowText[4],113,238,17)
			guiLabelSetColor (rowText[1],255,255,255)
			guiStaticImageLoadImage(rowImage[4],":DayZ/gui/gear/items/scrollmenu_3.png")
			guiStaticImageLoadImage(rowImage[1],":DayZ/gui/gear/items/scrollmenu_1.png")
		end
	elseif getElementData(rowText[5],"markedMenuItem") then
		if guiGetVisible(rowImage[6]) then
			setElementData(rowText[5],"markedMenuItem",false)
			setElementData(rowText[6],"markedMenuItem",true)
			guiLabelSetColor (rowText[5],113,238,17)
			guiLabelSetColor (rowText[6],255,255,255)
			guiStaticImageLoadImage(rowImage[5],":DayZ/gui/gear/items/scrollmenu_3.png")
			guiStaticImageLoadImage(rowImage[6],":DayZ/gui/gear/items/scrollmenu_1.png")
		else
			setElementData(rowText[5],"markedMenuItem",false)
			setElementData(rowText[1],"markedMenuItem",true)
			guiLabelSetColor (rowText[5],113,238,17)
			guiLabelSetColor (rowText[1],255,255,255)
			guiStaticImageLoadImage(rowImage[5],":DayZ/gui/gear/items/scrollmenu_3.png")
			guiStaticImageLoadImage(rowImage[1],":DayZ/gui/gear/items/scrollmenu_1.png")
		end
	end
end
end
end
bindKey ( "mouse_wheel_up", "down", PlayerScrollMenu, "up" )
bindKey ( "mouse_wheel_down", "down", PlayerScrollMenu, "down" )

function disableMenu()
	guiSetVisible(rowImage[1],false)
	guiSetVisible(rowImage[2],false)
	guiSetVisible(rowImage[3],false)
	guiSetVisible(rowImage[4],false)
	guiSetVisible(rowImage[5],false)
	guiSetVisible(rowImage[6],false)
	guiSetVisible(rowImage[7],false)
	setElementData(rowText[1],"markedMenuItem",false)
	setElementData(rowText[2],"markedMenuItem",false)
	setElementData(rowText[3],"markedMenuItem",false)
	setElementData(rowText[4],"markedMenuItem",false)
	setElementData(rowText[5],"markedMenuItem",false)
	setElementData(rowText[6],"markedMenuItem",false)
	setElementData(rowText[7],"markedMenuItem",false)
	guiLabelSetColor(rowText[1],255,255,255)
	guiLabelSetColor(rowText[2],113,238,17)
	guiLabelSetColor(rowText[3],113,238,17)
	guiLabelSetColor(rowText[4],113,238,17)
	guiLabelSetColor(rowText[5],113,238,17)
	guiLabelSetColor(rowText[6],113,238,17)
	guiLabelSetColor(rowText[7],113,238,17)
	setNewbieInfo (false,"","")
end
addEvent("disableMenu",true)
addEventHandler("disableMenu",getLocalPlayer(),disableMenu)


function getPlayerInCol(tab)
	for theKey,thePlayer in ipairs(tab) do
		if thePlayer ~= getLocalPlayer() then
			return true
		end
	end
	return false
end

isInFirePlace = false
function onPlayerTargetPickup (theElement)
	if theElement == getLocalPlayer() then
		if getElementData(source,"parent") == getLocalPlayer() then 
			return 
		end
		local player = getPlayerInCol(getElementsWithinColShape ( source, "player" ))
		if getPedOccupiedVehicle(getLocalPlayer()) then
			return
		end
		isInFirePlace = false
		setElementData(rowText[2],"markedMenuItem",false)
		setElementData(rowText[1],"markedMenuItem",true)
		guiLabelSetColor (rowText[1],255,255,255)
		guiLabelSetColor (rowText[2],113,238,17)
		if getElementData(source,"player") then
			showClientMenuItem("Player",getElementData(source,"parent"))
			setElementData(getLocalPlayer(),"currentCol",source)
			setElementData(getLocalPlayer(),"loot",false)
			return
		end
		if player then
			return
		end
		if getElementData(source,"petrolstation") then
			showClientMenuItem("petrol")
			setElementData(getLocalPlayer(),"currentCol",source)
			setElementData(getLocalPlayer(),"loot",false)
			--setNewbieInfo (true,"petrolstation","Press '-' or 'middle-mouse' to refill a canister!\n REQUIRED: Empty Gas Canister",source)
			return
		end
		if getElementData(source,"wirefence") then
			showClientMenuItem("Wirefence")
			setElementData(getLocalPlayer(),"currentCol",source)
			setElementData(getLocalPlayer(),"loot",false)
			triggerServerEvent ( "checkFenceOwner", getLocalPlayer(), getLocalPlayer(), getElementData(source,"owner"))
			--setNewbieInfo (true,"Wirefence","Press '-' or 'middle-mouse' to remove the fence!\n REQUIRED: Toolbox",source)
			return
		end
		if getElementData(source,"fireplace") then
			showClientMenuItem("Fireplace")
			setElementData(getLocalPlayer(),"currentCol",source)
			setElementData(getLocalPlayer(),"loot",false)
			--setNewbieInfo (true,"Fireplace","Press '-' or 'middle-mouse' to cook meat!\n REQUIRED: Raw Meat",source)
			isInFirePlace = true
			return
		end
		if getElementData(source,"deadman") then
			showClientMenuItem("Dead",getElementData(source,"playername"))
			setElementData(getLocalPlayer(),"currentCol",source)
			setElementData(getLocalPlayer(),"loot",true)
			setElementData(getLocalPlayer(),"lootname","Gear ("..getElementData(source,"playername")..")")
			--setNewbieInfo (true,"Gear","Press J to access the gear menu!",source)
			return
		end
		if getElementData(source,"item") then
			showClientMenuItem("Take",getElementData(source,"item"))
			setElementData(getLocalPlayer(),"currentCol",source)
			setElementData(getLocalPlayer(),"loot",false)
			--setNewbieInfo (true,"Item pickup","Press '-' or 'middle-mouse' to pick this item up!",source)
			return
		end
		if getElementData(source,"helicrash") then
			showClientMenuItem("Helicrashsite","helicrash")
			setElementData(getLocalPlayer(),"currentCol",source)
			setElementData(getLocalPlayer(),"loot",true)
			setElementData(getLocalPlayer(),"lootname","Gear (Helicrash)")
			--setNewbieInfo (true,"Gear","Press J to access the gear menu!",source)
			return
		end
		if getElementData(source,"hospitalbox") then
			showClientMenuItem("Hospitalbox","hospitalbox")
			setElementData(getLocalPlayer(),"currentCol",source)
			setElementData(getLocalPlayer(),"loot",true)
			setElementData(getLocalPlayer(),"lootname","Gear (Hospitalbox)")
			--setNewbieInfo (true,"Gear","Press J to access the gear menu!",source)
			return
		end
		if getElementData(source,"vehicle") then
			if not getElementData(source,"deadVehicle") then
				if getElementData(source,"vehicle_name") then
					name = getElementData(source,"vehicle_name")
				else
					name = "Tent"
				end
				showClientMenuItem("Vehicle",name,getElementData(source,"parent"))
				setElementData(getLocalPlayer(),"currentCol",source)
				setElementData(getLocalPlayer(),"loot",true)
				setElementData(getLocalPlayer(),"lootname","Gear ("..name..")")
				--setNewbieInfo (true,"Gear","Press J to acess the gear menu!",source)
				return
			end
		end
		if getElementData(source,"itemloot") then
			showClientMenuItem("Gear")
			setElementData(getLocalPlayer(),"loot",true)
			setElementData(getLocalPlayer(),"lootname","Gear")
			setElementData(getLocalPlayer(),"currentCol",source)
			setNewbieInfo (true,"Gear","Press J to access the gear menu!",source)
			return
		end
	showClientMenuItem("stop")
end	
end
addEventHandler("onClientColShapeHit",getRootElement(),onPlayerTargetPickup)

function onPlayerTargetPickup (theElement)
if theElement == getLocalPlayer() then
	local players = getElementsWithinColShape ( source, "player" )
	if players == getLocalPlayer() then --[[return ]]end
	showClientMenuItem("stop")
	setElementData(getLocalPlayer(),"loot",false)
	setElementData(getLocalPlayer(),"currentCol",false)
	setNewbieInfo (false,"","")
	isInFirePlace = false
end
end
addEventHandler("onClientColShapeLeave",getRootElement(),onPlayerTargetPickup)

--Newbie Infos

local screenWidth, screenHeight = guiGetScreenSize()
local newbieShow = false
local newbieHead = "-"
local newbieText = "-"
local newbiePosition = 0,0,0

local lootIcon = ""

function setNewbieInfo (show,head,text,element)
newbieShow = show
newbieHead = head
newbieText = ""
newbiePosition = element
return
end

addEventHandler("onClientRender", getRootElement(), 
function()
	if newbieShow == false then return end
	local x,y,z = getElementPosition(newbiePosition)
	local x,y = getScreenFromWorldPosition (x,y,z)
	local length = dxGetTextWidth(newbieText,1,"default-bold")
	local col = getElementData(localPlayer,"currentCol")
	local objects = getElementData(col,"objectsINloot")
	--dxDrawRectangle ( x-length/2-screenWidth*0.01,y, screenWidth*0.02+length, screenHeight*0.1, tocolor (33,33,33,100) )
	--dxDrawingColorText(newbieHead,x-length/2-screenWidth*0.01,y, x+length/2+screenWidth*0.01, y+screenHeight*0.03, tocolor(22,255,22,120),0.5, 1.1, "default-bold", "center", "center")
	if objects then
		if x and y then
			dxDrawImage(x-length/2-screenWidth*0.01,y, screenWidth*0.1, screenHeight*0.08,":DayZ/gui/gear/items/loot.png",0,0,0)
		--dxDrawingColorText(newbieText,x-length/2-screenWidth*0.01,y+screenHeight*0.03, x+length/2+screenWidth*0.01, y+screenHeight*0.07, tocolor(255,255,255,120),0.5, 1, "default-bold", "center", "center")
		end
	end
end
)

function fireRaiseTemperature ()
	if isInFirePlace then
		if getElementData(getLocalPlayer(),"temperature") <= 38 then
			setElementData(getLocalPlayer(),"temperature",getElementData(getLocalPlayer(),"temperature")+0.25)
		end
	end
end
setTimer(fireRaiseTemperature,10000,0)

------------------------------------------------------------------------------

unbindKey("mouse3","both")
function onPlayerPressMiddleMouse (key,keyState)
if ( keyState == "down" ) then
	if not guiGetVisible(rowText[1]) then return end
		local itemName = getMenuMarkedItem()
		if itemName == "helicrashsite" then
			local col = getElementData(getLocalPlayer(),"currentCol")
			local gearName = "Gear (Helicrash)"
			refreshLoot(col,gearName)
			showInventoryManual()
			disableMenu()
			return
		end
		if itemName == "itemloot" then
			local col = getElementData(getLocalPlayer(),"currentCol")
			local gearName = "Gear"
			refreshLoot(col,gearName)
			showInventoryManual()
			disableMenu()
			return
		end
		if itemName == "wirefence" then
			local col = getElementData(getLocalPlayer(),"currentCol")
			local gearName = "Remove Wirefence"
			triggerServerEvent("removeWirefence",getLocalPlayer(),getElementData(col,"parent"))
			disableMenu()
			return
		end
		if itemName == "hospitalbox" then
			local col = getElementData(getLocalPlayer(),"currentCol")
			local gearName = "Gear (Hospitalbox)"
			refreshLoot(col,gearName)
			showInventoryManual()
			disableMenu()
			return
		end
		if itemName == "vehicle" then
			local col = getElementData(getLocalPlayer(),"currentCol")
			if getElementData(getElementData(col,"parent"),"vehicle_name") then
				name = getElementData(getElementData(col,"parent"),"vehicle_name")
			else
				name = "Tent"
			end
			local gearName = "Gear ("..name..")"
			refreshLoot(col,gearName)
			showInventoryManual()
			disableMenu()
			return
		end
		if itemName == "repairvehicle" then
			local col = getElementData(getLocalPlayer(),"currentCol")
			triggerServerEvent("repairVehicle",getLocalPlayer(),getElementData(col,"parent"))
			disableMenu()
			return
		end
		if itemName == "hidebody" then
	        triggerServerEvent("onPlayerHideBody",getLocalPlayer())
	        disableMenu()
	        return
	    end
		if itemName == "takewheel" then
			if getPlayerCurrentSlots() + getItemSlots("Tire") <= getPlayerMaxAviableSlots() then
				local col = getElementData(getLocalPlayer(),"currentCol")
				itemName2 = "Tire"
				triggerServerEvent("takeVehicleComponent",getLocalPlayer(),getElementData(col,"parent"),itemName,itemName2)
				disableMenu()
				return
			else
				triggerEvent ("displayClientInfo",getLocalPlayer(),"Vehicle","Not enough slots to take off the wheel!",255,0,0)
				return
			end
		end
		if itemName == "takeengine" then
			if getPlayerCurrentSlots() + getItemSlots("Engine") <= getPlayerMaxAviableSlots() then
				local col = getElementData(getLocalPlayer(),"currentCol")
				itemName2 = "Engine"
				triggerServerEvent("takeVehicleComponent",getLocalPlayer(),getElementData(col,"parent"),itemName,itemName2)
				disableMenu()
				return
			else
				triggerEvent ("displayClientInfo",getLocalPlayer(),"Vehicle","Not enough slots to take off the engine!",255,0,0)
				return
			end
		end
		if itemName == "siphon" then
			if getElementData(localPlayer,"Empty Gas Canister") > 0 then
				local col = getElementData(getLocalPlayer(),"currentCol")
				itemName2 = "Fuel"
				triggerServerEvent("takeVehicleComponent",getLocalPlayer(),getElementData(col,"parent"),itemName,itemName2)
				disableMenu()
				return
			else
				triggerEvent ("displayClientInfo",getLocalPlayer(),"Vehicle","You need an empty gas canister!",255,0,0)
				return
			end
		end
		if itemName == "tent" then
			local col = getElementData(getLocalPlayer(),"currentCol")
			triggerServerEvent("removeTent",getLocalPlayer(),getElementData(col,"parent"))
			disableMenu()
			return
		end
		if itemName == "fireplace" then
			local col = getElementData(getLocalPlayer(),"currentCol")
			triggerServerEvent("addPlayerCookMeat",getLocalPlayer())
			disableMenu()
			return
		end
		if itemName == "bandage" then
			local col = getElementData(getLocalPlayer(),"currentCol")
			triggerServerEvent("onPlayerGiveMedicObject",getLocalPlayer(),itemName,getElementData(col,"parent"))
			disableMenu()
			return
		end
		if itemName == "morphine" then
			local col = getElementData(getLocalPlayer(),"currentCol")
			triggerServerEvent("onPlayerGiveMedicObject",getLocalPlayer(),itemName,getElementData(col,"parent"))
			disableMenu()
			return
		end
		if itemName == "antibiotics" then
			local col = getElementData(getLocalPlayer(),"currentCol")
			triggerServerEvent("onPlayerGiveMedicObject",getLocalPlayer(),itemName,getElementData(col,"parent"))
			disableMenu()
			return
		end
		if itemName == "giveblood" then
			local col = getElementData(getLocalPlayer(),"currentCol")
			triggerServerEvent("onPlayerGiveMedicObject",getLocalPlayer(),itemName,getElementData(col,"parent"))
			disableMenu()
			return
		end
		if itemName == "epipen" then
			local col = getElementData(getLocalPlayer(),"currentCol")
			triggerServerEvent("onPlayerGiveMedicObject",getLocalPlayer(),itemName,getElementData(col,"parent"))
			disableMenu()
			return
		end
		if itemName == "dead" then
			local col = getElementData(getLocalPlayer(),"currentCol")
			local gearName = "Gear ("..getElementData(col,"playername")..")"
			refreshLoot(col,gearName)
			showInventoryManual()
			disableMenu()
			return
		end
		if itemName == "deadreason" then
			local col = getElementData(getLocalPlayer(),"currentCol")
			outputChatBox(getElementData(col,"deadreason"),255,255,255,true)
			if getElementData(col,"killedBy") and getElementData(col,"killedBy") == localPlayer then
				setElementData(localPlayer,"murders",getElementData(localPlayer,"murders")+1)
				setElementData(col,"killedBy",nil)
			end
			return
		end
		if itemName == "petrolstation" then
				local col = getElementData(getLocalPlayer(),"currentCol")

				--Determine if the petrol station has any fuel left, otherwise tell the player. (1B0Y)
				if (getElementData(col,"petrolQuantity") >= 1) then
					setElementData(getLocalPlayer(),"Empty Gas Canister",getElementData(getLocalPlayer(),"Empty Gas Canister")-1)
					setElementData(getLocalPlayer(),"Full Gas Canister",(getElementData(getLocalPlayer(),"Full Gas Canister") or 0)+1)
					setElementData(col,"petrolQuantity",(getElementData(col,"petrolQuantity") or 10)-1)
					triggerEvent ("displayClientInfo",getLocalPlayer(),"petrolstation","Filled gas canister up!",22,255,0)
					disableMenu()
				else
					triggerEvent("displayClientInfo",localPlayer,"petrolstation","The petrol station has no fuel. Find another!")
				end
			return
		end
			if not playerPickedUpItem then
				if isToolbeltItem(itemName) then
					local col = getElementData(getLocalPlayer(),"currentCol")
					triggerServerEvent("onPlayerTakeItemFromGround",getLocalPlayer(),itemName,col)
					disableMenu()
					return
				end	
				if itemName == "Assault Pack (ACU)" or itemName == "ALICE Pack" or itemName == "Czech Backpack" or itemName == "Backpack (Coyote)" or itemName == "British Assault Pack" or itemName == "Czech Vest Pouch" or itemName == "Survival ACU" then
					local col = getElementData(getLocalPlayer(),"currentCol")
					triggerServerEvent("onPlayerTakeItemFromGround",getLocalPlayer(),itemName,col)
					disableMenu()
					return
				end
				if getPlayerCurrentSlots() + getItemSlots(itemName) <= getPlayerMaxAviableSlots() then	
					local col = getElementData(getLocalPlayer(),"currentCol")
					triggerServerEvent("onPlayerTakeItemFromGround",getLocalPlayer(),itemName,col)
					disableMenu()
				else
					startRollMessage2("Inventory", "Inventory is full!", 255, 22, 0 )
				end
				playerPickedUpItem = true
				setTimer(function()
					playerPickedUpItem = false
				end,10000,1)
			end
	end
end
bindKey ( "mouse3", "down", onPlayerPressMiddleMouse )
bindKey ( "-", "down", onPlayerPressMiddleMouse )

function getMenuMarkedItem() 
	for i,guiItem in ipairs(rowText) do
		if getElementData(guiItem,"markedMenuItem") then
			return getElementData(guiItem,"usedItem") 
		end
	end
end


function playerPressedKey(button, press)
    if (press) then
		if button == "w" or button == "a" or button == "s" or button == "d" then
			local anim,anim2 = getPedAnimation (getLocalPlayer())
			if anim and anim == "SCRATCHING" and anim2 == "sclng_r" then
				triggerServerEvent("onClientMovesWhileAnimation",getLocalPlayer())
			end
		end
	end
end
addEventHandler("onClientKey", root, playerPressedKey)

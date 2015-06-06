--[[
#---------------------------------------------------------------#
----*			DayZ MTA Script menu_client.lua			*----
----* This Script is owned by Marwin, you are not allowed to use or own it.
----* Owner: Marwin W., Germany, Lower Saxony, Otterndorf
----* Skype: xxmavxx96
----*														*----
#---------------------------------------------------------------#
]]


--Create Scroll Menü
local spalten = {}
local spalteGuiImage = {}
local spalteGuiText = {}
local font = {}

local optionsTable = {
["player"] = {
{"Give Painkillers"},
{"Give Bandage"},
{"Give Morphine"},
},
}

font[1] = guiCreateFont("fonts/etelka.ttf", 10)

spalten[1] = ""
spalten[2] = ""
spalten[3] = ""
spalten[4] = ""

spalteGuiImage[1] = guiCreateStaticImage(0,0.45,0.4,0.1,"images/scrollmenu_1.png",true)
spalteGuiImage[2] = guiCreateStaticImage(0,0.475,0.4,0.1,"images/scrollmenu_1.png",true)
spalteGuiImage[3] = guiCreateStaticImage(0,0.5,0.4,0.1,"images/scrollmenu_1.png",true)
spalteGuiImage[4] = guiCreateStaticImage(0,0.525,0.4,0.1,"images/scrollmenu_1.png",true)

spalteGuiText[1] = guiCreateLabel(0.05,0.05,0.995,0.95,spalten[1],true,spalteGuiImage[1])
spalteGuiText[2] = guiCreateLabel(0.05,0.05,0.995,0.95,spalten[2],true,spalteGuiImage[2])
spalteGuiText[3] = guiCreateLabel(0.05,0.05,0.995,0.95,spalten[3],true,spalteGuiImage[3])
spalteGuiText[4] = guiCreateLabel(0.05,0.05,0.995,0.95,spalten[4],true,spalteGuiImage[4])

--guiLabelSetColor (spalteGuiText[1],50,255,50)

guiSetVisible(spalteGuiImage[1],false)
guiSetVisible(spalteGuiImage[2],false)
guiSetVisible(spalteGuiImage[3],false)
guiSetVisible(spalteGuiImage[4],false)

guiSetFont(spalteGuiText[1],font[1])
guiSetFont(spalteGuiText[2],font[1])
guiSetFont(spalteGuiText[3],font[1])
guiSetFont(spalteGuiText[4],font[1])

------------------------------------------------------------------------------
--MENU
function showClientMenuItem(arg1,arg2,arg3,arg4)
local number = 0
if arg1 == "Take" then
	number = number+1
	guiSetVisible(spalteGuiImage[number],true)
	guiSetText(spalteGuiText[number],"Take "..arg2)
	if number == 1 then
		guiLabelSetColor (spalteGuiText[number],50,255,50)
		setElementData(spalteGuiText[number],"markedMenuItem",true)
	end
	setElementData(spalteGuiText[number],"usedItem",arg2)
end
if arg1 == "stop" then
	disableMenu()
	refreshLoot(false)
end
if arg1 == "Helicrashsite" then
	number = number+1
	guiSetVisible(spalteGuiImage[number],true)
	guiSetText(spalteGuiText[number],"Gear (Helicrash)")
	if number == 1 then
		guiLabelSetColor (spalteGuiText[number],50,255,50)
		setElementData(spalteGuiText[number],"markedMenuItem",true)
	end
	setElementData(spalteGuiText[number],"usedItem","helicrashsite")
end
if arg1 == "Hospitalbox" then
	number = number+1
	guiSetVisible(spalteGuiImage[number],true)
	guiSetText(spalteGuiText[number],"Gear (Hospitalbox)")
	if number == 1 then
		guiLabelSetColor (spalteGuiText[number],50,255,50)
		setElementData(spalteGuiText[number],"markedMenuItem",true)
	end
	setElementData(spalteGuiText[number],"usedItem","hospitalbox")
end
if arg1 == "Vehicle" then
	number = number+1
	guiSetVisible(spalteGuiImage[number],true)
	guiSetText(spalteGuiText[number],"Gear ("..arg2..")")
	guiLabelSetColor (spalteGuiText[number],50,255,50)
	setElementData(spalteGuiText[number],"markedMenuItem",true)
	setElementData(spalteGuiText[number],"usedItem","vehicle")
	if getElementData(getElementData(arg3,"parent"),"tent") then
		number = number+1
		guiSetVisible(spalteGuiImage[number],true)
		guiSetText(spalteGuiText[number],"Remove Tent")
		if number == 1 then
			guiLabelSetColor (spalteGuiText[number],50,255,50)
			setElementData(spalteGuiText[number],"markedMenuItem",true)
		end
			setElementData(spalteGuiText[number],"usedItem","tent")
		return
	end
	--2
	if getElementHealth(arg3) < 1000 and getElementHealth(arg3) >= 50 and getElementData(getLocalPlayer(),"Toolbox") >= 1 then
		number = number+1
		guiSetVisible(spalteGuiImage[number],true)
		guiSetText(spalteGuiText[number],"Repair ("..arg2..")")
		setElementData(spalteGuiText[number],"usedItem","repairvehicle")
	end
end
if arg1 == "Player" then
	--1
	if getElementData(arg2,"bleeding") > 0 and getElementData(getLocalPlayer(),"Bandage") >= 1 then
		number = number+1
		guiSetVisible(spalteGuiImage[number],true)
		guiSetText(spalteGuiText[number],"Give Bandage")
		guiLabelSetColor (spalteGuiText[1],50,255,50)
		setElementData(spalteGuiText[1],"markedMenuItem",true)
		setElementData(spalteGuiText[number],"usedItem","bandage")
	end	
	if getElementData(arg2,"blood") < 11900 and getElementData(getLocalPlayer(),"Blood Bag") >= 1 then
		number = number+1
		guiSetVisible(spalteGuiImage[number],true)
		guiSetText(spalteGuiText[number],"Administer Blood Bag")	
		setElementData(spalteGuiText[number],"usedItem","giveblood")
		if number == 1 then
			guiLabelSetColor (spalteGuiText[number],50,255,50)
			setElementData(spalteGuiText[number],"markedMenuItem",true)
		end
	end
end
if arg1 == "Dead" then
	number = number+1
	guiSetVisible(spalteGuiImage[number],true)
	guiSetText(spalteGuiText[number],"Gear ("..arg2..")")
	if number == 1 then
		guiLabelSetColor (spalteGuiText[number],50,255,50)
		setElementData(spalteGuiText[number],"markedMenuItem",true)
	end
	setElementData(spalteGuiText[number],"usedItem","dead")
	number = number+1
	setElementData(spalteGuiText[number],"usedItem","deadreason")
	guiSetVisible(spalteGuiImage[number],true)
	guiSetText(spalteGuiText[number],"Check Body")
end
if arg1 == "Fireplace" then
	if getElementData(getLocalPlayer(),"Raw Meat") >= 1 then
	number = number+1
	guiSetVisible(spalteGuiImage[number],true)
	guiSetText(spalteGuiText[number],"Cook Meat")
	guiLabelSetColor (spalteGuiText[number],50,255,50)
	setElementData(spalteGuiText[number],"markedMenuItem",true)
	setElementData(spalteGuiText[number],"usedItem","fireplace")
	end
end
if arg1 == "patrol" then
	if getElementData(getLocalPlayer(),"Empty Gas Canister") >= 1 then
		number = number+1
		guiSetVisible(spalteGuiImage[number],true)
		guiSetText(spalteGuiText[number],"Refill (Empty Gas Canister)")
		if number == 1 then
			guiLabelSetColor (spalteGuiText[number],50,255,50)
			setElementData(spalteGuiText[number],"markedMenuItem",true)
		end
			setElementData(spalteGuiText[number],"usedItem","patrolstation")
	end	
end
if arg1 == "Wirefence" then
	if getElementData(getLocalPlayer(),"Toolbox") >= 1 then
		number = number+1
		guiSetVisible(spalteGuiImage[number],true)
		guiSetText(spalteGuiText[number],"Remove Wirefence")
		if number == 1 then
			guiLabelSetColor (spalteGuiText[number],50,255,50)
			setElementData(spalteGuiText[number],"markedMenuItem",true)
		end
			setElementData(spalteGuiText[number],"usedItem","wirefence")
	end	
end
if arg1 == "Gear" then
	number = number+1
	guiSetVisible(spalteGuiImage[number],true)
	guiSetText(spalteGuiText[number],"Gear")
	if number == 1 then
		guiLabelSetColor (spalteGuiText[number],50,255,50)
		setElementData(spalteGuiText[number],"markedMenuItem",true)
	end
	setElementData(spalteGuiText[number],"usedItem","itemloot")
end
end
addEvent("showClientMenuItem",true)
addEventHandler("showClientMenuItem",getLocalPlayer(),showClientMenuItem)

function PlayerScrollMenu (key,keyState,arg)
if ( keyState == "down" ) then
if not guiGetVisible(spalteGuiImage[2]) then
	return
end
if arg == "up" then
	if getElementData(spalteGuiText[1],"markedMenuItem") then
		setElementData(spalteGuiText[1],"markedMenuItem",false)
		setElementData(spalteGuiText[2],"markedMenuItem",true)
		guiLabelSetColor (spalteGuiText[2],50,255,50)
		guiLabelSetColor (spalteGuiText[1],255,255,255)
	elseif getElementData(spalteGuiText[2],"markedMenuItem") then
		setElementData(spalteGuiText[2],"markedMenuItem",false)
		setElementData(spalteGuiText[1],"markedMenuItem",true)
		guiLabelSetColor (spalteGuiText[1],50,255,50)
		guiLabelSetColor (spalteGuiText[2],255,255,255)
	end
elseif arg == "down" then
	if getElementData(spalteGuiText[1],"markedMenuItem") then
		setElementData(spalteGuiText[1],"markedMenuItem",false)
		setElementData(spalteGuiText[2],"markedMenuItem",true)
		guiLabelSetColor (spalteGuiText[2],50,255,50)
		guiLabelSetColor (spalteGuiText[1],255,255,255)
	elseif getElementData(spalteGuiText[2],"markedMenuItem") then
		setElementData(spalteGuiText[2],"markedMenuItem",false)
		setElementData(spalteGuiText[1],"markedMenuItem",true)
		guiLabelSetColor (spalteGuiText[1],50,255,50)
		guiLabelSetColor (spalteGuiText[2],255,255,255)
	end
end
end
end
bindKey ( "mouse_wheel_up", "down", PlayerScrollMenu, "up" )
bindKey ( "mouse_wheel_down", "down", PlayerScrollMenu, "down" )

function disableMenu()
guiSetVisible(spalteGuiImage[1],false)
guiSetVisible(spalteGuiImage[2],false)
guiSetVisible(spalteGuiImage[3],false)
guiSetVisible(spalteGuiImage[4],false)
setElementData(spalteGuiText[1],"markedMenuItem",false)
setElementData(spalteGuiText[2],"markedMenuItem",false)
setElementData(spalteGuiText[3],"markedMenuItem",false)
setElementData(spalteGuiText[4],"markedMenuItem",false)
setNewbieInfo (false,"","")
end
addEvent("disableMenu",true)
addEventHandler("disableMenu",getLocalPlayer(),disableMenu)


------------------------------------------------------------------------------

------------------------------------------------------------------------------
--TAKE OBJECT FUNCTIONS

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
if getElementData(source,"parent") == getLocalPlayer() then return end
		local player = getPlayerInCol(getElementsWithinColShape ( source, "player" ))
		if getPedOccupiedVehicle(getLocalPlayer()) then
			return
		end
		isInFirePlace = false
		setElementData(spalteGuiText[2],"markedMenuItem",false)
		setElementData(spalteGuiText[1],"markedMenuItem",true)
		guiLabelSetColor (spalteGuiText[1],50,255,50)
		guiLabelSetColor (spalteGuiText[2],255,255,255)
		if getElementData(source,"player") then
			showClientMenuItem("Player",getElementData(source,"parent"))
			setElementData(getLocalPlayer(),"currentCol",source)
			setElementData(getLocalPlayer(),"loot",false)
			return
		end
		if player then
			return
		end
		if getElementData(source,"patrolstation") then
			showClientMenuItem("patrol")
			setElementData(getLocalPlayer(),"currentCol",source)
			setElementData(getLocalPlayer(),"loot",false)
			setNewbieInfo (true,"patrolstation","Press '-' or 'middle-mouse' to refill a canister!\n REQUIRED: Empty Gas Canister",source)
			return
		end
		if getElementData(source,"wirefence") then
			showClientMenuItem("Wirefence")
			setElementData(getLocalPlayer(),"currentCol",source)
			setElementData(getLocalPlayer(),"loot",false)
			setNewbieInfo (true,"Wirefence","Press '-' or 'middle-mouse' to remove the fence!\n REQUIRED: Toolbox",source)
			return
		end
		if getElementData(source,"fireplace") then
			showClientMenuItem("Fireplace")
			setElementData(getLocalPlayer(),"currentCol",source)
			setElementData(getLocalPlayer(),"loot",false)
			setNewbieInfo (true,"Fireplace","Press '-' or 'middle-mouse' to cook meat!\n REQUIRED: Raw Meat",source)
			isInFirePlace = true
			return
		end
		if getElementData(source,"deadman") then
			showClientMenuItem("Dead",getElementData(source,"playername"))
			setElementData(getLocalPlayer(),"currentCol",source)
			setElementData(getLocalPlayer(),"loot",true)
			setElementData(getLocalPlayer(),"lootname","Gear ("..getElementData(source,"playername")..")")
			setNewbieInfo (true,"Gear","Press J to access the gear menu!",source)
			return
		end
		if getElementData(source,"item") then
			showClientMenuItem("Take",getElementData(source,"item"))
			setElementData(getLocalPlayer(),"currentCol",source)
			setElementData(getLocalPlayer(),"loot",false)
			setNewbieInfo (true,"Item pickup","Press '-' or 'middle-mouse' to pick this item up!",source)
			return
		end
		if getElementData(source,"helicrash") then
			showClientMenuItem("Helicrashsite","helicrash")
			setElementData(getLocalPlayer(),"currentCol",source)
			setElementData(getLocalPlayer(),"loot",true)
			setElementData(getLocalPlayer(),"lootname","Gear (Helicrash)")
			setNewbieInfo (true,"Gear","Press J to access the gear menu!",source)
			return
		end
		if getElementData(source,"hospitalbox") then
			showClientMenuItem("Hospitalbox","hospitalbox")
			setElementData(getLocalPlayer(),"currentCol",source)
			setElementData(getLocalPlayer(),"loot",true)
			setElementData(getLocalPlayer(),"lootname","Gear (Hospitalbox)")
			setNewbieInfo (true,"Gear","Press J to access the gear menu!",source)
			return
		end
		if getElementData(source,"vehicle") then
			if not getElementData(source,"deadVehicle") then
			showClientMenuItem("Vehicle",(getVehicleName(getElementData(source,"parent")) or "Tent"),getElementData(source,"parent"))
			setElementData(getLocalPlayer(),"currentCol",source)
			setElementData(getLocalPlayer(),"loot",true)
			setElementData(getLocalPlayer(),"lootname","Gear ("..(getVehicleName(getElementData(source,"parent")) or "Tent")..")")
			setNewbieInfo (true,"Gear","Press J to acess the gear menu!",source)
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

function setNewbieInfo (show,head,text,element)
--newbieShow = show
--newbieHead = head
--newbieText = text
--newbiePosition = element
return
end

addEventHandler("onClientRender", getRootElement(), 
function()
	if newbieShow == false then return end
	local x,y,z = getElementPosition(newbiePosition)
	local x,y = getScreenFromWorldPosition (x,y,z)
	local length = dxGetTextWidth(newbieText,1,"default-bold")
	dxDrawRectangle ( x-length/2-screenWidth*0.01,y, screenWidth*0.02+length, screenHeight*0.1, tocolor (33,33,33,100) )
	dxDrawingColorText(newbieHead,x-length/2-screenWidth*0.01,y, x+length/2+screenWidth*0.01, y+screenHeight*0.03, tocolor(22,255,22,120),0.5, 1.1, "default-bold", "center", "center")
	dxDrawingColorText(newbieText,x-length/2-screenWidth*0.01,y+screenHeight*0.03, x+length/2+screenWidth*0.01, y+screenHeight*0.07, tocolor(255,255,255,120),0.5, 1, "default-bold", "center", "center")
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
	if not guiGetVisible(spalteGuiText[1]) then return end
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
			local gearName = "Gear ("..(getVehicleName(getElementData(col,"parent")) or "Tent")..")"
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
		if itemName == "giveblood" then
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
			--triggerServerEvent("onPlayerHideBody",col)
			--outputChatBox("You hid the body...",0,255,0,true)
			--disableMenu()
			return
		end
		if itemName == "patrolstation" then
			local col = getElementData(getLocalPlayer(),"currentCol")
				setElementData(getLocalPlayer(),"Empty Gas Canister",getElementData(getLocalPlayer(),"Empty Gas Canister")-1)
				setElementData(getLocalPlayer(),"Full Gas Canister",(getElementData(getLocalPlayer(),"Full Gas Canister") or 0)+1)
				triggerEvent ("displayClientInfo",getLocalPlayer(),"patrolstation","Filled gas canister up!",22,255,0)
				disableMenu()
			return
		end
			if isToolbeltItem(itemName) then
				local col = getElementData(getLocalPlayer(),"currentCol")
				triggerServerEvent("onPlayerTakeItemFromGround",getLocalPlayer(),itemName,col)
				disableMenu()
				return
			end	
			if itemName == "Assault Pack (ACU)" or itemName == "Alice Pack" or itemName == "Czech Backpack" or itemName == "Coyote Backpack" then
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
	end
end
bindKey ( "mouse3", "down", onPlayerPressMiddleMouse )
bindKey ( "-", "down", onPlayerPressMiddleMouse )

function getMenuMarkedItem() 
	for i,guiItem in ipairs(spalteGuiText) do
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

--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: crafting_player.lua					*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: CLIENT														*----
#-----------------------------------------------------------------------------#
]]

--[[
Stuff to do:
- Player must not move while crafting, or else crafting will cancel (Animation?)
- Are the requirements too high/too low? Needs extensive testing!
]]

-- [[ We initialize the crafting process ]] --
selectedBlueprint = ""		-- The blueprint that will be used (equals data[1])
craftedItem = ""			-- The end result of the crafting process (equals data[2])
craftedAmount = 0			-- The amount of craftedItem (equals data[3])
craftingTime = 0			-- How long will the item take to craft? (equals data[10])
ComponentA = ""				-- Component A (equals data[4])
ComponentB = ""				-- Component B (equals data[5])
ComponentC = ""				-- Component C (equals data[6])
ComponentA_Amount = ""		-- Amount for A (equals data[7])
ComponentB_Amount = ""		-- Amount for B (equals data[8])
ComponentC_Amount = ""		-- Amount for C (equals data[9])
crafted = false				-- Has the item been crafted?
isCrafting = false			-- Is the player crafting already?


-- [[ Using the assigned variables, we now craft the item ]] --
function craftItem()
	if getElementData(localPlayer,ComponentA) >= ComponentA_Amount then
		if getElementData(localPlayer,ComponentB) >= ComponentB_Amount then
			if getElementData(localPlayer,ComponentC) >= ComponentC_Amount then
				if not isCrafting then
					triggerEvent("onStartCraftingTimer",localPlayer)
					if crafted then
						local cItem = getElementData(localPlayer,craftedItem)or 0
						startRollMessage2("Crafting","Item has been crafted!",0,255,0)
						setElementData(localPlayer,craftedItem,cItem+craftedAmount)
						setElementData(localPlayer,selectedBlueprint,getElementData(localPlayer,selectedBlueprint)-1)
						setElementData(localPlayer,ComponentA,getElementData(localPlayer,ComponentA)-ComponentA_Amount)
						setElementData(localPlayer,ComponentB,getElementData(localPlayer,ComponentB)-ComponentB_Amount)
						setElementData(localPlayer,ComponentC,getElementData(localPlayer,ComponentC)-ComponentC_Amount)
						craftingTime = 0
						crafted = false
						destroyElement(craftingBar)
						killTimer(craftingTimer)
						isCrafting = false
					else
						startRollMessage2("Crafting","Item is being crafted...",0,0,255)
					end
				else
					startRollMessage2("Crafting","You are crafting already!",255,0,0)
				end
			else
				startRollMessage2("Crafting","Not enough components! ("..ComponentC..")",255,0,0)
				return
			end
		else
			startRollMessage2("Crafting","Not enough components! ("..ComponentB..")",255,0,0)
			return
		end
	else
		startRollMessage2("Crafting","Not enough components! ("..ComponentA..")",255,0,0)
		return
	end
end
addEvent("onPlayerStartCrafting",true)
addEventHandler("onPlayerStartCrafting",root,craftItem)

-- [[ First we check if the player has all components, and if he has, assign the respective item ]] --
function checkComponents()
local getSelectedBlueprint = getElementData(localPlayer,"selectedBlueprint")
	for i,data in ipairs(craftingTable) do
		if getSelectedBlueprint == data[1] then
			selectedBlueprint = data[1]
			craftedItem = data[2]
			craftedAmount = data[3]
			ComponentA = data[4]
			ComponentB = data[5]
			ComponentC = data[6]
			ComponentA_Amount = data[7]
			ComponentB_Amount = data[8]
			ComponentC_Amount = data[9]
			craftingTime = data[10]
			triggerEvent("onPlayerStartCrafting",localPlayer)
			break
		end
	end
end

-- [[ Creates a progress bar for crafting ]] --
function onStartCraftingTimer()
	if isElement(craftingBar) then
		return
	else
		craftingBar = guiCreateProgressBar(0.35,0.9,0.3,0.05,true)
		guiProgressBarSetProgress(craftingBar,0)
		craftingTimer = setTimer(increaseTimer,craftingTime,0)
		craftingsound = playSound(":DayZ/sounds/status/crafting.mp3",false)
		isCrafting = true
		
	end
end
addEvent("onStartCraftingTimer",true)
addEventHandler("onStartCraftingTimer",localPlayer,onStartCraftingTimer)

-- [[ Increasing the progress bar status until it's 100 ]] --
function increaseTimer()
	if guiProgressBarGetProgress(craftingBar) >= 100 then
		if getPlayerCurrentSlots() --[[+ getItemSlots(itemName) ]] >= getPlayerMaxAviableSlots() then
			setTimer(startRollMessage2("Crafting","Inventory is full!",255,0,0),100,1)
			crafted = false
			destroyElement(craftingBar)
			destroyElement(secondsleftlabel)
			killTimer(craftingTimer)
			isCrafting = false
			return
		else
			crafted = true
			isCrafting = false
			craftItem()
			return
		end
	else
		guiProgressBarSetProgress(craftingBar,guiProgressBarGetProgress(craftingBar)+1)
	end
end

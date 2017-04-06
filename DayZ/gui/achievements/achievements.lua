--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: achievements.lua						*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: CLIENT														*----
#-----------------------------------------------------------------------------#
]]

waitList = {}
GUIEdit = {
    label = {},
    staticimage = {}
}

function panel(state)
	if not GUIEdit.staticimage[1] then
		GUIEdit.staticimage[1] = guiCreateStaticImage(0.00, -0.15, 0.31, 0.14, "gui/achievements/icons/bg_achievements.png", true)
		guiSetAlpha(GUIEdit.staticimage[1], 1.00)
		guiBringToFront(GUIEdit.staticimage[1])

		GUIEdit.staticimage[2] = guiCreateStaticImage(0.04, 0.16, 0.29, 0.67, "gui/gear/items/white.png", true, GUIEdit.staticimage[1])
		GUIEdit.label[1] = guiCreateLabel(0.34, 0.16, 0.62, 0.17, "Achievement Unlocked", true, GUIEdit.staticimage[1])
		guiSetFont(GUIEdit.label[1], "default-bold-small")
		guiLabelSetHorizontalAlign(GUIEdit.label[1], "center", false)
		GUIEdit.label[2] = guiCreateLabel(0.34, 0.33, 0.99, 0.50, "", true, GUIEdit.staticimage[1])
		guiLabelSetHorizontalAlign(GUIEdit.label[2], "left", false)
		guiLabelSetVerticalAlign(GUIEdit.label[2], "center")
	else
		guiSetVisible(GUIEdit.staticimage[1],state)
	end
end

local xac,yac = 0.00, -0.15
local yaux = -0.15
local xaux = 0.00
function move()
	yaux = yaux+0.01
	guiSetPosition(GUIEdit.staticimage[1],xac,yaux,true)
	if yaux >= 0.00 then
		removeEventHandler("onClientRender",getRootElement(),move)
		setTimer(function()
			function moverparaolado()
				xaux = xaux-0.01
				guiSetPosition(GUIEdit.staticimage[1],xaux,yaux,true)
				if xaux <= -0.22 then
					yaux = yac
					xaux = xac
					panel(false)

					if #waitList > 0 then
						giveAchievement(waitList[1])
						table.remove(waitList,1)
					end
					removeEventHandler("onClientRender",getRootElement(),moverparaolado)
				end
			end
			addEventHandler("onClientRender",getRootElement(),moverparaolado)
		end,5000,1)
	end
end

function getAchievements()
	local achievementsunlocked = fromJSON(getElementData(getLocalPlayer(),"achievements"))
	if not achievementsunlocked then
		setElementData(getLocalPlayer(),"achievements",toJSON({}))
		achievementsunlocked = {}
	end
	return achievementsunlocked
end

function giveAchievement(ID)
	if GUIEdit.staticimage[1] and guiGetVisible(GUIEdit.staticimage[1]) then
		table.insert(waitList,ID)
	else
		panel(true)
		if ID then
			local achievementsunlocked = getAchievements()
			achievementsunlocked[ID] = true
			setElementData(getLocalPlayer(),"achievements",toJSON(achievementsunlocked))
			guiSetText(GUIEdit.label[2],achievements[ID]["name"])
			guiStaticImageLoadImage(GUIEdit.staticimage[2],pathToImg..achievements[ID]["image"])
			addEventHandler("onClientRender",getRootElement(),move)
		end
	end
end

function check() -- Needs optimizing
	if not getElementData(localPlayer,"logedin") then return end
	local achievementsunlocked = getAchievements()
	local counter = 0
	for i, all in pairs(achievements) do
		if not achievementsunlocked[i] then
			for _,cond in ipairs(all["conditions"]) do
				if(cond[2] == "greater" and cond[3]) then
					if getElementData(getLocalPlayer(),cond[1]) > tonumber(cond[3]) then
						counter = counter+1
					end
				elseif (cond[2] == "equal") then
					if getElementData(getLocalPlayer(),cond[1]) == cond[3] then
						counter = counter+1
					end
				elseif (cond[2] == "less" and cond[3]) then
					if getElementData(getLocalPlayer(),cond[1]) < tonumber(cond[3]) then
						counter = counter+1
					end
				elseif (cond[2] == "misc_zaxis") then
					local x,y,z = getElementPosition(localPlayer)
					-- outputChatBox(assert(loadstring("return "..tostring(cond[1])))()) -- Don't load > 100 above ground (idk why)
					if z >= 300 then
						counter = counter+1
					end
				elseif (cond[2] == "clothes") then
					local playerClothesShirt = getPedClothes(localPlayer,0)
					local playerClothesHead = getPedClothes(localPlayer,1)
					local playerClothesPants = getPedClothes(localPlayer,2)
					if playerClothesShirt == "player_torso" then
						if playerClothesHead == "player_face" then
							if playerClothesPants == "player_legs" then
								counter = counter+1
							end
						end
					end
				elseif cond[2] == "area" then
					local x,y,z = getElementPosition(localPlayer)
					if getDistanceBetweenPoints3D(x,y,z,213,1898,17) <= 25 then
						counter = counter+1
					end
				elseif cond[2] == "carrier" then
					local x,y,z = getElementPosition(localPlayer)
					if getDistanceBetweenPoints3D(x,y,z,-1325,502,18) <= 25 then
						counter = counter+1
					end
				end
				if(counter == #all["conditions"]) then
					giveAchievement(i)
					for index, element in ipairs(all["items"]) do
						if getElementData(localPlayer,"CURRENT_Slots") + getItemSlots(element[1]) > getElementData(localPlayer,"MAX_Slots") then
							startRollMessage2("Inventory","Inventory full, can't accept achievement rewards!",255,0,0)
							break
						else
							setElementData(getLocalPlayer(),element[1],element[2])
						end
					end
				end
			end
			counter = 0
		end
	end	
end
setTimer(check,10000,0)

--giveAchievement(2)
--giveAchievement(1)
--showAchievement("kill50z")







--------- Achievement list [Needs design renewal]
GUIAchiev = {
    staticimage = {},
    scrollpane = {},
    label = {}
}

function achievpanel(state)
	if not GUIAchiev.staticimage[1] then
		local font0_needhelp = guiCreateFont("fonts/needhelp.ttf", 20)
		GUIAchiev.staticimage[1] = guiCreateStaticImage(0.00, 0.06, 1.00, 0.90, "gui/journal/images/journal_page1.png", true)
		guiBringToFront(GUIAchiev.staticimage[1])
		
		GUIAchiev.label[1] = guiCreateLabel(0.09, 0.09, 0.14, 0.05, "Achievements", true, GUIAchiev.staticimage[1])
		guiSetFont(GUIAchiev.label[1], font0_needhelp)
		guiLabelSetColor(GUIAchiev.label[1], 0, 0, 0)
		
		GUIAchiev.label[2] = guiCreateLabel(0.23, 0.11, 0.21, 0.03, "Your achievements: 01 of 100 (01% completed)", true, GUIAchiev.staticimage[1])
		guiLabelSetColor(GUIAchiev.label[2], 45, 45, 45)
		
		GUIAchiev.label[3] = guiCreateLabel(0.80, 0.09, 0.14, 0.05, "Close", true, GUIAchiev.staticimage[1])
		guiSetFont(GUIAchiev.label[3], font0_needhelp)
		guiLabelSetColor(GUIAchiev.label[3], 0, 0, 0)
		
		GUIAchiev.scrollpane[1] = guiCreateScrollPane(0.09, 0.17, 0.37, 0.70, true, GUIAchiev.staticimage[1])
		GUIAchiev.scrollpane[2] = guiCreateScrollPane(0.54, 0.17, 0.35, 0.71, true, GUIAchiev.staticimage[1])
		
		addEventHandler("onClientGUIClick",GUIAchiev.label[3],function()
			achievpanel(false)
		end)
	else
		guiSetVisible(GUIAchiev.staticimage[1],state)
	end
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function loadList()  -- Needs optimizing (urgent)
	local achievunl = getAchievements()
	achievpanel(true)
	local y1 = 0.00
	local ind = 0
	local aunlocked, aachiev = tablelength(achievunl),tablelength(achievements)
	guiSetText(GUIAchiev.label[2], "Your achievements: "..aunlocked.." of "..aachiev.." ("..math.round((((aunlocked/aachiev) * 100) or 0),2).."% completed)")
	for i, all in pairs(achievunl) do
		ind = ind+1
		if ind > 6 then
			break
		end
		panelachiev = guiCreateStaticImage(0.00, y1, 1.00, 0.14, "gui/crosshair/none.png", true, GUIAchiev.scrollpane[1])
		
		achievIMG = guiCreateStaticImage(0.00, 0.00, 0.15, 1.00, pathToImg..achievements[i]["image"], true, panelachiev)
		achievbg = guiCreateStaticImage(0.18, 0.00, 0.82, 1.00, "gui/achievements/icons/bg_achievements.png", true, panelachiev)

		achievname = guiCreateLabel(0.01, 0.00, 0.99, 0.28, achievements[i]["name"], true, achievbg)
		guiSetFont(achievname, "default-bold-small")
		achievdescript = guiCreateLabel(0.01, 0.28, 0.99, 0.69, achievements[i]["description"], true, achievbg)
		y1 = y1+0.16
	end
	
	y1 = 0.00
	if aunlocked > 6 then
		ind = 0
		for i, all in pairs(achievunl) do
			ind = ind+1
			if (ind > 6) then
				panelachiev = guiCreateStaticImage(0.00, y1, 1.00, 0.14, "gui/crosshair/none.png", true, GUIAchiev.scrollpane[2])
				
				achievIMG = guiCreateStaticImage(0.00, 0.00, 0.15, 1.00, pathToImg..achievements[i]["image"], true, panelachiev)
				achievbg = guiCreateStaticImage(0.18, 0.00, 0.82, 1.00, "gui/achievements/icons/bg_achievements.png", true, panelachiev)

				achievname = guiCreateLabel(0.01, 0.00, 0.99, 0.28, achievements[i]["name"], true, achievbg)
				guiSetFont(achievname, "default-bold-small")
				achievdescript = guiCreateLabel(0.01, 0.28, 0.99, 0.69, achievements[i]["description"], true, achievbg)
				y1 = y1+0.16
			end
		end
	end
end
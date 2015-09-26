--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: hud_gear.lua							*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: CLIENT														*----
#-----------------------------------------------------------------------------#
]]

local enableBlips = true
local renderNorthBlip = false
local alwaysRenderMap = false
local worldmap
local gpsborder
local alpha = 255
local font = {}
font[1] = dxCreateFont(":DayZ/fonts/bitstream.ttf", 10)

local worldW, worldH = 3200, 3200
local blip = 12 

local sx, sy = guiGetScreenSize()
local rt = dxCreateRenderTarget(290, 175)
local xFactor, yFactor = sx/1366, sy/768
local yFactor = xFactor

function playerDrawMapGPSCompass()
	if getElementData(getLocalPlayer(),"logedin") then
		toggleControl ("radar",false)
		showPlayerHudComponent ("clock",false) 
		showPlayerHudComponent ("radar",false)
		showPlayerHudComponent ("money",false) 
		showPlayerHudComponent ("health",false) 
		showPlayerHudComponent ("weapon",false) 
		showPlayerHudComponent ("ammo",false) 
		showPlayerHudComponent ("breath",false) 
		if getElementData(getLocalPlayer(),"Map") >= 1  then
			if not mapkeybound then
				bindKey("F11","down",toggleMap)
				mapkeybound = true
			end
		else
			if mapkeybound then
				unbindKey("F11","down",toggleMap)
				mapkeybound = false
			end
		end
		if getElementData(getLocalPlayer(),"GPS") >= 1  then
			if not gpskeybound then
				addCommandHandler("gps",toggleGPS)
				gpskeybound = true
			end
		else
			if gpskeybound then
				removeEventHandler("onClientRender",root,drawTheGPS)
				removeCommandHandler("gps",toggleGPS)
				dxSetRenderTarget()
				gpskeybound = false
			end
		end
		if getElementData(getLocalPlayer(),"Watch") >= 1 then
			local hour, minutes = getTime()
			if hour < 10 then
				hour = "0"..hour
			else
				hour = hour
			end
			if minutes < 10 then
				minutes = "0"..minutes
			else
				minutes = minutes
			end
			local screenW, screenH = guiGetScreenSize()
			dxDrawText(hour..":"..minutes, (screenW * 0.8287) - 1, (screenH * 0.1667) - 1, (screenW * 0.9550) - 1, (screenH * 0.1983) - 1, tocolor(0, 0, 0, 255), 1.00, font[1], "center", "center", false, false, false, false, false)
			dxDrawText(hour..":"..minutes, (screenW * 0.8287) + 1, (screenH * 0.1667) - 1, (screenW * 0.9550) + 1, (screenH * 0.1983) - 1, tocolor(0, 0, 0, 255), 1.00, font[1], "center", "center", false, false, false, false, false)
			dxDrawText(hour..":"..minutes, (screenW * 0.8287) - 1, (screenH * 0.1667) + 1, (screenW * 0.9550) - 1, (screenH * 0.1983) + 1, tocolor(0, 0, 0, 255), 1.00,  font[1], "center", "center", false, false, false, false, false)
			dxDrawText(hour..":"..minutes, (screenW * 0.8287) + 1, (screenH * 0.1667) + 1, (screenW * 0.9550) + 1, (screenH * 0.1983) + 1, tocolor(0, 0, 0, 255), 1.00,  font[1], "center", "center", false, false, false, false, false)
			dxDrawText(hour..":"..minutes, screenW * 0.8287, screenH * 0.1667, screenW * 0.9550, screenH * 0.1983, tocolor(0, 255, 0, 255), 1.00,  font[1], "center", "center", false, false, false, false, false)
		end
		if getElementData(getLocalPlayer(),"Compass") >= 1 then
			if not compasskeybound then
				addCommandHandler("compass",toggleCompass)
				compasskeybound = true
			end
		else
			if compasskeybound then
				removeEventHandler("onClientRender",root,drawTheCompass)
				removeCommandHandler("compass",toggleCompass)
				compasskeybound = false
			end
		end
	end
end
addEventHandler("onClientRender",root,playerDrawMapGPSCompass)

local isMapShown = false
local isGPSShown = false
local isCompassShown = false

function toggleMap()
	if not isMapShown then
		isMapShown = true
		addEventHandler("onClientRender",root,drawTheMap)
		alpha = 0
	else
		isMapShown = false
		removeEventHandler("onClientRender",root,drawTheMap)
		alpha = 255
	end
end

function toggleGPS()
	if not isGPSShown then
		isGPSShown = true
		addEventHandler("onClientRender",root,drawTheGPS)
	else
		isGPSShown = false
		removeEventHandler("onClientRender",root,drawTheGPS)
	end
end

function toggleCompass()
	if not isCompassShown then
		isCompassShown = true
		addEventHandler("onClientRender",root,drawTheCompass)
	else
		isCompassShown = false
		removeEventHandler("onClientRender",root,drawTheCompass)
	end
end

function drawTheMap()
	local x, y = getElementPosition(localPlayer)
	local X, Y = sx/2 -(x/(6000/(worldW-200))), sy/2 + (y/(6000/(worldH-200)))
	local camX,camY,camZ = getElementRotation(getCamera())
	if alwaysRenderMap or getElementInterior(localPlayer) == 0 then
		dxDrawRectangle(0, 0, sx, sy, tocolor(176, 200, 210,255))
		dxDrawImage(X - worldW/2, Y - worldH/2, worldW, worldH, ":DayZ/gui/gear/items/world.png", 0, (x/(6000/worldW)), -(y/(6000/worldH)), tocolor(255, 255, 255, 255))
	end
	local col = tocolor(r, g, b, 190)
	local bg = tocolor(r, g, b, 100)
	local rx, ry, rz = getElementRotation(localPlayer)
	local lB = (15)*xFactor
	local rB = (15+sx)*xFactor
	local tB = sy-(205)*yFactor
	local bB = tB + (sy)*yFactor
	local cX, cY = (rB+lB)/2, (tB+bB)/2 +(35)*yFactor
	local toLeft, toTop, toRight, toBottom = cX-lB, cY-tB, rB-cX, bB-cY
	for k, v in ipairs(getElementsByType("blip")) do
		local bx, by = getElementPosition(v)
		local actualDist = getDistanceBetweenPoints2D(x, y, bx, by)
		local maxDist = getBlipVisibleDistance(v)
		if actualDist <= maxDist and getElementDimension(v)==getElementDimension(localPlayer) and getElementInterior(v)==getElementInterior(localPlayer) then
			local dist = actualDist/(6000/((3072+3072)/2))
			local rot = findRotation(bx, by, x, y)-camZ
			local bpx, bpy = getPointFromDistanceRotation(cX, cY, math.min(dist, math.sqrt(toTop^2 + toRight^2)), rot)
			local bpx = math.max(lB, math.min(rB, bpx))
			local bpy = math.max(tB, math.min(bB, bpy))
			local bid = getElementData(v, "customIcon") or getBlipIcon(v)
			local _, _, _, bcA = getBlipColor(v)
			local bcR, bcG, bcB = 255, 255, 255
				if getBlipIcon(v) == 0 then
					bcR, bcG, bcB = getBlipColor(v)
				end
			local bS = getBlipSize(v)
			dxDrawImage(bpx -(blip*bS)*xFactor/2, bpy -(blip*bS)*yFactor/2, (blip*bS)*xFactor, (blip*bS)*yFactor, ":DayZ/gui/gear/items/blip/0.png", 0, 0, 0, tocolor(bcR, bcG, bcB, alpha))
		end
	end
	dxDrawImage(sx * 0.5, sy * 0.5, (blip*2)*xFactor, (blip*2)*yFactor, ":DayZ/gui/gear/items/player.png", camZ-rz, 0, 0, tocolor(255,30,0,255))
end

function drawTheGPS()
	if (not isPlayerMapVisible()) then
		local mW, mH = dxGetMaterialSize(rt)
		local x, y = getElementPosition(localPlayer)
		local X, Y = mW/2 -(x/(6000/(3072))), mH/2 +(y/(6000/(3072)))
		local camX,camY,camZ = getElementRotation(getCamera())
		dxSetRenderTarget(rt, true)
		if alwaysRenderMap or getElementInterior(localPlayer) == 0 then
			dxDrawRectangle(0, 0, mW, mH, tocolor(176, 200, 210,alpha)) --render background
			worldmap = dxDrawImage(X - 3072/2, mH/5 + (Y - 3072/2), 3072, 3072, ":DayZ/gui/gear/items/radarworld.png", camZ, (x/(6000/(3072))), -(y/(6000/3072)), tocolor(255, 255, 255, alpha))
		end
		dxSetRenderTarget()
		gpsborder = dxDrawImage((990)*xFactor, sy-((300+10))*yFactor, (300)*xFactor, (200)*yFactor, ":DayZ/gui/gear/items/gps.png",0,0,0,tocolor(255,255,255,alpha),true)
		--dxDrawRectangle((10)*xFactor, sy-((200+10))*yFactor, (300)*xFactor, (200)*yFactor, tocolor(0, 0, 0, 175))
		dxDrawImage((5+1000)*xFactor, sy-((300+10))*yFactor, (300-30)*xFactor, (175)*yFactor, rt, 0, 0, 0, tocolor(255, 255, 255, alpha))
		local col = tocolor(r, g, b, 190)
		local bg = tocolor(r, g, b, 100)
		local rx, ry, rz = getElementRotation(localPlayer)
		local lB = (15)*xFactor
		local rB = (15+290)*xFactor
		local tB = sy-(205)*yFactor
		local bB = tB + (175)*yFactor
		local cX, cY = (rB+lB)/2, (tB+bB)/2 +(35)*yFactor
		local toLeft, toTop, toRight, toBottom = cX-lB, cY-tB, rB-cX, bB-cY
		for k, v in ipairs(getElementsByType("blip")) do
			local bx, by = getElementPosition(v)
			local actualDist = getDistanceBetweenPoints2D(x, y, bx, by)
			local maxDist = getBlipVisibleDistance(v)
			if actualDist <= maxDist and getElementDimension(v)==getElementDimension(localPlayer) and getElementInterior(v)==getElementInterior(localPlayer) then
				local dist = actualDist/(6000/((3072+3072)/2))
				local rot = findRotation(bx, by, x, y)-camZ
				local bpx, bpy = getPointFromDistanceRotation(cX, cY, math.min(dist, math.sqrt(toTop^2 + toRight^2)), rot)
				local bpx = math.max(lB, math.min(rB, bpx))
				local bpy = math.max(tB, math.min(bB, bpy))
				local bid = getElementData(v, "customIcon") or getBlipIcon(v)
				local _, _, _, bcA = getBlipColor(v)
				local bcR, bcG, bcB = 255, 255, 255
					if getBlipIcon(v) == 0 then
						bcR, bcG, bcB = getBlipColor(v)
					end
				local bS = getBlipSize(v)
				--dxDrawImage(bpx -(blip*bS)*xFactor/2, bpy -(blip*bS)*yFactor/2, (blip*bS)*xFactor, (blip*bS)*yFactor, ":DayZ/gui/gear/items/blip/0.png", 0, 0, 0, tocolor(bcR, bcG, bcB, alpha))
			end
		end
		if renderNorthBlip then
			local rot = -camZ+180
			local bpx, bpy = getPointFromDistanceRotation(cX, cY, math.sqrt(toTop^2 + toRight^2), rot) --get position
			local bpx = math.max(lB, math.min(rB, bpx))
			local bpy = math.max(tB, math.min(bB, bpy)) --cap position to screen
			local dist = getDistanceBetweenPoints2D(cX, cY, bpx, bpy) --get distance to the capped position
			local bpx, bpy = getPointFromDistanceRotation(cX, cY, dist, rot) --re-calculate position based on new distance
			if bpx and bpy then --if position was obtained successfully
				local bpx = math.max(lB, math.min(rB, bpx))
				local bpy = math.max(tB, math.min(bB, bpy)) --cap position just in case
				--dxDrawImage(bpx -(blip*2)/2, bpy -(blip*2)/2, blip*2, blip*2, ":DayZ/gui/gear/items/blip/4.png", 0, 0, 0) --draw north (4) blip
			end
		end
		--dxDrawImage(cX -(blip*2)*xFactor/2, cY -(blip*2)*yFactor/2, (blip*2)*xFactor, (blip*2)*yFactor, ":DayZ/gui/gear/items/player.png", camZ-rz, 0, 0, tocolor(255,30,0,alpha))
	end
end

function drawTheCompass()
	local rx,ry,rz = getRotationOfCamera(localPlayer)
	local bX, bY, bX2, bY2 = 0, 0, 0, 0
	local aX, aY, aY2, aY2 = 0, 0, 0, 0
	if sx == 800 or sx == 1024 then
		bX, bY, bX2, bY2 = 0.0375, 0.5767, 0.1625, 0.2150
		aX, aY, aX2, aY2 = 0.0488, 0.5917, 0.1375, 0.1817	
	elseif sx == 1280 or sx == 1366 then
		bX, bY, bX2, bY2 = 0.0549, 0.4961, 0.1296, 0.2279
		aX, aY, aX2, aY2 = 0.0644, 0.5130, 0.1098, 0.1914
	else
		bX, bY, bX2, bY2 = 0.0549, 0.4961, 0.1296, 0.2279
		aX, aY, aX2, aY2 = 0.0644, 0.5130, 0.1098, 0.1914
	end
	dxDrawImage(sx * bX, sy * bY, sx * bX2, sy * bY2, ":DayZ/gui/gear/items/compassborder.png" )
	dxDrawImage(sx * aX, sy * aY, sx * aX2, sy * aY2, ":DayZ/gui/gear/items/compassarrow.png", rz )
end

function hideGPSOnInventoryOpen()
	alpha = 0
end
addEvent("hideGPSOnInventoryOpen",true)
addEventHandler("hideGPSOnInventoryOpen",root,hideGPSOnInventoryOpen)

function showGPSOnInventoryClose()
	alpha = 255
end
addEvent("showGPSOnInventoryClose",true)
addEventHandler("showGPSOnInventoryClose",root,showGPSOnInventoryClose)


nightvisionimage = guiCreateStaticImage(0,0,1,1,":DayZ/gui/gear/items/nightvision.png",true)
guiSetVisible(nightvisionimage,false)

infravision = guiCreateStaticImage(0,0,1,1,":DayZ/gui/gear/items/infravision.png",true)
guiSetVisible(infravision,false)

function playerActivateGoggles (key,keyState)
	if key == "n" then
		if getElementData(getLocalPlayer(),"NV Goggles") > 0 then
			if nightvision then
				nightvision = false
				guiSetVisible(nightvisionimage,false)
				guiSetVisible(infravision,false)
				showChat(true)
				setCameraGoggleEffect("normal")
				local hour, minutes = getTime()
				if gameplayVariables["enablenight"] then
					setClientNight (hour,minutes)
				end
			else 
				nightvision = true
				guiSetVisible(nightvisionimage,true)
				guiSetVisible(infravision,false)
				showChat(false)
				setCameraGoggleEffect("nightvision")
				setFarClipDistance(1000)
			end
		end
	elseif key == "i" then
		if getElementData(getLocalPlayer(),"IR Goggles") > 0 then
			if infaredvision then
				infaredvision = false
				guiSetVisible(infravision,false)
				guiSetVisible(nightvisionimage,false)
				showChat(true)
				setCameraGoggleEffect("normal")
				if gameplayVariables["enablenight"] then
					setClientNight (hour,minutes)
				end
			else 
				 infaredvision = true
				 guiSetVisible(infravision,true)
				 guiSetVisible(nightvisionimage,false)
				 showChat(false)
				setCameraGoggleEffect("thermalvision")
				if gameplayVariables["enablenight"] then
					setClientNight (hour,minutes)
				end
			end
		end
	end
end
bindKey("n","down",playerActivateGoggles)
bindKey("i","up",playerActivateGoggles)

function setClientNight (hour,minutes)
	if hour == 21 then
		setSkyGradient(0, 100/minutes, 196/minutes, 136/minutes, 170/minutes, 212/minutes)
		setFarClipDistance(120+(880-minutes*14.6))
		setFogDistance(-150+(250-minutes*4.16))
	elseif hour == 7 then
		setSkyGradient( 0, 1.6*minutes, 196*3.26, 136*2.26, 170*2.83, 212*3.53 )
		setFarClipDistance(120+(minutes*14.6))
		setFogDistance(-150+(minutes*4.16))
	elseif hour == 22 or hour == 23 then
		setSkyGradient( 0, 0, 0, 0, 0, 0 )
		setFarClipDistance(120)
		setFogDistance(-150)
	elseif hour >= 0 and hour <= 7 then
		setSkyGradient( 0, 0, 0, 0, 0, 0 )
		setFarClipDistance(120)
		setFogDistance(-150)
	else
		setSkyGradient(0, 100, 196, 136, 170, 212)
		setFarClipDistance(1000)
		setFogDistance(100)
	end
end

local sWidth,sHeight = guiGetScreenSize()
function WeaponHUD()
	if getElementData(localPlayer,"logedin") then
		ammo = getPedTotalAmmo (localPlayer) - getPedAmmoInClip (localPlayer)
		clip = getPedAmmoInClip (localPlayer)
		weaponID = getPedWeapon(localPlayer)
		local divide = "|"
		if weaponID == 22 then
			weapName = tostring(getElementData(localPlayer,"currentweapon_2"))
			divide = "|"
			magsLeft()
		elseif weaponID == 23 then
		   weapName = tostring(getElementData(localPlayer,"currentweapon_2"))
			divide = "|"
			magsLeft()
		elseif weaponID == 24 then
			weapName = tostring(getElementData(localPlayer,"currentweapon_2"))
			divide = "|"
			magsLeft()
		elseif weaponID == 25 then
			weapName = tostring(getElementData(localPlayer,"currentweapon_1"))
			divide = "|"
			magsLeft()
		elseif weaponID == 26 then
		   weapName = tostring(getElementData(localPlayer,"currentweapon_1"))
			divide = "|"
			magsLeft()
		elseif weaponID == 27 then
			weapName = tostring(getElementData(localPlayer,"currentweapon_1"))
			divide = "|"
			magsLeft()
		elseif weaponID == 28 then
			weapName = tostring(getElementData(localPlayer,"currentweapon_2"))
			divide = "|"
			magsLeft()
		elseif weaponID == 29 then
			weapName = tostring(getElementData(localPlayer,"currentweapon_2"))
			divide = "|"
			magsLeft()
		elseif weaponID == 30 then
		   weapName = tostring(getElementData(localPlayer,"currentweapon_1"))
			divide = "|"
			magsLeft()
		elseif weaponID == 31 then
			weapName = tostring(getElementData(localPlayer,"currentweapon_1"))
			divide = "|"
			magsLeft()
		elseif weaponID == 33 then
			weapName = tostring(getElementData(localPlayer,"currentweapon_1"))
			divide = "|"
			magsLeft()
		elseif weaponID == 34 then
			weapName = tostring(getElementData(localPlayer,"currentweapon_1"))
			divide = "|"
			magsLeft()
		elseif weaponID == 16 then
			weapName = "Grenade"
			divide = "|"
		elseif weaponID == 43 then
			if getElementData(localPlayer,"currentweapon_2") == "Range Finder" then
				weapName = "Range Finder"
			else
				weapName = "Binoculars"
			end
			clip = ""
			ammo = ""
			divide = ""
		elseif weaponID == 44 then
			weapName = "NV Goggles"
			clip = ""
			ammo = ""
			divide = ""
		elseif weaponID == 45 then
			weapName = "IR Goggles"
			clip = ""
			ammo = ""
		elseif weaponID == 46 then
			weapName = "Parachute"
			clip = ""
			ammo = ""
			divide = ""
		elseif weaponID == 4 then
			weapName = "Hunting Knife"
			clip = ""
			ammo = ""
			divide = ""
		elseif weaponID == 5 then
			weapName = "Baseball Bat"
			clip = ""
			ammo = ""
			divide = ""
		elseif weaponID == 6 then
			weapName = "Shovel"
			clip = ""
			ammo = ""
			divide = ""
		elseif weaponID == 8 then
			weapName = "Hatchet"
			clip = ""
			ammo = ""
			divide = ""
		elseif weaponID == 0 then
			weapName = " "
			clip = ""
			ammo = ""
			divide = ""
		end
	dxDrawText(""..weapName,sWidth*0.675,sHeight*0.05833333333,sWidth*0.37,sHeight*0.46666666666,tocolor(0,255,0,255),1.0,font[1],"left","top",false,false,false)
	dxDrawText(""..clip.." "..divide.." "..ammo,sWidth*0.875,sHeight*0.09166666666,sWidth*0.37,sHeight*0.50166666666,tocolor(0,255,0,255),1.0,font[1],"left","top",false,false,false)
    end
end
addEventHandler("onClientRender",getRootElement(),WeaponHUD)

function magsLeft()
	dxDrawText(math.floor(getPedTotalAmmo (localPlayer) / getWeaponProperty(getPedWeapon( localPlayer ), "pro", "maximum_clip_ammo")) or 0,sWidth*0.9399999999,sHeight*0.093,sWidth*0.37,sHeight*0.50166666666,tocolor(0,255,0,255),.6,font[1],"left","top",false,false,false)
	dxDrawText(math.floor(getPedTotalAmmo (localPlayer) / getWeaponProperty(getPedWeapon( localPlayer ), "std", "maximum_clip_ammo")) or 0,sWidth*0.9399999999,sHeight*0.093,sWidth*0.37,sHeight*0.50166666666,tocolor(0,255,0,255),.6,font[1],"left","top",false,false,false)
	dxDrawText(math.floor(getPedTotalAmmo (localPlayer) / getWeaponProperty(getPedWeapon( localPlayer ), "poor", "maximum_clip_ammo")) or 0,sWidth*0.9399999999,sHeight*0.093,sWidth*0.37,sHeight*0.50166666666,tocolor(0,255,0,255),.6,font[1],"left","top",false,false,false)
end

statsLabel = {}
statsFont = guiCreateFont(":DayZ/fonts/bitstream.ttf",8)


statsWindows = guiCreateStaticImage(0.775,0.2,0.225,0.22,":DayZ/gui/gear/items/debug.png",true)
guiSetAlpha(statsWindows,0.9)
guiSetVisible(statsWindows,false)
--Zombies  Killed
statsLabel["zombieskilled"] = guiCreateLabel(0,0.05,1,0.15,"Zombies killed: 0",true,statsWindows)
guiLabelSetHorizontalAlign (statsLabel["zombieskilled"],"center")
guiSetFont (statsLabel["zombieskilled"], statsFont )
setElementData(statsLabel["zombieskilled"],"identifikation","zombieskilled")
--Headshots
statsLabel["headshots"] = guiCreateLabel(0,0.15,1,0.15,"Headshots: 0",true,statsWindows)
guiLabelSetHorizontalAlign (statsLabel["headshots"],"center")
guiSetFont (statsLabel["headshots"], statsFont )
setElementData(statsLabel["headshots"],"identifikation","headshots")
--Murders
statsLabel["murders"] = guiCreateLabel(0,0.25,1,0.15,"Murders: 0",true,statsWindows)
guiLabelSetHorizontalAlign (statsLabel["murders"],"center")
guiSetFont (statsLabel["murders"], statsFont )
setElementData(statsLabel["murders"],"identifikation","murders")
--Bandits Killed
statsLabel["banditskilled"] = guiCreateLabel(0,0.35,1,0.15,"Bandits killed: 0",true,statsWindows)
guiLabelSetHorizontalAlign (statsLabel["banditskilled"],"center")
guiSetFont (statsLabel["banditskilled"], statsFont )
setElementData(statsLabel["banditskilled"],"identifikation","banditskilled")
--Blood
statsLabel["blood"] = guiCreateLabel(0,0.45,1,0.15,"Blood: 12000 (Type: ?)",true,statsWindows)
guiLabelSetHorizontalAlign (statsLabel["blood"],"center")
guiSetFont (statsLabel["blood"], statsFont )
setElementData(statsLabel["blood"],"identifikation","blood")
--Zombies
statsLabel["zombies"] = guiCreateLabel(0,0.55,1,0.15,"Zombies (Alive/Total): 0/0",true,statsWindows)
guiLabelSetHorizontalAlign (statsLabel["zombies"],"center")
guiSetFont (statsLabel["zombies"], statsFont )
setElementData(statsLabel["zombies"],"identifikation","zombies")
--Temperature
statsLabel["temperature"] = guiCreateLabel(0,0.65,1,0.15,"Temperature: 37°C",true,statsWindows)
guiLabelSetHorizontalAlign (statsLabel["temperature"],"center")
guiSetFont (statsLabel["temperature"], statsFont )
setElementData(statsLabel["temperature"],"identifikation","temperature")
--Humanity
statsLabel["humanity"] = guiCreateLabel(0,0.75,1,0.15,"Humanity: 2500",true,statsWindows)
guiLabelSetHorizontalAlign (statsLabel["humanity"],"center")
guiSetFont (statsLabel["humanity"], statsFont )
setElementData(statsLabel["humanity"],"identifikation","humanity")
--Name
statsLabel["name"] = guiCreateLabel(0,0.85,1,0.15,"Name: "..getPlayerName(getLocalPlayer()):gsub("#%x%x%x%x%x%x", ""),true,statsWindows)
guiLabelSetHorizontalAlign (statsLabel["name"],"center")
guiSetFont (statsLabel["name"], statsFont )
setElementData(statsLabel["name"],"identifikation","name")

function showDebugMintorOnLogin ()
	if getElementData(localPlayer,"logedin") then
		guiSetVisible(statsWindows,true)
	end
end
addEvent("onClientPlayerDayZLogin", true)
addEventHandler("onClientPlayerDayZLogin", root, showDebugMintorOnLogin)

local isVisible = false
function showDebugMonitorOnF5()
	if getElementData(localPlayer,"logedin") then
		if not isVisible then
			guiSetVisible(statsWindows,true)
			isVisible = true
		else
			guiSetVisible(statsWindows,false)
			isVisible = false
		end
	else
		guiSetVisible(statsWindows,false)
	end
end
bindKey("F5","down",showDebugMonitorOnF5)

function showDebugMonitor()
	guiSetVisible(statsWindows,true)
	isVisible = true
end
addEvent("showDebugMonitor",true)
addEventHandler("showDebugMonitor",root,showDebugMonitor)

function hideDebugMonitor()
	guiSetVisible(statsWindows,false)
	isVisible = false
end
addEvent("hideDebugMonitor",true)
addEventHandler("hideDebugMonitor",root,hideDebugMonitor)

function refreshDebugMonitor()
	if getElementData(getLocalPlayer(),"logedin") then
		local zombieskilled = getElementData(getLocalPlayer(),getElementData(statsLabel["zombieskilled"],"identifikation"))
		guiSetText(statsLabel["zombieskilled"],"Zombies killed: "..zombieskilled)
		
		local headshots = getElementData(getLocalPlayer(),getElementData(statsLabel["headshots"],"identifikation"))
		guiSetText(statsLabel["headshots"],"Headshots: "..headshots)
		
		local banditskilled = getElementData(getLocalPlayer(),getElementData(statsLabel["banditskilled"],"identifikation"))
		guiSetText(statsLabel["banditskilled"],"Bandits killed: "..banditskilled)
		
		local murders = getElementData(getLocalPlayer(),getElementData(statsLabel["murders"],"identifikation"))
		guiSetText(statsLabel["murders"],"Murders: "..murders)
		
		local blood = getElementData(getLocalPlayer(),getElementData(statsLabel["blood"],"identifikation"))
		local bloodtype = getElementData(localPlayer,"bloodtypediscovered")
		guiSetText(statsLabel["blood"],"Blood: "..blood.." (Type: "..tostring(bloodtype)..")")
		
		local zombiesalive = getElementData(getRootElement(),"zombiesalive") or 0
		local zombiestotal = getElementData(getRootElement(),"zombiestotal") or 0
		guiSetText(statsLabel["zombies"],"Zombies (Alive/Total): "..zombiesalive.."/"..zombiestotal)
		
		local temperature = getElementData(getLocalPlayer(),getElementData(statsLabel["temperature"],"identifikation"))
		guiSetText(statsLabel["temperature"],"Temperature: "..math.round(temperature,2).."°C")
		
		local humanity = getElementData(getLocalPlayer(),getElementData(statsLabel["humanity"],"identifikation"))
		guiSetText(statsLabel["humanity"],"Humanity: "..math.round(humanity,2))
		
		guiSetText(statsLabel["name"],"Name: "..getPlayerName(getLocalPlayer()))
	end			
end
addEventHandler("onClientRender",root,refreshDebugMonitor)
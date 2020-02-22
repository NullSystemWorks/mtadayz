--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: hud_gear.lua							*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: CLIENT														*----
#-----------------------------------------------------------------------------#
]]

local sx, sy = guiGetScreenSize()
local alpha = 255
local font = {}
font[1] = dxCreateFont(":DayZ/fonts/bitstream.ttf", 10)

toggleControl ("radar",false)
setPlayerHudComponentVisible ("clock",false) 
setPlayerHudComponentVisible ("radar",false)
setPlayerHudComponentVisible ("money",false) 
setPlayerHudComponentVisible ("health",false) 
setPlayerHudComponentVisible ("weapon",false) 
setPlayerHudComponentVisible ("ammo",false)
setPlayerHudComponentVisible ("breath",false)

function toggleMap(key,state)
	if getElementData(localPlayer,"logedin") then
		local mapKey = getKeyBoundToCommand("radar")
		if key then
			if key == mapKey then
				if getElementData(localPlayer,"Map") > 0 then
					toggleControl("radar",true)
				else
					toggleControl("radar",false)
				end
			end
		end
	end
end
addEventHandler("onClientKey",root,toggleMap)

local gpsToggle = false
function toggleGPS(key)
	if getElementData(localPlayer,"logedin") then
		if getElementData(localPlayer,"GPS") > 0 then
			if not gpsToggle then
				setPlayerHudComponentVisible("radar",true)
				gpsToggle = true
			else
				setPlayerHudComponentVisible("radar",false)
				gpsToggle = false
			end
		end
	end	
end
bindKey("1","down",toggleGPS)

local watchToggle = false
function toggleWatch(key)
	if getElementData(localPlayer,"logedin") then
		if getElementData(getLocalPlayer(),"Watch") > 0 then
			if not watchToggle then
				addEventHandler("onClientRender",root,drawWatch)
				watchToggle = true
			else
				removeEventHandler("onClientRender",root,drawWatch)
				watchToggle = false
			end
			
		end
	end
end
bindKey("2","down",toggleWatch)

function drawWatch()
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
	dxDrawText(hour..":"..minutes,(screenW * 0.8287) - 1, (screenH * 0.1667) - 1, (screenW * 0.9550) - 1, (screenH * 0.1983) - 1, tocolor(0, 0, 0, 255), 1.00, font[1], "center", "center", false, false, false, false, false)
	dxDrawText(hour..":"..minutes,(screenW * 0.8287) + 1, (screenH * 0.1667) - 1, (screenW * 0.9550) + 1, (screenH * 0.1983) - 1, tocolor(0, 0, 0, 255), 1.00, font[1], "center", "center", false, false, false, false, false)
	dxDrawText(hour..":"..minutes,(screenW * 0.8287) - 1, (screenH * 0.1667) + 1, (screenW * 0.9550) - 1, (screenH * 0.1983) + 1, tocolor(0, 0, 0, 255), 1.00,  font[1], "center", "center", false, false, false, false, false)
	dxDrawText(hour..":"..minutes,(screenW * 0.8287) + 1, (screenH * 0.1667) + 1, (screenW * 0.9550) + 1, (screenH * 0.1983) + 1, tocolor(0, 0, 0, 255), 1.00,  font[1], "center", "center", false, false, false, false, false)			
	dxDrawText(hour..":"..minutes, screenW * 0.8287, screenH * 0.1667, screenW * 0.9550, screenH * 0.1983, tocolor(0, 255, 0, 255), 1.00,  font[1], "center", "center", false, false, false, false, false)
end

local compassToggle = false
function toggleCompass(key)
	if getElementData(localPlayer,"logedin") then
		if getElementData(getLocalPlayer(),"Compass") > 0 then
			if not compassToggle then
				addEventHandler("onClientRender",root,drawCompass)
				compassToggle = true
			else
				removeEventHandler("onClientRender",root,drawCompass)
				compassToggle = false
			end
			
		end
	end
end
bindKey("3","down",toggleCompass)

function drawCompass()
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

local nightVisionActive = false
local nightvisionimage = guiCreateStaticImage(0,0,1,1,":DayZ/gui/gear/items/nightvision.png",true)
guiSetVisible(nightvisionimage,false)

local infraredVisionActive = false
local infravision = guiCreateStaticImage(0,0,1,1,":DayZ/gui/gear/items/infravision.png",true)
guiSetVisible(infravision,false)

function activateGoggles(key,state)
	if getElementData(localPlayer,"logedin") then
		if key == "n" then
			if getElementData(localPlayer,"NV Goggles") > 0 then
				if nightVisionActive then
					guiSetVisible(nightvisionimage,false)
					guiSetVisible(infravision,false)
					showChat(true)
					setCameraGoggleEffect("normal")
					togglePlayerGoggles(false)
					nightVisionActive = false
				else
					guiSetVisible(nightvisionimage,true)
					guiSetVisible(infravision,false)
					showChat(false)
					setCameraGoggleEffect("nightvision")
					togglePlayerGoggles(true)
					nightVisionActive = true
				end
			end
		elseif key == "i" then
			if getElementData(getLocalPlayer(),"IR Goggles") > 0 then
				if infraredVisionActive then
					guiSetVisible(infravision,false)
					guiSetVisible(nightvisionimage,false)
					showChat(true)
					setCameraGoggleEffect("normal")
					togglePlayerGoggles(false)
					infraredVisionActive = false
				else 
					infraredVisionActive = true
					guiSetVisible(infravision,true)
					guiSetVisible(nightvisionimage,false)
					showChat(false)
					setCameraGoggleEffect("thermalvision")
					togglePlayerGoggles(true)
					infraredVisionActive = true
				end
			end
		end
	end
end
addEventHandler("onClientKey",root,activateGoggles)

local sWidth,sHeight = guiGetScreenSize()
function WeaponHUD()
	if getElementData(localPlayer,"logedin") then
		local ammo = 0
		local ammoType = ""
		local clip = 0
		local weaponID = getPedWeapon(localPlayer)
		local divide = "|"
		local weapName = ""
		if weaponID == 22 then
			if playerStatusTable[localPlayer]["currentweapon_2"] == "Flashlight" then
				weapName = "Flashlight"
				clip = ""
				ammo = ""
				divide = ""
			else
				weapName = tostring(playerStatusTable[localPlayer]["currentweapon_2"])
				ammoType = getWeaponAmmoFromName(weapName)
				ammo = getElementData(localPlayer,ammoType) - getPedAmmoInClip(localPlayer)
				clip = getPedAmmoInClip(localPlayer)
				divide = "|"
				magsLeft()
			end
		elseif weaponID == 23 then
			weapName = tostring(playerStatusTable[localPlayer]["currentweapon_2"])
			ammoType = getWeaponAmmoFromName(weapName)
			ammo = getElementData(localPlayer,ammoType) - getPedAmmoInClip(localPlayer)
			clip = getPedAmmoInClip(localPlayer)
			divide = "|"
			magsLeft()
		elseif weaponID == 24 then
			weapName = tostring(playerStatusTable[localPlayer]["currentweapon_2"])
			ammoType = getWeaponAmmoFromName(weapName)
			ammo = getElementData(localPlayer,ammoType) - getPedAmmoInClip(localPlayer)
			clip = getPedAmmoInClip(localPlayer)
			divide = "|"
			magsLeft()
		elseif weaponID == 25 then
			weapName = tostring(playerStatusTable[localPlayer]["currentweapon_1"])
			ammoType = getWeaponAmmoFromName(weapName)
			ammo = getElementData(localPlayer,ammoType) - getPedAmmoInClip(localPlayer)
			clip = getPedAmmoInClip(localPlayer)
			divide = "|"
			magsLeft()
		elseif weaponID == 26 then
			weapName = tostring(playerStatusTable[localPlayer]["currentweapon_1"])
			ammoType = getWeaponAmmoFromName(weapName)
			ammo = getElementData(localPlayer,ammoType) - getPedAmmoInClip(localPlayer)
			clip = getPedAmmoInClip(localPlayer)
			divide = "|"
			magsLeft()
		elseif weaponID == 27 then
			weapName = tostring(playerStatusTable[localPlayer]["currentweapon_1"])
			ammoType = getWeaponAmmoFromName(weapName)
			ammo = getElementData(localPlayer,ammoType) - getPedAmmoInClip(localPlayer)
			clip = getPedAmmoInClip(localPlayer)
			divide = "|"
			magsLeft()
		elseif weaponID == 28 then
			weapName = tostring(playerStatusTable[localPlayer]["currentweapon_2"])
			ammoType = getWeaponAmmoFromName(weapName)
			ammo = getElementData(localPlayer,ammoType) - getPedAmmoInClip(localPlayer)
			clip = getPedAmmoInClip(localPlayer)
			divide = "|"
			magsLeft()
		elseif weaponID == 29 then
			weapName = tostring(playerStatusTable[localPlayer]["currentweapon_2"])
			ammoType = getWeaponAmmoFromName(weapName)
			ammo = getElementData(localPlayer,ammoType) - getPedAmmoInClip(localPlayer)
			clip = getPedAmmoInClip(localPlayer)
			divide = "|"
			magsLeft()
		elseif weaponID == 30 then
			weapName = tostring(playerStatusTable[localPlayer]["currentweapon_1"])
			ammoType = getWeaponAmmoFromName(weapName)
			ammo = getElementData(localPlayer,ammoType) - getPedAmmoInClip(localPlayer)
			clip = getPedAmmoInClip(localPlayer)
			divide = "|"
			magsLeft()
		elseif weaponID == 31 then
			weapName = tostring(playerStatusTable[localPlayer]["currentweapon_1"])
			ammoType = getWeaponAmmoFromName(weapName)
			ammo = getElementData(localPlayer,ammoType) - getPedAmmoInClip(localPlayer)
			clip = getPedAmmoInClip(localPlayer)
			divide = "|"
			magsLeft()
		elseif weaponID == 33 then
			weapName = tostring(playerStatusTable[localPlayer]["currentweapon_1"])
			ammoType = getWeaponAmmoFromName(weapName)
			ammo = getElementData(localPlayer,ammoType) - getPedAmmoInClip(localPlayer)
			clip = getPedAmmoInClip(localPlayer)
			divide = "|"
			magsLeft()
		elseif weaponID == 34 then
			weapName = tostring(playerStatusTable[localPlayer]["currentweapon_1"])
			ammoType = getWeaponAmmoFromName(weapName)
			ammo = getElementData(localPlayer,ammoType) - getPedAmmoInClip(localPlayer)
			clip = getPedAmmoInClip(localPlayer)
			divide = "|"
			magsLeft()
		elseif weaponID == 16 then
			weapName = "Grenade"
			divide = "|"
		elseif weaponID == 43 then
			if playerStatusTable[localPlayer]["currentweapon_2"] == "Range Finder" then
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
		elseif weaponID == 2 then
			weapName = "Crowbar"
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

local statsLabel = {}
local statsFont = guiCreateFont(":DayZ/fonts/bitstream.ttf",8)


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

function showDebugMintorOnLogin()
	if getElementData(localPlayer,"logedin") then
		if (gameplayVariables["debugmonitorenabled"]) then
			guiSetVisible(statsWindows,true)
		end
	end
end
addEvent("onClientPlayerDayZLogin", true)
addEventHandler("onClientPlayerDayZLogin", root, showDebugMintorOnLogin)

local isDebugMonitorActive = false
function showDebugMonitorOnF5()
	if getElementData(localPlayer,"logedin") then
		if gameplayVariables["debugmonitorenabled"] then
			isDebugMonitorActive = not isDebugMonitorActive
			guiSetVisible(statsWindows,isDebugMonitorActive)
		end
	end
end

if (gameplayVariables["debugmonitorenabled"]) then 
	bindKey("F5","down",showDebugMonitorOnF5)
end

function toggleDebugMonitorOnInventory(state)
	isDebugMonitorActive = state
	guiSetVisible(statsWindows,state)
end

function refreshDebugMonitor()
	if getElementData(getLocalPlayer(),"logedin") then
		if playerStatusTable[localPlayer] then
			guiSetText(statsLabel["zombieskilled"],"Zombies killed: "..tostring(playerStatusTable[localPlayer]["killedZombies"]))
			
			guiSetText(statsLabel["headshots"],"Headshots: "..tostring(playerStatusTable[localPlayer]["headshots"]))
			
			guiSetText(statsLabel["banditskilled"],"Bandits killed: "..tostring(playerStatusTable[localPlayer]["killedBandits"]))

			guiSetText(statsLabel["murders"],"Murders: "..tostring(playerStatusTable[localPlayer]["murders"]))
			
			guiSetText(statsLabel["blood"],"Blood: "..tostring(playerStatusTable[localPlayer]["blood"]).." (Type: "..tostring(playerStatusTable[localPlayer]["bloodtypediscovered"])..")")
			
			local zombiesalive = getElementData(getRootElement(),"zombiesalive") or 0
			local zombiestotal = getElementData(getRootElement(),"zombiestotal") or 0
			guiSetText(statsLabel["zombies"],"Zombies (Alive/Total): "..zombiesalive.."/"..zombiestotal)
			
			guiSetText(statsLabel["temperature"],"Temperature: "..math.round(playerStatusTable[localPlayer]["temperature"],2).."°C")
			
			guiSetText(statsLabel["humanity"],"Humanity: "..math.round(playerStatusTable[localPlayer]["humanity"],2))
			
			guiSetText(statsLabel["name"],"Name: "..getPlayerName(getLocalPlayer()))
		end
	end			
end
setTimer(refreshDebugMonitor,1000,0)

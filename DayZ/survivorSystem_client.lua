--[[
#---------------------------------------------------------------#
----*			DayZ MTA Script survivor_system.lua			*----
----* This Script is owned by Marwin, you are not allowed to use or own it.
----* Owner: Marwin W., Germany, Lower Saxony, Otterndorf
----* Skype: xxmavxx96
----*														*----
#---------------------------------------------------------------#
]]

--version drawing
addEventHandler("onClientResourceStart", getResourceRootElement(),
	function()
		dayzVersion = "MTA:DayZ 0.9.0a"
		versionLabel  = guiCreateLabel(1,1,0.3,0.3,dayzVersion,true)
		guiSetSize ( versionLabel, guiLabelGetTextExtent ( versionLabel ), guiLabelGetFontHeight ( versionLabel ), false )
		x,y = guiGetSize(versionLabel,true)
		guiSetPosition( versionLabel, 1-x, 1-y*1.8, true )
		guiSetAlpha(versionLabel,0.5)
	end
)

--disable ped targeting markers
setPedTargetingMarkerEnabled(false)

--Survivor Skins
--Sniper
snipertxd = engineLoadTXD ("mods/playerskins/sniper.txd");
engineImportTXD (snipertxd, 285);
sniperdff = engineLoadDFF ("mods/playerskins/sniper.dff", 285);
engineReplaceModel (sniperdff, 285);
--Civilian
snipertxd = engineLoadTXD ("mods/playerskins/civilian.txd");
engineImportTXD (snipertxd, 179);
sniperdff = engineLoadDFF ("mods/playerskins/civilian.dff", 179);
engineReplaceModel (sniperdff, 179);
--Bandit1
snipertxd = engineLoadTXD ("mods/playerskins/bandit3.txd");
engineImportTXD (snipertxd, 180);
sniperdff = engineLoadDFF ("mods/playerskins/bandit3.dff", 180);
engineReplaceModel (sniperdff, 180);
--Bandit2
snipertxd = engineLoadTXD ("mods/playerskins/bandit2.txd");
engineImportTXD (snipertxd, 288);
sniperdff = engineLoadDFF ("mods/playerskins/bandit2.dff", 288);
engineReplaceModel (sniperdff, 288);
--Standard
snipertxd = engineLoadTXD ("mods/playerskins/standart.txd");
engineImportTXD (snipertxd, 73);
sniperdff = engineLoadDFF ("mods/playerskins/standart.dff", 73);
engineReplaceModel (sniperdff, 73);
--Hero
snipertxd = engineLoadTXD ("mods/playerskins/hero.txd");
engineImportTXD (snipertxd, 210);
sniperdff = engineLoadDFF ("mods/playerskins/hero.dff", 210);
engineReplaceModel (sniperdff, 210);
-- Army
snipertxd = engineLoadTXD ("mods/playerskins/army.txd");
engineImportTXD (snipertxd, 287);
sniperdff = engineLoadDFF ("mods/playerskins/army.dff", 287);
engineReplaceModel (sniperdff, 287);
--Standard (Female)
snipertxd = engineLoadTXD ("mods/playerskins/femalestandard.txd");
engineImportTXD (snipertxd, 192);
sniperdff = engineLoadDFF ("mods/playerskins/femalestandard.dff", 192);
engineReplaceModel (sniperdff, 192);
--Civilian (Female)
snipertxd = engineLoadTXD ("mods/playerskins/civilian_female.txd");
engineImportTXD (snipertxd, 172);
sniperdff = engineLoadDFF ("mods/playerskins/civilian_female.dff", 172);
engineReplaceModel (sniperdff, 172);
-- Bandit 1 (Female)
snipertxd = engineLoadTXD ("mods/playerskins/bandit_female1.txd");
engineImportTXD (snipertxd, 191);
sniperdff = engineLoadDFF ("mods/playerskins/bandit_female1.dff", 191);
engineReplaceModel (sniperdff, 191);
-- Bandit 2 (Female)
snipertxd = engineLoadTXD ("mods/playerskins/bandit_female2.txd");
engineImportTXD (snipertxd, 211);
sniperdff = engineLoadDFF ("mods/playerskins/bandit_female2.dff", 211);
engineReplaceModel (sniperdff, 211);


--Items

itemTXD = engineLoadTXD ("items/army_clothes.txd");
engineImportTXD (itemTXD, 1247);
itemDFF = engineLoadDFF ("items/army_clothes.dff", 1247);
engineReplaceModel (itemDFF, 1247);

itemTXD = engineLoadTXD ("items/sniper_clothes.txd");
engineImportTXD (itemTXD, 1213);
itemDFF = engineLoadDFF ("items/sniper_clothes.dff", 1213);
engineReplaceModel (itemDFF, 1213);

itemTXD = engineLoadTXD ("items/civilian_clothes.txd");
engineImportTXD (itemTXD, 1241);
itemDFF = engineLoadDFF ("items/civilian_clothes.dff", 1241);
engineReplaceModel (itemDFF, 1241);

itemTXD = engineLoadTXD ("items/standard_clothes.txd");
engineImportTXD (itemTXD, 1577);
itemDFF = engineLoadDFF ("items/standard_clothes.dff", 1577);
engineReplaceModel (itemDFF, 1577);

itemTXD = engineLoadTXD ("items/beans_can.txd");
engineImportTXD (itemTXD, 2601);
itemDFF = engineLoadDFF ("items/beans_can.dff", 2601);
engineReplaceModel (itemDFF, 2601);

itemTXD = engineLoadTXD ("items/first_aid_kit.txd");
engineImportTXD (itemTXD, 2891);
itemDFF = engineLoadDFF ("items/first_aid_kit.dff", 2891);
engineReplaceModel (itemDFF, 2891);

itemTXD = engineLoadTXD ("items/heat_pack.txd");
engineImportTXD (itemTXD, 1576);
itemDFF = engineLoadDFF ("items/heat_pack.dff", 1576);
engineReplaceModel (itemDFF, 1576);

itemTXD = engineLoadTXD ("items/pain_killers.txd");
engineImportTXD (itemTXD, 2709);
itemDFF = engineLoadDFF ("items/pain_killers.dff", 2709);
engineReplaceModel (itemDFF, 2709);

itemTXD = engineLoadTXD ("items/pasta_can.txd");
engineImportTXD (itemTXD, 2770);
itemDFF = engineLoadDFF ("items/pasta_can.dff", 2770);
engineReplaceModel (itemDFF, 2770);

itemTXD = engineLoadTXD ("items/pistol_ammo.txd");
engineImportTXD (itemTXD, 3013);
itemDFF = engineLoadDFF ("items/pistol_ammo.dff", 3013);
engineReplaceModel (itemDFF, 3013);

itemTXD = engineLoadTXD ("items/shotgun_ammo.txd");
engineImportTXD (itemTXD, 2358);
itemDFF = engineLoadDFF ("items/shotgun_ammo.dff", 2358);
engineReplaceModel (itemDFF, 2358);

itemTXD = engineLoadTXD ("items/backpack_small.txd");
engineImportTXD (itemTXD, 3026);
itemDFF = engineLoadDFF ("items/backpack_small.dff", 3026);
engineReplaceModel (itemDFF, 3026);

itemTXD = engineLoadTXD ("items/smg_ammo.txd");
engineImportTXD (itemTXD, 2041);
itemDFF = engineLoadDFF ("items/smg_ammo.dff", 2041);
engineReplaceModel (itemDFF, 2041);

itemTXD = engineLoadTXD ("items/sniper_ammo.txd");
engineImportTXD (itemTXD, 2358);
itemDFF = engineLoadDFF ("items/sniper_ammo.dff", 2358);
engineReplaceModel (itemDFF, 2358);

itemTXD = engineLoadTXD ("items/soda_can.txd");
engineImportTXD (itemTXD, 2647);
itemDFF = engineLoadDFF ("items/soda_can.dff", 2647);
engineReplaceModel (itemDFF, 2647);

itemTXD = engineLoadTXD ("items/water_bottle.txd");
engineImportTXD (itemTXD, 2683);
itemDFF = engineLoadDFF ("items/water_bottle.dff", 2683);
engineReplaceModel (itemDFF, 2683);

itemTXD = engineLoadTXD ("items/assault_ammo.txd");
engineImportTXD (itemTXD, 1271);
itemDFF = engineLoadDFF ("items/assault_ammo.dff", 1271);
engineReplaceModel (itemDFF, 1271);

itemTXD = engineLoadTXD ("items/backpack_alice.txd");
engineImportTXD (itemTXD, 1248);
itemDFF = engineLoadDFF ("items/backpack_alice.dff", 1248);
engineReplaceModel (itemDFF, 1248);

itemTXD = engineLoadTXD ("items/backpack_coyote.txd");
engineImportTXD (itemTXD, 1252);
itemDFF = engineLoadDFF ("items/backpack_coyote.dff", 1252);
engineReplaceModel (itemDFF, 1252);

itemTXD = engineLoadTXD ("items/backpack_czech.txd");
engineImportTXD (itemTXD, 1575);
itemDFF = engineLoadDFF ("items/backpack_czech.dff", 1575);
engineReplaceModel (itemDFF, 1575);

itemTXD = engineLoadTXD ("items/backpack_ghillie.txd");
engineImportTXD (itemTXD, 1275);
itemDFF = engineLoadDFF ("items/backpack_ghillie.dff", 1275);
engineReplaceModel (itemDFF, 1275);

itemTXD = engineLoadTXD ("items/backpack_os.txd");
engineImportTXD (itemTXD, 1644);
itemDFF = engineLoadDFF ("items/backpack_os.dff", 1644);
engineReplaceModel (itemDFF, 1644);

itemTXD = engineLoadTXD ("items/tent.txd");
engineImportTXD (itemTXD, 3243);
itemDFF = engineLoadDFF ("items/tent.dff", 3243);
engineReplaceModel (itemDFF, 3243);
itemCOL = engineLoadCOL("items/tent.col");
engineReplaceCOL(itemCOL,3243);

itemTXD = engineLoadTXD ("items/wirefence.txd");
engineImportTXD (itemTXD, 983);
itemDFF = engineLoadDFF ("items/wirefence.dff", 983);
engineReplaceModel (itemDFF, 983);

itemTXD = engineLoadTXD ("items/windscreenglass.txd");
engineImportTXD (itemTXD, 3104);
itemDFF = engineLoadDFF ("items/windscreenglass.dff", 3104);
engineReplaceModel (itemDFF, 3104);

-- Camera -> Binoculars
weaponTXD = engineLoadTXD ("items/camera.txd");
engineImportTXD (weaponTXD, 367);
weaponDFF = engineLoadDFF ("items/camera.dff", 367);
engineReplaceModel (weaponDFF, 367);

-- Katana -> Hatchet
weaponTXD = engineLoadTXD ("items/katana.txd");
engineImportTXD (weaponTXD, 339);
weaponDFF = engineLoadDFF ("items/katana.dff", 339);
engineReplaceModel (weaponDFF, 339);

-- Knife -> Better Knife
weaponTXD = engineLoadTXD("mods/weapons/knife.txd");
engineImportTXD(weaponTXD, 335);
weaponDFF = engineLoadDFF("mods/weapons/knife.dff", 355);
engineReplaceModel(weaponDFF, 335);

local function getRotationOfCamera()
    local px, py, pz, lx, ly, lz = getCameraMatrix()
    local rotz = 6.2831853071796 - math.atan2 ( ( lx - px ), ( ly - py ) ) % 6.2831853071796
    local rotx = math.atan2 ( lz - pz, getDistanceBetweenPoints2D ( lx, ly, px, py ) )
    --Convert to degrees
    rotx = math.deg(rotx)
    rotz = -math.deg(rotz)	
    return rotx, 180, rotz
end

function findRotation(x1,y1,x2,y2) 
  local t = -math.deg(math.atan2(x2-x1,y2-y1))
  if t < 0 then t = t + 360 end;
  return t;
end
function getPointFromDistanceRotation(x, y, dist, angle)
    local a = math.rad(90 - angle);
    local dx = math.cos(a) * dist;
    local dy = math.sin(a) * dist;
    return x+dx, y+dy;
end


local enableBlips = true
local renderNorthBlip = false
local alwaysRenderMap = false
local worldmap
local gpsborder
local alpha = 255

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
			--toggleControl ("radar",true)
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
			if (not isPlayerMapVisible()) then
				local mW, mH = dxGetMaterialSize(rt)
				local x, y = getElementPosition(localPlayer)
				local X, Y = mW/2 -(x/(6000/(3200))), mH/2 +(y/(6000/(3072)))
				local camX,camY,camZ = getElementRotation(getCamera())
				dxSetRenderTarget(rt, true)
				if alwaysRenderMap or getElementInterior(localPlayer) == 0 then
					dxDrawRectangle(0, 0, mW, mH, tocolor(124, 167, 209,alpha)) --render background
					worldmap = dxDrawImage(X - (3072)/2, mH/5 + (Y - 3072/2), 3072, 3072, "images/world.png", camZ, (x/(6000/(3072))), -(y/(6000/3072)), tocolor(255, 255, 255, alpha))
				end
				dxSetRenderTarget()
				gpsborder = dxDrawImage((10)*xFactor, sy-((200+10))*yFactor, (300)*xFactor, (200)*yFactor, "images/gps.png",0,0,0,tocolor(255,255,255,alpha),true)
				--dxDrawRectangle((10)*xFactor, sy-((200+10))*yFactor, (300)*xFactor, (200)*yFactor, tocolor(0, 0, 0, 175))
				dxDrawImage((10+15)*xFactor, sy-((200+5))*yFactor, (300-30)*xFactor, (175)*yFactor, rt, 0, 0, 0, tocolor(255, 255, 255, alpha))
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
						dxDrawImage(bpx -(blip*bS)*xFactor/2, bpy -(blip*bS)*yFactor/2, (blip*bS)*xFactor, (blip*bS)*yFactor, "image/blip/"..bid..".png", 0, 0, 0, tocolor(bcR, bcG, bcB, alpha))
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
						dxDrawImage(bpx -(blip*2)/2, bpy -(blip*2)/2, blip*2, blip*2, "images/blip/4.png", 0, 0, 0) --draw north (4) blip
					end
				end
				dxDrawImage(cX -(blip*2)*xFactor/2, cY -(blip*2)*yFactor/2, (blip*2)*xFactor, (blip*2)*yFactor, "images/player.png", camZ-rz, 0, 0, tocolor(255,30,0,alpha))
			end
		else
			dxSetRenderTarget()
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
			local sWidth,sHeight = guiGetScreenSize()
			dxDrawText(""..hour.."   ",sWidth*0.09625,sHeight*0.94333333333,sWidth*0.37,sHeight*0.46666666666,tocolor(0,255,0,255),1.3,"clear-normal","left","top",false,false,false)
			dxDrawText(" : ",sWidth*0.118125,sHeight*0.94333333333,sWidth*0.37,sHeight*0.46666666666,tocolor(0,255,0,255),1.3,"clear-normal","left","top",false,false,false)
			dxDrawText("   "..minutes,sWidth*0.12125,sHeight*0.94333333333,sWidth*0.37,sHeight*0.46666666666,tocolor(0,255,0,255),1.3,"clear-normal","left","top",false,false,false)
		end
		if getElementData(getLocalPlayer(),"Compass") >= 1 then
			local rx,ry,rz = getRotationOfCamera(localPlayer)
			local sWidth,sHeight = guiGetScreenSize()
			compass_border = dxDrawImage(sWidth*0.065,sHeight*0.57,sWidth*0.16,sHeight*0.18, "images/compassborder.png" )
			compass_arrow = dxDrawImage(sWidth*0.064,sHeight*0.58,sWidth*0.151,sHeight*0.16, "images/compassarrow.png", rz )
		end
	end
end
addEventHandler("onClientRender",root,playerDrawMapGPSCompass)

local isMapShown = false

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

function drawTheMap()
	local x, y = getElementPosition(localPlayer)
	local X, Y = sx/2 -(x/(6000/(worldW-200))), sy/2 + (y/(6000/(worldH-200)))
	local camX,camY,camZ = getElementRotation(getCamera())
	--dxSetRenderTarget(rt, true)
	if alwaysRenderMap or getElementInterior(localPlayer) == 0 then
		dxDrawRectangle(0, 0, sx, sy, tocolor(176, 200, 210,255))
		dxDrawImage(X - worldW/2, Y - worldH/2, worldW, worldH, "images/world.png", 0, (x/(6000/worldW)), -(y/(6000/worldH)), tocolor(255, 255, 255, 255))
	end
	--dxSetRenderTarget()
	--dxDrawImage(sx * 0.000, sy * 0.0000, sx * 1.0000, sy * 1.0000, rt_map, 0, 0, 0, tocolor(255, 255, 255, alpha))
	local col = tocolor(r, g, b, 190)
	local bg = tocolor(r, g, b, 100)
	local rx, ry, rz = getElementRotation(localPlayer)
	local lB = (15)*xFactor
	local rB = (15+sx/2)*xFactor
	local tB = (sy/2)-(205)*yFactor
	local bB = tB + (sy)*yFactor
	local cX, cY = (rB+lB)/2, (tB+bB)/2 +(35)*yFactor
	local toLeft, toTop, toRight, toBottom = cX-lB, cY-tB, rB-cX, bB-cY
	dxDrawImage(sx * 0.5, sy * 0.5, (blip*2)*xFactor, (blip*2)*yFactor, "images/player.png", camZ-rz, 0, 0, tocolor(255,30,0,255))
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


nightvisionimage = guiCreateStaticImage(0,0,1,1,"images/nightvision.png",true)
guiSetVisible(nightvisionimage,false)

infravision = guiCreateStaticImage(0,0,1,1,"images/infravision.png",true)
guiSetVisible(infravision,false)

function playerZoom (key,keyState)
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
bindKey("n","down",playerZoom)
bindKey("i","up",playerZoom)

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

local citysounds = {"sounds/ambience/helicopter.mp3"}

local ambiencesounds = {
	"sounds/ambience/ambience_1.ogg",
	"sounds/ambience/ambience_2.ogg",
	"sounds/ambience/ambience_3.ogg",
	"sounds/ambience/ambience_4.ogg",
	"sounds/ambience/ambience_5.ogg",
	"sounds/ambience/ambience_6.ogg",
	"sounds/ambience/ambience_7.ogg",
	"sounds/ambience/ambience_8.ogg",
	"sounds/ambience/ambience_9.ogg",
	"sounds/ambience/ambience_10.ogg",
	"sounds/ambience/ambience_11.ogg",
	"sounds/ambience/ambience_12.ogg",
	"sounds/ambience/ambience_13.ogg",
	"sounds/ambience/ambience_14.ogg",
	"sounds/ambience/ambience_15.ogg",
	"sounds/ambience/ambience_16.ogg",
}

function playAmbienceMusic()
	if getElementData(localPlayer,"logedin") then
		playSound(ambiencesounds[math.random(1,#ambiencesounds)],false)
	end
end
setTimer(playAmbienceMusic,65000,0)

function PlayCityAmbience()
local x,y,z = getElementPosition(localPlayer)
local city = getZoneName(x,y,z)
	if city == "Los Santos" or city == "Las Venturas" or city == "San Fierro" then
		playSound("sounds/ambience4.mp3",false)
	else return end
end
setTimer(PlayCityAmbience,300000,0)


--------------------------------------------------------
--Player Stats										  --
--------------------------------------------------------
function getGroundMaterial(x, y, z)
	local hit, hitX, hitY, hitZ, hitElement, normalX, normalY, normalZ, material = processLineOfSight(x, y, z, x, y, z-10, true, false, false, true, false, false, false, false, nil)
	return material
end

function isInBuilding(x, y, z)
	local hit, hitX, hitY, hitZ, hitElement, normalX, normalY, normalZ, material = processLineOfSight(x, y, z, x, y, z+10, true, false, false, true, false, false, false, false, nil)
	if hit then return true end
	return false
end

function isObjectAroundPlayer2 ( thePlayer, distance, height )
	material_value = 0
	local x, y, z = getElementPosition( thePlayer )
	for i = math.random(0,360), 360, 1 do
		local nx, ny = getPointFromDistanceRotation( x, y, distance, i )
		local hit, hitX, hitY, hitZ, hitElement, normalX, normalY, normalZ, material = processLineOfSight ( x, y, z + height, nx, ny, z + height,true,false,false,false,false,false,false,false )
		if material == 0 then
			material_value = material_value+1
		end
		if material_value > 40 then
			return 0,hitX, hitY, hitZ
		end
	end
	return false
end

function isObjectAroundPlayer ( thePlayer, distance, height )
	local x, y, z = getElementPosition( thePlayer )
	for i = math.random(0,360), 360, 1 do
		local nx, ny = getPointFromDistanceRotation( x, y, distance, i )
		local hit, hitX, hitY, hitZ, hitElement, normalX, normalY, normalZ, material = processLineOfSight ( x, y, z + height, nx, ny, z + height)
		if material == 0 then
			return material,hitX, hitY, hitZ
		end
	end
	return false
end

function getPointFromDistanceRotation ( x, y, dist, angle )
    local a = math.rad( 90 - angle )
    local dx = math.cos( a ) * dist
    local dy = math.sin( a ) * dist
    return x + dx, y + dy
end


function zombieSpawning()
	local x, y, z = getElementPosition(getLocalPlayer())
	local material,hitX, hitY, hitZ = isObjectAroundPlayer2 ( getLocalPlayer(), 30, 3 )
	if material == 0 and not isInBuilding(x,y,z) then
		triggerServerEvent("createZomieForPlayer",getLocalPlayer(),hitX, hitY, hitZ)
	end
end
setTimer(zombieSpawning,3000,0)

--ALL ZOMBIES STFU
function stopZombieSound()
	local zombies = getElementsByType ( "ped" )
	for theKey,theZomb in ipairs(zombies) do
		setPedVoice(theZomb, "PED_TYPE_DISABLED")
	end
end
setTimer(stopZombieSound,1000,0)

function stopPlayerVoices()
	setPedVoice(localPlayer, "PED_TYPE_DISABLED")
end
addEventHandler("onClientPlayerSpawn",localPlayer,stopPlayerVoices)

function WeaponHUD()
if getElementData(getLocalPlayer(),"logedin") then
    ammo = getPedTotalAmmo (getLocalPlayer())
    clip = getPedAmmoInClip (getLocalPlayer())
    weaponID = getPedWeapon(getLocalPlayer())
	local sWidth,sHeight = guiGetScreenSize()
    if weaponID == 22 then
		if getElementData(localPlayer,"currentweapon_2") == "M1911" then
			weapName = "M1911"
			dxDrawText(""..clip.." | "..ammo,sWidth*0.875,sHeight*0.09166666666,sWidth*0.37,sHeight*0.50166666666,tocolor(0,255,0,255),1.3,"clear-normal","left","top",false,false,false)
		elseif getElementData(localPlayer,"currentweapon_2") == "G17" then
			weapName = "G17"
			dxDrawText(""..clip.." | "..ammo,sWidth*0.875,sHeight*0.09166666666,sWidth*0.37,sHeight*0.50166666666,tocolor(0,255,0,255),1.3,"clear-normal","left","top",false,false,false)
		end
    elseif weaponID == 23 then
        weapName = "M9 SD"
		dxDrawText(""..clip.." | "..ammo,sWidth*0.875,sHeight*0.09166666666,sWidth*0.37,sHeight*0.50166666666,tocolor(0,255,0,255),1.3,"clear-normal","left","top",false,false,false)
    elseif weaponID == 24 then
		if getElementData(localPlayer,"currentweapon_2") == "Desert Eagle" then
			weapName = "Desert Eagle"
			dxDrawText(""..clip.." | "..ammo,sWidth*0.875,sHeight*0.09166666666,sWidth*0.37,sHeight*0.50166666666,tocolor(0,255,0,255),1.3,"clear-normal","left","top",false,false,false)
		elseif getElementData(localPlayer,"currentweapon_2") == "Revolver" then
			weapName = "Revolver"
			dxDrawText(""..clip.." | "..ammo,sWidth*0.875,sHeight*0.09166666666,sWidth*0.37,sHeight*0.50166666666,tocolor(0,255,0,255),1.3,"clear-normal","left","top",false,false,false)
		end
    elseif weaponID == 25 then
		if getElementData(localPlayer,"currentweapon_1") == "Winchester 1866" then
			weapName = "Winchester 1866"
			dxDrawText(""..clip.." | "..ammo,sWidth*0.875,sHeight*0.09166666666,sWidth*0.37,sHeight*0.50166666666,tocolor(0,255,0,255),1.3,"clear-normal","left","top",false,false,false)
		elseif getElementData(localPlayer,"currentweapon_1") == "Crossbow" then
			weapName = "Crossbow"
			dxDrawText(""..clip.." | "..ammo,sWidth*0.875,sHeight*0.09166666666,sWidth*0.37,sHeight*0.50166666666,tocolor(0,255,0,255),1.3,"clear-normal","left","top",false,false,false)
		elseif getElementData(localPlayer,"currentweapon_1") == "Blaze 95 Double Rifle" then
			weapName = "Blaze 95 D. Rifle"
			dxDrawText(""..clip.." | "..ammo,sWidth*0.875,sHeight*0.09166666666,sWidth*0.37,sHeight*0.50166666666,tocolor(0,255,0,255),1.3,"clear-normal","left","top",false,false,false)
		end
    elseif weaponID == 26 then
        weapName = "Sawn-Off Shotgun"
		dxDrawText(""..clip.." | "..ammo,sWidth*0.875,sHeight*0.09166666666,sWidth*0.37,sHeight*0.50166666666,tocolor(0,255,0,255),1.3,"clear-normal","left","top",false,false,false)
    elseif weaponID == 27 then
		if getElementData(localPlayer,"currentweapon_1") == "SPAZ-12 Combat Shotgun" then
			weapName = "SPAZ-12 C. Shotgun"
		dxDrawText(""..clip.." | "..ammo,sWidth*0.875,sHeight*0.09166666666,sWidth*0.37,sHeight*0.50166666666,tocolor(0,255,0,255),1.3,"clear-normal","left","top",false,false,false)
		elseif getElementData(localPlayer,"currentweapon_1") == "Remington 870" then
			weapName = "Remington 870"
			dxDrawText(""..clip.." | "..ammo,sWidth*0.875,sHeight*0.09166666666,sWidth*0.37,sHeight*0.50166666666,tocolor(0,255,0,255),1.3,"clear-normal","left","top",false,false,false)
		end
    elseif weaponID == 28 then
        weapName = "PDW"
		dxDrawText(""..clip.." | "..ammo,sWidth*0.875,sHeight*0.09166666666,sWidth*0.37,sHeight*0.50166666666,tocolor(0,255,0,255),1.3,"clear-normal","left","top",false,false,false)
    elseif weaponID == 29 then
		if getElementData(localPlayer,"currentweapon_2") == "MP5A5" then
			weapName = "MP5A5"
			dxDrawText(""..clip.." | "..ammo,sWidth*0.875,sHeight*0.09166666666,sWidth*0.37,sHeight*0.50166666666,tocolor(0,255,0,255),1.3,"clear-normal","left","top",false,false,false)
		elseif getElementData(localPlayer,"currentweapon_2") == "Bizon PP-19" then
			weapName = "Bizon PP-19"
			dxDrawText(""..clip.." | "..ammo,sWidth*0.875,sHeight*0.09166666666,sWidth*0.37,sHeight*0.50166666666,tocolor(0,255,0,255),1.3,"clear-normal","left","top",false,false,false)
		end
    elseif weaponID == 30 then
        if getElementData(localPlayer,"currentweapon_1") == "AK-47" then
			weapName = "AK-47"
			dxDrawText(""..clip.." | "..ammo,sWidth*0.875,sHeight*0.09166666666,sWidth*0.37,sHeight*0.50166666666,tocolor(0,255,0,255),1.3,"clear-normal","left","top",false,false,false)
		elseif getElementData(localPlayer,"currentweapon_1") == "FN FAL" then
			weapName = "FN FAL"
			dxDrawText(""..clip.." | "..ammo,sWidth*0.875,sHeight*0.09166666666,sWidth*0.37,sHeight*0.50166666666,tocolor(0,255,0,255),1.3,"clear-normal","left","top",false,false,false)
		elseif getElementData(localPlayer,"currentweapon_1") == "G36C" then
			weapName = "G36C"
			dxDrawText(""..clip.." | "..ammo,sWidth*0.875,sHeight*0.09166666666,sWidth*0.37,sHeight*0.50166666666,tocolor(0,255,0,255),1.3,"clear-normal","left","top",false,false,false)
		elseif getElementData(localPlayer,"currentweapon_1") == "Sa58V CCO" then
			weapName = "Sa58V CCO"
			dxDrawText(""..clip.." | "..ammo,sWidth*0.875,sHeight*0.09166666666,sWidth*0.37,sHeight*0.50166666666,tocolor(0,255,0,255),1.3,"clear-normal","left","top",false,false,false)
		end
    elseif weaponID == 31 then
		weapName = "M4"
		dxDrawText(""..clip.." | "..ammo,sWidth*0.875,sHeight*0.09166666666,sWidth*0.37,sHeight*0.50166666666,tocolor(0,255,0,255),1.3,"clear-normal","left","top",false,false,false)
    elseif weaponID == 33 then
		if getElementData(localPlayer,"currentweapon_1") == "Lee Enfield" then
			weapName = "Lee Enfield"
			dxDrawText(""..clip.." | "..ammo,sWidth*0.875,sHeight*0.09166666666,sWidth*0.37,sHeight*0.50166666666,tocolor(0,255,0,255),1.3,"clear-normal","left","top",false,false,false)
		elseif getElementData(localPlayer,"currentweapon_1") == "Sporter 22" then
			weapName = "Sporter 22"
			dxDrawText(""..clip.." | "..ammo,sWidth*0.875,sHeight*0.09166666666,sWidth*0.37,sHeight*0.50166666666,tocolor(0,255,0,255),1.3,"clear-normal","left","top",false,false,false)
		elseif getElementData(localPlayer,"currentweapon_1") == "Mosin 9130" then
			weapName = "Mosin 9130"
			dxDrawText(""..clip.." | "..ammo,sWidth*0.875,sHeight*0.09166666666,sWidth*0.37,sHeight*0.50166666666,tocolor(0,255,0,255),1.3,"clear-normal","left","top",false,false,false)
		elseif getElementData(localPlayer,"currentweapon_1") == "SKS" then
			weapName = "SKS"
			dxDrawText(""..clip.." | "..ammo,sWidth*0.875,sHeight*0.09166666666,sWidth*0.37,sHeight*0.50166666666,tocolor(0,255,0,255),1.3,"clear-normal","left","top",false,false,false)
		end
    elseif weaponID == 34 then
		if getElementData(localPlayer,"currentweapon_1") == "CZ 550" then
			weapName = "CZ 550"
			dxDrawText(""..clip.." | "..ammo,sWidth*0.875,sHeight*0.09166666666,sWidth*0.37,sHeight*0.50166666666,tocolor(0,255,0,255),1.3,"clear-normal","left","top",false,false,false)
		elseif getElementData(localPlayer,"currentweapon_1") == "DMR" then
			weapName = "DMR"
			dxDrawText(""..clip.." | "..ammo,sWidth*0.875,sHeight*0.09166666666,sWidth*0.37,sHeight*0.50166666666,tocolor(0,255,0,255),1.3,"clear-normal","left","top",false,false,false)
		elseif getElementData(localPlayer,"currentweapon_1") == "SVD Dragunov" then
			weapName = "SVD Dragunov"
			dxDrawText(""..clip.." | "..ammo,sWidth*0.875,sHeight*0.09166666666,sWidth*0.37,sHeight*0.50166666666,tocolor(0,255,0,255),1.3,"clear-normal","left","top",false,false,false)
		end
    elseif weaponID == 16 then
		weapName = "Grenade"
		dxDrawText(""..clip.." | "..ammo,sWidth*0.875,sHeight*0.09166666666,sWidth*0.37,sHeight*0.50166666666,tocolor(0,255,0,255),1.3,"clear-normal","left","top",false,false,false)
    elseif weaponID == 43 then
        weapName = "Binoculars"
    elseif weaponID == 44 then
        weapName = "NV Goggles"
    elseif weaponID == 45 then
        weapName = "IR Goggles"
    elseif weaponID == 46 then
        weapName = "Parachute"
    elseif weaponID == 2 then
        weapName = "Golf Club"
    elseif weaponID == 4 then
        weapName = "Hunting Knife"
    elseif weaponID == 5 then
        weapName = "Baseball Bat"
    elseif weaponID == 6 then
        weapName = "Shovel"
    elseif weaponID == 8 then
        weapName = "Hatchet"
    elseif weaponID == 0 then
        weapName = " "
    end
 		dxDrawText(""..weapName,sWidth*0.675,sHeight*0.05833333333,sWidth*0.37,sHeight*0.46666666666,tocolor(0,255,0,255),1.3,"clear-normal","left","top",false,false,false)
        if isPedInVehicle (localPlayer) == false then return end
    end
end
addEventHandler("onClientRender",getRootElement(),WeaponHUD)
addEventHandler("onClientPlayerSpawn",getRootElement(),WeaponHUD)

function loadModels()
	weapontxd1 = engineLoadTXD ("mods/weapons/fnfal.txd");
	weapondff1 = engineLoadDFF ("mods/weapons/fnfal.dff", 0);
	weapontxd2 = engineLoadTXD ("mods/weapons/g36c.txd");
	weapondff2 = engineLoadDFF ("mods/weapons/g36c.dff", 0);
	weapontxd3 = engineLoadTXD ("mods/weapons/crossbow.txd");
	weapondff3 = engineLoadDFF ("mods/weapons/crossbow.dff", 0);
	weapontxd4 = engineLoadTXD ("mods/weapons/dmr.txd");
	weapondff4 = engineLoadDFF ("mods/weapons/dmr.dff", 0);
	weapontxd5 = engineLoadTXD ("mods/weapons/dragunov.txd");
	weapondff5 = engineLoadDFF ("mods/weapons/dragunov.dff", 0);
	weapontxd6 = engineLoadTXD ("mods/weapons/bizon.txd");
	weapondff6 = engineLoadDFF ("mods/weapons/bizon.dff", 0);
	weapontxd7 = engineLoadTXD ("mods/weapons/remington.txd");
	weapondff7 = engineLoadDFF ("mods/weapons/remington.dff", 0);
	weapontxd8 = engineLoadTXD ("mods/weapons/revolver.txd");
	weapondff8 = engineLoadDFF ("mods/weapons/revolver.dff", 0);
	weapontxd9 = engineLoadTXD ("mods/weapons/m1911.txd");
	weapondff9 = engineLoadDFF ("mods/weapons/m1911.dff", 0);
	weapontxd10 = engineLoadTXD ("mods/weapons/sks.txd");
	weapondff10 = engineLoadDFF ("mods/weapons/sks.dff", 0);
	weapontxd11 = engineLoadTXD ("mods/weapons/sa58v.txd");
	weapondff11 = engineLoadDFF ("mods/weapons/sa58v.dff", 0);

end
addEventHandler("onClientResourceStart",resourceRoot,loadModels)

loaded = false

function onClientPlayerSkinChange(prevSlot,newSlot)
local getSlot = getPedWeaponSlot(localPlayer)
	if getSlot == 0 then
		loaded = false
	elseif getSlot > 0 then
		if getElementData(localPlayer,"currentweapon_1") == "FN FAL" then
			if not loaded then
				engineImportTXD (weapontxd1, 355);
				engineReplaceModel (weapondff1, 355);
				loaded = true
			else return true
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "G36C" then
			if not loaded then
				engineImportTXD (weapontxd2, 355);
				engineReplaceModel (weapondff2, 355);
				loaded = true
			else return true
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "AK-47" then
			if not loaded then
				engineRestoreModel(355)
				loaded = true
			else return true
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "Crossbow" then
			if not loaded then
				engineImportTXD(weapontxd3, 349);
				engineReplaceModel(weapondff3, 349);
				loaded = true
			else return true
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "DMR" then
			if not loaded then
				engineImportTXD(weapontxd4, 358);
				engineReplaceModel(weapondff4, 358);
				loaded = true
			else return true
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "SVD Dragunov" then
			if not loaded then
				engineImportTXD(weapontxd5, 358);
				engineReplaceModel(weapondff5, 358);
				loaded = true
			else return true
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "CZ 550" then
			if not loaded then
				engineRestoreModel(358)
				loaded = true
			else return true
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "Remington 870" then
			if not loaded then
				engineImportTXD(weapontxd7, 351);
				engineReplaceModel(weapondff7, 351);
				loaded = true
			else return true
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "Winchester 1866" then
			if not loaded then
				engineRestoreModel(349)
				loaded = true
			else return true
			end
		elseif getElementData(localPlayer,"currentweapon_2") == "M1911" then
			if not loaded then
				engineImportTXD(weapontxd9, 346);
				engineReplaceModel(weapondff9, 346);
				loaded = true
			else return true
			end
		elseif getElementData(localPlayer,"currentweapon_2") == "Revolver" then
			if not loaded then
				engineImportTXD(weapontxd8, 348);
				engineReplaceModel(weapondff8, 348);
				loaded = true
			else return true
			end
		elseif getElementData(localPlayer,"currentweapon_2") == "Desert Eagle" then
			if not loaded then
				--if getElementData(localPlayer,"WonEvent") then
					--engineImportTXD(eventeagletxd,348);
					--engineReplaceModel(eventeagledff,348);
					--loaded = true
				--else
					engineRestoreModel(348)
					loaded = true
				--end
			else return true
			end
		elseif getElementData(localPlayer,"currentweapon_2") == "Bizon PP-19" then
			if not loaded then
				engineImportTXD(weapontxd6, 353);
				engineReplaceModel(weapondff6, 353);
				loaded = true
			else return true
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "Sa58V CCO" then
			if not loaded then
				engineImportTXD(weapontxd11, 355);
				engineReplaceModel(weapondff11, 355);
				loaded = true
			else return true
			end
		else
			engineRestoreModel(355)
			engineRestoreModel(349)
			engineRestoreModel(358)
			engineRestoreModel(353)
			engineRestoreModel(348)
			engineRestoreModel(351)
			loaded = false
		end
	end
end
addEventHandler("onClientPlayerWeaponSwitch",localPlayer,onClientPlayerSkinChange)

--SKIN REPLACEMENTS
	local skin = engineLoadTXD ( "skins/22.txd" ) -- slashed 12 by Wall-E
	engineImportTXD ( skin, 22 )
	local skinDFF = engineLoadDFF("skins/22.dff")
	engineReplaceModel(skinDFF,22)	
	local skin = engineLoadTXD ( "skins/56.txd" ) --young and blue by Slothman
	engineImportTXD ( skin, 56 )
	local skinDFF = engineLoadDFF("skins/56.dff")
	engineReplaceModel(skinDFF,56)
	local skin = engineLoadTXD ( "skins/67.txd" ) -- slit r* employee
	engineImportTXD ( skin, 67 )
	local skinDFF = engineLoadDFF("skins/67.dff")
	engineReplaceModel(skinDFF,67)
	local skin = engineLoadTXD ( "skins/68.txd" ) -- shredded preist by Deixell
	engineImportTXD ( skin, 68 )
	local skinDFF = engineLoadDFF("skins/68.dff")
	engineReplaceModel(skinDFF,68)
	local skin = engineLoadTXD ( "skins/69.txd" ) --bleedin eyes in denim by Capitanazop
	engineImportTXD ( skin, 69 )
	local skinDFF = engineLoadDFF("skins/69.dff")
	engineReplaceModel(skinDFF,69)
	local skin = engineLoadTXD ( "skins/70.txd" ) --ultra gory scientist by 50p
	engineImportTXD ( skin, 70 )
	local skin = engineLoadTXD ( "skins/84.txd" ) --guitar wolf (nonzombie) by Slothman
	engineImportTXD ( skin, 84 )
	local skin = engineLoadTXD ( "skins/92.txd" ) -- peeled flesh by xbost
	local skinDFF = engineLoadDFF("skins/92.dff")
	engineReplaceModel(skinDFF,92)
	--[[engineImportTXD ( skin, 92 )
	local skin = engineLoadTXD ( "skins/zomb9.txd" ) -- NEW
	engineImportTXD ( skin, 97 )
	local skinDFF = engineLoadDFF ("skins/zomb9.dff", 97 ) -- NEW
	engineReplaceModel (skinDFF, 97);
	local skin = engineLoadTXD ( "skins/zomb8.txd" ) -- NEW
	engineImportTXD ( skin, 105 )
	local skinDFF = engineLoadDFF ("skins/zomb8.dff", 105 )
	engineReplaceModel (skinDFF, 105);
	local skin = engineLoadTXD ( "skins/zomb7.txd" ) -- NEW
	engineImportTXD ( skin, 107 )
	local skinDFF = engineLoadDFF ("skins/zomb7.dff", 107 )
	engineReplaceModel (skinDFF, 107);
	local skin = engineLoadTXD ( "skins/zomb6.txd" ) -- NEW
	engineImportTXD ( skin, 108 )
	local skinDFF = engineLoadDFF ("skins/zomb6.dff", 108 )
	engineReplaceModel (skinDFF, 108);
	local skin = engineLoadTXD ( "skins/zomb5.txd" ) -- NEW
	engineImportTXD ( skin, 111 )
	local skinDFF = engineLoadDFF ("skins/zomb5.dff", 111 )
	engineReplaceModel (skinDFF, 111);
	local skin = engineLoadTXD ( "skins/zomb4.txd" ) -- NEW
	engineImportTXD ( skin, 126 )
	local skinDFF = engineLoadDFF ("skins/zomb4.dff", 126 )
	engineReplaceModel (skinDFF, 126);
	local skin = engineLoadTXD ( "skins/zomb3.txd" ) -- NEW
	engineImportTXD ( skin, 127 );
	local skinDFF = engineLoadDFF ("skins/zomb3.dff", 127 )
	engineReplaceModel (skinDFF, 127);
	local skin = engineLoadTXD ( "skins/zomb2.txd" ) -- NEW
	engineImportTXD ( skin, 128 )
	local skinDFF = engineLoadDFF ("skins/zomb2.dff", 128 )
	engineReplaceModel (skinDFF, 128);
	local skin = engineLoadTXD ( "skins/zomb16.txd" ) -- NEW
	engineImportTXD ( skin, 152 )
	local skinDFF = engineLoadDFF ("skins/zomb16.dff", 152 )
	engineReplaceModel (skinDFF, 152);
	local skin = engineLoadTXD ( "skins/zomb15.txd" ) -- NEW
	engineImportTXD ( skin, 162 )
	local skinDFF = engineLoadDFF ("skins/zomb15.dff", 162 )
	engineReplaceModel (skinDFF, 162);
	local skin = engineLoadTXD ("skins/zomb14.txd" ) -- NEW
	engineImportTXD ( skin, 167 )
	local skinDFF = engineLoadDFF ("skins/zomb14.dff", 167 )
	engineReplaceModel (skinDFF, 167);
	local skin = engineLoadTXD ( "skins/zomb13.txd" ) -- NEW
	engineImportTXD ( skin, 188 )
	local skinDFF = engineLoadDFF ("skins/zomb13.dff", 188 )
	engineReplaceModel (skinDFF, 188);
	local skin = engineLoadTXD ( "skins/zomb12.txd" ) -- NEW
	engineImportTXD ( skin, 192 )
	local skinDFF = engineLoadDFF ("skins/zomb12.dff", 192 )
	engineReplaceModel (skinDFF, 192);
	local skin = engineLoadTXD ( "skins/zomb10.txd" ) -- NEW
	engineImportTXD ( skin, 195 )
	local skinDFF = engineLoadDFF ("skins/zomb10.dff", 195 )
	engineReplaceModel (skinDFF, 105);
	local skin = engineLoadTXD ( "skins/zomb1.txd" ) -- NEW
	engineImportTXD ( skin, 206 )
	local skinDFF = engineLoadDFF ("skins/zomb1.dff", 206 )
	engineReplaceModel (skinDFF, 206);
	local skin = engineLoadTXD ( "skins/ptyzomb.txd" ) -- NEW
	engineImportTXD ( skin, 209 )
	local skinDFF = engineLoadDFF ("skins/ptyzomb.dff", 209 )
	engineReplaceModel (skinDFF, 209);
	local skin = engineLoadTXD ( "skins/rotzomb.txd" ) -- NEW
	engineImportTXD ( skin, 212 )
	local skinDFF = engineLoadDFF ("skins/rotzomb.dff", 212 )
	engineReplaceModel (skinDFF, 212);
	local skin = engineLoadTXD ( "skins/oldzomb.txd" ) -- NEW
	engineImportTXD ( skin, 229 )
	local skinDFF = engineLoadDFF ("skins/oldzomb.dff", 229 )
	engineReplaceModel (skinDFF, 229);
	local skin = engineLoadTXD ( "skins/fzomb.txd" ) -- NEW
	engineImportTXD ( skin, 230 )
	local skinDFF = engineLoadDFF ("skins/fzomb.dff", 230 )
	engineReplaceModel (skinDFF, 230);
	local skin = engineLoadTXD ( "skins/forzomb.txd" ) -- NEW
	engineImportTXD ( skin, 258 )
	local skinDFF = engineLoadDFF ("skins/forzomb.dff", 258 )
	engineReplaceModel (skinDFF, 258);
	local skin = engineLoadTXD ( "skins/fatzomb.txd" ) -- NEW
	engineImportTXD ( skin, 264 ) 
	local skinDFF = engineLoadDFF ("skins/fatzomb.dff", 264 )
	engineReplaceModel (skinDFF, 264);
	local skin = engineLoadTXD ( "skins/ddzomb.txd" ) -- NEW
	engineImportTXD ( skin, 274 )
	local skinDFF = engineLoadDFF ("skins/ddzomb.dff", 274 )
	engineReplaceModel (skinDFF, 274);
	local skin = engineLoadTXD ( "skins/dsczomb.txd" )  -- NEW
	engineImportTXD ( skin, 277 )
	local skinDFF = engineLoadDFF ("skins/dsczomb.dff", 277 )
	engineReplaceModel (skinDFF, 277); ]]
	local skin = engineLoadTXD ( "skins/97.txd" ) -- easterboy by Slothman
	engineImportTXD ( skin, 97 )
	local skinDFF = engineLoadDFF("skins/97.dff")
	engineReplaceModel(skinDFF,97)
	local skin = engineLoadTXD ( "skins/105.txd" ) --Scarred Grove Gangster by Wall-E
	engineImportTXD ( skin, 105 )
	local skinDFF = engineLoadDFF("skins/105.dff")
	engineReplaceModel(skinDFF,105)
	local skin = engineLoadTXD ( "skins/107.txd" ) --ripped and slashed grove by Wall-E
	engineImportTXD ( skin, 107 )
	local skinDFF = engineLoadDFF("skins/107.dff")
	engineReplaceModel(skinDFF,107)
	local skin = engineLoadTXD ( "skins/108.txd" ) -- skeleton thug by Deixell
	engineImportTXD ( skin, 108 )
	local skinDFF = engineLoadDFF("skins/108.dff")
	engineReplaceModel(skinDFF,108)
	local skin = engineLoadTXD ( "skins/111.txd" ) --Frank West from dead rising (nonzombie) by Slothman
	engineImportTXD ( skin, 111 )
	local skin = engineLoadTXD ( "skins/126.txd" ) -- bullet ridden wiseguy by Slothman
	engineImportTXD ( skin, 126 )
	local skinDFF = engineLoadDFF("skins/126.dff")
	engineReplaceModel(skinDFF,126)
	local skin = engineLoadTXD ( "skins/127.txd" ) --flyboy from dawn of the dead by Slothman
	engineImportTXD ( skin, 127 )
	local skinDFF = engineLoadDFF("skins/127.dff")
	engineReplaceModel(skinDFF,127)
	local skin = engineLoadTXD ( "skins/128.txd" ) --holy native by Slothman
	engineImportTXD ( skin, 128 )
	local skinDFF = engineLoadDFF("skins/128.dff")
	engineReplaceModel(skinDFF,128)
	local skin = engineLoadTXD ( "skins/152.txd" ) --bitten schoolgirl by Slothman
	engineImportTXD ( skin, 152 )
	local skinDFF = engineLoadDFF("skins/152.dff")
	engineReplaceModel(skinDFF,152)
	local skin = engineLoadTXD ( "skins/162.txd" ) --shirtless redneck by Slothman
	engineImportTXD ( skin, 162 )
	local skinDFF = engineLoadDFF("skins/162.dff")
	engineReplaceModel(skinDFF,162)
	local skin = engineLoadTXD ( "skins/167.txd" ) --dead chickenman by 50p
	engineImportTXD ( skin, 167 )
	local skinDFF = engineLoadDFF("skins/167.dff")
	engineReplaceModel(skinDFF,167)
	local skin = engineLoadTXD ( "skins/188.txd" ) --burnt greenshirt by Slothman
	engineImportTXD ( skin, 188 )
	local skinDFF = engineLoadDFF("skins/188.dff")
	engineReplaceModel(skinDFF,188)
	local skin = engineLoadTXD ( "skins/192.txd" ) --Alice from resident evil (nonzombie) by Slothman
	engineImportTXD ( skin, 192 )
	local skin = engineLoadTXD ( "skins/195.txd" ) --bloody ex by Slothman
	engineImportTXD ( skin, 195 )
	local skinDFF = engineLoadDFF("skins/195.dff")
	engineReplaceModel(skinDFF,195)
	local skin = engineLoadTXD ( "skins/206.txd" ) -- faceless zombie by Slothman
	engineImportTXD ( skin, 206 )
	local skinDFF = engineLoadDFF("skins/206.dff")
	engineReplaceModel(skinDFF,206)
	local skin = engineLoadTXD ( "skins/209.txd" ) --Noodle vendor by 50p
	engineImportTXD ( skin, 209 )
	local skinDFF = engineLoadDFF("skins/209.dff")
	engineReplaceModel(skinDFF,209)
	local skin = engineLoadTXD ( "skins/212.txd" ) --brainy hobo by Slothman
	engineImportTXD ( skin, 212 )
	local skinDFF = engineLoadDFF("skins/212.dff")
	engineReplaceModel(skinDFF,212)
	local skin = engineLoadTXD ( "skins/229.txd" ) --infected tourist by Slothman
	engineImportTXD ( skin, 229 )
	local skinDFF = engineLoadDFF("skins/229.dff")
	engineReplaceModel(skinDFF,229)
	local skin = engineLoadTXD ( "skins/230.txd" ) --will work for brains hobo by Slothman
	engineImportTXD ( skin, 230 )
	local skinDFF = engineLoadDFF("skins/230.dff")
	engineReplaceModel(skinDFF,239)
	local skin = engineLoadTXD ( "skins/258.txd" ) --bloody sided suburbanite by Slothman
	engineImportTXD ( skin, 258 )
	local skinDFF = engineLoadDFF("skins/258.dff")
	engineReplaceModel(skinDFF,258)
	local skin = engineLoadTXD ( "skins/264.txd" ) --scary clown by 50p
	engineImportTXD ( skin, 264 )
	local skinDFF = engineLoadDFF("skins/264.dff")
	engineReplaceModel(skinDFF,264)
	local skin = engineLoadTXD ( "skins/274.txd" ) --Ash Williams (nonzombie) by Slothman
	engineImportTXD ( skin, 274 )
	local skin = engineLoadTXD ( "skins/277.txd" ) -- gutted firefighter by Wall-E
	engineImportTXD ( skin, 277 )
	local skinDFF = engineLoadDFF("skins/277.dff")
	engineReplaceModel(skinDFF,277)
	local skin = engineLoadTXD ( "skins/280.txd" ) --infected cop by Lordy
	engineImportTXD ( skin, 280 )
	local skinDFF = engineLoadDFF("skins/280.dff")
	engineReplaceModel(skinDFF,280)

	
-- PLAY ZOMBIE SOUNDS
local zombiesounds = {
	"sounds/zombies/zgroan (1).ogg", 
	"sounds/zombies/zgroan (2).ogg",
	"sounds/zombies/zgroan (3).ogg", 
	"sounds/zombies/zgroan (4).ogg", 
	"sounds/zombies/zgroan (5).ogg", 
	"sounds/zombies/zgroan (6).ogg", 
	"sounds/zombies/zgroan (7).ogg",
	"sounds/zombies/zgroan (8).ogg",
	"sounds/zombies/zgroan (9).ogg",
	"sounds/zombies/zgroan (10).ogg",
	"sounds/zombies/zgroan (11).ogg", 
	"sounds/zombies/zgroan (12).ogg",
	"sounds/zombies/zgroan (13).ogg", 
	"sounds/zombies/zgroan (14).ogg", 
	"sounds/zombies/zgroan (15).ogg", 
	"sounds/zombies/zgroan (16).ogg", 
	"sounds/zombies/zgroan (17).ogg",
	"sounds/zombies/zgroan (18).ogg",
	"sounds/zombies/zgroan (19).ogg",
	"sounds/zombies/zgroan (20).ogg", 
	"sounds/zombies/zgroan (21).ogg", 
	"sounds/zombies/zgroan (22).ogg",
	"sounds/zombies/zgroan (23).ogg", 
	"sounds/zombies/zgroan (24).ogg", 
	"sounds/zombies/zgroan (25).ogg", 
	"sounds/zombies/zgroan (26).ogg", 
	"sounds/zombies/zgroan (27).ogg",
	"sounds/zombies/zgroan (28).ogg",
	"sounds/zombies/zgroan (29).ogg",
	"sounds/zombies/zgroan (30).ogg", 
	"sounds/zombies/zgroan (31).ogg", 
	"sounds/zombies/zgroan (32).ogg",
	"sounds/zombies/zgroan (33).ogg", 
	"sounds/zombies/zgroan (34).ogg", 
	"sounds/zombies/zgroan (35).ogg", 
	"sounds/zombies/zgroan (36).ogg", 
} 
local zedSound = false

function playZombieSounds()
local zombies = getElementsByType("ped")
	for theKey,theZomb in ipairs(zombies) do
		if theZomb and isElement(theZomb) and isElementStreamedIn(theZomb) and getElementData(theZomb,"zombie") and not getElementData(theZomb,"animal") then
			local Zx,Zy,Zz = getElementPosition(theZomb)
			zedSound = playSound3D(zombiesounds[math.random(1,#zombiesounds)], Zx, Zy, Zz, false)
			setSoundMaxDistance(zedSound,5)
		end
		if getElementData(theZomb,"deadman") then
			if zedSound then
				stopSound(zedSound)
			end
		end
	end
end
setTimer(playZombieSounds,6000,0)

	
--------------------------------------------------------
--GUI + STATS						 				  --
--------------------------------------------------------

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end

statsLabel = {}
statsFont = guiCreateFont("fonts/bitstream.ttf",8)


statsWindows = guiCreateStaticImage(0.775,0.2,0.225,0.22,"images/scrollmenu_2.png",true)
guiSetAlpha(statsWindows,0.8)
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
statsLabel["blood"] = guiCreateLabel(0,0.45,1,0.15,"Blood: 12000",true,statsWindows)
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
statsLabel["name"] = guiCreateLabel(0,0.85,1,0.15,"Name: "..getPlayerName(getLocalPlayer()),true,statsWindows)
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

function showDebugMonitorOnF5()
	if getElementData(localPlayer,"logedin") then
		local visible = guiGetVisible(statsWindows)
		guiSetVisible(statsWindows,not visible)
	else
		guiSetVisible(statsWindow,false)
	end
end
bindKey("F5","down",showDebugMonitorOnF5)

function showDebugMonitor()
	guiSetVisible(statsWindows,true)
end
addEvent("showDebugMonitor",true)
addEventHandler("showDebugMonitor",root,showDebugMonitor)

function hideDebugMonitor()
	guiSetVisible(statsWindows,false)
end
addEvent("hideDebugMonitor",true)
addEventHandler("hideDebugMonitor",root,hideDebugMonitor)

function refreshDebugMonitor()
	if getElementData(getLocalPlayer(),"logedin") then
		local value = getElementData(getLocalPlayer(),getElementData(statsLabel["zombieskilled"],"identifikation"))
		guiSetText(statsLabel["zombieskilled"],"Zombies killed: "..value)
		
		local value = getElementData(getLocalPlayer(),getElementData(statsLabel["headshots"],"identifikation"))
		guiSetText(statsLabel["headshots"],"Headshots: "..value)
		
		local value = getElementData(getLocalPlayer(),getElementData(statsLabel["banditskilled"],"identifikation"))
		guiSetText(statsLabel["banditskilled"],"Bandits killed: "..value)
		
		local value = getElementData(getLocalPlayer(),getElementData(statsLabel["murders"],"identifikation"))
		guiSetText(statsLabel["murders"],"Murders: "..value)
		
		local value = getElementData(getLocalPlayer(),getElementData(statsLabel["blood"],"identifikation"))
		guiSetText(statsLabel["blood"],"Blood: "..value)
		
		local value = getElementData(getRootElement(),"zombiesalive") or 0
		local value2 = getElementData(getRootElement(),"zombiestotal") or 0
		guiSetText(statsLabel["zombies"],"Zombies (Alive/Total): "..value.."/"..value2)
		
		local value = getElementData(getLocalPlayer(),getElementData(statsLabel["temperature"],"identifikation"))
		guiSetText(statsLabel["temperature"],"Temperature: "..math.round(value,2).."°C")
		
		local value = getElementData(getLocalPlayer(),getElementData(statsLabel["humanity"],"identifikation"))
		guiSetText(statsLabel["humanity"],"Humanity: "..math.round(value,2))
		
		guiSetText(statsLabel["name"],"Name: "..getPlayerName(getLocalPlayer()))
	end			
end
setTimer(refreshDebugMonitor,2000,0)

weaponAmmoTable = {
[".45 ACP Cartridge"] = {
{"M1911",22},
{"Desert Eagle",24},
{"Revolver",24},
},

["9x19mm SD Cartridge"] = {
{"M9 SD",23},
},

["9x19mm Cartridge"] = {
{"PDW",28},
{"G17",22},
},

["9x18mm Cartridge"] = {
{"MP5A5",29},
{"Bizon PP-19",29},
},

["5.45x39mm Cartridge"] = {
{"AK-47",30},
{"FN FAL",30},
{"G36C",30},
{"Sa58V CCO",30},
},

["5.56x45mm Cartridge"] = {
{"M4",31},
},

["1866 Slug"] = {
{"Winchester 1866",25},
},

["2Rnd. Slug"] = {
{"Sawn-Off Shotgun",26},
{"Blaze 95 Double Rifle",25},
},

["12 Gauge Pellet"] = {
{"SPAZ-12 Combat Shotgun",27},
{"Remington 870",27},
},

["9.3x62mm Cartridge"] = {
{"CZ 550",34},
{"DMR",34},
{"SVD Dragunov",34},
},

[".303 British Cartridge"] = {
{"Lee Enfield",33},
{"Sporter 22",33},
{"Mosin 9130",33},
{"SKS",33},
},

["M136 Rocket"] = {
{"Heat-Seeking RPG",36},
{"M136 Rocket Launcher",35},
},

["Bolt"] = {
{"Crossbow",25},
},

["others"] = {
{"Parachute",46},
{"Satchel",39},
{"Tear Gas",17},
{"Grenade",16},
{"Hunting Knife",4},
{"Hatchet",8},
{"Binoculars",43},
{"Baseball Bat",5},
{"Shovel",6},
{"Golf Club",2},
{"Machete",8},
{"Crowbar",2},
},
}

function getWeaponAmmoType (weaponName)
	for i,weaponData in ipairs(weaponAmmoTable["others"]) do
        if weaponName == weaponData[1] then
            return weaponData[1],weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable[".45 ACP Cartridge"]) do
        if weaponName == weaponData[1] then
            return ".45 ACP Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["9x19mm SD Cartridge"]) do
        if weaponName == weaponData[1] then
            return "9x19mm SD Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["9x19mm Cartridge"]) do
        if weaponName == weaponData[1] then
            return "9x19mm Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["9x18mm Cartridge"]) do
        if weaponName == weaponData[1] then
            return "9x18mm Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["5.45x39mm Cartridge"]) do
        if weaponName == weaponData[1] then
            return "5.45x39mm Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["5.56x45mm Cartridge"]) do
        if weaponName == weaponData[1] then
            return "5.56x45mm Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["1866 Slug"]) do
        if weaponName == weaponData[1] then
            return "1866 Slug",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["12 Gauge Pellet"]) do
        if weaponName == weaponData[1] then
            return "12 Gauge Pellet",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["2Rnd. Slug"]) do
        if weaponName == weaponData[1] then
            return "2Rnd. Slug",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["9.3x62mm Cartridge"]) do
        if weaponName == weaponData[1] then
            return "9.3x62mm Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable[".303 British Cartridge"]) do
        if weaponName == weaponData[1] then
            return ".303 British Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["M136 Rocket"]) do
        if weaponName == weaponData[1] then
            return "M136 Rocket",weaponData[2]
        end
    end
	for i,weaponData in ipairs(weaponAmmoTable["Bolt"]) do
		if weaponName == weaponData[1] then
			return "Bolt",weaponData[2]
		end
	end
end

-- WEAPON DAMAGE TABLE IS IN editor_client.lua

function getWeaponDamage (weapon)
	for i,weapon2 in ipairs(damageTable) do
		local t,weapon1 = getWeaponAmmoType(weapon2[1])
		if weapon1 == weapon then
			if getElementData(getLocalPlayer(),"humanity") == 5000 then
				if weapon2[1] == "M1911" or weapon2[1] == "M9 SD" or weapon2[1] == "PDW" then
					return weapon2[2]*1.3
				end
			end	
			return weapon2[2]
		end
	end
end


function playRandomHitSound () 
	local number = math.random(1,3)
	local sound = playSound("sounds/hit"..number..".mp3")
end

--
function playerGetDamageDayZ ( attacker, weapon, bodypart, loss )
	cancelEvent()
	damage = 100
	headshot = false
	damage_half = 1
	if weapon == 37 then
		return
	end
	if getElementData(attacker,"zombie") then
		if getElementData(localPlayer,"humanity") >= 5000 then
			damage_half = 2
		end
		setElementData(getLocalPlayer(),"blood",getElementData(getLocalPlayer(),"blood")-(gameplayVariables["zombiedamage"]/damage_half))
		local gender = getElementData(localPlayer,"gender")
		if gender == "male" then
			playSFX("pain_a",2,53,false)
		elseif gender == "female" then
			playSFX("pain_a",1,52,false)
		end
		local number = math.random(1,7)
		if number == 4 then
			setElementData(getLocalPlayer(),"bleeding",getElementData(getLocalPlayer(),"bleeding") + math.floor(loss*10))
		end
	end
	if weapon == 49 then
		if loss > 30 then
			setElementData(getLocalPlayer(),"brokenbone",true)
			setControlState ("jump",true)
			setElementData(getLocalPlayer(),"blood",getElementData(getLocalPlayer(),"blood")-math.floor(loss*10))
		end
	setElementData(getLocalPlayer(),"blood",getElementData(getLocalPlayer(),"blood")-math.floor(loss*5))
	elseif weapon == 63 or weapon == 51 or weapon == 19 then
		setElementData(getLocalPlayer(),"blood",0)
		if getElementData(getLocalPlayer(),"blood") <= 0 then
			if not getElementData(getLocalPlayer(),"isDead") == true then
				triggerServerEvent("kilLDayZPlayer",getLocalPlayer(),attacker,headshot)
			end
		end
	elseif weapon and weapon > 1 and attacker and getElementType(attacker) == "player" then
		local number = math.random(1,8)
		if number >= 6 or number <= 8 then
			setElementData(getLocalPlayer(),"bleeding",getElementData(getLocalPlayer(),"bleeding") + math.floor(loss*10))
		end
		local number = math.random(1,7)
		if number == 2 then
			setElementData(getLocalPlayer(),"pain",true)
		end
		damage = getWeaponDamage (weapon)
		if damage <= 1000 then
			damage = 0
		end
		if bodypart == 9 then
			damage = damage*gameplayVariables["headshotdamage_player"]
			headshot = true
		end
		if bodypart == 7 or bodypart == 8 then
			setElementData(getLocalPlayer(),"brokenbone",true)
			playSound("sounds/brokenbone.mp3",false)
		end
		playRandomHitSound()
		setElementData(getLocalPlayer(),"blood",getElementData(getLocalPlayer(),"blood")-math.random(damage*0.75,damage*1.25))
		if not getElementData(getLocalPlayer(),"bandit") then
			setElementData(attacker,"humanity",getElementData(attacker,"humanity")-math.random(40,200))
			if getElementData(attacker,"humanity") < 0 then
				setElementData(attacker,"bandit",true)
			end
		else
			setElementData(attacker,"humanity",getElementData(attacker,"humanity")+math.random(40,200))
			if getElementData(attacker,"humanity") > 5000 then
				setElementData(attacker,"humanity",5000)
			end
			if getElementData(attacker,"humanity") > 2000 then
				setElementData(attacker,"bandit",false)
			end
		end	
		if getElementData(getLocalPlayer(),"blood") <= 0 then
			if not getElementData(getLocalPlayer(),"isDead") then
				triggerServerEvent("kilLDayZPlayer",getLocalPlayer(),attacker,headshot,getWeaponNameFromID (weapon))
				setElementData(getLocalPlayer(),"isDead",true)
			end
		end
	elseif weapon == 54 or weapon == 63 or weapon == 49 or weapon == 51 then
		setElementData(getLocalPlayer(),"blood",getElementData(getLocalPlayer(),"blood")-math.random(100,1000))
		local number = math.random(1,5)
		if loss > 30 then
			setElementData(getLocalPlayer(),"brokenbone",true)
			setControlState ("jump",true)
		end
		if loss >= 100 then
			setElementData(getLocalPlayer(),"blood",49)
			setElementData(getLocalPlayer(),"bleeding",50)
		end
		local number = math.random(1,11)
		if number == 3 then
			setElementData(getLocalPlayer(),"pain",true)
		end
		if getElementData(getLocalPlayer(),"blood") <= 0 then
			if not getElementData(getLocalPlayer(),"isDead") == true then
				triggerServerEvent("kilLDayZPlayer",getLocalPlayer(),attacker,headshot,getWeaponNameFromID (weapon))
				setElementData(getLocalPlayer(),"isDead",true)
			end
		end
	end
end
addEventHandler ( "onClientPlayerDamage", getLocalPlayer (), playerGetDamageDayZ )

--[[
function damageZombieOnVehicleHit(collider,force, bodyPart, x, y, z, nx, ny, nz)
	if collider then
		if (source == getPedOccupiedVehicle(localPlayer)) and (getElementType(collider) == "ped") then
            setElementData(collider,"blood",getElementData(collider,"blood")-1000)
			outputChatBox("Hit! :"..getElementData(collider,"blood"))
			local pedX, pedY, pedZ = getElementPosition (collider)
			local endX, endY, endZ = pedX-x, pedY-y, pedZ-z
			--setElementVelocity ( collider, endX, endY, endZ )
			triggerServerEvent("onZombieHitByVehicle",collider)
		end
    end
end
addEventHandler("onClientVehicleCollision", root,damageZombieOnVehicleHit)
]]

function pedGetDamageDayZ ( attacker, weapon, bodypart, loss )
	cancelEvent()
	if attacker and attacker == getLocalPlayer() then
		damage = 100
		if weapon == 37 then
			return
		end
		if weapon == 63 or weapon == 51 or weapon == 19 then
			setElementData(source,"blood",0)
			if getElementData(source,"blood") <= 0 then
				triggerServerEvent("onZombieGetsKilled",source,attacker)
			end
		elseif weapon and weapon > 1 and attacker and getElementType(attacker) == "player" then
			damage = getWeaponDamage (weapon)
			if bodypart == 9 then
				damage = damage*gameplayVariables["headshotdamage_zombie"]
				headshot = true
			end
				setElementData(source,"blood",getElementData(source,"blood")-damage)
			if getElementData(source,"blood") <= 0 then
					triggerServerEvent("onZombieGetsKilled",source,attacker,headshot)
			end
		end
	end	
end
addEventHandler ( "onClientPedDamage", getRootElement(), pedGetDamageDayZ )

function checkStats()
	if getElementData(getLocalPlayer(),"logedin") then
		if getElementData(getLocalPlayer(),"bleeding") > 20 then
			setElementData(getLocalPlayer(),"blood",getElementData(getLocalPlayer(),"blood")-getElementData(getLocalPlayer(),"bleeding"))
		else
			setElementData(getLocalPlayer(),"bleeding",0)
		end
		if getElementData(getLocalPlayer(),"blood") < 0 then
			if not getElementData(getLocalPlayer(),"isDead") then
				triggerServerEvent("kilLDayZPlayer",getLocalPlayer(),false,false)
			end
		end
	end	
end
setTimer(checkStats,3000,0)

function createBloodForBleedingPlayers ()
	if getElementData(getLocalPlayer(),"logedin") then
	local x,y,z = getElementPosition(getLocalPlayer())
		for i,player in ipairs(getElementsByType("player")) do
			local bleeding = getElementData(player,"bleeding") or 0
			if bleeding > 0 then
				local px,py,pz = getPedBonePosition (player,3)
				local pdistance = getDistanceBetweenPoints3D ( x,y,z,px,py,pz )
				if bleeding > 600 then
					number = 5
				elseif bleeding > 300 then
					number = 3
				elseif bleeding > 100 then
					number = 1
				else
					number = 0
				end
				if pdistance <= 120 then
					fxAddBlood ( px,py,pz,0,0,0,number, 1 )
				end
			end	
		end
	end	
end
setTimer(createBloodForBleedingPlayers,300,0)

function checkBrokenbone()
	if getElementData(getLocalPlayer(),"logedin") then
		if getElementData(getLocalPlayer(),"brokenbone") then
			if not isPedDucked(getLocalPlayer()) then
				--setControlState ("walk",false)
				--setControlState ("crouch",true)
			end
			toggleControl ( "jump", false )
			toggleControl ( "sprint", false )
		else
			toggleControl ( "jump", true )
			toggleControl ( "sprint", true )
		end
	end	
end
setTimer(checkBrokenbone,1400,0)

function setPain()
	if getElementData(getLocalPlayer(),"logedin") then
		if getElementData(getLocalPlayer(),"pain") then
			local x,y,z = getElementPosition(getLocalPlayer())
			createExplosion (x,y,z+15,8,false,1.0,false)
			local x, y, z, lx, ly, lz = getCameraMatrix() -- Get the current location and lookat of camera
			x, lx = x + 1, lx + 1 -- What will be the new x and x lookat values
			setCameraMatrix(x,y,z,lx,ly,lz) -- Set camera to new position
			setCameraTarget (getLocalPlayer())
		end
	end	
end
setTimer(setPain,1500,0)

function checkCold()
	if getElementData(getLocalPlayer(),"logedin") then
		if getElementData(getLocalPlayer(),"temperature") <= 33 then
			setElementData(getLocalPlayer(),"cold",true)
		end
	end	
end
setTimer(checkCold,3000,0)

function setCold()
	if getElementData(getLocalPlayer(),"logedin") then
		if getElementData(getLocalPlayer(),"cold") then
			local x,y,z = getElementPosition(getLocalPlayer())
			createExplosion (x,y,z+15,8,false,0.5,false)
			local x, y, z, lx, ly, lz = getCameraMatrix() -- Get the current location and lookat of camera
			randomsound = math.random(0,99)
			if randomsound >= 0 and randomsound <= 6 then
				playSound("sounds/coughing.mp3",false)
				setElementData(localPlayer,"volume",100)
				setTimer(function() setElementData(localPlayer,"volume",0) end,1500,1)
			elseif randomsound >= 7 and randomsound <= 13 then	
				setElementData(localPlayer,"volume",100)
				setTimer(function() setElementData(localPlayer,"volume",0) end,1500,1)
				playSound("sounds/sneezing.mp3",false)
			end
		end	
	end	
end
setTimer(setCold,10000,0)

--[[ 
Volume (Noise):

0 = Silent
20 = Very Low
40 = Low
60 = Moderate
80 = High
100 = Very High

]]

function setVolume()
	value = 0
	local block, animation = getPedAnimation(localPlayer)
	if getPedMoveState (getLocalPlayer()) == "stand" then
		value = 0
	elseif getPedMoveState (getLocalPlayer()) == "crouch" then	
		value = 0
	elseif getPedMoveState(localPlayer) == "crawl" then
		value = 20
	elseif getPedMoveState (getLocalPlayer()) == "walk" then
		value = 40
	elseif getPedMoveState (getLocalPlayer()) == "powerwalk" then
		value = 60
	elseif getPedMoveState (getLocalPlayer()) == "jog" then
		value = 80
	elseif getPedMoveState (getLocalPlayer()) == "sprint" then	
		value = 100
	elseif not getPedMoveState (getLocalPlayer()) then
		value = 20
	end
	if getElementData(getLocalPlayer(),"shooting") and getElementData(getLocalPlayer(),"shooting") > 0 then
		value = value+getElementData(getLocalPlayer(),"shooting")
	end
	if isPedInVehicle (getLocalPlayer()) then
		value = 100
	end	
	if value > 100 then
		value = 100
	end
	if block == "ped" or block == "SHOP" or block == "BEACH" then
		value = 0
	end
	setElementData(getLocalPlayer(),"volume",value)
end
setTimer(setVolume,100,0)

--[[
Visibility:

0 = Invisible
20 = Very Low Visibility
40 = Low Visibility
60 = Moderate Visibility
80 = High Visibility
100 = Very High Visibility

]]
function setVisibility()
	value = 0
	local block, animation = getPedAnimation(localPlayer)
	if getPedMoveState (getLocalPlayer()) == "stand" then
		value = 40
	elseif getPedMoveState (getLocalPlayer()) == "crouch" then	
		value = 0
	elseif getPedMoveState(localPlayer) == "crawl" then
		value = 20
	elseif getPedMoveState (getLocalPlayer()) == "walk" then
		value = 60
	elseif getPedMoveState (getLocalPlayer()) == "powerwalk" then
		value = 60
	elseif getPedMoveState (getLocalPlayer()) == "jog" then
		value = 60
	elseif getPedMoveState (getLocalPlayer()) == "sprint" then	
		value = 80
	elseif not getPedMoveState (getLocalPlayer()) then	
		value = 20
	end
	if getElementData(getLocalPlayer(),"jumping") then
		value = 100
	end
	if isObjectAroundPlayer (getLocalPlayer(),2, 4 ) then
		value = 0
	end
	if isPedInVehicle (getLocalPlayer()) then
		value = 100
	end
	if block == "ped" or block == "SHOP" or block == "BEACH" then
		value = 0
	end
	setElementData(getLocalPlayer(),"visibly",value)
end
setTimer(setVisibility,100,0)

function debugJump()
	if getControlState("jump") then
		setElementData(getLocalPlayer(),"jumping",true)
		setTimer(debugJump2,650,1)
	end
end
setTimer(debugJump,100,0)

function debugJump2()
	setElementData(getLocalPlayer(),"jumping",false)
end

function setPlayerSneakOnWalk()
	if getControlState("walk") then
		setPedWalkingStyle(localPlayer,69)
	else
		setPedWalkingStyle(localPlayer,54)
	end
end
setTimer(setPlayerSneakOnWalk,1000,0)

weaponNoiseTable = {
-- Weapons with * as operator are louder, while those with / are quieter
-- Also, those with * as operator have lower values, those with / have higher ones
{2,20,"/",5},
{3,20,"/",5},
{4,20,"/",5},
{5,20,"/",5},
{6,20,"/",5},
{7,20,"/",5},
{8,20,"/",5},
{9,100,"*",0.4},
{10,20,"/",5},
{11,20,"/",5},
{12,100,"*",0.4},
{14,20,"/",5},
{15,20,"/",5},
{16,100,"*",0.4},
{17,40,"/",2},
{18,60,"*",1},
{22,40,"/",2},
{23,0,"/",100},
{24,60,"*",1},
{25,60,"*",1},
{26,60,"*",1},
{27,60,"*",1},
{28,40,"/",1},
{29,40,"/",1},
{30,80,"*",0.5},
{31,80,"*",0.5},
{32,40,"/",2},
{33,100,"*",0.4},
{34,100,"*",0.4},
{35,100,"*",0.4},
{36,100,"*",0.4},

}

--[[
Noise Values:

0 = Silent (Level 0)
20 = Very Low (Level 1)
40 = Low (Level 2)
60 = Moderate (Level 3)
80 = High (Level 4)
100 = Very High (Level 5)

Factors: (Max Distance)
100 = 0m
5 = 20m
2 = 50m
1 = 100m
0.5 = 200m
0.4 = 250m

]]

function getWeaponNoise(weapon)
	for i,weapon2 in ipairs(weaponNoiseTable) do
		if weapon == weapon2[1] then
			return weapon2[2]
		end
	end
	return 0
end

function getWeaponNoiseOperator(weapon)
    for i,weapon2 in ipairs(weaponNoiseTable) do
        if weapon == weapon2[1] then
            return weapon2[3]
        end
    end
	return "/"
end

function getWeaponNoiseFactor(weapon)
    for i,weapon2 in ipairs(weaponNoiseTable) do
        if weapon == weapon2[1] then
            return weapon2[4]
        end
    end
	return 5
end

function debugShooting()
	if getControlState("fire") then
		local weapon = getPedWeapon(getLocalPlayer())
		local noise = getWeaponNoise(weapon) or 0
		setElementData(getLocalPlayer(),"shooting",noise)
		if shootTimer then
			killTimer(shootTimer)
		end
		shootTimer = setTimer(debugShooting2,200,1)
	end
end
setTimer(debugShooting,100,0)

function debugShooting2()
	setElementData(getLocalPlayer(),"shooting",0)
	shootTimer = false
end

function zombieMovement(ped)
local rotation = math.random(1,359)
local setStance = math.random(0,50)
setPedRotation(ped,rotation)
	if setStance >= 0 and setStance <= 49 then
		setPedAnimation (ped, "RYDER", "RYD_Die_PT1", -1, true, true, true)
	elseif setStance == 50 then
		setPedAnimation(ped,"PED","WEAPON_crouch",-1,true,true,true)
	end
end
addEvent("onZombieMove",true)
addEventHandler("onZombieMove",getRootElement(),zombieMovement)


function checkZombies()
	zombiesalive = 0
	zombiestotal = 0
	for i,ped in ipairs(getElementsByType("ped")) do
		if getElementData(ped,"zombie") then
			zombiesalive = zombiesalive + 1
		end
		if getElementData(ped,"deadzombie") then
			zombiestotal = zombiestotal + 1
		end
	end
	setElementData(getRootElement(),"zombiesalive",zombiesalive)
	setElementData(getRootElement(),"zombiestotal",zombiestotal+zombiesalive)
end
setTimer(checkZombies,5000,0)

function checkZombies3()
    local x,y,z = getElementPosition(getLocalPlayer())
    local weaponOperator = getWeaponNoiseOperator(getPedWeapon(localPlayer))
    for i,ped in ipairs(getElementsByType("ped")) do
        if getElementData(ped,"zombie") then
			if getElementData(localPlayer,"shooting") and getElementData(localPlayer,"shooting") > 0 then
				value = getWeaponNoiseFactor(getPedWeapon(localPlayer))
			else
				value = 5
			end
			local sound = getElementData(localPlayer,"volume")/value
            local visibly = getElementData(getLocalPlayer(),"visibly")/5
            local xZ,yZ,zZ = getElementPosition(ped)
            if getDistanceBetweenPoints3D (x,y,z,xZ,yZ,zZ) < sound+visibly then
                if getElementData ( ped, "leader" ) == nil then
                    triggerServerEvent("botAttack",getLocalPlayer(),ped)

                end
            else
				if getElementData ( ped, "target" ) == getLocalPlayer() then
					setElementData(ped,"target",nil)
					triggerEvent("onZombieMove",getRootElement(),ped)
				end
                if getElementData ( ped, "leader" ) == getLocalPlayer() then
                    triggerServerEvent("botStopFollow",getLocalPlayer(),ped)
                    triggerEvent("onZombieMove",getRootElement(),ped)
                end
            end
        end
    end
end
setTimer(checkZombies3,500,0)

function math.percent(percent,maxvalue)
    if tonumber(percent) and tonumber(maxvalue) then
        local x = (maxvalue*percent)/100
        return x
    end
    return false
end

fading = 0
fading2 = "up"
local screenWidth,screenHeight = guiGetScreenSize()

function updateIcons ()
	if getElementData(getLocalPlayer(),"logedin") then
		--fading
		if fading >= 0 and fading2 == "up" then
			fading = fading + 5
		elseif fading <= 255 and fading2 == "down" then
			fading = fading - 5
		end
		--fading math.
		if fading == 0 then
			fading2 = "up"
		elseif fading == 255 then
			fading2 = "down"
		end
		--sound
		dxDrawImage ( screenWidth*0.9325 , screenHeight*0.41, screenHeight*0.075, screenHeight*0.075, "images/dayzicons/sound.png",0,0,0,tocolor(0,255,0))
		local sound = getElementData(getLocalPlayer(),"volume")/20
		if sound > 0 then
			dxDrawImage ( screenWidth*0.9075 , screenHeight*0.41, screenHeight*0.075, screenHeight*0.075, "images/dayzicons/level_"..sound..".png",0,0,0)
		end
		--visibly
		dxDrawImage ( screenWidth*0.9325 , screenHeight*0.475, screenHeight*0.075, screenHeight*0.075, "images/dayzicons/eye.png",0,0,0,tocolor(0,255,0))
		local sound = getElementData(getLocalPlayer(),"visibly")/20
		if sound > 0 then
			dxDrawImage ( screenWidth*0.9075 , screenHeight*0.475, screenHeight*0.075, screenHeight*0.075, "images/dayzicons/level_"..sound..".png",0,0,0)
		end
		--brokenbone
		if getElementData(getLocalPlayer(),"brokenbone") then
			dxDrawImage ( screenWidth*0.9375 , screenHeight*0.55, screenHeight*0.065, screenHeight*0.065, "images/dayzicons/brokenbone.png",0,0,0,tocolor(255,255,255))
		end
		--bandit	
		local humanity =  getElementData(getLocalPlayer(),"humanity")
		local humanity_icon = "images/dayzicons/humanity/2500.png"
		local number = 0
		if humanity >= 5000 and humanity >= 3501 then
			number = 5
		elseif humanity <= 3500 and humanity >= 2501 then
			number = 4
		elseif humanity <= 2500 and humanity >= 1 then
			number = 3
		elseif humanity <= 0 and humanity >= -1001 then
			number = 2
		elseif humanity <= -1000 and humanity >= -2501 then
			number = 1
		elseif humanity >= -2500 then
			number = 0
		end
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.6, screenHeight*0.065, screenHeight*0.065, "images/dayzicons/humanity/"..number..".png",0,0,0,tocolor(0,255,0))
		--temperature
		local temperature = math.round(getElementData(getLocalPlayer(),"temperature"),2)
		r,g,b = 0,255,0
		local number = 5
		if temperature <= 37 then
			value = (37-temperature)*42.5
			r,g,b = 0,255-value,value
			number = 3
		elseif temperature > 37 and temperature < 41 then
			r,g,b = 0,255,0
			number = 5
		elseif temperature == 41 then
			number = 5
			r,g,b = 255,0,0
		end
		if value > 215 then
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.7, screenHeight*0.065, screenHeight*0.065, "images/dayzicons/temperature/"..number..".png",0,0,0,tocolor(r,g,b,fading))
		else
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.7, screenHeight*0.065, screenHeight*0.065, "images/dayzicons/temperature/"..number..".png",0,0,0,tocolor(r,g,b))
		end
		--thirsty
		r,g,b = 0,255,0
		local thirst = getElementData(localPlayer,"thirst")
		local thirst_coloring = getElementData(getLocalPlayer(),"thirst")*2.55
		r,g,b = 255-thirst_coloring,thirst_coloring,0
		local thirst_icon = "images/dayzicons/thirst/100.png"
		if thirst >= 100 and thirst <= 81 then
			thirst_icon = "images/dayzicons/thirst/100.png"
		elseif thirst <= 80 and thirst >= 61 then
			thirst_icon = "images/dayzicons/thirst/80.png"
		elseif thirst <= 60 and thirst >= 41 then
			thirst_icon = "images/dayzicons/thirst/60.png"
		elseif thirst <= 40 and thirst >= 21 then
			thirst_icon = "images/dayzicons/thirst/40.png"
		elseif thirst <= 20 and thirst >= 1 then
			thirst_icon = "images/dayzicons/thirst/20.png"
		elseif thirst < 1 then
			thirst_icon = "images/dayzicons/thirst/0.png"
		end
		if thirst_coloring < 15 then
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.775, screenHeight*0.065, screenHeight*0.065, thirst_icon,0,0,0,tocolor(r,g,b,fading))
		else
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.775, screenHeight*0.065, screenHeight*0.065, thirst_icon,0,0,0,tocolor(r,g,b))
		end
		--blood
		r,g,b = 0,255,0
		local blood = getElementData(localPlayer,"blood")
		local blood_coloring = getElementData(getLocalPlayer(),"blood")/47.2
		r,g,b = 255-blood_coloring,blood_coloring,0
		local blood_icon = "images/dayzicons/blood/12000.png"
		if blood >= 12000 and blood >= 10001 then
			blood_icon = "images/dayzicons/blood/12000.png"
		elseif blood <= 10000 and blood >= 8001 then
			blood_icon = "images/dayzicons/blood/10000.png"
		elseif blood <= 8000 and blood >= 6001 then
			blood_icon = "images/dayzicons/blood/8000.png"
		elseif blood <= 6000 and blood >= 4001 then
			blood_icon = "images/dayzicons/blood/6000.png"
		elseif blood <= 4000 and blood >= 2001 then
			blood_icon = "images/dayzicons/blood/4000.png"
		elseif blood <= 2000 then
			blood_icon = "images/dayzicons/blood/2000.png"
		end	
		dxDrawImage ( screenWidth*0.94 , screenHeight*0.85, screenHeight*0.065, screenHeight*0.065, blood_icon,0,0,0,tocolor(r,g,b))
		if getElementData(getLocalPlayer(),"bleeding") > 0 then
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.85, screenHeight*0.065, screenHeight*0.065, "images/dayzicons/medic.png",0,0,0,tocolor(255,255,255,fading))
		end
		--food
		r,g,b = 0,255,0
		local food = getElementData(getLocalPlayer(),"food")*2.55
		r,g,b = 255-food,food,0
		local food_icon = "images/dayzicons/hunger/100.png"
		if food >= 100 and food <= 81 then
			food_icon = "images/dayzicons/hunger/100.png"
		elseif food <= 80 and food >= 61 then
			food_icon = "images/dayzicons/hunger/80.png"
		elseif food <= 60 and food >= 41 then
			food_icon = "images/dayzicons/hunger/60.png"
		elseif food <= 40 and food >= 21 then
			food_icon = "images/dayzicons/hunger/40.png"
		elseif food <= 20 and food >= 1 then
			food_icon = "images/dayzicons/hunger/20.png"
		elseif food < 1 then
			food_icon = "images/dayzicons/hunger/0.png"
		end
		if food < 15 then
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.925, screenHeight*0.065, screenHeight*0.065, food_icon,0,0,0,tocolor(r,g,b,fading))
		else
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.925, screenHeight*0.065, screenHeight*0.065, food_icon,0,0,0,tocolor(r,g,b))
		end	
		--Nametags
		local x,y,z = getElementPosition(getLocalPlayer())
		for i,player in ipairs(getElementsByType("player")) do
			setPlayerNametagShowing ( player, false )
			if player ~= getLocalPlayer() then
			local vehicle = getPedOccupiedVehicle(player)
				local px,py,pz = getElementPosition (player)
				local pdistance = getDistanceBetweenPoints3D ( x,y,z,px,py,pz )
				if pdistance <= 2 then
					--Get screenposition
					local sx,sy = getScreenFromWorldPosition ( px, py, pz+0.95, 0.06 )
					if sx and sy then
					--Draw Name
					if getElementData(player,"bandit") then
						text = string.gsub(getPlayerName(player), '#%x%x%x%x%x%x', '' ).." (Bandit)"
					else
						text = string.gsub(getPlayerName(player), '#%x%x%x%x%x%x', '' )
					end
					local w = dxGetTextWidth(text,1.02,"default-bold")
					dxDrawText (text, sx-(w/2), sy, sx-(w/2), sy, tocolor ( 100, 255, 100, 200 ), 1.02, "default-bold" )
					end
				end
			end		
		end
		--Vehicletags
		local x,y,z = getElementPosition(getLocalPlayer())
		for i,veh in ipairs(getElementsByType("vehicle")) do
			local px,py,pz = getElementPosition (veh)
			local vehID = getElementModel(veh)
			local vehicle = getPedOccupiedVehicle(getLocalPlayer())
			if veh ~= vehicle then
				if vehID ~= 548 then
					local pdistance = getDistanceBetweenPoints3D ( x,y,z,px,py,pz )
					if pdistance <= 6 then
						--Get screenposition
						local sx,sy = getScreenFromWorldPosition ( px, py, pz+0.95, 0.06 )
						if sx and sy then
							--Draw Vehicle
							local w = dxGetTextWidth(getVehicleName(veh),1.02,"default-bold")
							local vehName = getElementData(getElementData(veh,"parent"),"vehicle_name")
							dxDrawText ( vehName, sx-(w/2), sy, sx-(w/2), sy, tocolor ( 100, 255, 100, 200 ), 1.02, "default-bold" )	
						end
					end
				end
			end
		end
		--Vehicle Infos
		local veh = getPedOccupiedVehicle (getLocalPlayer())
		if veh then
			local screenW, screenH = guiGetScreenSize()
			local maxfuel = getElementData(veh,"maxfuel")
			local fuel = getElementData(getElementData(veh,"parent"),"fuel")
			local needengine = getElementData(veh,"needengines")
			local needtires = getElementData(veh,"needtires")
			local needparts = getElementData(veh,"needparts")
			local needscrap = getElementData(veh,"needscrap")
			local needglass = getElementData(veh,"needglass")
			local needrotary = getElementData(veh,"needrotary")
			local vehiclename = getElementData(veh,"vehicle_name")
			local engine = getElementData(getElementData(veh,"parent"),"Engine_inVehicle") or 0
			local tires = getElementData(getElementData(veh,"parent"),"Tire_inVehicle") or 0
			local parts = getElementData(getElementData(veh,"parent"),"Parts_inVehicle") or 0
			local scrap = getElementData(getElementData(veh,"parent"),"Scrap_inVehicle") or 0
			local glass = getElementData(getElementData(veh,"parent"),"Glass_inVehicle") or 0
			local rotary = getElementData(getElementData(veh,"parent"),"Rotary_inVehicle") or 0
			local offset = dxGetFontHeight(1.02,"default-bold")
			--local w = dxGetTextWidth(engine.."/"..needengine.." Engine",1.02,"default-bold")
			local enginetype = ""
			if needrotary == 0 then
				if engine == needengine then
					r,g,b = 0,255,0
					number = 1
					enginetype = "eng"
				else
					r,g,b = 255,0,0
					number = 0
					enginetype = "eng"
				end
			else
				if rotary == needrotary then
					r,g,b = 0,255,0
					number = 1
					enginetype = "mrot"
				else
					r,g,b = 255,0,0
					number = 0
					enginetype = "mrot"
				end
			end
			--dxDrawText (engine.."/"..needengine.." Engine" ,screenWidth*0.5-w/2 , screenHeight*0,screenWidth*0.5-w/2 , screenHeight*0,tocolor ( r,g,b, 220 ), 1.02, "default-bold" )
			dxDrawImage(screenW * 0.4562, screenH * 0.0767, screenW * 0.0488, screenH * 0.0317, "images/dayzicons/vehicle/engine/"..enginetype.."_"..number..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			--local w = dxGetTextWidth(tires.."/"..needtires.." Tires",1.02,"default-bold")
			if tires == needtires then
				r,g,b = 0,255,0
				number = 1
			else
				r,g,b = 255,0,0
				number = 0
			end
			--dxDrawText (tires.."/"..needtires.." Tires",screenWidth*0.5-w/2 , screenHeight*0+offset,screenWidth*0.5-w/2 , screenHeight*0+offset,tocolor ( r,g,b, 220 ), 1.02, "default-bold" )
			dxDrawText(tonumber(tires).."/"..tonumber(needtires), screenW * 0.5162, screenH * 0.1083, screenW * 0.5687, screenH * 0.1333, tocolor(73, 251, 3, 255), 1.00, "default-bold", "center", "top", false, false, false, false, false)
			dxDrawImage(screenW * 0.5175, screenH * 0.0767, screenW * 0.0488, screenH * 0.0317, "images/dayzicons/vehicle/whl/whl_"..number..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			--local w = dxGetTextWidth(parts.."/"..needparts.." Tank Parts",1.02,"default-bold")
			if parts == needparts then
				r,g,b = 0,255,0
				number = 1
			else
				r,g,b = 255,0,0
				number = 0
			end
			--dxDrawText (parts.."/"..needparts.." Tank Parts",screenWidth*0.5-w/2 , screenHeight*0+offset*2,screenWidth*0.5-w/2 , screenHeight*0+offset, tocolor (r,g,b, 220 ) , 1.02, "default-bold" )
			dxDrawImage(screenW * 0.5787, screenH * 0.0767, screenW * 0.0488, screenH * 0.0317, "images/dayzicons/vehicle/tank/tank_"..number..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			--local w = dxGetTextWidth("Fuel:"..math.floor(fuel).."/"..maxfuel,1.02,"default-bold")
			--[[if fuel == maxfuel then
				r,g,b = 0,255,0
				number = 100
			elseif fuel < maxfuel/10 then
				r,g,b = 255,0,0	
			elseif fuel < maxfuel/4 then
				r,g,b = 255,50,0	
			elseif fuel < maxfuel/3 then
				r,g,b = 200,100,0
			elseif fuel < maxfuel/2 then
				r,g,b = 125,200,0		
			elseif fuel < maxfuel/1.5 then
				r,g,b = 50,200,0
			end]]
			-- a*100/b
			if getElementModel(veh) ~= 509 then
				if fuel == maxfuel then
					number = 100
				elseif fuel >= (maxfuel*99)/100 then
					number = 90
				elseif fuel >= (maxfuel*90)/100 then 
					number = 90
				elseif fuel >= (maxfuel*80)/100 then
					number = 80
				elseif fuel >= (maxfuel*70)/100 then
					number = 70
				elseif fuel >= (maxfuel*60)/100 then
					number = 60
				elseif fuel >= (maxfuel*50)/100 then
					number = 50
				elseif fuel >= (maxfuel*40)/100 then
					number = 40
				elseif fuel >= (maxfuel*30)/100 then
					number = 30
				elseif fuel >= (maxfuel*20)/100 then
					number = 20
				elseif fuel >= (maxfuel*1)/100 then
					number = 10
				elseif fuel == (maxfuel*0)/100 then
					number = 0
				end
			
			--dxDrawText ("Fuel:"..math.floor(fuel).."/"..maxfuel,screenWidth*0.5-w/2 , screenHeight*0+offset*3,screenWidth*0.5-w/2 , screenHeight*0+offset*2,tocolor ( r,g,b, 220 ), 1.02, "default-bold" )
			dxDrawImage(screenW * 0.4975, screenH * -0.0983, screenW * 0.0200, screenH * 0.2750, "images/dayzicons/vehicle/fuel/"..number..".png", 270, 0, 0, tocolor(255, 255, 255, 255), false)
			end
			local veh_health = getElementHealth(veh)
			if veh_health <= 1000 and veh_health >= 510 then
				number = 0
			elseif veh_health <= 500 and veh_health >= 310 then
				number = 1
			elseif veh_health <= 300 and veh_health >= 0 then
				number = 2
			end
			dxDrawImage(screenW * 0.3950, screenH * 0.0767, screenW * 0.0488, screenH * 0.0317, "images/dayzicons/vehicle/hull/hull_"..number..".png", 0, 0, 0, tocolor(255,255,255,255), false)
		end
		if not playerTarget then return end
		local x,y,z = getElementPosition(playerTarget)
		local x,y,distance = getScreenFromWorldPosition (x,y,z+0.5)
		distance = 20
		if getElementData(playerTarget,"bandit") then
			text = string.gsub(getPlayerName(playerTarget), '#%x%x%x%x%x%x', '' ).." (Bandit)"
		else
			text = string.gsub(getPlayerName(playerTarget), '#%x%x%x%x%x%x', '' )
		end
		local w = dxGetTextWidth(text,distance*0.033,"default-bold")
		dxDrawText (text,x-(w/2),y,x-(w/2), y, tocolor ( 100, 255, 100, 200 ), distance*0.033, "default-bold" )
	end	
end
addEventHandler ( "onClientRender", getRootElement(), updateIcons )

playerTarget = false
function targetingActivated ( target )
	if ( target ) and getElementType(target) == "player" then
		playerTarget = target
	else
		playerTarget = false
	end
end
addEventHandler ( "onClientPlayerTarget", getRootElement(), targetingActivated )

function dayZDeathInfo ()
	fadeCamera (false, 1.0, 0, 0, 0 ) 
	setTimer(showDayZDeathScreen,2000,1)
end
addEvent("onClientPlayerDeathInfo",true)
addEventHandler("onClientPlayerDeathInfo",getRootElement(),dayZDeathInfo)

function showDayZDeathScreen()
	setTimer ( fadeCamera, 1000, 1, true, 1.5 )
	deadBackground = guiCreateStaticImage(0,0,1,1,"images/dead.jpg",true)
	deathText = guiCreateLabel(0,0.8,1,0.2,"You died! \n You will respawn in 5 seconds.",true)
	guiLabelSetHorizontalAlign (deathText,"center")
	setTimer(guiSetVisible,5000,1,false)
	setTimer(guiSetVisible,5000,1,false)
	setTimer(destroyElement,5000,1,deathText)
	setTimer(destroyElement,5000,1,deadBackground)
end

--OnClientPlayerHit
whiteWindow = guiCreateStaticImage(0,0,1,1,"images/white.png",true)
guiSetVisible(whiteWindow,false)


function showPlayerDamageScreen (visibly2,stateControle2)
	guiSetVisible(whiteWindow,true)
	visibly = visibly2 or visibly
	stateControle = stateControle2 or stateControle
	if visibly >= 6*0.025 and stateControle == "up" then
		stateControle = "down"
	end
	if visibly < 0 then
		guiSetVisible(whiteWindow,false)
		return
	end
	if stateControle == "up" then
		visibly = visibly + 0.025
	elseif stateControle == "down" then
		visibly = visibly - 0.025
	end
	guiSetAlpha(whiteWindow,visibly)
	setTimer(showPlayerDamageScreen,50,1)
end

function showWhiteScreen ( attacker, weapon, bodypart )
	--if weapon then
		showPlayerDamageScreen (0,"up")
	--end
end
addEventHandler ( "onClientPlayerDamage", getLocalPlayer(), showWhiteScreen )

--[[
function destroyBlipGPS ()
local blips = getElementsByType("blip")
	for index, blip in ipairs(blips) do
		destroyElement(blip)
	end
local players = getElementsByType("player")
	for index, player in ipairs(players) do
		local blip = createBlipAttachedTo(player,0,2,255,255,255,180)
		setElementData(blip,"player",player)
		setBlipVisibleDistance(blip,0)
	end	
end		
setTimer(destroyBlipGPS,5000,0)

function showBlipGPS ()
local blips = getElementsByType("player")
if getElementData(getLocalPlayer(),"Thermal GPS") >= 1 then
	for index, blip in ipairs(blips) do
		local player = getElementData(blip,"player")
		setBlipVisibleDistance(blip,0)
		if getElementData(player,"temperature") >= 40 then
			if getElementData(player,"GPS Jammer") >= 1 then
				setBlipVisibleDistance(blip,0)
			else
				setBlipVisibleDistance(blip,180)
			end
		end	
	end
end	
end		
setTimer(showBlipGPS,500,0)
--addEventHandler ( "onClientHUDRender", getRootElement(), showBlipGPS )
]]

--[[
supportWindow = guiCreateStaticImage(0.05,0.25,0.9,0.5,"images/scrollmenu_1.png",true)
guiSetVisible(supportWindow,false)
supportGridlist = guiCreateGridList ( 0.05,0.1,0.9,0.7,true,supportWindow)
nameColumn = guiGridListAddColumn( supportGridlist, "Name", 0.2 )
messageColumn = guiGridListAddColumn( supportGridlist, "Message", 0.8 )
messageInput = guiCreateEdit( 0.05, 0.825, 0.9, 0.075, "", true,supportWindow )
closeButton = guiCreateButton( 0.9, 0.015, 0.09, 0.05, "Close", true, supportWindow )


function openSupportChat ()
	local showing = guiGetVisible(supportWindow)
	guiSetInputMode("no_binds_when_editing")
	guiSetVisible(supportWindow,not showing)
	if getElementData(getLocalPlayer(),"supporter") or getElementData(getLocalPlayer(),"admin") then
		guiSetVisible(supporterWindow,not showing)
	end
	if showing then
		guiSetVisible(supporterWindow,false)
	end
	showCursor(not showing)
	toggleControl ("chatbox",showing)
	if showing == false then
		unbindKey("o","down",openSupportChat)
		unbindKey("j","down",showInventory)
	else
		bindKey("o","down",openSupportChat)
		bindKey ("j","down",showInventory)
	end
end
bindKey("o","down",openSupportChat)

function outputEditBox ()
    local showing = guiGetVisible(supportWindow)
	guiSetVisible(supportWindow,false)
	showCursor(false)
	toggleControl ("chatbox",true) 
	bindKey("o","down",openSupportChat)
	bindKey ("j","down",showInventory)
end
addEventHandler ( "onClientGUIClick", closeButton, outputEditBox, false )
bindKey("o","down",outputEditBox)


addEventHandler( "onClientGUIAccepted", messageInput,
    function( theElement ) 
		if not isSpamTimer() then
			local text = guiGetText( theElement )
			triggerServerEvent ( "onServerSupportChatMessage", getLocalPlayer(),getLocalPlayer(),text)
		end
		setAntiSpamActive()
		guiSetText(messageInput,"")
    end
)

function outputSupportChat(sourcePlayer,text)
	local row = guiGridListAddRow ( supportGridlist )
	if sourcePlayer == "Sandra" or sourcePlayer == "James" or sourcePlayer == "Paul" then
		name =  sourcePlayer.." (Bot)"
	elseif not getElementData(sourcePlayer,"logedin") then
		name = string.gsub(getPlayerName ( sourcePlayer ), '#%x%x%x%x%x%x', '').." (Guest)"
	else
		if getElementData(sourcePlayer,"admin") then
			name = string.gsub(getPlayerName ( sourcePlayer ), '#%x%x%x%x%x%x', '').." (Admin)"
		elseif getElementData(sourcePlayer,"supporter") then
			name = string.gsub(getPlayerName ( sourcePlayer ), '#%x%x%x%x%x%x', '').." (Supporter)"
		else
			name = string.gsub(getPlayerName ( sourcePlayer ), '#%x%x%x%x%x%x', '').." (Player)"
		end
	end
	guiGridListSetItemText ( supportGridlist, row, nameColumn, name, false, false )
	guiGridListSetItemText ( supportGridlist, row, messageColumn,text , false, false )
	if sourcePlayer == "Sandra" then 
		r,g,b = 255,30,120
	elseif sourcePlayer == "James" or sourcePlayer == "Paul" then
		r,g,b = 255,255,22
	elseif getElementData(sourcePlayer,"admin") then
		r,g,b = 255,22,0
	elseif getElementData(sourcePlayer,"supporter") then
		r,g,b = 22,255,0
	else
		r,g,b = 255,255,255
	end
	guiGridListSetItemColor ( supportGridlist, row, nameColumn, r, g, b )
end
addEvent("onSupportChatMessage",true)
addEventHandler("onSupportChatMessage", getRootElement(),outputSupportChat,true)
]]
--[[
--------------------------------------------------------------------
Create the AntiSpam Support Chat
--------------------------------------------------------------------
]]


local antiSpamTimer = {}
function setAntiSpamActive()
	if not isTimer(antiSpamTimer) then
		antiSpamTimer = setTimer(killAntiSpamTimer,1000,1)
	else
		killTimer(antiSpamTimer)
		antiSpamTimer = setTimer(killAntiSpamTimer,2500,1)
	end
end

function isSpamTimer()
	if isTimer(antiSpamTimer) then 
		outputChatBox("Please do not spam the support chat!", 255, 255, 0,true)
		return true
	else
		return false
	end
end

function killAntiSpamTimer ()
	killTimer(antiSpamTimer)
end


--[[
--------------------------------------------------------------------
--Create Scoreboard
--------------------------------------------------------------------
]]

function getRankingPlayer (place)
return playerRankingTable[place]["Player"]
end

function getElementDataPosition(key,value)
	if key and value then
		local result = 1
		for i,player in pairs(getElementsByType("player")) do
			local data = tonumber(getElementData(player,key))
			if data then
				if data > value then 
					result = result+1
				end
			end
		end
		return result
	end
end

function positionGetElementData(key, positions)
	if key and positions then
		local Position = {}
		for index,player in pairs(getElementsByType("player")) do
			local data = tonumber(getElementData(player,key))
			if data then
				for i1=1, positions, 1 do
					if Position[tonumber(i1)] then
						if Position[tonumber(i1)]["Wert"] < tonumber(data) then
							local Position_Cache1 = Position[tonumber(i1)]["Player"]
							local Position_Cache2 = Position[tonumber(i1)]["Wert"]
							local Position_Cache3
							local Position_Cache4
							for i2=i1, positions, 1 do
								if Position[tonumber(i2)] then
									Position_Cache3 = Position[tonumber(i2)]["Player"]
									Position_Cache4 = Position[tonumber(i2)]["Wert"]
									Position[tonumber(i2)]["Player"] = Position_Cache1
									Position[tonumber(i2)]["Wert"] = Position_Cache2
									Position_Cache1 = Position_Cache3
									Position_Cache2 = Position_Cache4
								else
									Position[tonumber(i2)] = {}
									Position[tonumber(i2)]["Player"] = Position_Cache1
									Position[tonumber(i2)]["Wert"] = Position_Cache2
									break
								end
							end
							Position[tonumber(i1)] = {}
							Position[tonumber(i1)]["Player"] = player
							Position[tonumber(i1)]["Wert"] = data
							break
						end
					else
						Position[tonumber(i1)] = {}
						Position[tonumber(i1)]["Player"] = player
						Position[tonumber(i1)]["Wert"] = data
						break
					end
				end
			end
		end
		return Position
	end
end

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end

function formatTimeFromMinutes(value)
	if value then
		local hours = math.floor(value/60)
		local minutes = math.round(((value/60) - math.floor(value/60))*100/(100/60))
		if minutes < 10 then minutes = "0"..minutes end
		value = hours..":"..minutes
		return value
	end
	return false
end

playerRankingTable = {}

function checkTopPlayer()
	playerRankingTable = positionGetElementData("daysalive", #getElementsByType("player"))
end
checkTopPlayer()
setTimer(checkTopPlayer,10000,0)

function onQuitGame( reason )
    checkTopPlayer()
end
addEventHandler( "onClientPlayerQuit", getRootElement(), onQuitGame )

yA = 0
local screenWidth,screenHeight = guiGetScreenSize()
function scoreBoard ()
	if getKeyState( "tab" ) == false then return end
	if getElementData(getLocalPlayer(),"logedin") then
		local offset = dxGetFontHeight(1.55,"default-bold")
		--Background
		dxDrawImage ( screenWidth*0.15 , screenHeight*0.2, screenWidth*0.7, screenHeight*0.2+yA, "images/window_bg.png",0,0,0,tocolor(255,255,255))

		--Table Form
		dxDrawRectangle ( screenWidth*0.15, screenHeight*0.2+offset*2, screenWidth*0.7, screenHeight*0.0025, tocolor ( 255, 255, 255, 220 ) )

		--Table Spalten
		--Name
		dxDrawText ("Name", screenWidth*0.175 , screenHeight*0.2+offset, screenWidth*0.175 , screenHeight*0.2+offset, tocolor ( 50, 255, 50, 200 ), 1.5, "default-bold" )
		w1 = dxGetTextWidth("Name",1.5,"default-bold")
		--Murders
		dxDrawText ("Murders", screenWidth*0.3+w1*1.6, screenHeight*0.2+offset, screenWidth*0.3+w1*1.6 , screenHeight*0.2+offset, tocolor ( 50, 255, 50, 200 ), 1.5, "default-bold" )
		w2 = dxGetTextWidth("Murders",1.5,"default-bold")
		dxDrawRectangle ( screenWidth*0.3+w1*1.6-w2*0.1-(screenWidth*0.0025/2), screenHeight*0.2, screenWidth*0.0025, screenHeight*0.2+yA, tocolor ( 255, 255, 255, 220 ) )
		dxDrawRectangle ( screenWidth*0.3+w1*1.6+w2*1.1-(screenWidth*0.0025/2), screenHeight*0.2, screenWidth*0.0025, screenHeight*0.2+yA, tocolor ( 255, 255, 255, 220 ) )
		
		--Zombies Killed
		dxDrawText ("Zombies Killed", screenWidth*0.3+w1*1.6+w2*1.1-(screenWidth*0.0025/2)+w2*0.1, screenHeight*0.2+offset, screenWidth*0.3+w1*1.6 , screenHeight*0.2+offset, tocolor ( 50, 255, 50, 200 ), 1.5, "default-bold" )
		w3 = dxGetTextWidth("Zombies Killed",1.5,"default-bold")
		dxDrawRectangle ( screenWidth*0.3+w1*1.6+w2*1.1+w3+w2*0.1+(screenWidth*0.0025/2), screenHeight*0.2, screenWidth*0.0025, screenHeight*0.2+yA, tocolor ( 255, 255, 255, 220 ) )
		
		--Days Alive
		dxDrawText ("Days Alive", screenWidth*0.3+w1*1.6+w2*1.1+w3+w2*0.1+(screenWidth*0.0025/2)+w2*0.1, screenHeight*0.2+offset, screenWidth*0.3+w1*1.6 , screenHeight*0.2+offset, tocolor ( 50, 255, 50, 200 ), 1.5, "default-bold" )
		w4 = dxGetTextWidth("Days Alive",1.5,"default-bold")
		dxDrawRectangle ( screenWidth*0.3+w1*1.6+w2*1.1+w3+w2*0.1+(screenWidth*0.0025/2)+w2*0.1+w4+w2*0.1, screenHeight*0.2, screenWidth*0.0025, screenHeight*0.2+yA, tocolor ( 255, 255, 255, 220 ) )
		
		--Player Amount
		--dxDrawText ("Players:"..#getElementsByType("player"), screenWidth*0.3+w1*1.6+w2*1.1+w3+w2*0.1+(screenWidth*0.0025/2)+w2*0.1+w4+w2*0.1+w4/3, screenHeight*0.2+offset, screenWidth*0.8 , screenHeight*0.2+offset, tocolor ( 50, 255, 50, 200 ), 1.5, "default-bold" )

		--Player
		playerInList = false
		local playerAmount = #getElementsByType("player")
		if playerAmount > 10 then
			playerAmount = 10
		end
		for i = 1, playerAmount do
			yA = i*offset
			local offset2 = dxGetFontHeight(1.5,"default-bold")
			--Spiler Getten
			local player = getRankingPlayer(i) or false
			if not player then break end
			--Abfragen ob spieler == local Player
			r,g,b = 255,255,255
			if getPlayerName(player) == getPlayerName(getLocalPlayer()) then
				r,g,b = 50, 255, 50
				playerInList = true
			end
			--dxDrawImage(screenWidth*0.175 , screenHeight*0.2+offset*2+yA-offset2*0.1, screenWidth*0.65, offset2+offset2*0.1,"images/background_scoreboard.png", 0,0,0,tocolor(255,255,255,200), false)
			--Position
			dxDrawText (i, screenWidth*0.155 , screenHeight*0.2+offset*2+yA, screenWidth*0.175, screenHeight*0.2+offset+yA, tocolor ( r,g,b, 200 ), 1.5, "default-bold" )
			--Name
			dxDrawText (string.gsub(getPlayerName(player), '#%x%x%x%x%x%x', '' ), screenWidth*0.175 , screenHeight*0.2+offset*2+yA, screenWidth*0.175, screenHeight*0.2+offset+yA, tocolor ( r,g,b, 200 ), 1.5, "default-bold" )
			--Murders
			local murders = getElementData(player,"murders")
			dxDrawText (murders, screenWidth*0.3+w1*1.6 , screenHeight*0.2+offset*2+yA, screenHeight*0.2+offset*2+yA, screenHeight*0.2+offset+yA, tocolor ( r,g,b, 200 ), 1.5, "default-bold" )
			--Bandit
			--local bandit = getElementData(player,"bandit") 
			--if bandit then
			--	r1,g1,b1 = 255,0,0
			--else
			--	r1,g1,b1 = 0,255,0
			--end
			--dxDrawText ("☻◘☺", screenWidth*0.3+w1*1.6+w2*1.1-(screenWidth*0.0025/2)-w2/2,  screenHeight*0.2+offset*2+yA, screenWidth*0.3+w1*1.6+w2*1.1-(screenWidth*0.0025/2)-w2/2,  screenHeight*0.2+offset*2+yA, tocolor ( r1,g1,b1, 200 ), 1.5, "default-bold" )
			--Zombies Killed
			local zombieskilled = getElementData(player,"zombieskilled")
			dxDrawText (zombieskilled, screenWidth*0.3+w1*1.6+w2*1.1-(screenWidth*0.0025/2)+w2*0.1 , screenHeight*0.2+offset*2+yA, screenWidth*0.175, screenHeight*0.2+offset+yA, tocolor ( r,g,b, 200 ), 1.5, "default-bold" )
			--Alive Time
			local daysalive = getElementData(player,"daysalive") or 0
			--formatTimeFromMinutes(alivetime)
			dxDrawText (daysalive.." Day(s)", screenWidth*0.3+w1*1.6+w2*1.1+w3+w2*0.1+(screenWidth*0.0025/2)+w2*0.1 , screenHeight*0.2+offset*2+yA, screenWidth*0.175, screenHeight*0.2+offset+yA, tocolor ( r,g,b, 200 ), 1.5, "default-bold" )
		end
		playerLocalAdd = 0
		if not playerInList then
			playerLocalAdd = offset
			r,g,b = 50, 255, 50
			dxDrawRectangle ( screenWidth*0.15, screenHeight*0.2+offset*2+((playerAmount+2)*offset)-offset/2, screenWidth*0.7, screenHeight*0.0025, tocolor ( 255, 255, 255, 220 ) )
			--Position
			local rank = getElementDataPosition("daysalive",getElementData(getLocalPlayer(),"daysalive"))
			dxDrawText (rank, screenWidth*0.155 , screenHeight*0.2+offset*2+((playerAmount+2)*offset), screenWidth*0.175, screenHeight*0.2+offset*2+((playerAmount+2)*offset), tocolor ( r,g,b, 200 ), 1.5, "default-bold" )
			--Name
			dxDrawText (string.gsub(getPlayerName(getLocalPlayer()), '#%x%x%x%x%x%x', '' ), screenWidth*0.175 , screenHeight*0.2+offset*2+((playerAmount+2)*offset), screenWidth*0.175, screenHeight*0.2+offset+((playerAmount+2)*offset), tocolor ( r,g,b, 200 ), 1.5, "default-bold" )
			--Murders
			local murders = getElementData(getLocalPlayer(),"murders")
			dxDrawText (murders, screenWidth*0.3+w1*1.6 , screenHeight*0.2+offset*2+((playerAmount+2)*offset), screenWidth*0.175, screenHeight*0.2+offset+((playerAmount+2)*offset), tocolor ( r,g,b, 200 ), 1.5, "default-bold" )
			--Zombies Killed
			local zombieskilled = getElementData(getLocalPlayer(),"zombieskilled")
			dxDrawText (zombieskilled, screenWidth*0.3+w1*1.6+w2*1.1-(screenWidth*0.0025/2)+w2*0.1 , screenHeight*0.2+offset*2+((playerAmount+2)*offset), screenWidth*0.175, screenHeight*0.2+offset+((playerAmount+2)*offset), tocolor ( r,g,b, 200 ), 1.5, "default-bold" )
			--Alive Time
			local daysalive = getElementData(getLocalPlayer(),"daysalive") or 0
			--formatTimeFromMinutes(alivetime)
			dxDrawText (daysalive.." Day(s)", screenWidth*0.3+w1*1.6+w2*1.1+w3+w2*0.1+(screenWidth*0.0025/2)+w2*0.1 , screenHeight*0.2+offset*2+((playerAmount+2)*offset), screenWidth*0.175, screenHeight*0.2+offset+((playerAmount+2)*offset), tocolor ( r,g,b, 200 ), 1.5, "default-bold" )
		end
		yA = playerAmount*offset+playerLocalAdd
	end	
end
--addEventHandler ( "onClientRender", getRootElement(), scoreBoard )




--Vehicles In Water
function checkVehicleInWaterClient ()
	vehiclesInWater = {}
	for i,veh in ipairs(getElementsByType("vehicle")) do
		if isElementInWater(veh) then
				table.insert(vehiclesInWater,veh)
		end
	end
	triggerServerEvent("respawnVehiclesInWater",getLocalPlayer(),vehiclesInWater)
end
addEvent("checkVehicleInWaterClient",true)
addEventHandler("checkVehicleInWaterClient",getRootElement(),checkVehicleInWaterClient)

function updateDaysAliveTime()
	if getElementData(localPlayer,"logedin") then
		local daysalive = getElementData(localPlayer,"daysalive")
		setElementData(localPlayer,"daysalive",daysalive+1)
	end
end
setTimer(updateDaysAliveTime,2880000,0)

function updatePlayTime()
	if getElementData(getLocalPlayer(),"logedin") then
		local playtime = getElementData(getLocalPlayer(),"alivetime")
		setElementData(getLocalPlayer(),"alivetime",playtime+1)	
	end	
end
setTimer(updatePlayTime,60000,0)

bindKey("z", "down", "chatbox", "radiochat" )


local pingFails = 0
function playerPingCheck ()
	if getPlayerPing(getLocalPlayer()) > gameplayVariables["ping"] then
		pingFails = pingFails +1
		if pingFails == 5 then
			triggerServerEvent("kickPlayerOnHighPing",getLocalPlayer())
			return
		end
			startRollMessage2("Ping", "Your ping is over "..gameplayVariables["ping"].."! ("..pingFails.."/5)", 255, 22, 0 )
		if isTimer(pingTimer) then return end
		pingTimer = setTimer(function()
			pingFails = 0
		end,30000,1)
	end
end	
setTimer(playerPingCheck,4000,0)


--[[
local sx,sy = guiGetScreenSize()
number = 1
stamina = guiCreateLabel(0.56, 0.88, 0.2, 0.06, "STAMINA:", true)

function drawStaminaBar()
	if getElementData(localPlayer,"logedin") then
		dxDrawRectangle(sx - 352, sy - 55, 241, 15, tocolor(0, 0, 0, 150), true)
		dxDrawRectangle(sx - 350, sy - 53, (getElementData(localPlayer,"stamina")) / 100 * 237, 15, tocolor(66,66,111), true)
    else return
	end
end

addEventHandler("onClientRender",root,drawStaminaBar)

function getElementSpeed(element,unit)
	if (unit == nil) then unit = 0 end
	if (isElement(element)) then
		local x,y,z = getElementVelocity(element)
		if (unit=="mph" or unit==1 or unit =='1') then
			return (x^2 + y^2 + z^2) ^ 0.5 * 100
		else
			return (x^2 + y^2 + z^2) ^ 0.5 * 1.8 * 100
		end
	else
		outputDebugString("Not an element. Can't get speed")
		return false
	end
end


function onSpawn()
	setElementData(localPlayer,"stamina",100)
end
addEventHandler("onClientPlayerSpawn",root,onSpawn)


function staminaFunctions()
local staminaLevel = getElementData(localPlayer,"stamina") or 100
if (not isPedInVehicle(localPlayer)) and (not doesPedHaveJetPack(localPlayer)) and (isPedOnGround(localPlayer)) then
	local speed = getElementSpeed(localPlayer)
	local speedMath = math.ceil(speed) / number 
	if getElementData(localPlayer,"tired") == true then
		if staminaLevel == 100 then return end
	setElementData(localPlayer,"stamina", staminaLevel + 5)
	else
	if speed <= 30 then
		number = 100 
	else
		number = 10
	end
	setElementData(localPlayer,"stamina", staminaLevel - speedMath)
	end
	if speed <= 1 then
		if staminaLevel == 100 then return end
	setElementData(localPlayer,"stamina", staminaLevel + 5)
	end
	else
		if staminaLevel == 100 then return end
	setElementData(localPlayer,"stamina", staminaLevel + 5)
	end
end
setTimer(staminaFunctions,1000,0)


addEventHandler("onClientPreRender",root,function()
local staminaLevel = getElementData(localPlayer,"stamina") or 100
if staminaLevel > 100 then
	setElementData(localPlayer,"stamina", 100)
	setElementData(localPlayer,"tired",false)
end

if staminaLevel < 0 then
	setElementData(localPlayer,"stamina", 0)
end

if staminaLevel == 0 then
	setElementData(localPlayer,"stamina", 1)
	triggerServerEvent("tiredAnimation",root,localPlayer)
	end
end
)
]]


function abortAllStealthKills(targetPlayer)
    cancelEvent()
end
addEventHandler("onClientPlayerStealthKill", getLocalPlayer(), abortAllStealthKills)

function disableCameraOnSwitch ( prevSlot, newSlot )
	if getPedWeapon(getLocalPlayer(),newSlot) == 43 then 
		toggleControl ( "fire", false ) 
	else
		toggleControl ( "fire", true )
	end
end
addEventHandler ( "onClientPlayerWeaponSwitch", getRootElement(), disableCameraOnSwitch )


function getPlayerStance()
currentskin = getElementData(localPlayer,"skin")
	if currentskin == 285 then
		if getPedMoveState(localPlayer) == "stand" or getPedMoveState(localPlayer) == "crouch" then
			triggerServerEvent("onPlayerGhillieStateOn",localPlayer)
		else
			triggerServerEvent("onPlayerGhillieStateOff",localPlayer)
		end
	else
		triggerServerEvent("onPlayerGhillieStateOff",localPlayer)
	end
end
setTimer(getPlayerStance,3000,0)


-- DEBUG FUNCTIONS FOR DEVS ONLY!
--[[
devMode = false

function setDevModeOn(cmd)
	if getElementData(localPlayer,"admin") then
		if not devMode then
			outputChatBox("Dev Mode activated!",0,255,0)
			setElementData(localPlayer,"devmode",true)
			devMode = true
		else
			outputChatBox("Dev Mode is already active!",255,0,0,true)
		end
	else
		outputChatBox("You are not a developer!",255,0,0,true)
	end
end
addCommandHandler("devon",setDevModeOn)

function setDevModeOff(cmd)
	if getElementData(localPlayer,"admin") then
		if devMode then
			outputChatBox("Dev Mode deactivated!",0,255,0)
			setElementData(localPlayer,"devmode",false)
			devMode = false
		else
			outputChatBox("Dev Mode is already deactivated!",255,0,0,true)
		end
	else
		outputChatBox("You are not a developer!",255,0,0,true)
	end
end
addCommandHandler("devoff",setDevModeOff)

function onClientPlayerDev()
	if getElementData(localPlayer,"devmode") then
		if getElementData(localPlayer,"food") <= 50 then
			setElementData(localPlayer,"food",100)
		elseif getElementData(localPlayer,"thirst") <= 50 then
			setElementData(localPlayer,"thirst",100)
		elseif getElementData(localPlayer,"blood") <= 9000 then
			setElementData(localPlayer,"blood",12000)
		elseif getElementData(localPlayer,"bleeding") > 0 then
			setElementData(localPlayer,"bleeding",0)
		elseif getElementData(localPlayer,"brokenbone") then
			setElementData(localPlayer,"brokenbone",false)
		else return
		end
	else return
	end
end
setTimer(onClientPlayerDev,1000,0)
]]

local length = 3

function onClientPlayerWeaponSwitch(prevSlot,newSlot)
	if getPedWeapon(localPlayer,newSlot) == 8 then
		addEventHandler("onClientPreRender",root,onClientChainsawRender)
	else
		removeEventHandler("onClientPreRender",root,onClientChainsawRender)
	end
end

function onClientChainsawRender()
	local x, y, z = getElementPosition( localPlayer )
	local _, _, rz = getElementRotation( localPlayer )
	local tx = x + - ( length ) * math.sin( math.rad( rz ) )
	local ty = y + length * math.cos( math.rad( rz ) )
	local tz = z
	if getControlState( "fire" ) and getPedWeapon( localPlayer ) == 8 then
		local hit, hitX, hitY, hitZ, hitElement, normalX, normalY, normalZ, material, lighting, piece, worldID, worldX, worldY, worldZ, worldRX, worldRY, worldRZ, worldLODID = processLineOfSight( x, y, z, tx, ty, tz, true, false, false, true, true, false, false, false, localPlayer, true, false )

		if worldID and not startwoodtick and treelist[worldID] then
			local treename = treelist[worldID].name
			local interior = getElementInterior( localPlayer )

			if not startwoodtick then
				local anora = findDaVowel( treename )
				startwoodtick = getTickCount()

				triggerServerEvent( "onPlayerChopTree", localPlayer, worldID, worldX, worldY, worldZ, worldRX, worldRY, worldRZ, worldLODID, interior )
				startRollMessage2("Chopping", "You chopped down " .. anora .. " " .. treename, 0,255,0)
				if getPlayerCurrentSlots() <= getPlayerMaxAviableSlots() then
					setElementData(localPlayer,"Wood Pile",getElementData(localPlayer,"Wood Pile")+1)
					startRollMessage2("Chopping", "You got 1 'Wood Pile'!", 0,255,0)
				else
					startRollMessage2("Inventory", "Inventory is full!", 255, 22, 0)
				end
			end
		end

		if worldID then
			--dxDrawText( worldID, 300, 300 )
		end
	end

	if startwoodtick then
		currenttick = getTickCount() - startwoodtick

		if currenttick >= 2000 then
			chopping = false
			startwoodtick = nil
		end

		--dxDrawText( currenttick, 300, 300 )
	end

	--dxDrawLine3D( x, y, z, tx, ty, tz )
end

function findDaVowel( string )
	if vowels[string.sub( string:lower(), 1, 1 )] then
		return "an"
	else
		return "a"
	end
end

addEventHandler( "onClientPlayerWeaponSwitch", localPlayer, onClientPlayerWeaponSwitch )

function playCampfireSound()
	x = getElementData(source,"x")
	y = getElementData(source,"y")
	z = getElementData(source,"z")
	campfiresound = playSound3D("sounds/campfire.mp3",x,y,z,true)
end
addEvent("playCampfireSound",true)
addEventHandler("playCampfireSound",root,playCampfireSound)

function stopCampfireSound()
	stopSound(campfiresound)
end
addEvent("stopCampfireSound",true)
addEventHandler("stopCampfireSound",root,stopCampfireSound)


local PI = math.pi

local isEnabled = false
local wasInVehicle = isPedInVehicle(localPlayer)

local mouseSensitivity = 0.1
local rotX, rotY = 0,0
local mouseFrameDelay = 0
local idleTime = 2500
local fadeBack = false
local fadeBackFrames = 50
local executeCounter = 0
local recentlyMoved = false
local Xdiff,Ydiff

function toggleFPS()
weapon = getPedWeapon(localPlayer)
	if weapon ~= 34 then
		if (not isEnabled) then
			fadeCamera(false,0,0,0,0)
			setTimer(function() fadeCamera(true,1) end,100,1)
			isEnabled = true
			addEventHandler ("onClientPreRender", root, updateCamera)
			addEventHandler ("onClientCursorMove",root, freecamMouse)
		else
			fadeCamera(false,0,0,0,0)
			setTimer(function() fadeCamera(true,1) end,100,1)
			isEnabled = false
			setCameraTarget (localPlayer, localPlayer)
			removeEventHandler ("onClientPreRender", root, updateCamera)
			removeEventHandler ("onClientCursorMove", root, freecamMouse)
		end
	else
		return
	end
end
bindKey("o","down",toggleFPS)

function toggleViewIfSniper()
weapon = getPedWeapon(localPlayer)
	if isEnabled then
		if weapon == 34 then
			fadeCamera(false,0,0,0,0)
			setTimer(function() fadeCamera(true,1) end,100,1)
			isEnabled = false
			setCameraTarget (localPlayer, localPlayer)
			removeEventHandler ("onClientPreRender", root, updateCamera)
			removeEventHandler ("onClientCursorMove", root, freecamMouse)
		end
	else
		return
	end
end
addEventHandler("onClientPlayerWeaponSwitch",localPlayer,toggleViewIfSniper)

function updateCamera()
	if (isEnabled) then
		local nowTick = getTickCount()
		-- check if the last mouse movement was more than idleTime ms ago
		if wasInVehicle and recentlyMoved and not fadeBack and startTick and nowTick - startTick > idleTime then
			recentlyMoved = false
			fadeBack = true
			if rotX > 0 then
				Xdiff = rotX / fadeBackFrames
			elseif rotX < 0 then
				Xdiff = rotX / -fadeBackFrames
			end
			if rotY > 0 then
				Ydiff = rotY / fadeBackFrames
			elseif rotY < 0 then
				Ydiff = rotY / -fadeBackFrames
			end
		end		
		if fadeBack then	
			executeCounter = executeCounter + 1
			if rotX > 0 then
				rotX = rotX - Xdiff
			elseif rotX < 0 then
				rotX = rotX + Xdiff
			end
			if rotY > 0 then
				rotY = rotY - Ydiff
			elseif rotY < 0 then
				rotY = rotY + Ydiff
			end	
			if executeCounter >= fadeBackFrames then
				fadeBack = false
				executeCounter = 0
			end
		end
		local camPosXr, camPosYr, camPosZr = getPedBonePosition (localPlayer, 6)
		local camPosXl, camPosYl, camPosZl = getPedBonePosition (localPlayer, 7)
		local camPosX, camPosY, camPosZ = (camPosXr + camPosXl) / 2, (camPosYr + camPosYl) / 2, (camPosZr + camPosZl) / 2
		local roll = 0
		inVehicle = isPedInVehicle(localPlayer)
		-- note the vehicle rotation
		if inVehicle then
			local rx,ry,rz = getElementRotation(getPedOccupiedVehicle(localPlayer))	
			roll = -ry
			if rx > 90 and rx < 270 then
				roll = ry - 180
			end
			if not wasInVehicle then
				rotX = rotX + math.rad(rz) --prevent camera from rotation when entering a vehicle
				if rotY > -PI/15 then --force camera down if needed
					rotY = -PI/15 
				end
			end
			cameraAngleX = rotX - math.rad(rz)
			cameraAngleY = rotY + math.rad(rx)
			if getControlState("vehicle_look_behind") or ( getControlState("vehicle_look_right") and getControlState("vehicle_look_left") ) then
				cameraAngleX = cameraAngleX + math.rad(180)
				--cameraAngleY = cameraAngleY + math.rad(180)
			elseif getControlState("vehicle_look_left") then
				cameraAngleX = cameraAngleX - math.rad(90)
				--roll = rx doesn't work out well
			elseif getControlState("vehicle_look_right") then
				cameraAngleX = cameraAngleX + math.rad(90)  
				--roll = -rx
			end
		else
			local rx, ry, rz = getElementRotation(localPlayer)
			if wasInVehicle then
				rotX = rotX - math.rad(rz) --prevent camera from rotating when exiting a vehicle
			end
			cameraAngleX = rotX
			cameraAngleY = rotY
		end
		wasInVehicle = inVehicle
		--Taken from the freecam resource made by eAi
		-- work out an angle in radians based on the number of pixels the cursor has moved (ever)
		local freeModeAngleZ = math.sin(cameraAngleY)
		local freeModeAngleY = math.cos(cameraAngleY) * math.cos(cameraAngleX)
		local freeModeAngleX = math.cos(cameraAngleY) * math.sin(cameraAngleX)

		-- calculate a target based on the current position and an offset based on the angle
		local camTargetX = camPosX + freeModeAngleX * 100
		local camTargetY = camPosY + freeModeAngleY * 100
		local camTargetZ = camPosZ + freeModeAngleZ * 100

		-- Work out the distance between the target and the camera (should be 100 units)
		local camAngleX = camPosX - camTargetX
		local camAngleY = camPosY - camTargetY
		local camAngleZ = 0 -- we ignore this otherwise our vertical angle affects how fast you can strafe

		-- Calulcate the length of the vector
		local angleLength = math.sqrt(camAngleX*camAngleX+camAngleY*camAngleY+camAngleZ*camAngleZ)

		-- Normalize the vector, ignoring the Z axis, as the camera is stuck to the XY plane (it can't roll)
		local camNormalizedAngleX = camAngleX / angleLength
		local camNormalizedAngleY = camAngleY / angleLength
		local camNormalizedAngleZ = 0

		-- We use this as our rotation vector
		local normalAngleX = 0
		local normalAngleY = 0
		local normalAngleZ = 1

		-- Perform a cross product with the rotation vector and the normalzied angle
		local normalX = (camNormalizedAngleY * normalAngleZ - camNormalizedAngleZ * normalAngleY)
		local normalY = (camNormalizedAngleZ * normalAngleX - camNormalizedAngleX * normalAngleZ)
		local normalZ = (camNormalizedAngleX * normalAngleY - camNormalizedAngleY * normalAngleX)

		-- Update the target based on the new camera position (again, otherwise the camera kind of sways as the target is out by a frame)
		camTargetX = camPosX + freeModeAngleX * 100
		camTargetY = camPosY + freeModeAngleY * 100
		camTargetZ = camPosZ + freeModeAngleZ * 100

		-- Set the new camera position and target
		setCameraMatrix (camPosX, camPosY, camPosZ, camTargetX, camTargetY, camTargetZ, roll)
	end
end

function freecamMouse (cX,cY,aX,aY)
	--ignore mouse movement if the cursor or MTA window is on
	--and do not resume it until at least 5 frames after it is toggled off
	--(prevents cursor mousemove data from reaching this handler)
	if isCursorShowing() or isMTAWindowActive() then
		mouseFrameDelay = 5
		return
	elseif mouseFrameDelay > 0 then
		mouseFrameDelay = mouseFrameDelay - 1
		return
	end
	
	startTick = getTickCount()
	recentlyMoved = true
	
	-- check if the mouse is moved while fading back, if so abort the fading
	if fadeBack then
		fadeBack = false
		executeCounter = 0
	end
	
	-- how far have we moved the mouse from the screen center?
	local width, height = guiGetScreenSize()
	aX = aX - width / 2 
	aY = aY - height / 2
	
	rotX = rotX + aX * mouseSensitivity * 0.01745
	rotY = rotY - aY * mouseSensitivity * 0.01745

	local pRotX, pRotY, pRotZ = getElementRotation (localPlayer)
	pRotZ = math.rad(pRotZ)
	
	if rotX > PI then
		rotX = rotX - 2 * PI
	elseif rotX < -PI then
		rotX = rotX + 2 * PI
	end
	
	if rotY > PI then
		rotY = rotY - 2 * PI
	elseif rotY < -PI then
		rotY = rotY + 2 * PI
	end
	-- limit the camera to stop it going too far up or down
	if isPedInVehicle(localPlayer) then
		if rotY < -PI / 4 then
			rotY = -PI / 4
		elseif rotY > -PI/15 then
			rotY = -PI/15
		end
	else
		if rotY < -PI / 4 then
			rotY = -PI / 4
		elseif rotY > PI / 3.5 then
			rotY = PI / 3.5
		end
	end
end

local proned = false
local proneObject
local speed = 16
local animTimer
checkForHandler = false

function onPlayerProne(state)
	proned = state
	
	--NOTE: We had to re-apply the animation clientside due to a positioning bug with GTA. Go along with it.
	if not proned then
		setPedAnimation(localPlayer,"ped","getup_front",-1,false)
		if proneObject and isElement(proneObject) then destroyElement(proneObject) end
		if animTimer and isTimer(animTimer) then killTimer(animTimer) end
		animTimer = setTimer(setPedAnimation,1300,1,localPlayer)
		removeEventHandler("onClientRender",root,moveWhileProne)
		checkForHandler = false
	else
		setPedAnimation(localPlayer,"ped","FLOOR_hit_f",-1,false)	
		if proneObject and isElement(proneObject) then destroyElement(proneObject) end
		local x,y,z = getElementPosition(localPlayer)
		local rX,rY,rZ = getElementRotation(localPlayer)
		proneObject = createObject(2061,x,y,z,rX,rY,rZ)
		attachElements(localPlayer,proneObject,0,0,0)
		setElementCollisionsEnabled(proneObject,false)
		setElementAlpha(proneObject,0)
		addEventHandler("onClientRender",root,moveWhileProne)
		checkForHandler = false
	end
end
addEvent("onPlayerProne",true)
addEventHandler("onPlayerProne",root,onPlayerProne)

addEventHandler("onPlayerSpawn",root,
function()
	proned = false
	if checkForHandler then
		removeEventHandler("onClientRender",root,moveWhileProne)
		checkForHandler = false
	end
end)

function moveWhileProne()
	_pos = proneObject:getPosition()
	playerPosX, playerPosY, playerPosZ = getElementPosition(localPlayer)
	local bX,bY,bZ = getPedBonePosition(localPlayer,8)
	
	if isKeyDown("W") then
		pos = Vector3(playerPosX,playerPosY,playerPosZ) + proneObject.matrix.forward / speed	
		sightPos = Vector3(bX,bY,bZ) + proneObject.matrix.forward 
		if not isLineOfSightClear(_pos,sightPos,true,true,true,true,false,true,false,false) then
			-- Currently, the player is able to "glide" past some objects, such as walls of buildings. This causes him to fall below the map. Any fix?
			pos = (Vector3(playerPosX,playerPosY,playerPosZ) + (proneObject.matrix.up/10)) + (proneObject.matrix.forward/8)
		end
	elseif isKeyDown("A") then
		pos = _pos - localPlayer.matrix.right / speed
		sightPos = _pos - localPlayer.matrix.right * 1.25
		if not isLineOfSightClear(_pos,sightPos,true,true,true,true,false,false,false,false) then
			pos = _pos --revert
		end
	elseif isKeyDown("S") then
		pos = Vector3(playerPosX,playerPosY,playerPosZ) - proneObject.matrix.forward / speed
		sightPos = Vector3(bX,bY,bZ) - proneObject.matrix.forward 
		if not isLineOfSightClear(_pos,sightPos,true,true,true,true,false,false,false,false) then
			pos = _pos
		end
	elseif isKeyDown("D") then
		pos = pos + localPlayer.matrix.right / speed
		sightPos = _pos + localPlayer.matrix.right * 1.25
		if not isLineOfSightClear(_pos,sightPos,true,true,true,true,false,false,false,false) then
			pos = _pos
		end
	end
	
	if isKeyDown("W") or isKeyDown("A") or isKeyDown("S") or isKeyDown("D") then
		setElementPosition(proneObject,pos)
	end
	
	isOnGround = isPedOnGround(localPlayer)
	isInWater = isElementInWater(localPlayer)
	x,y,z = getElementPosition(localPlayer)
	gPos = getGroundPosition(x,y,z)
	
	if not isOnGround then
		if not isInWater then
			if gPos > -45 then
				DownPos = (Vector3(playerPosX,playerPosY,playerPosZ) - (proneObject.matrix.up/10)) + (proneObject.matrix.forward/8)
			end
			setElementPosition(proneObject,DownPos)
		end
	end
	
	--Update the rotation based on the camera's rotation
	setElementRotation(localPlayer,0,0,360 - getPedCameraRotation(localPlayer))
	setElementRotation(proneObject,0,0,360 - getPedCameraRotation(localPlayer))
end


function isKeyDown(key)
	if getKeyState(key) then return true else return false end
end
--[[
#---------------------------------------------------------------#
----*			DayZ MTA Script survivor_system.lua			*----
----* This Script is owned by Marwin, you are not allowed to use or own it.
----* Owner: Marwin W., Germany, Lower Saxony, Otterndorf
----* Skype: xxmavxx96
----*														*----
#---------------------------------------------------------------#
]]

--local dayzTheme = dxGetTheme("Orange")
--dxCreateWindow(0.2*sx,0.2*sy,0.6*sx,0.6*sy,"test",tocolor(255,255,255),nil,orange)

--version drawing
addEventHandler("onClientResourceStart", getResourceRootElement(),
	function()
		dayzVersion = "MTA:DayZ 0.6"
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
snipertxd = engineLoadTXD ("mods/sniper.txd");
engineImportTXD (snipertxd, 285);
sniperdff = engineLoadDFF ("mods/sniper.dff", 285);
engineReplaceModel (sniperdff, 285);
--Civilian (Male)
snipertxd = engineLoadTXD ("mods/civilian.txd");
engineImportTXD (snipertxd, 179);
sniperdff = engineLoadDFF ("mods/civilian.dff", 179);
engineReplaceModel (sniperdff, 179);

-- MODELS: http://wiki.multitheftauto.com/wiki/Character_Skins

-- Civilian (Female)
snipertxd = engineLoadTXD ("mods/civilian_female.txd");
engineImportTXD (snipertxd, MODEL ID);
sniperdff = engineLoadDFF ("mods/civilian_female.dff", MODEL ID);
engineReplaceModel (sniperdff, MODEL ID);

-- Survivor(Female)
snipertxd = engineLoadTXD ("mods/survivor_female.txd");
engineImportTXD (snipertxd, MODEL ID);
sniperdff = engineLoadDFF ("mods/survivor_female.dff", MODEL ID);
engineReplaceModel (sniperdff, MODEL ID);


--Bandit1 (Male)
snipertxd = engineLoadTXD ("mods/bandit3.txd");
engineImportTXD (snipertxd, 180);
sniperdff = engineLoadDFF ("mods/bandit3.dff", 180);
engineReplaceModel (sniperdff, 180);
--Bandit2 (Male)
snipertxd = engineLoadTXD ("mods/bandit2.txd");
engineImportTXD (snipertxd, 288);
sniperdff = engineLoadDFF ("mods/bandit2.dff", 288);
engineReplaceModel (sniperdff, 288);
--Bandit1 (Female)
snipertxd = engineLoadTXD ("mods/bandit_female1.txd");
engineImportTXD (snipertxd, MODEL ID);
sniperdff = engineLoadDFF ("mods/bandit_female2.dff", MODEL ID);
engineReplaceModel (sniperdff, MODEL ID);
--Bandit2 (Female)
snipertxd = engineLoadTXD ("mods/bandit_female2.txd");
engineImportTXD (snipertxd, MODEL ID);
sniperdff = engineLoadDFF ("mods/bandit_female2.dff", MODEL ID);
engineReplaceModel (sniperdff, MODEL ID);
--Standard (Male)
snipertxd = engineLoadTXD ("mods/standart.txd");
engineImportTXD (snipertxd, 73);
sniperdff = engineLoadDFF ("mods/standart.dff", 73);
engineReplaceModel (sniperdff, 73);
-- Standard (Female)
snipertxd = engineLoadTXD ("mods/femalestandard.txd");
engineImportTXD (snipertxd, 191);
sniperdff = engineLoadDFF ("mods/femalestandard.dff", 191);
engineReplaceModel (sniperdff, 191);
--Hero
snipertxd = engineLoadTXD ("mods/hero.txd");
engineImportTXD (snipertxd, 210);
sniperdff = engineLoadDFF ("mods/hero.dff", 210);
engineReplaceModel (sniperdff, 210);
-- Camouflage (Female)
snipertxd = engineLoadTXD ("mods/camouflage_female.txd");
engineImportTXD (snipertxd, MODEL ID);
sniperdff = engineLoadDFF ("mods/camouflage_female.dff", MODEL ID);
engineReplaceModel (sniperdff, MODEL ID);


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

-- [XR]
itemTXD = engineLoadTXD ("items/backpack_british.txd"); -- British Backpack
engineImportTXD (itemTXD, ID);
itemDFF = engineLoadDFF ("items/backpack_british.dff", ID);
engineReplaceModel (itemDFF, ID);

itemTXD = engineLoadTXD ("items/backpack_british.txd"); -- Camouflage Pack
engineImportTXD (itemTXD, ID);
itemDFF = engineLoadDFF ("items/backpack_british.dff", ID);
engineReplaceModel (itemDFF, ID);

itemTXD = engineLoadTXD ("items/backpack_british.txd"); -- Camp Pack
engineImportTXD (itemTXD, ID);
itemDFF = engineLoadDFF ("items/backpack_british.dff", ID);
engineReplaceModel (itemDFF, ID);

itemTXD = engineLoadTXD ("items/backpack_british.txd"); -- Krysset Pack
engineImportTXD (itemTXD, ID);
itemDFF = engineLoadDFF ("items/backpack_british.dff", ID);
engineReplaceModel (itemDFF, ID);

itemTXD = engineLoadTXD ("items/backpack_british.txd"); -- Ghillie Pack 
engineImportTXD (itemTXD, ID);
itemDFF = engineLoadDFF ("items/backpack_british.dff", ID);
engineReplaceModel (itemDFF, ID);

itemTXD = engineLoadTXD ("items/backpack_british.txd"); -- Light Pack
engineImportTXD (itemTXD, ID);
itemDFF = engineLoadDFF ("items/backpack_british.dff", ID);
engineReplaceModel (itemDFF, ID);

itemTXD = engineLoadTXD ("items/backpack_british.txd"); -- Military Pack
engineImportTXD (itemTXD, ID);
itemDFF = engineLoadDFF ("items/backpack_british.dff", ID);
engineReplaceModel (itemDFF, ID);

itemTXD = engineLoadTXD ("items/backpack_british.txd"); -- OS Pack
engineImportTXD (itemTXD, ID);
itemDFF = engineLoadDFF ("items/backpack_british.dff", ID);
engineReplaceModel (itemDFF, ID);

itemTXD = engineLoadTXD ("items/backpack_british.txd"); -- RSS Pack
engineImportTXD (itemTXD, ID);
itemDFF = engineLoadDFF ("items/backpack_british.dff", ID);
engineReplaceModel (itemDFF, ID);

itemTXD = engineLoadTXD ("items/backpack_british.txd"); -- Soldier Pack
engineImportTXD (itemTXD, ID);
itemDFF = engineLoadDFF ("items/backpack_british.dff", ID);
engineReplaceModel (itemDFF, ID);

itemTXD = engineLoadTXD ("items/tent.txd");
engineImportTXD (itemTXD, 3243);
itemDFF = engineLoadDFF ("items/tent.dff", 3243);
engineReplaceModel (itemDFF, 3243);

itemTXD = engineLoadTXD ("items/wirefence.txd");
engineImportTXD (itemTXD, 983);
itemDFF = engineLoadDFF ("items/wirefence.dff", 983);
engineReplaceModel (itemDFF, 983);

--Weapons

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

function playerStatsClientSite()
	if getElementData(getLocalPlayer(),"logedin") then
		toggleControl ("radar",false)
		showPlayerHudComponent ("clock",false) 
		showPlayerHudComponent ("radar",false)
		showPlayerHudComponent ("money",false) 
		showPlayerHudComponent ("health",false) 
		showPlayerHudComponent ("breath",false) 
		if getElementData(getLocalPlayer(),"Map") >= 1  then
			toggleControl ("radar",true)
		end
		if getElementData(getLocalPlayer(),"GPS") >= 1  then
			showPlayerHudComponent ("radar",true) 
		end
		if getElementData(getLocalPlayer(),"Watch") >= 1 then
			showPlayerHudComponent ("clock",true) 
		end
	end
end
setTimer(playerStatsClientSite,1000,0)

function playerZoom (key,keyState)
	if key == "n" then
		if getElementData(getLocalPlayer(),"Night Vision Goggles") > 0 then
			if nightvision then
				nightvision = false
				setCameraGoggleEffect("normal")
				local hour, minutes = getTime()
				if gameplayVariables["enablenight"] then
					setClientNight (hour,minutes)
				end
			else 
				nightvision = true
				setCameraGoggleEffect("nightvision")
				setFarClipDistance(1000)
			end
		end
	elseif key == "i" then
		if getElementData(getLocalPlayer(),"Infrared Goggles") > 0 then
			if infaredvision then
				infaredvision = false
				setCameraGoggleEffect("normal")
				if gameplayVariables["enablenight"] then
					setClientNight (hour,minutes)
				end
			else 
				 infaredvision = true
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

local daysounds = {"sounds/day1.mp3", "sounds/day2.mp3", "sounds/day3.mp3", "sounds/day4.mp3", "sounds/day5.mp3"}
local nightsounds = {"sounds/night1.mp3", "sounds/night2.mp3", "sounds/night3.mp3", "sounds/night4.mp3"}


function PlayDaySounds(hour,minutes)
	local hour = getTime()
	if hour >= 7 and hour <= 23 then
		playSound(daysounds[math.random(1, #daysounds)], false)
	end
end
setTimer(PlayDaySounds, 300000, 0)

function PlayNightSounds(hour,minutes)
	local hour = getTime()
	if hour >= 0 and hour <= 7 then
		playSound(nightsounds[math.random(1, #nightsounds)], false)
	end
end
setTimer(PlayNightSounds, 300000, 0)


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
setTimer(stopZombieSound,5000,0)

--SKIN REPLACEMENTS
	local skin = engineLoadTXD ( "skins/22.txd" ) -- slashed 12 by Wall-E
	engineImportTXD ( skin, 22 )	
	local skin = engineLoadTXD ( "skins/56.txd" ) --young and blue by Slothman
	engineImportTXD ( skin, 56 )
	local skin = engineLoadTXD ( "skins/67.txd" ) -- slit r* employee
	engineImportTXD ( skin, 67 )
	local skin = engineLoadTXD ( "skins/68.txd" ) -- shredded preist by Deixell
	engineImportTXD ( skin, 68 )
	local skin = engineLoadTXD ( "skins/69.txd" ) --bleedin eyes in denim by Capitanazop
	engineImportTXD ( skin, 69 )
	local skin = engineLoadTXD ( "skins/70.txd" ) --ultra gory scientist by 50p
	engineImportTXD ( skin, 70 )
	local skin = engineLoadTXD ( "skins/84.txd" ) --guitar wolf (nonzombie) by Slothman
	engineImportTXD ( skin, 84 )
	local skin = engineLoadTXD ( "skins/92.txd" ) -- peeled flesh by xbost
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
	local skin = engineLoadTXD ( "skins/105.txd" ) --Scarred Grove Gangster by Wall-E
	engineImportTXD ( skin, 105 )
	local skin = engineLoadTXD ( "skins/107.txd" ) --ripped and slashed grove by Wall-E
	engineImportTXD ( skin, 107 )
	local skin = engineLoadTXD ( "skins/108.txd" ) -- skeleton thug by Deixell
	engineImportTXD ( skin, 108 )
	local skin = engineLoadTXD ( "skins/111.txd" ) --Frank West from dead rising (nonzombie) by Slothman
	engineImportTXD ( skin, 111 )
	local skin = engineLoadTXD ( "skins/126.txd" ) -- bullet ridden wiseguy by Slothman
	engineImportTXD ( skin, 126 )
	local skin = engineLoadTXD ( "skins/127.txd" ) --flyboy from dawn of the dead by Slothman
	engineImportTXD ( skin, 127 )
	local skin = engineLoadTXD ( "skins/128.txd" ) --holy native by Slothman
	engineImportTXD ( skin, 128 )
	local skin = engineLoadTXD ( "skins/152.txd" ) --bitten schoolgirl by Slothman
	engineImportTXD ( skin, 152 )
	local skin = engineLoadTXD ( "skins/162.txd" ) --shirtless redneck by Slothman
	engineImportTXD ( skin, 162 )
	local skin = engineLoadTXD ( "skins/167.txd" ) --dead chickenman by 50p
	engineImportTXD ( skin, 167 )
	local skin = engineLoadTXD ( "skins/188.txd" ) --burnt greenshirt by Slothman
	engineImportTXD ( skin, 188 )
	local skin = engineLoadTXD ( "skins/192.txd" ) --Alice from resident evil (nonzombie) by Slothman
	engineImportTXD ( skin, 192 )
	local skin = engineLoadTXD ( "skins/195.txd" ) --bloody ex by Slothman
	engineImportTXD ( skin, 195 )
	local skin = engineLoadTXD ( "skins/206.txd" ) -- faceless zombie by Slothman
	engineImportTXD ( skin, 206 )
	local skin = engineLoadTXD ( "skins/209.txd" ) --Noodle vendor by 50p
	engineImportTXD ( skin, 209 )
	local skin = engineLoadTXD ( "skins/212.txd" ) --brainy hobo by Slothman
	engineImportTXD ( skin, 212 )
	local skin = engineLoadTXD ( "skins/229.txd" ) --infected tourist by Slothman
	engineImportTXD ( skin, 229 )
	local skin = engineLoadTXD ( "skins/230.txd" ) --will work for brains hobo by Slothman
	engineImportTXD ( skin, 230 )
	local skin = engineLoadTXD ( "skins/258.txd" ) --bloody sided suburbanite by Slothman
	engineImportTXD ( skin, 258 )
	local skin = engineLoadTXD ( "skins/264.txd" ) --scary clown by 50p
	engineImportTXD ( skin, 264 )
	local skin = engineLoadTXD ( "skins/274.txd" ) --Ash Williams (nonzombie) by Slothman
	engineImportTXD ( skin, 274 )
	local skin = engineLoadTXD ( "skins/277.txd" ) -- gutted firefighter by Wall-E
	engineImportTXD ( skin, 277 )
	local skin = engineLoadTXD ( "skins/280.txd" ) --infected cop by Lordy
	engineImportTXD ( skin, 280 )

	
-- PLAY ZOMBIE SOUNDS
--local Zx,Zy,Zz = getElementPosition( ped )
--local sound = playSound3D("sounds/mgroan"..randnum..".ogg", Zx, Zy, Zz, false)
--setSoundMaxDistance(sound, 20)

	
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

statsWindows = guiCreateStaticImage(0.775,0.2,0.225,0.22,"images/scrollmenu_1.png",true)
guiSetAlpha(statsWindows,0.8)
--Zombies  Killed
statsLabel["zombieskilled"] = guiCreateLabel(0,0.05,1,0.15,"Zombies killed: 0",true,statsWindows)
guiLabelSetHorizontalAlign (statsLabel["zombieskilled"],"center")
guiSetFont (statsLabel["zombieskilled"], "default-bold-small" )
setElementData(statsLabel["zombieskilled"],"identifikation","zombieskilled")
--Headshots
statsLabel["headshots"] = guiCreateLabel(0,0.15,1,0.15,"Headshots: 0",true,statsWindows)
guiLabelSetHorizontalAlign (statsLabel["headshots"],"center")
guiSetFont (statsLabel["headshots"], "default-bold-small" )
setElementData(statsLabel["headshots"],"identifikation","headshots")
--Murders
statsLabel["murders"] = guiCreateLabel(0,0.25,1,0.15,"Murders: 0",true,statsWindows)
guiLabelSetHorizontalAlign (statsLabel["murders"],"center")
guiSetFont (statsLabel["murders"], "default-bold-small" )
setElementData(statsLabel["murders"],"identifikation","murders")
--Bandits Killed
statsLabel["banditskilled"] = guiCreateLabel(0,0.35,1,0.15,"Bandits killed: 0",true,statsWindows)
guiLabelSetHorizontalAlign (statsLabel["banditskilled"],"center")
guiSetFont (statsLabel["banditskilled"], "default-bold-small" )
setElementData(statsLabel["banditskilled"],"identifikation","banditskilled")
--Blood
statsLabel["blood"] = guiCreateLabel(0,0.45,1,0.15,"Blood: 12000",true,statsWindows)
guiLabelSetHorizontalAlign (statsLabel["blood"],"center")
guiSetFont (statsLabel["blood"], "default-bold-small" )
setElementData(statsLabel["blood"],"identifikation","blood")
--Zombies
statsLabel["zombies"] = guiCreateLabel(0,0.55,1,0.15,"Zombies (Alive/Total): 0/0",true,statsWindows)
guiLabelSetHorizontalAlign (statsLabel["zombies"],"center")
guiSetFont (statsLabel["zombies"], "default-bold-small" )
setElementData(statsLabel["zombies"],"identifikation","zombies")
--Temperature
statsLabel["temperature"] = guiCreateLabel(0,0.65,1,0.15,"Temperature: 37°C",true,statsWindows)
guiLabelSetHorizontalAlign (statsLabel["temperature"],"center")
guiSetFont (statsLabel["temperature"], "default-bold-small" )
setElementData(statsLabel["temperature"],"identifikation","temperature")
--Humanity
statsLabel["humanity"] = guiCreateLabel(0,0.75,1,0.15,"Humanity: 2500",true,statsWindows)
guiLabelSetHorizontalAlign (statsLabel["humanity"],"center")
guiSetFont (statsLabel["humanity"], "default-bold-small" )
setElementData(statsLabel["humanity"],"identifikation","humanity")
--Name
statsLabel["name"] = guiCreateLabel(0,0.85,1,0.15,"Name: "..getPlayerName(getLocalPlayer()),true,statsWindows)
guiLabelSetHorizontalAlign (statsLabel["name"],"center")
guiSetFont (statsLabel["name"], "default-bold-small" )
setElementData(statsLabel["name"],"identifikation","name")

if getElementData(localPlayer,"logedin") then
	guiSetVisible(statsWindows,true)
else
	guiSetVisible(statsWindows,false)
end

function showDebugMonitor ()
	local visible = guiGetVisible(statsWindows)
	guiSetVisible(statsWindows,not visible)
end
bindKey("F5","down",showDebugMonitor)

function showDebugMintorOnLogin ()
	guiSetVisible(statsWindows,true)
end
addEvent("onClientPlayerDayZLogin", true)
addEventHandler("onClientPlayerDayZLogin", root, showDebugMintorOnLogin)

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


["M1911 Mag"] = {
{"M1911",22},
},

["M9 SD Mag"] = {
{"M9 SD",23},
},

["Desert Eagle Mag"] = {
{"Desert Eagle",24},
},

["PDW Mag"] = {
{"PDW",28},
},

["MP5A5 Mag"] = {
{"MP5A5",29},
},

["AK Mag"] = {
{"AK-47",30},
},

["M4 Mag"] = {
{"M4",31},
},

["1866 Slug"] = {
{"Winchester 1866",25},
},


["2Rnd. Slug"] = {
{"Sawn-Off Shotgun",26},
},

["SPAZ-12 Pellet"] = {
{"SPAZ-12 Combat Shotgun",27},
},

["CZ 550 Mag"] = {
{"CZ 550",34},
},

["Lee Enfield Mag"] = {
{"Lee Enfield",33},
},

["M136 Rocket"] = {
{"Heat-Seeking RPG",36},
{"M136 Rocket Launcher",35},
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
{"Radio Device",1},
},
}

function getWeaponAmmoType (weaponName)
	for i,weaponData in ipairs(weaponAmmoTable["others"]) do
		if weaponName == weaponData[1] then
			return weaponData[1],weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["M1911 Mag"]) do
		if weaponName == weaponData[1] then
			return "M1911 Mag",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["M9 SD Mag"]) do
		if weaponName == weaponData[1] then
			return "M9 SD Mag",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["Desert Eagle Mag"]) do
		if weaponName == weaponData[1] then
			return "Desert Eagle Mag",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["PDW Mag"]) do
		if weaponName == weaponData[1] then
			return "PDW Mag",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["MP5A5 Mag"]) do
		if weaponName == weaponData[1] then
			return "MP5A5 Mag",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["AK Mag"]) do
		if weaponName == weaponData[1] then
			return "AK Mag",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["M4 Mag"]) do
		if weaponName == weaponData[1] then
			return "M4 Mag",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["1866 Slug"]) do
		if weaponName == weaponData[1] then
			return "1866 Slug",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["SPAZ-12 Pellet"]) do
		if weaponName == weaponData[1] then
			return "SPAZ-12 Pellet",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["2Rnd. Slug"]) do
		if weaponName == weaponData[1] then
			return "2Rnd. Slug",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["CZ 550 Mag"]) do
		if weaponName == weaponData[1] then
			return "CZ 550 Mag",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["Lee Enfield Mag"]) do
		if weaponName == weaponData[1] then
			return "Lee Enfield Mag",weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["M136 Rocket"]) do
		if weaponName == weaponData[1] then
			return "M136 Rocket",weaponData[2]
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
					return weapon2[2]*0.3
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
	if weapon == 37 then
		return
	end
	if getElementData(attacker,"zombie") then
		setElementData(getLocalPlayer(),"blood",getElementData(getLocalPlayer(),"blood")-gameplayVariables["zombiedamage"])
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
		if bodypart == 9 then
			damage = damage*1.5
			headshot = true
		end
		if bodypart == 7 or bodypart == 8 then
			setElementData(getLocalPlayer(),"brokenbone",true)
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
				damage = damage*1.5
				headshot = true
			end
			setElementData(source,"blood",getElementData(source,"blood")-math.random(damage*0.75,damage*1.25))
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
		if getElementData(getLocalPlayer(),"temperature") <= 31 then
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
		end	
	end	
end
setTimer(setCold,1500,0)

function setVolume()
	value = 0
	if getPedMoveState (getLocalPlayer()) == "stand" then
		value = 0
	elseif getPedMoveState (getLocalPlayer()) == "walk" then
		value = 20
	elseif getPedMoveState (getLocalPlayer()) == "powerwalk" then
		value = 40
	elseif getPedMoveState (getLocalPlayer()) == "jog" then
		value = 80
	elseif getPedMoveState (getLocalPlayer()) == "sprint" then	
		value = 100
	elseif getPedMoveState (getLocalPlayer()) == "crouch" then	
		value = 0
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
	setElementData(getLocalPlayer(),"volume",value)
end
setTimer(setVolume,100,0)

function setVisibility()
	value = 0
	if getPedMoveState (getLocalPlayer()) == "stand" then
		value = 60
	elseif getPedMoveState (getLocalPlayer()) == "walk" then
		value = 60
	elseif getPedMoveState (getLocalPlayer()) == "powerwalk" then
		value = 60
	elseif getPedMoveState (getLocalPlayer()) == "jog" then
		value = 60
	elseif getPedMoveState (getLocalPlayer()) == "sprint" then	
		value = 60
	elseif getPedMoveState (getLocalPlayer()) == "crouch" then	
		value = 20
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

weaponNoiseTable = {
{22,20},
{23,0},
{24,60},
{28,40},
{32,40},
{29,40},
{30,60},
{31,60},
{25,40},
{26,60},
{27,60},
{33,40},
{34,60},
{36,60},
{35,60},
}
--0 none
--20 low
--40 moderate
--60 high

function getWeaponNoise(weapon)
	for i,weapon2 in ipairs(weaponNoiseTable) do
		if weapon == weapon2[1] then
			return weapon2[2]
		end
	end
	return 0
end

function debugShooting()
	if getControlState("fire") then
		local weapon = getPedWeapon(getLocalPlayer())
		local noise = getWeaponNoise(weapon) or 0
		setElementData(getLocalPlayer(),"shooting",noise)
		if shootTimer then
			killTimer(shootTimer)
		end
		shootTimer = setTimer(debugShooting2,100,1)
	end
end
setTimer(debugShooting,100,0)

function debugShooting2()
	setElementData(getLocalPlayer(),"shooting",0)
	shootTimer = false
end

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
	for i,ped in ipairs(getElementsByType("ped")) do
		if getElementData(ped,"zombie") then
			local sound = getElementData(getLocalPlayer(),"volume")/5
			local visibly = getElementData(getLocalPlayer(),"visibly")/5
			local xZ,yZ,zZ = getElementPosition(ped)
			if getDistanceBetweenPoints3D (x,y,z,xZ,yZ,zZ) < sound+visibly then
				if getElementData ( ped, "leader" ) == nil then
					triggerServerEvent("botAttack",getLocalPlayer(),ped)
				end
			else
				if getElementData ( ped, "target" ) == getLocalPlayer() then
					setElementData(ped,"target",nil)
				end
				if getElementData ( ped, "leader" ) == getLocalPlayer() then
					triggerServerEvent("botStopFollow",getLocalPlayer(),ped)
				end
			end
		end
	end
end
setTimer(checkZombies3,500,0)

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
		if sound > 1 then
			dxDrawImage ( screenWidth*0.9075 , screenHeight*0.41, screenHeight*0.075, screenHeight*0.075, "images/dayzicons/level_"..sound..".png",0,0,0,tocolor(0,255,0))
		end
		--visibly
		dxDrawImage ( screenWidth*0.9325 , screenHeight*0.475, screenHeight*0.075, screenHeight*0.075, "images/dayzicons/eye.png",0,0,0,tocolor(0,255,0))
		local sound = getElementData(getLocalPlayer(),"visibly")/20
		if sound > 1 then
			dxDrawImage ( screenWidth*0.9075 , screenHeight*0.475, screenHeight*0.075, screenHeight*0.075, "images/dayzicons/level_"..sound..".png",0,0,0,tocolor(0,255,0))
		end
		--brokenbone
		if getElementData(getLocalPlayer(),"brokenbone") then
			dxDrawImage ( screenWidth*0.9375 , screenHeight*0.55, screenHeight*0.065, screenHeight*0.065, "images/dayzicons/brokenbone.png",0,0,0,tocolor(255,255,255))
		end
		--bandit	
		local humanity =  getElementData(getLocalPlayer(),"humanity")
		if humanity > 0 then
			local humanity =  getElementData(getLocalPlayer(),"humanity")/9.8
			r,g,b = 255-humanity,humanity,0
		else	
			r,g,b = 255,0,0
		end
			dxDrawImage ( screenWidth*0.925 , screenHeight*0.6, screenHeight*0.1, screenHeight*0.1, "images/dayzicons/bandit.png",0,0,0,tocolor(r,g,b))
		--temperature
		local temperature = math.round(getElementData(getLocalPlayer(),"temperature"),2)
		r,g,b = 0,255,0
		if temperature <= 37 then
			value = (37-temperature)*42.5
			r,g,b = 0,255-value,value
		elseif temperature > 37 and temperature < 41 then
			r,g,b = 0,255,0
		elseif temperature == 41 then
			r,g,b = 255,0,0
		end
		if value > 215 then
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.7, screenHeight*0.065, screenHeight*0.065, "images/dayzicons/temperature.png",0,0,0,tocolor(r,g,b,fading))
		else
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.7, screenHeight*0.065, screenHeight*0.065, "images/dayzicons/temperature.png",0,0,0,tocolor(r,g,b))
		end
		--thirsty
		r,g,b = 0,255,0
		local thirst = getElementData(getLocalPlayer(),"thirst")*2.55
		r,g,b = 255-thirst,thirst,0
		if thirst < 15 then
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.775, screenHeight*0.065, screenHeight*0.065, "images/dayzicons/thirsty.png",0,0,0,tocolor(r,g,b,fading))
		else
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.775, screenHeight*0.065, screenHeight*0.065, "images/dayzicons/thirsty.png",0,0,0,tocolor(r,g,b))
		end	
		--blood
		r,g,b = 0,255,0
		local blood = getElementData(getLocalPlayer(),"blood")/47.2
		r,g,b = 255-blood,blood,0
		dxDrawImage ( screenWidth*0.94 , screenHeight*0.85, screenHeight*0.065, screenHeight*0.065, "images/dayzicons/blood.png",0,0,0,tocolor(r,g,b))
		if getElementData(getLocalPlayer(),"bleeding") > 0 then
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.85, screenHeight*0.065, screenHeight*0.065, "images/dayzicons/medic.png",0,0,0,tocolor(255,255,255,fading))
		end
		--food
		r,g,b = 0,255,0
		local food = getElementData(getLocalPlayer(),"food")*2.55
		r,g,b = 255-food,food,0
		if food < 15 then
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.925, screenHeight*0.065, screenHeight*0.065, "images/dayzicons/food.png",0,0,0,tocolor(r,g,b,fading))
		else
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.925, screenHeight*0.065, screenHeight*0.065, "images/dayzicons/food.png",0,0,0,tocolor(r,g,b))
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
				if vehID ~= 600 then
					local pdistance = getDistanceBetweenPoints3D ( x,y,z,px,py,pz )
					if pdistance <= 6 then
						--Get screenposition
						local sx,sy = getScreenFromWorldPosition ( px, py, pz+0.95, 0.06 )
						if sx and sy then
							--Draw Vehicle
							local w = dxGetTextWidth(getVehicleName(veh),1.02,"default-bold")
							dxDrawText ( getVehicleName(veh), sx-(w/2), sy, sx-(w/2), sy, tocolor ( 100, 255, 100, 200 ), 1.02, "default-bold" )	
						end
					end
				end
			end
		end
		--Vehicle Infos
		local veh = getPedOccupiedVehicle (getLocalPlayer())
		if veh then
			local maxfuel = getElementData(veh,"maxfuel")
			local fuel = getElementData(getElementData(veh,"parent"),"fuel")
			local needengine = getElementData(veh,"needengines")
			local needtires = getElementData(veh,"needtires")
			local needparts = getElementData(veh,"needparts")
			local engine = getElementData(getElementData(veh,"parent"),"Engine_inVehicle") or 0
			local tires = getElementData(getElementData(veh,"parent"),"Tire_inVehicle") or 0
			local parts = getElementData(getElementData(veh,"parent"),"Parts_inVehicle") or 0
			local offset = dxGetFontHeight(1.02,"default-bold")
			local w = dxGetTextWidth(engine.."/"..needengine.." Engine",1.02,"default-bold")
			if engine == needengine then
				r,g,b = 0,255,0
			else
				r,g,b = 255,0,0
			end
			dxDrawText (engine.."/"..needengine.." Engine" ,screenWidth*0.5-w/2 , screenHeight*0,screenWidth*0.5-w/2 , screenHeight*0,tocolor ( r,g,b, 220 ), 1.02, "default-bold" )
			local w = dxGetTextWidth(tires.."/"..needtires.." Tires",1.02,"default-bold")
			if tires == needtires then
				r,g,b = 0,255,0
			else
				r,g,b = 255,0,0
			end
			dxDrawText (tires.."/"..needtires.." Tires",screenWidth*0.5-w/2 , screenHeight*0+offset,screenWidth*0.5-w/2 , screenHeight*0+offset,tocolor ( r,g,b, 220 ), 1.02, "default-bold" )
			local w = dxGetTextWidth(parts.."/"..needparts.." Tank Parts",1.02,"default-bold")
			if parts == needparts then
				r,g,b = 0,255,0
			else
				r,g,b = 255,0,0
			end
			dxDrawText (parts.."/"..needparts.." Tank Parts",screenWidth*0.5-w/2 , screenHeight*0+offset*2,screenWidth*0.5-w/2 , screenHeight*0+offset, tocolor (r,g,b, 220 ) , 1.02, "default-bold" )
			local w = dxGetTextWidth("Fuel:"..math.floor(fuel).."/"..maxfuel,1.02,"default-bold")
			if fuel == maxfuel then
				r,g,b = 0,255,0
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
			end
			dxDrawText ("Fuel:"..math.floor(fuel).."/"..maxfuel,screenWidth*0.5-w/2 , screenHeight*0+offset*3,screenWidth*0.5-w/2 , screenHeight*0+offset*2,tocolor ( r,g,b, 220 ), 1.02, "default-bold" )
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

--Support Chat
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

--[[
--------------------------------------------------------------------
--Create the AntiSpam Support Chat
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
	playerRankingTable = positionGetElementData("alivetime", #getElementsByType("player"))
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
		
		--Zombies Killed
		dxDrawText ("Alive Time", screenWidth*0.3+w1*1.6+w2*1.1+w3+w2*0.1+(screenWidth*0.0025/2)+w2*0.1, screenHeight*0.2+offset, screenWidth*0.3+w1*1.6 , screenHeight*0.2+offset, tocolor ( 50, 255, 50, 200 ), 1.5, "default-bold" )
		w4 = dxGetTextWidth("Alive Time",1.5,"default-bold")
		dxDrawRectangle ( screenWidth*0.3+w1*1.6+w2*1.1+w3+w2*0.1+(screenWidth*0.0025/2)+w2*0.1+w4+w2*0.1, screenHeight*0.2, screenWidth*0.0025, screenHeight*0.2+yA, tocolor ( 255, 255, 255, 220 ) )
		
		--Player Amount
		dxDrawText ("Players:"..#getElementsByType("player"), screenWidth*0.3+w1*1.6+w2*1.1+w3+w2*0.1+(screenWidth*0.0025/2)+w2*0.1+w4+w2*0.1+w4/3, screenHeight*0.2+offset, screenWidth*0.8 , screenHeight*0.2+offset, tocolor ( 50, 255, 50, 200 ), 1.5, "default-bold" )

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
			local alivetime = getElementData(player,"alivetime") or 0
			dxDrawText (formatTimeFromMinutes(alivetime), screenWidth*0.3+w1*1.6+w2*1.1+w3+w2*0.1+(screenWidth*0.0025/2)+w2*0.1 , screenHeight*0.2+offset*2+yA, screenWidth*0.175, screenHeight*0.2+offset+yA, tocolor ( r,g,b, 200 ), 1.5, "default-bold" )
		end
		playerLocalAdd = 0
		if not playerInList then
			playerLocalAdd = offset
			r,g,b = 50, 255, 50
			dxDrawRectangle ( screenWidth*0.15, screenHeight*0.2+offset*2+((playerAmount+2)*offset)-offset/2, screenWidth*0.7, screenHeight*0.0025, tocolor ( 255, 255, 255, 220 ) )
			--Position
			local rank = getElementDataPosition("alivetime",getElementData(getLocalPlayer(),"alivetime"))
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
			local alivetime = getElementData(getLocalPlayer(),"alivetime") or 0
			dxDrawText (formatTimeFromMinutes(alivetime), screenWidth*0.3+w1*1.6+w2*1.1+w3+w2*0.1+(screenWidth*0.0025/2)+w2*0.1 , screenHeight*0.2+offset*2+((playerAmount+2)*offset), screenWidth*0.175, screenHeight*0.2+offset+((playerAmount+2)*offset), tocolor ( r,g,b, 200 ), 1.5, "default-bold" )
		end
		yA = playerAmount*offset+playerLocalAdd
	end	
end
addEventHandler ( "onClientRender", getRootElement(), scoreBoard )




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


function updatePlayTime()
	--for i,player in ipairs(getElementsByType("player")) do
	--	local account = getPlayerAccount(player)
		--if not isGuestAccount(account) then
		if getElementData(getLocalPlayer(),"logedin") then
			local playtime = getElementData(getLocalPlayer(),"alivetime")
			setElementData(getLocalPlayer(),"alivetime",playtime+1)	
		end	
		--end
	--end
end
setTimer(updatePlayTime, 60000, 0)

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

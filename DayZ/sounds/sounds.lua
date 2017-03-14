--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: sounds.lua							*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: CLIENT														*----
#-----------------------------------------------------------------------------#
]]

local citysounds = {":DayZ/sounds/ambience/helicopter.mp3"}
local ambiencesounds = {
	":DayZ/sounds/ambience/ambience_1.ogg",
	":DayZ/sounds/ambience/ambience_2.ogg",
	":DayZ/sounds/ambience/ambience_3.ogg",
	":DayZ/sounds/ambience/ambience_4.ogg",
	":DayZ/sounds/ambience/ambience_5.ogg",
	":DayZ/sounds/ambience/ambience_6.ogg",
	":DayZ/sounds/ambience/ambience_7.ogg",
	":DayZ/sounds/ambience/ambience_8.ogg",
	":DayZ/sounds/ambience/ambience_9.ogg",
	":DayZ/sounds/ambience/ambience_10.ogg",
	":DayZ/sounds/ambience/ambience_11.ogg",
	":DayZ/sounds/ambience/ambience_12.ogg",
	":DayZ/sounds/ambience/ambience_13.ogg",
	":DayZ/sounds/ambience/ambience_14.ogg",
	":DayZ/sounds/ambience/ambience_15.ogg",
	":DayZ/sounds/ambience/ambience_16.ogg",
}

local ambienceOn = true

function playAmbienceMusic()
	if getElementData(localPlayer,"logedin") then
		if ambienceOn then
			ambiencesound = playSound(ambiencesounds[math.random(1,#ambiencesounds)],false)
			if ambiencesound then
				setSoundVolume(ambiencesound,gameplayVariables["ambiencesoundvolume"])
			end
		end
	end
end
setTimer(playAmbienceMusic,65000,0)

function PlayCityAmbience()
local x,y,z = getElementPosition(localPlayer)
local city = getZoneName(x,y,z)
	if city == "Los Santos" or city == "Las Venturas" or city == "San Fierro" then
		playSound(":DayZ/sounds/ambience/helicopter.mp3",false)
	else return end
end
setTimer(PlayCityAmbience,300000,0)

function toggleAmbience()
	if ambienceOn then
		ambienceOn = false
		outputChatBox("Turned off ambience sounds.",255,0,0)
	else
		ambienceOn = true
		outputChatBox("Turned on ambience sounds.",0,255,0)
	end
end
addCommandHandler("ambience",toggleAmbience)

-- PLAY ZOMBIE SOUNDS
local zombiesounds = {
	":DayZ/sounds/zombies/zgroan (1).ogg", 
	":DayZ/sounds/zombies/zgroan (2).ogg",
	":DayZ/sounds/zombies/zgroan (3).ogg", 
	":DayZ/sounds/zombies/zgroan (4).ogg", 
	":DayZ/sounds/zombies/zgroan (5).ogg", 
	":DayZ/sounds/zombies/zgroan (6).ogg", 
	":DayZ/sounds/zombies/zgroan (7).ogg",
	":DayZ/sounds/zombies/zgroan (8).ogg",
	":DayZ/sounds/zombies/zgroan (9).ogg",
	":DayZ/sounds/zombies/zgroan (10).ogg",
	":DayZ/sounds/zombies/zgroan (11).ogg", 
	":DayZ/sounds/zombies/zgroan (12).ogg",
	":DayZ/sounds/zombies/zgroan (13).ogg", 
	":DayZ/sounds/zombies/zgroan (14).ogg", 
	":DayZ/sounds/zombies/zgroan (15).ogg", 
	":DayZ/sounds/zombies/zgroan (16).ogg", 
	":DayZ/sounds/zombies/zgroan (17).ogg",
	":DayZ/sounds/zombies/zgroan (18).ogg",
	":DayZ/sounds/zombies/zgroan (19).ogg",
	":DayZ/sounds/zombies/zgroan (20).ogg", 
	":DayZ/sounds/zombies/zgroan (21).ogg", 
	":DayZ/sounds/zombies/zgroan (22).ogg",
	":DayZ/sounds/zombies/zgroan (23).ogg", 
	":DayZ/sounds/zombies/zgroan (24).ogg", 
	":DayZ/sounds/zombies/zgroan (25).ogg", 
	":DayZ/sounds/zombies/zgroan (26).ogg", 
	":DayZ/sounds/zombies/zgroan (27).ogg",
	":DayZ/sounds/zombies/zgroan (28).ogg",
	":DayZ/sounds/zombies/zgroan (29).ogg",
	":DayZ/sounds/zombies/zgroan (30).ogg", 
	":DayZ/sounds/zombies/zgroan (31).ogg", 
	":DayZ/sounds/zombies/zgroan (32).ogg",
	":DayZ/sounds/zombies/zgroan (33).ogg", 
	":DayZ/sounds/zombies/zgroan (34).ogg", 
	":DayZ/sounds/zombies/zgroan (35).ogg", 
	":DayZ/sounds/zombies/zgroan (36).ogg", 
} 
local zedSound = false

--ALL ZOMBIES STFU
function stopZombieSound()
	local zombies = getElementsByType ( "ped" )
	for theKey,theZomb in ipairs(zombies) do
		setPedVoice(theZomb, "PED_TYPE_DISABLED")
	end
end
setTimer(stopZombieSound,1000,0)

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

function playCampfireSound()
	local x = getElementData(source,"x")
	local y = getElementData(source,"y")
	local z = getElementData(source,"z")
	campfiresound = playSound3D(":DayZ/sounds/items/campfire.mp3",x,y,z,true)
end
addEvent("playCampfireSound",true)
addEventHandler("playCampfireSound",root,playCampfireSound)

function stopCampfireSound()
	stopSound(campfiresound)
end
addEvent("stopCampfireSound",true)
addEventHandler("stopCampfireSound",root,stopCampfireSound)

setWorldSoundEnabled(5,false)

local weaponSounds = {
	["M1911"] = {20,":DayZ/sounds/weapons/fire/M1911.wav"},
	["G17"] = {20,":DayZ/sounds/weapons/fire/G17.wav"},
	["M9"] = {20,":DayZ/sounds/weapons/fire/M1911.wav"},
	["Makarov PM"] = {20,":DayZ/sounds/weapons/fire/Makarov.wav"},
	["Makarov SD"] = {0,":DayZ/sounds/weapons/fire/MakarovSD.wav"},
	["Revolver"] = {40,":DayZ/sounds/weapons/fire/Revolver.wav"},
	["Compound Crossbow"] = {5,":DayZ/sounds/weapons/fire/Crossbow.wav"},
	["Winchester 1866"] = {30,":DayZ/sounds/weapons/fire/Winchester.wav"},
	["Double-barreled Shotgun"] = {30,":DayZ/sounds/weapons/fire/Double.wav"},
	["M1014"] = {30,":DayZ/sounds/weapons/fire/M1014.wav"},
	["Remington 870"] = {30,":DayZ/sounds/weapons/fire/M1014.wav"},
	["PDW"] = {15,":DayZ/sounds/weapons/fire/PDW.wav"},
	["Bizon PP-19 SD"] = {0,":DayZ/sounds/weapons/fire/Bizon.wav"},
	["MP5A5"] = {15,":DayZ/sounds/weapons/fire/MP5A5.wav"},
	["AK-74"] = {60,":DayZ/sounds/weapons/fire/AK74.wav"},
	["AKS-74U"] = {60,":DayZ/sounds/weapons/fire/AK74.wav"},
	["RPK"] = {60,":DayZ/sounds/weapons/fire/AK74.wav"},
	["AKM"] = {60,":DayZ/sounds/weapons/fire/AKM.wav"},
	["Sa58V CCO"] = {60,":DayZ/sounds/weapons/fire/AKM.wav"},
	["FN FAL"] = {60,":DayZ/sounds/weapons/fire/FNFAL.wav"},
	["G36A CAMO"] = {60,":DayZ/sounds/weapons/fire/G36C.wav"},
	["G36C"] = {60,":DayZ/sounds/weapons/fire/G36C.wav"},
	["G36C CAMO"] = {60,":DayZ/sounds/weapons/fire/G36C.wav"},
	["G36K CAMO"] = {60,":DayZ/sounds/weapons/fire/G36C.wav"},
	["L85A2 RIS Holo"] = {60,":DayZ/sounds/weapons/fire/G36C.wav"},
	["M16A2"] = {60,":DayZ/sounds/weapons/fire/M16A2.wav"},
	["M16A2 M203"] = {60,":DayZ/sounds/weapons/fire/M16A2.wav"},
	["M4A1"] = {60,":DayZ/sounds/weapons/fire/M4A1.wav"},
	["M16A1"] = {60,":DayZ/sounds/weapons/fire/M16A2.wav"},
	["Mosin-Nagant"] = {120,":DayZ/sounds/weapons/fire/Mosin.wav"},
	["Enfield"] = {120,":DayZ/sounds/weapons/fire/Enfield.wav"},
	["CZ 550"] = {240,":DayZ/sounds/weapons/fire/CZ550.wav"},
	["DMR"] = {gameplayVariables["silencedDMRs"] and 5 or 240,":DayZ/sounds/weapons/fire/DMR.wav"},
	["SVD Dragunov"] = {240,":DayZ/sounds/weapons/fire/Dragunov.wav"},
	["M24"] = {240,":DayZ/sounds/weapons/fire/M24.wav"},
}

function playSoundOnWeaponFire(weapon)
	local x,y,z = getElementPosition(localPlayer)
	local x2,y2,z2 = getElementPosition(source)
	
	--Get weapon info based on the weapon id used.
	if ((weapon == 22) or (weapon == 23) or (weapon == 24) or (weapon == 29)) then
		wepSlot = "currentweapon_2"
	elseif ((weapon == 25) or (weapon == 27) or (weapon == 28) or (weapon == 30) or (weapon == 31) or (weapon == 33) or (weapon == 34)) then
		wepSlot = "currentweapon_1"
	end
	
	--Check if we have a sound for specified weapon, get range and play accordingly.
	local wepTable = weaponSounds[getElementData(source,wepSlot)]
	if (wepTable) then
		if (getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > wepTable[1]) then
			playSound3D(wepTable[2],x2,y2,z2,false)
		else
			setSoundMaxDistance(playSound(wepTable[2],false), 0)
		end
	end
end
addEventHandler ( "onClientPlayerWeaponFire", root, playSoundOnWeaponFire )

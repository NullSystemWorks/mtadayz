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

function playSoundOnWeaponFire(weapon)
	local x,y,z = getElementPosition(localPlayer)
	local x2,y2,z2 = getElementPosition(source)
	if weapon == 22 then
		if getElementData(source,"currentweapon_2") == "M1911" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 20 then
				playSound3D(":DayZ/sounds/weapons/fire/M1911.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/M1911.wav",false)
				setSoundMaxDistance(sound,0)
			end
		elseif getElementData(source,"currentweapon_2") == "G17" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 20 then
				playSound3D(":DayZ/sounds/weapons/fire/G17.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/G17.wav",false)
				setSoundMaxDistance(sound,0)
			end
		elseif getElementData(source,"currentweapon_2") == "M9" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 20 then
				playSound3D(":DayZ/sounds/weapons/fire/M1911.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/fire/weapons/M1911.wav",false)
				setSoundMaxDistance(sound,0)
			end
		elseif getElementData(source,"currentweapon_2") == "Makarov PM" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 20 then
				playSound3D(":DayZ/sounds/weapons/fire/Makarov.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/Makarov.wav",false)
				setSoundMaxDistance(sound,0)
			end
		elseif getElementData(source,"currentweapon_2") == "Flashlight" then
			return
		end
	elseif weapon == 23 then
		if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 0 then
			playSound3D(":DayZ/sounds/weapons/fire/MakarovSD.wav",x2,y2,z2,false)
		else
			local sound = playSound(":DayZ/sounds/weapons/fire/MakarovSD.wav",false)
			setSoundMaxDistance(sound,0)
		end
	elseif weapon == 24 then
		if getElementData(source,"currentweapon_2") == "Revolver" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 40 then
				playSound3D(":DayZ/sounds/weapons/fire/Revolver.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/Revolver.wav",false)
				setSoundMaxDistance(sound,0)
			end
		end
	elseif weapon == 25 then
		if getElementData(source,"currentweapon_1") == "Compound Crossbow" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 5 then
				playSound3D(":DayZ/sounds/weapons/Crossbow.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/Crossbow.wav",false)
				setSoundVolume(sound,0.3)
				setSoundMaxDistance(sound,0)
			end
		elseif getElementData(source,"currentweapon_1") == "Winchester 1866" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 30 then
				playSound3D(":DayZ/sounds/weapons/fire/Winchester/.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/Winchester.wav",false)
				setSoundMaxDistance(sound,0)
			end
		elseif getElementData(source,"currentweapon_1") == "Double-barreled Shotgun" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 30 then
				playSound3D(":DayZ/sounds/weapons/fire/Double.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/Double.wav",false)
				setSoundMaxDistance(sound,0)
			end
		end
	elseif weapon == 27 then
		if getElementData(source,"currentweapon_1") == "M1014" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 30 then
				playSound3D(":DayZ/sounds/weapons/fire/M1014.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/M1014.wav",false)
				setSoundMaxDistance(sound,0)
			end
		elseif getElementData(source,"currentweapon_1") == "Remington 870" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 30 then
				playSound3D(":DayZ/sounds/weapons/fire/M1014.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/M1014.wav",false)
				setSoundMaxDistance(sound,0)
			end
		end
	elseif weapon == 28 then
		if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 15 then
			playSound3D(":DayZ/sounds/weapons/fire/PDW.wav",x2,y2,z2,false)
		else
			local sound = playSound(":DayZ/sounds/weapons/fire/PDW.wav",false)
			setSoundMaxDistance(sound,0)
		end
	elseif weapon == 29 then
		if getElementData(source,"currentweapon_2") == "Bizon PP-19 SD" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 0 then
				playSound3D(":DayZ/sounds/weapons/fire/Bizon.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/Bizon.wav",false)
				setSoundMaxDistance(sound,0)
			end
		else
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 15 then
				playSound3D(":DayZ/sounds/weapons/fire/MP5A5.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/MP5A5.wav",false)
				setSoundMaxDistance(sound,0)
			end
		end
	elseif weapon == 30 then
		if getElementData(source,"currentweapon_1") == "AK-74" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 60 then
				playSound3D(":DayZ/sounds/weapons/fire/AK74.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/AK74.wav",false)
				setSoundMaxDistance(sound,0)
			end
		elseif getElementData(source,"currentweapon_1") == "AKS-74U" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 60 then
				playSound3D(":DayZ/sounds/weapons/fire/AK74.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/AK74.wav",false)
				setSoundMaxDistance(sound,0)
			end
		elseif getElementData(source,"currentweapon_1") == "RPK" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 60 then
				playSound3D(":DayZ/sounds/weapons/fire/AK74.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/AK74.wav",false)
				setSoundMaxDistance(sound,0)
			end
		elseif getElementData(source,"currentweapon_1") == "AKM" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 60 then
				playSound3D(":DayZ/sounds/weapons/fire/AKM.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/AKM.wav",false)
				setSoundMaxDistance(sound,0)
			end
		elseif getElementData(source,"currentweapon_1") == "Sa58V CCO" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 60 then
				playSound3D(":DayZ/sounds/weapons/fire/AKM.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/AKM.wav",false)
				setSoundMaxDistance(sound,0)
			end
		elseif getElementData(source,"currentweapon_1") == "Sa58V CCO" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 60 then
				playSound3D(":DayZ/sounds/weapons/fire/AKM.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/AKM.wav",false)
				setSoundMaxDistance(sound,0)
			end
		elseif getElementData(source,"currentweapon_1") == "FN FAL" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 60 then
				playSound3D(":DayZ/sounds/weapons/fire/FNFAL.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/FNFAL.wav",false)
				setSoundMaxDistance(sound,0)
			end
		end
	elseif weapon == 31 then
		if getElementData(source,"currentweapon_1") == "G36A CAMO" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 60 then
					playSound3D(":DayZ/sounds/weapons/fire/G36C.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/G36C.wav",false)
				setSoundMaxDistance(sound,0)
			end
		elseif getElementData(source,"currentweapon_1") == "G36C" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 60 then
					playSound3D(":DayZ/sounds/weapons/fire/G36C.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/G36C.wav",false)
				setSoundMaxDistance(sound,0)
			end
		elseif getElementData(source,"currentweapon_1") == "G36C CAMO" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 60 then
					playSound3D(":DayZ/sounds/weapons/fire/G36C.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/G36C.wav",false)
				setSoundMaxDistance(sound,0)
			end
		elseif getElementData(source,"currentweapon_1") == "G36K CAMO" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 60 then
					playSound3D(":DayZ/sounds/weapons/fire/G36C.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/G36C.wav",false)
				setSoundMaxDistance(sound,0)
			end
		elseif getElementData(source,"currentweapon_1") == "L85A2 RIS Holo" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 60 then
					playSound3D(":DayZ/sounds/weapons/fire/G36C.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/G36C.wav",false)
				setSoundMaxDistance(sound,0)
			end
		elseif getElementData(source,"currentweapon_1") == "M16A2" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 60 then
					playSound3D(":DayZ/sounds/weapons/fire/M16A2.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/M16A2.wav",false)
				setSoundMaxDistance(sound,0)
			end
		elseif getElementData(source,"currentweapon_1") == "M16A2 M203" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 60 then
					playSound3D(":DayZ/sounds/weapons/fire/M16A2.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/M16A2.wav",false)
				setSoundMaxDistance(sound,0)
			end
		elseif getElementData(source,"currentweapon_1") == "M4A1" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 60 then
					playSound3D(":DayZ/sounds/weapons/fire/M4A1.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/M4A1.wav",false)
				setSoundMaxDistance(sound,0)
			end
		elseif getElementData(source,"currentweapon_1") == "M16A4" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 60 then
					playSound3D(":DayZ/sounds/weapons/fire/M16A2.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/M16A2.wav",false)
				setSoundMaxDistance(sound,0)
			end
		end
	elseif weapon == 33 then
		if getElementData(source,"currentweapon_1") == "Mosin-Nagant" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 120 then
				playSound3D(":DayZ/sounds/weapons/fire/Mosin.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/Mosin.wav",false)
				setSoundMaxDistance(sound,0)
			end
		else
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 120 then
				playSound3D(":DayZ/sounds/weapons/fire/Enfield.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/Enfield.wav",false)
				setSoundMaxDistance(sound,0)
			end
		end
	elseif weapon == 34 then
		if getElementData(source,"currentweapon_1") == "CZ 550" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 240 then
				playSound3D(":DayZ/sounds/weapons/fire/CZ550.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/CZ550.wav",false)
				setSoundMaxDistance(sound,0)
			end
		elseif getElementData(source,"currentweapon_1") == "DMR" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 5 then
				playSound3D(":DayZ/sounds/weapons/fire/DMR.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/DMR.wav",false)
				setSoundMaxDistance(sound,0)
			end
		elseif getElementData(source,"currentweapon_1") == "SVD Dragunov" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 240 then
				playSound3D(":DayZ/sounds/weapons/fire/Dragunov.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/Dragunov.wav",false)
				setSoundMaxDistance(sound,0)
			end
		elseif getElementData(source,"currentweapon_1") == "SVD Dragunov" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 240 then
				playSound3D(":DayZ/sounds/weapons/fire/M40A3.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/fire/M40A3.wav",false)
				setSoundMaxDistance(sound,0)
			end
		end
	end 
end
addEventHandler ( "onClientPlayerWeaponFire", root, playSoundOnWeaponFire )
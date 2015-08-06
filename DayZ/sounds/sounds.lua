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

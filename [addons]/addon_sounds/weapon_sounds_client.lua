setWorldSoundEnabled(5,false)

function playSoundOnWeaponFire(weapon)
	local wX, wY, wZ = getPedWeaponMuzzlePosition(localPlayer)
	local x,y,z = getElementPosition(localPlayer)
	if weapon == 22 then
		if getElementData(localPlayer,"currentweapon_2") == "M1911" then
			playSound3D("sounds/M1911.wav",wX,wY,wZ,false)
		elseif getElementData(localPlayer,"currentweapon_2") == "G17" then
			playSound3D("sounds/G17.wav",wX,wY,wZ,false)
		end
	elseif weapon == 23 then
		playSound3D("sounds/Silenced.wav",wX,wY,wZ,false)
	elseif weapon == 24 then
		if getElementData(localPlayer,"currentweapon_2") == "Revolver" then
			playSound3D("sounds/Revolver.wav",wX,wY,wZ,false)
		elseif getElementData(localPlayer,"currentweapon_2") == "Desert Eagle" then
			playSound3D("sounds/DesertEagle.wav",wX,wY,wZ,false)
		end
	elseif weapon == 25 then
		if getElementData(localPlayer,"currentweapon_1") == "Crossbow" then
			playSound3D("sounds/Crossbow.wav",wX,wY,wZ,false)
		else
			playSound3D("sounds/Shotgun.wav",wX,wY,wZ,false)
		end
	elseif weapon == 26 then
		playSound3D("sounds/Sawed-Off.wav",wX,wY,wZ,false)
	elseif weapon == 27 then
		if getElementData(localPlayer,"currentweapon_1") == "Blaze 95 Double Rifle" then
			playSound3D("sounds/Blaze95.wav",wX,wY,wZ,false)
		else
			playSound3D("sounds/Combat Shotgun.wav",wX,wY,wZ,false)
		end
	elseif weapon == 28 or weapon == 32 then
		playSound3D("sounds/UZI_Tec9.wav",wX,wY,wZ,false)
	elseif weapon == 29 then
		playSound3D("sounds/MP5A5.wav",wX,wY,wZ,false)
	elseif weapon == 30 then
		if getElementData(localPlayer,"currentweapon_1") == "FN FAL" then
			playSound3D("sounds/FNFAL.wav",wX,wY,wZ,false)
		else
			playSound3D("sounds/AK-47.wav",wX,wY,wZ,false)
		end
	elseif weapon == 31 then
		playSound3D("sounds/M4.wav",wX,wY,wZ,false)
	elseif weapon == 33 then
		if getElementData(localPlayer,"currentweapon_1") == "Mosin 9130" then
			playSound3D("sounds/Mosin9130.wav",wX,wY,wZ,false)
		elseif getElementData(localPlayer,"currentweapon_1") == "Sporter 22" then
			playSound3D("sounds/Sporter22.wav",wX,wY,wZ,false)
		elseif getElementData(localPlayer,"currentweapon_1") == "SKS" then
			playSound3D("sounds/SKS.wav",wX,wY,wZ,false)
		else
			playSound3D("sounds/Rifle.wav",wX,wY,wZ,false)
		end
	elseif weapon == 34 then
		if getElementData(localPlayer,"currentweapon_1") == "CZ 550" then
			playSound3D("sounds/CZ550.wav",wX,wY,wZ,false)
		else
			playSound3D("sounds/Sniper.wav",wX,wY,wZ,false)
		end
		--playSFX("genrl",136,24,false)
	end 
end

addEventHandler ( "onClientPlayerWeaponFire", getRootElement(), playSoundOnWeaponFire )


local rootElement = getRootElement()
local screenWidth, screenHeight = guiGetScreenSize() -- Get the screen resolution
 
zoneTable = {

{"San Fierro","Ozyorsk"},
{"Battery Point",""},
{"Gant Bridge",""},
{"Garver Bridge",""},
{"Juniper Hollow",""},
{"Paradiso",""},
{"Esplanade North",""},
{"Esplanade East",""},
{"Downtown",""},
{"Financial",""},
{"Calton Heights",""},
{"Chinatown",""},
{"Juniper Hill",""},
{"Palisades",""},
{"Santa Flora",""},
{"City Hall",""},
{"Queens",""},
{"Corvin Stadium",""},
{"King's",""},
{"Easter Basin",""},
{"Doherty",""},
{"Cranberry Station",""},
{"Garcia",""},
{"Hashbury",""},
{"Ocean Flats",""},
{"Avispa Country Club",""},
{"Missionary Hill",""},
{"Foster Valley",""},
{"Easter Bay Airport","Ozyorsk Airport"},

{"Los Santos","Snezhinsk"},
{"Las Venturas","Tryokhgorny"},
{"Angel Pine","Kasli"},
{"Dillimore","Kata-Ivanovsk"},
{"Palomino Creek","Kartaly"},
{"El Quebrados","Kopeysk"},
{"Blueberry","Kyshtym"},
{"Fort Carson","Magnitogorsk"},
{"Las Brujas","Miass"},
{"Bayside","Troitsk"},
{"Aldea Malvada","Verkhny Ufaley"},
{"Montgomery","Yemanzhelisnk"},
{"Las Barrancas","Yuzhnoursalsk"},
{"Las Payasadas","Zlatoust"},
{"Valle Ocultado","Korkino"},
{"El Corona",""},
{"Ganton",""},
{"Whetstone","Yetkulsky"},
{"Mount Chiliad","Mount Yamantau"},
}

function HandleTheRendering()
    	-- keep the text visible with onClientRender.
	setTrafficLightState("disabled")
	setTrafficLightsLocked(true)
end
addEventHandler("onClientResourceStart",root, HandleTheRendering)



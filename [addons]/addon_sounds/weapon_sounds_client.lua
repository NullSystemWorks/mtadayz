setWorldSoundEnabled(5,false)

function playSoundOnWeaponFire(weapon)
	local x,y,z = getElementPosition(localPlayer)
	local x2,y2,z2 = getElementPosition(source)
	if weapon == 22 then
		if getElementData(localPlayer,"currentweapon_2") == "M1911" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 20 then
				playSound3D("sounds/M1911.wav",false,x,y,z)
			else
				playSound("sounds/M1911.wav",false)
			end
		elseif getElementData(localPlayer,"currentweapon_2") == "G17" then
			playSound("sounds/G17.wav",false)
		end
	elseif weapon == 23 then
		playSound("sounds/Silenced.wav",false)
	elseif weapon == 24 then
		if getElementData(localPlayer,"currentweapon_2") == "Revolver" then
			playSound("sounds/Revolver.wav",false)
		elseif getElementData(localPlayer,"currentweapon_2") == "Desert Eagle" then
			playSound("sounds/DesertEagle.wav",false)
		end
	elseif weapon == 25 then
		if getElementData(localPlayer,"currentweapon_1") == "Crossbow" then
			playSound("sounds/Crossbow.wav",false)
		else
			playSound("sounds/Shotgun.wav",false)
		end
	elseif weapon == 26 then
		playSound("sounds/Sawed-Off.wav",false)
	elseif weapon == 27 then
		if getElementData(localPlayer,"currentweapon_1") == "Blaze 95 Double Rifle" then
			playSound("sounds/Blaze95.wav",false)
		else
			playSound("sounds/Combat Shotgun.wav",false)
		end
	elseif weapon == 28 or weapon == 32 then
		playSound("sounds/UZI_Tec9.wav",false)
	elseif weapon == 29 then
		playSound("sounds/MP5A5.wav",false)
	elseif weapon == 30 then
		if getElementData(localPlayer,"currentweapon_1") == "FN FAL" then
			playSound("sounds/FNFAL.wav",false)
		else
			playSound("sounds/AK-47.wav",false)
		end
	elseif weapon == 31 then
		playSound("sounds/M4.wav",false)
	elseif weapon == 33 then
		if getElementData(localPlayer,"currentweapon_1") == "Mosin 9130" then
			playSound("sounds/Mosin9130.wav",false)
		elseif getElementData(localPlayer,"currentweapon_1") == "Sporter 22" then
			playSound("sounds/Sporter22.wav",false)
		elseif getElementData(localPlayer,"currentweapon_1") == "SKS" then
			playSound("sounds/SKS.wav",false)
		else
			playSound("sounds/Rifle.wav",false)
		end
	elseif weapon == 34 then
		if getElementData(localPlayer,"currentweapon_1") == "CZ 550" then
			playSound("sounds/CZ550.wav",false)
		else
			playSound("sounds/Sniper.wav",false)
		end
		--playSFX("genrl",136,24,false)
	end 
end
addEventHandler ( "onClientPlayerWeaponFire", root, playSoundOnWeaponFire )
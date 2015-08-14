--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: damage_player.lua						*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: CLIENT														*----
#-----------------------------------------------------------------------------#
]]

function playerDayZDamage(attacker,weapon,bodypart,loss)
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
		else
			damage_half = 1
		end
		if gameplayVariables["difficulty"] and gameplayVariables["difficulty"] == "normal" then
			multiplier = 1
		elseif gameplayVariables["difficulty"] and gameplayVariables["difficulty"] == "veteran" then
			multiplier = 1.5
		elseif gameplayVariables["difficulty"] and gameplayVariables["difficulty"] == "hardcore" then
			multiplier = 3
		else
			multiplier = 1
		end
		setElementData(localPlayer,"blood",getElementData(localPlayer,"blood")-((gameplayVariables["zombiedamage"]*multiplier)/damage_half))
		local gender = getElementData(localPlayer,"gender")
		if gender == "male" then
			playSFX("pain_a",2,53,false)
		elseif gender == "female" then
			playSFX("pain_a",1,52,false)
		end
		enableBlackWhite(true)
		setTimer(function() enableBlackWhite(false) end,1000,1)
		local number = math.random(1,40)
		if number >= 1 and number <= 15 then
			setElementData(localPlayer,"bleeding",getElementData(localPlayer,"bleeding") + math.floor(loss*10))
		elseif number == 20 then
			setElementData(localPlayer,"sepsis",1)
		elseif number == 25 then
			setElementData(localPlayer,"infection",true)
		end
	end
	if weapon == 49 then
		if loss > 30 then
			setElementData(localPlayer,"brokenbone",true)
			setControlState ("jump",true)
			setElementData(localPlayer,"blood",getElementData(localPlayer,"blood")-math.floor(loss*10))
		end
		setElementData(localPlayer,"blood",getElementData(localPlayer,"blood")-math.floor(loss*5))
	elseif weapon == 63 or weapon == 51 or weapon == 19 then
		setElementData(localPlayer,"blood",0)
		if getElementData(localPlayer,"blood") <= 0 then
			if not getElementData(localPlayer,"isDead") == true then
				triggerServerEvent("kilLDayZPlayer",localPlayer,attacker,headshot)
			end
		end
	end
	if weapon and weapon > 1 and attacker and getElementType(attacker) == "player" then
		local number = math.random(1,8)
		if number >= 6 or number <= 8 then
			setElementData(localPlayer,"bleeding",getElementData(localPlayer,"bleeding") + math.floor(loss*10))
		end
		local number = math.random(1,7)
		if number == 2 then
			setElementData(localPlayer,"pain",true)
		end
		damage = getWeaponDamage(weapon)
		if bodypart == 9 then
			damage = damage*gameplayVariables["headshotdamage_player"]
			headshot = true
		end
		if bodypart == 7 or bodypart == 8 then
			setElementData(localPlayer,"brokenbone",true)
			playSound("sounds/brokenbone.mp3",false)
		end
		damage = math.random(damage*0.75,damage*1.25)
		if getElementData(localPlayer,"humanity") >= 5000 then
			if damage <= 1000 then
				damage = 0
			else
				damage = damage
			end
		end
		setElementData(localPlayer,"blood",getElementData(localPlayer,"blood")-damage)
		enableBlackWhite(true)
		setTimer(function() enableBlackWhite(false) end,1000,1)
		if not getElementData(localPlayer,"bandit") then
			triggerServerEvent("onPlayerChangeStatus",attacker,"humanity",-math.random(40,200))
			if getElementData(attacker,"humanity") < 0 then
				setElementData(attacker,"bandit",true)
			end
		else
			triggerServerEvent("onPlayerChangeStatus",attacker,"humanity",math.random(400,200))
			if getElementData(attacker,"humanity") > 5000 then
				setElementData(attacker,"humanity",5000)
			end
			if getElementData(attacker,"humanity") > 2000 then
				setElementData(attacker,"bandit",false)
			end
		end	
		if getElementData(localPlayer,"blood") <= 0 then
			if not getElementData(localPlayer,"isDead") then
				triggerServerEvent("kilLDayZPlayer",localPlayer,attacker,headshot,getWeaponNameFromID(weapon))
				setElementData(localPlayer,"isDead",true)
			end
		end
	elseif weapon == 54 or weapon == 63 or weapon == 49 or weapon == 51 then
		setElementData(localPlayer,"blood",getElementData(localPlayer,"blood")-math.random(100,1000))
		enableBlackWhite(true)
		setTimer(function() enableBlackWhite(false) end,1000,1)
		local number = math.random(1,5)
		if loss > 30 then
			setElementData(localPlayer,"brokenbone",true)
			setControlState ("jump",true)
		end
		if loss >= 100 then
			setElementData(localPlayer,"blood",49)
			setElementData(localPlayer,"bleeding",50)
		end
		local number = math.random(1,11)
		if number == 3 then
			setElementData(localPlayer,"pain",true)
		end
		if getElementData(localPlayer,"blood") <= 0 then
			if not getElementData(localPlayer,"isDead") == true then
				triggerServerEvent("kilLDayZPlayer",localPlayer,attacker,headshot,getWeaponNameFromID (weapon))
				setElementData(localPlayer,"isDead",true)
			end
		end
	end
end
addEventHandler ("onClientPlayerDamage",localPlayer,playerDayZDamage)


function onPlayerDamageShader()
	enableBlackWhite(true)
	setTimer(function() enableBlackWhite(false) end,1000,1)
end
addEvent("onPlayerDamageShader",true)
addEventHandler("onPlayerDamageShader",root,onPlayerDamageShader)

bindKey("z", "down", "chatbox", "radiochat" )

function abortAllStealthKills(targetPlayer)
    cancelEvent()
end
addEventHandler("onClientPlayerStealthKill", localPlayer, abortAllStealthKills)

function disableCameraOnSwitch ( prevSlot, newSlot )
	if getPedWeapon(localPlayer,newSlot) == 43 then 
		toggleControl ( "fire", false ) 
	else
		toggleControl ( "fire", true )
	end
end
addEventHandler ("onClientPlayerWeaponSwitch",root,disableCameraOnSwitch)

setWorldSoundEnabled(5,false)

function playSoundOnWeaponFire(weapon)
	local x,y,z = getElementPosition(localPlayer)
	local x2,y2,z2 = getElementPosition(source)
	if weapon == 22 then
		if getElementData(localPlayer,"currentweapon_2") == "M1911" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 20 then
				playSound3D(":DayZ/sounds/weapons/M1911.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/M1911.wav",false)
				setSoundMaxDistance(sound,0)
			end
		elseif getElementData(localPlayer,"currentweapon_2") == "G17" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 20 then
				playSound3D(":DayZ/sounds/weapons/G17.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/G17.wav",false)
				setSoundMaxDistance(sound,0)
			end
		end
	elseif weapon == 23 then
		if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 0 then
			playSound3D(":DayZ/sounds/weapons/Silenced.wav",x2,y2,z2,false)
		else
			local sound = playSound(":DayZ/sounds/weapons/Silenced.wav",false)
			setSoundMaxDistance(sound,0)
		end
	elseif weapon == 24 then
		if getElementData(localPlayer,"currentweapon_2") == "Revolver" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 40 then
				playSound3D(":DayZ/sounds/weapons/Revolver.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/Revolver.wav",false)
				setSoundMaxDistance(sound,0)
			end
		elseif getElementData(localPlayer,"currentweapon_2") == "Desert Eagle" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 40 then
				playSound3D(":DayZ/sounds/weapons/DesertEagle.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/DesertEagle.wav",false)
				setSoundMaxDistance(sound,0)
			end
		end
	elseif weapon == 25 then
		if getElementData(localPlayer,"currentweapon_1") == "Crossbow" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 5 then
				playSound3D(":DayZ/sounds/weapons/Crossbow.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/Crossbow.wav",false)
				setSoundMaxDistance(sound,0)
			end
		else
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 30 then
				playSound3D(":DayZ/sounds/weapons/Shotgun.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/Shotgun.wav",false)
				setSoundMaxDistance(sound,0)
			end
		end
	elseif weapon == 26 then
		if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 30 then
				playSound3D(":DayZ/sounds/weapons/Sawed-Off.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/Sawed-Off.wav",false)
				setSoundMaxDistance(sound,0)
			end
	elseif weapon == 27 then
		if getElementData(localPlayer,"currentweapon_1") == "Blaze 95 Double Rifle" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 30 then
				playSound3D(":DayZ/sounds/weapons/Blaze95.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/Blaze95.wav",false)
				setSoundMaxDistance(sound,0)
			end
		else
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 30 then
				playSound3D(":DayZ/sounds/weapons/Combat Shotgun.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/Combat Shotgun.wav",false)
				setSoundMaxDistance(sound,0)
			end
		end
	elseif weapon == 28 or weapon == 32 then
		if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 15 then
				playSound3D(":DayZ/sounds/weapons/UZI_Tec9.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/UZI_Tec9.wav",false)
				setSoundMaxDistance(sound,0)
			end
	elseif weapon == 29 then
		if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 15 then
				playSound3D(":DayZ/sounds/weapons/MP5A5.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/MP5A5.wav",false)
				setSoundMaxDistance(sound,0)
			end
	elseif weapon == 30 then
		if getElementData(localPlayer,"currentweapon_1") == "FN FAL" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 60 then
				playSound3D(":DayZ/sounds/weapons/FNFAL.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/FNFAL.wav",false)
				setSoundMaxDistance(sound,0)
			end
		else
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 60 then
				playSound3D(":DayZ/sounds/weapons/AK-47.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/AK-47.wav",false)
				setSoundMaxDistance(sound,0)
			end
		end
	elseif weapon == 31 then
		if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 60 then
				playSound3D(":DayZ/sounds/weapons/M4.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/M4.wav",false)
				setSoundMaxDistance(sound,0)
			end
	elseif weapon == 33 then
		if getElementData(localPlayer,"currentweapon_1") == "Mosin 9130" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 120 then
				playSound3D(":DayZ/sounds/weapons/Mosin9130.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/Mosin9130.wav",false)
				setSoundMaxDistance(sound,0)
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "Sporter 22" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 120 then
				playSound3D(":DayZ/sounds/weapons/Sporter22.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/Sporter22.wav",false)
				setSoundMaxDistance(sound,0)
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "SKS" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 120 then
				playSound3D(":DayZ/sounds/weapons/SKS.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/SKS.wav",false)
				setSoundMaxDistance(sound,0)
			end
		else
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 120 then
				playSound3D(":DayZ/sounds/weapons/Rifle.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/Rifle.wav",false)
				setSoundMaxDistance(sound,0)
			end
		end
	elseif weapon == 34 then
		if getElementData(localPlayer,"currentweapon_1") == "CZ 550" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 240 then
				playSound3D(":DayZ/sounds/weapons/CZ550.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/CZ550.wav",false)
				setSoundMaxDistance(sound,0)
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "DMR" then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 1 then
				playSound3D(":DayZ/sounds/weapons/Silenced.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/Silenced.wav",false)
				setSoundMaxDistance(sound,0)
			end
		else
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 0 then
				playSound3D(":DayZ/sounds/weapons/Sniper.wav",x2,y2,z2,false)
			else
				local sound = playSound(":DayZ/sounds/weapons/Sniper.wav",false)
				setSoundMaxDistance(sound,0)
			end
		end
	end 
end
addEventHandler ( "onClientPlayerWeaponFire", root, playSoundOnWeaponFire )

function rangeFinder()
local w, h = guiGetScreenSize ()
local tx, ty, tz = getWorldFromScreenPosition ( w/2, h/2, 500 )
local px, py, pz = getPedBonePosition(localPlayer,8)
hit, x, y, z, elementHit = processLineOfSight ( px, py, pz, tx, ty, tz )
	if getPedWeapon(localPlayer) == 43 and getElementData(localPlayer, "currentweapon_2") == "Range Finder" then
		if getControlState("aim_weapon") then
			if x and y and z then
				local distance = getDistanceBetweenPoints3D(px,py,pz,x,y,z)
				dxDrawText(tostring(math.floor(distance)).."m",w/2-50,h/2,w,h,tocolor(0,255,0,255),1.5,"clear")
			else
				local distance = 500
				dxDrawText(">"..tostring(math.floor(distance)).."m",w/2-50,h/2,w,h,tocolor(0,255,0,255),1.5,"clear")
			end
		end
	end
end
addEventHandler("onClientRender",root,rangeFinder)

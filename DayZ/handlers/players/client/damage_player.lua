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
		setElementData(localPlayer,"blood",getElementData(localPlayer,"blood")-(gameplayVariables["zombiedamage"]/damage_half))
		local gender = getElementData(localPlayer,"gender")
		if gender == "male" then
			playSFX("pain_a",2,53,false)
		elseif gender == "female" then
			playSFX("pain_a",1,52,false)
		end
		enableBlackWhite(true)
		setTimer(function() enableBlackWhite(false) end,1000,1)
		local number = math.random(1,7)
		if number == 4 then
			setElementData(localPlayer,"bleeding",getElementData(localPlayer,"bleeding") + math.floor(loss*10))
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

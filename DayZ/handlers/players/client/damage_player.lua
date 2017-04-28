--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: damage_player.lua						*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: CLIENT														*----
#-----------------------------------------------------------------------------#
]]

function dayZPlayerDamage(attacker,weapon,bodypart,loss)
	cancelEvent()
	local damage = 0
	local headshot = false
	local halfDamage = 1
	local damageMultiplier = 1
	if weapon == 37 then return end
	
	-- Attacker: Zombie
	if isElement(attacker) and getElementData(attacker,"zombie") then
		if getElementData(localPlayer,"humanity") >= 5000 then
			halfDamage = 2
		end
		local difficulty = gameplayVariables["difficulty"]
		if difficulty then
			if difficulty == "veteran" then
				damageMultiplier = 1.5
			elseif difficulty == "hardcore" then
				damageMultiplier = 3
			end
		else
			damageMultiplier = 1
		end
		setElementData(localPlayer,"blood",getElementData(localPlayer,"blood")-((gameplayVariables["zombiedamage"]*damageMultiplier)/halfDamage))
		enableBlackWhite(true)
		setTimer(function() enableBlackWhite(false) end,1000,1)
		local painChance = math.min((((gameplayVariables["zombiedamage"]*damageMultiplier)/halfDamage)/100),100)
		local bleedChance = 15
		if math.random(0,100) <= painChance then
			setElementData(localPlayer,"pain",true)
		end
		if math.random(0,100) <= bleedChance then
			setElementData(localPlayer,"bleeding",math.floor(painChance*25))
		end
		
	-- Attacker: Player
	elseif isElement(attacker) and getElementType(attacker) == "player" then
		if weapon and weapon > 1 then
			damage = getWeaponDamage(weapon,attacker)
			local x1,y1,z1 = getElementPosition(localPlayer)
			local x2,y2,z2 = getElementPosition(attacker)
			local distance = getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2)
			damage = damage-(distance*5)
			if bodypart == 5 or bodypart == 6 then
				damage = damage/1.07
				setElementData(localPlayer,"fracturedArms",true)
				playSound(":DayZ/sounds/status/bonecrack.mp3",false)
				playSFX("pain_a",2,98,false)
			elseif bodypart == 7 or bodypart == 8 then
				damage = damage/1.05
				setElementData(localPlayer,"fracturedLegs",true)
				playSound(":DayZ/sounds/status/bonecrack.mp3",false)
				playSFX("pain_a",2,95,false)
			elseif bodypart == 9 then
				local hasHelmet
				if gameplayVariables["newclothingsystem"] then
					hasHelmet = getPedClothes(localPlayer,16)
					if hasHelmet == "helmet" or hasHelmet == "moto" then
						if weapon ~=34 then
							damage = 0
							playSFX("genrl",20,12,false)
						else
							damage = damage*gameplayVariables["headshotdamage_player"]
							headshot = true
							playSFX("pain_a",2,38,false)
						end
					end
				else
					hasHelmet = getElementData(localPlayer,"hasHelmet")
					if hasHelmet then
						if weapon ~=34 then
							damage = 0
							playSFX("genrl",20,12,false)
						else
							damage = damage*gameplayVariables["headshotdamage_player"]
							headshot = true
							playSFX("pain_a",2,38,false)
						end
					end
				end
				
			end
			if getElementData(localPlayer,"humanity") >= 5000 then
				if damage <= 1000 then
					damage = 0
				end
			end
			if damage > 0 then
				setElementData(localPlayer,"blood",getElementData(localPlayer,"blood")-math.floor(damage))
				enableBlackWhite(true)
				setTimer(function() enableBlackWhite(false) end,1000,1)
				if damage >= 6000 then
					if math.random() < 0.5 then
						setElementData(localPlayer,"unconscious",true)
					end
					if not getElementData(localPlayer,"unconscious") then
						setElementData(localPlayer,"pain",true)
					end
				end
				setElementData(localPlayer,"bleeding",getElementData(localPlayer,"bleeding")+10)
			end
			local humanityHit = 0
			local myKills = 200-(getElementData(localPlayer,"murders")*3.3)
			humanityHit = math.abs(myKills-damage)
			if humanityHit >= 800 then
				humanityHit = 800
			end
			if not getElementData(localPlayer,"bandit") then	
				triggerServerEvent("onPlayerChangeStatus",attacker,"humanity",humanityHit)
			else
				triggerServerEvent("onPlayerChangeStatus",attacker,"humanity",-humanityHit)
			end
		end
	end
	
	-- Attacker: Explosions & Vehicle Crash/Runover
	if weapon == 49 or weapon == 50 then
		if loss >= 30 then
			setElementData(localPlayer,"fracturedLegs",true)
			setElementData(localPlayer,"fracturedArms",true)
			playSound(":DayZ/sounds/status/bonecrack.mp3",false)
			playSFX("pain_a",2,95,false)
			setElementData(localPlayer,"blood",getElementData(localPlayer,"blood")-math.floor(loss*10))
		else
			setElementData(localPlayer,"blood",getElementData(localPlayer,"blood")-math.floor(loss*5))
		end
		enableBlackWhite(true)
		setTimer(function() enableBlackWhite(false) end,1000,1)
	elseif weapon == 63 or weapon == 51 or weapon == 19 then
		if not getElementData(localPlayer,"isDead") then
			setElementData(localPlayer,"blood",0)
		end
	elseif weapon == 54 then
		local gravity = math.min(9.81,(loss/10))
		local potentialEnergy = gravity*(loss/10)
		local kineticEnergy = potentialEnergy/(5*9.81)
		if loss >= 30 then
			if kineticEnergy >= 0.001 then
				setElementData(localPlayer,"fracturedLegs",true)
				playSound(":DayZ/sounds/status/bonecrack.mp3",false)
				playSFX("pain_a",2,95,false)
				setElementData(localPlayer,"blood",getElementData(localPlayer,"blood")-math.floor(potentialEnergy*25*loss))
			end
		else
			setElementData(localPlayer,"blood",getElementData(localPlayer,"blood")-math.floor(potentialEnergy*25*loss))
		end
		enableBlackWhite(true)
		setTimer(function() enableBlackWhite(false) end,1000,1)
	end
	
	-- Final calculations
	if getElementData(localPlayer,"blood") <= 0 then
		if not getElementData(localPlayer,"isDead") then
			triggerServerEvent("kilLDayZPlayer",localPlayer,attacker,headshot)
			setElementData(localPlayer,"isDead",true)
		end
	end
	local gender = getElementData(localPlayer,"gender")
	if gender == "male" then
		playSFX("pain_a",2,53,false)
	elseif gender == "female" then
		playSFX("pain_a",1,52,false)
	end
end
addEventHandler ("onClientPlayerDamage",localPlayer,dayZPlayerDamage)


function playerDayZDamage(attacker,weapon,bodypart,loss)
	cancelEvent()
	damage = 100
	headshot = false
	damage_half = 1
	multiplier = 1
	
	if weapon == 37 then
		return
	end
	
	if isElement(attacker) and getElementData(attacker,"zombie") then
		if getElementData(localPlayer,"humanity") >= 5000 then
			damage_half = 2
		else
			damage_half = 1
		end
		if gameplayVariables["difficulty"] then
			if gameplayVariables["difficulty"] == "normal" then
				multiplier = 1
			elseif gameplayVariables["difficulty"] == "veteran" then
				multiplier = 1.5
			elseif gameplayVariables["difficulty"] == "hardcore" then
				multiplier = 3
			else
				multiplier = 1
			end
		end
		if getElementData(attacker,"viralzombie") then
			viralmultiplier = 2
		else
			viralmultiplier = 1
		end
		setElementData(localPlayer,"blood",getElementData(localPlayer,"blood")-(((gameplayVariables["zombiedamage"]*viralmultiplier)*multiplier)/damage_half))
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
		damage = getWeaponDamage(weapon,attacker)
		local x1,y1,z1 = getElementPosition(localPlayer)
		local x2,y2,z2 = getElementPosition(attacker)
		local distance = getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2)
		damage = damage-(distance*5)
		
		if bodypart == 9 then
			local hasHelmet = getPedClothes(source,16)
			if hasHelmet == "helmet" or hasHelmet == "moto" then
				if weapon ~= 34 then
					damage = 0
				end
			end
			damage = damage*gameplayVariables["headshotdamage_player"]
			headshot = true
		end
		
		if bodypart == 7 or bodypart == 8 then
			setElementData(localPlayer,"brokenbone",true)
			playSound(":DayZ/sounds/status/bonecrack.mp3",false)
		end
		
		if getElementData(localPlayer,"humanity") >= 5000 then
			if damage <= 1000 then
				damage = 0
			else
				damage = damage
			end
		end
		
		setElementData(localPlayer,"blood",getElementData(localPlayer,"blood")-math.floor(damage))
		enableBlackWhite(true)
		setTimer(function() enableBlackWhite(false) end,1000,1)
		
		if damage >= 6000 then
			setElementData(localPlayer,"unconscious",true)
		end
		
		local number = math.random(1,8)
		if number >= 6 and number <= 8 then
			if damage > 0 then
				setElementData(localPlayer,"bleeding",getElementData(localPlayer,"bleeding") + math.floor(loss*10))
			end
		end
		
		local number = math.random(1,7)
		if number == 2 then
			setElementData(localPlayer,"pain",true)
		end
		--[[
			// 
			We check how many murders the attacked one (localPlayer) has
			Subtract 200 humanity from attacker for killing localPlayer
			But remove 50 from the initial 200 for every murder the localPlayer has
			This means the more murders the localPlayer has, the more humanity his 
			killer can get, even if the localPlayer is not a bandit yet
			//
		]]
		local myKills = 200 - ((getElementData(localPlayer,"murders") / 3) * 150)
		local rawDamage = math.floor(math.sqrt((damage/55.55)))
		local humanityHit = -(myKills * rawDamage)
		
		if humanityHit > -800 then
			humanityHit = -800
		end
		
		if not getElementData(localPlayer,"bandit") then
			triggerServerEvent("onPlayerChangeStatus",attacker,"humanity",math.floor(humanityHit))
			if getElementData(attacker,"humanity") < 0 then
				setElementData(attacker,"bandit",true)
			end
		else
			triggerServerEvent("onPlayerChangeStatus",attacker,"humanity",math.floor(humanityHit))
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
	local gender = getElementData(localPlayer,"gender")
	if gender == "male" then
		playSFX("pain_a",2,53,false)
	elseif gender == "female" then
		playSFX("pain_a",1,52,false)
	end
end
--addEventHandler ("onClientPlayerDamage",localPlayer,playerDayZDamage)


function onPlayerDamageShader()
	enableBlackWhite(true)
	setTimer(function() enableBlackWhite(false) end,1000,1)
end
addEvent("onPlayerDamageShader",true)
addEventHandler("onPlayerDamageShader",root,onPlayerDamageShader)

function abortAllStealthKills(targetPlayer)
    cancelEvent()
end
addEventHandler("onClientPlayerStealthKill", localPlayer, abortAllStealthKills)

function disableCameraOnSwitch ( prevSlot, newSlot )
	if getPedWeapon(localPlayer,newSlot) == 43 then 
		toggleControl ( "fire", false ) 
	elseif getPedWeapon(localPlayer,newSlot) == 22 then
		if getElementData(localPlayer,"currentweapon_2") == "Flashlight" then
			toggleControl("fire",false)
		end
	else
		toggleControl ( "fire", true )
	end
end
addEventHandler ("onClientPlayerWeaponSwitch",root,disableCameraOnSwitch)

local binoculars = guiCreateStaticImage(0,0,1,1,":DayZ/gui/gear/items/binoculars.png",true)
local rangefinder = guiCreateStaticImage(0,0,1,1,":DayZ/gui/gear/items/rangefinder.png",true)
guiSetVisible(binoculars,false)
guiSetVisible(rangefinder,false)

function isPlayerUsingBinoculars(button, press)
	if getPedWeapon(localPlayer) == 43 then
		if getElementData(localPlayer,"currentweapon_2") == "Binoculars" then
			visible = binoculars
		else
			visible = rangefinder
		end
		
		if button == "mouse2" then
			if press then
				guiSetVisible(visible,true)
				showChat(false)
			else
				guiSetVisible(visible,false)
				showChat(true)
			end
		end
	end
end
addEventHandler("onClientKey",root,isPlayerUsingBinoculars)

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

function weaponBurstFire(weapon)
	if weapon == 30 then
		if getElementData(source,"currentweapon_1") == "FN FAL" then
			setTimer(function()
				setControlState("fire",true)
				setControlState("fire",false)
				setControlState("fire",true)
				setControlState("fire",false)
			end,200,1)
		end	
	elseif weapon == 33 then
		setTimer(function()
			setControlState("fire",true)
			setControlState("fire",false)
		end,100,1)
	elseif weapon == 34 then
		setTimer(function()
			setControlState("fire",true)
			setControlState("fire",false)
		end,100,1)
	end
end
addEventHandler("onClientPlayerWeaponFire",localPlayer,weaponBurstFire)

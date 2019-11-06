--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: damage_player.lua						*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]

function onDayZPlayerDamage(attacker,weapon,bodypart,loss)
	local damage = 0
	local headshot = false
	local halfDamage = 1
	local damageMultiplier = 1
	if weapon == 37 then return end
	if not client then client = source end
	
	-- Attacker: Zombie
	if isElement(attacker) and getElementData(attacker,"zombie") then
		if isElementWithinColShape(client,whetstone_safezone) then return end
		if playerSkillsTable[client] then
			if playerSkillsTable[client]["SoldierDodgeChance"] > 0 then
				local dodgeChance = math.random(0,100)
				if dodgeChance <= playerSkillsTable[client]["SoldierDodgeChance"] then 
					return
				end
			end
		end
		-- Destroy zombie or let NPCs handle it?
		if playerStatusTable[client]["humanity"] >= 5000 then
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
		local totalDamage = (gameplayVariables["zombiedamage"]*damageMultiplier)/halfDamage
		if playerSkillsTable[client] then
			if playerSkillsTable[client]["SoldierToughChance"] > 0 then
				totalDamage = totalDamage-(totalDamage*(playerSkillsTable[client]["SoldierToughChance"]/100))
			end
		end
		playerStatusTable[client]["blood"] = playerStatusTable[client]["blood"]-totalDamage
		triggerClientEvent(client,"onPlayerDamageShader",client)
		
		local painChance = math.min((((gameplayVariables["zombiedamage"]*damageMultiplier)/halfDamage)/100),100)
		local bleedChance = 15
		if math.random(0,100) <= painChance then
			playerStatusTable[client]["pain"] = true
		end
		if math.random(0,100) <= bleedChance then
			playerStatusTable[client]["bleeding"] = math.floor(painChance*25)
		end
		
	-- Attacker: Player
	elseif isElement(attacker) and getElementType(attacker) == "player" then
		if isElementWithinColShape(client,whetstone_safezone) then return end
		if weapon and weapon > 1 then
			damage = getWeaponDamage(weapon,attacker)
			local x1,y1,z1 = getElementPosition(client)
			local x2,y2,z2 = getElementPosition(attacker)
			local distance = getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2)
			damage = damage-(distance*5)
			if bodypart == 5 or bodypart == 6 then
				damage = damage/1.07
				playerStatusTable[client]["fracturedArms"] = true
				setPlayerFracturedBones(client,"fracturedArms")
				triggerClientEvent(client,"onClientPlayerPlaySoundEffect",client,":DayZ/sounds/status/bonecrack.mp3",false)
				triggerClientEvent(client,"onClientPlayerPlaySFX",client,"pain_a",2,98,false)
			elseif bodypart == 7 or bodypart == 8 then
				damage = damage/1.05
				playerStatusTable[client]["fracturedLegs"] = true
				setPlayerFracturedBones(client,"fracturedLegs")
				triggerClientEvent(client,"onClientPlayerPlaySoundEffect",client,":DayZ/sounds/status/bonecrack.mp3",false)
				triggerClientEvent(client,"onClientPlayerPlaySFX",client,"pain_a",2,95,false)
			elseif bodypart == 9 then
				local hasHelmet
				if gameplayVariables["newclothingsystem"] then
					hasHelmet = getPedClothes(client,16)
					if hasHelmet == "helmet" or hasHelmet == "moto" then
						if weapon ~=34 then
							damage = 0
							triggerClientEvent(client,"onClientPlayerPlaySFX",client,"genrl",20,12,false)
						else
							damage = damage*gameplayVariables["headshotdamage_player"]
							headshot = true
							triggerClientEvent(client,"onClientPlayerPlaySFX",client,"pain_a",2,38,false)
						end
					end
				else
					hasHelmet = getElementData(client,"hasHelmet")
					if hasHelmet then
						if weapon ~=34 then
							damage = 0
							triggerClientEvent(client,"onClientPlayerPlaySFX",client,"genrl",20,12,false)
						else
							damage = damage*gameplayVariables["headshotdamage_player"]
							headshot = true
							triggerClientEvent(client,"onClientPlayerPlaySFX",client,"pain_a",2,38,false)
						end
					end
				end
				
			end
			if playerStatusTable[client]["humanity"] >= 5000 then
				if damage <= 1000 then
					damage = 1 -- Scratch damage
				end
			end
			if damage > 0 then
				if playerSkillsTable[attacker] then
					if playerSkillsTable[attacker]["SoldierCritChance"] > 0 then
						local critChance = math.random(0,100)
						if critChance < playerSkillsTable[attacker]["SoldierCritChance"] then
							damage = damage*2
						end
					end
				end
				if playerSkillsTable[client] then
					if playerSkillsTable[client]["SoldierToughChance"] > 0 then
						damage = damage-(damage*(playerSkillsTable[client]["SoldierToughChance"]/100))
					end
				end
				playerStatusTable[client]["blood"] = playerStatusTable[client]["blood"]-math.floor(damage)
				triggerClientEvent(client,"onPlayerDamageShader",client)
				if damage >= 6000 then
					if math.random() < 0.5 then
						playerStatusTable[client]["unconscious"] = true
					end
					if not playerStatusTable[client]["unconscious"] then
						playerStatusTable[client]["pain"] = true
					end
				end
				playerStatusTable[client]["bleeding"] = playerStatusTable[client]["bleeding"]+10
			end
			
			local humanityHit = 0
			local murders = playerStatusTable[client]["murders"] or 0
			local myKills = 200-(murders*3.3)
			humanityHit = math.abs(myKills-damage)
			if humanityHit >= 800 then
				humanityHit = 800
			end
			if not playerStatusTable[client]["bandit"] then
				playerStatusTable[attacker]["humanity"] = playerStatusTable[attacker]["humanity"]-humanityHit
			else
				playerStatusTable[attacker]["humanity"] = playerStatusTable[attacker]["humanity"]+humanityHit
			end
		end
	end
	
	-- Attacker: Explosions & Vehicle Crash/Runover
	if weapon == 49 or weapon == 50 then
		if isElementWithinColShape(client,whetstone_safezone) then return end
		if loss >= 30 then
			playerStatusTable[client]["brokenbone"] = true
			playerStatusTable[client]["fracturedArms"] = true
			playerStatusTable[client]["fracturedLegs"] = true
			setPlayerFracturedBones(client,"fracturedArms")
			setPlayerFracturedBones(client,"fracturedLegs")
			triggerClientEvent(client,"onClientPlayerPlaySoundEffect",client,":DayZ/sounds/status/bonecrack.mp3",false)
			triggerClientEvent(client,"onClientPlayerPlaySFX",client,"pain_a",2,95,false)
			playerStatusTable[client]["blood"] = playerStatusTable[client]["blood"]-math.floor(loss*10)
		else
			playerStatusTable[client]["blood"] = playerStatusTable[client]["blood"]-math.floor(loss*5)
		end
		triggerClientEvent(client,"onPlayerDamageShader",client)
	elseif weapon == 63 or weapon == 51 or weapon == 19 then
		if isElementWithinColShape(client,whetstone_safezone) then return end
		if not getElementData(client,"isDead") then
			playerStatusTable[client]["blood"] = 0
		end
	elseif weapon == 54 then
		local gravity = math.min(9.81,(loss/10))
		local potentialEnergy = gravity*(loss/10)
		local kineticEnergy = potentialEnergy/(5*9.81)
		if loss >= 30 then
			if kineticEnergy >= 0.001 then
				playerStatusTable[client]["brokenbone"] = true
				playerStatusTable[client]["fracturedLegs"] = true
				setPlayerFracturedBones(client,"fracturedLegs")
				triggerClientEvent(client,"onClientPlayerPlaySoundEffect",client,":DayZ/sounds/status/bonecrack.mp3",false)
				triggerClientEvent(client,"onClientPlayerPlaySFX",client,"pain_a",2,95,false)	
				playerStatusTable[client]["blood"] = playerStatusTable[client]["blood"]-math.floor(potentialEnergy*25*loss)
			end
		else
			playerStatusTable[client]["blood"] = playerStatusTable[client]["blood"]-math.floor(potentialEnergy*25*loss)
		end
		triggerClientEvent(client,"onPlayerDamageShader",client)
	end
	
	-- Final calculations
	if playerStatusTable[client]["blood"] <= 0 then
		if not getElementData(client,"isDead") then
			if playerSkillsTable[client] then
				if playerSkillsTable[client]["MedicChanceChance"] > 0 then
					local secondChance = math.random(0,100)
					if secondChance < playerSkillsTable[client]["MedicChanceChance"] then
						if playerStatusTable[client]["blood"] ~= 1 then
							playerStatusTable[client]["blood"] = 1
							playerStatusTable[client]["bleeding"] = 0
							playerStatusTable[client]["brokenbone"] = false
							playerStatusTable[client]["fracturedArms"] = false
							playerStatusTable[client]["fracturedLegs"] = false
							playerStatusTable[client]["unconscious"] = false
							playerStatusTable[client]["pain"] = false
							setPlayerFracturedBones(client,false)
							return
						else
							killDayZPlayer(client,attacker,headshot)
						end
					end
				end
			end
			killDayZPlayer(client,attacker,headshot)
			setElementData(client,"isDead",true)
		end
	end
	local gender = playerStatusTable[client]["gender"]
	if gender == "male" then
		triggerClientEvent(client,"onClientPlayerPlaySFX",client,"pain_a",2,53,false)		
	elseif gender == "female" then
		triggerClientEvent(client,"onClientPlayerPlaySFX",client,"pain_a",1,52,false)
	end
end
addEvent("onDayZPlayerDamage",true)
addEventHandler("onDayZPlayerDamage",root,onDayZPlayerDamage)

setWeaponProperty ("m4","poor","maximum_clip_ammo",30)
setWeaponProperty ("m4","std","maximum_clip_ammo",30)
setWeaponProperty ("m4","pro","maximum_clip_ammo",30)

function rearmPlayerWeapon (weaponName,slot)
	takeAllWeapons(source)
	--Rearm
	local ammoData,weapID = getWeaponAmmoFromName(weaponName)
	if not (ammoData == "others") then
		if getElementData(source,ammoData) <= 0 then 
			triggerClientEvent (source, "displayClientInfo", source,"Rearm",shownInfos["nomag"],255,22,0) 
			return 
		end
	end
	playerStatusTable[source]["currentweapon_"..slot] = weaponName
	--Old Weapons
	local weapon = playerStatusTable[source]["currentweapon_1"]
	if weapon then
		local ammoData,weapID = getWeaponAmmoFromName (weapon)
		if (ammoData == "others") then
				giveWeapon(source,weapID,1, true )
		else 
			local ammoData,weapID = getWeaponAmmoFromName (weapon)
			giveWeapon(source,weapID,getElementData(source,ammoData), true )
		end
	end
	local weapon = playerStatusTable[source]["currentweapon_2"]
	if weapon then
		local ammoData,weapID = getWeaponAmmoFromName (weapon)
		if (ammoData == "others") then
			giveWeapon(source,weapID,1, false )
		else
			local ammoData,weapID = getWeaponAmmoFromName (weapon)
			giveWeapon(source,weapID,getElementData(source,ammoData), false )
		end
	end
	local weapon = playerStatusTable[source]["currentweapon_3"]
	if weapon then
		local ammoData,weapID = getWeaponAmmoFromName (weapon)
		giveWeapon(source,weapID,getElementData(source,ammoData), false )
	end
	if elementWeaponBack[source] then
		detachElementFromBone(elementWeaponBack[source])
		destroyElement(elementWeaponBack[source])
		elementWeaponBack[source] = false
	end
end
addEvent("onPlayerRearmWeapon",true)
addEventHandler("onPlayerRearmWeapon",getRootElement(),rearmPlayerWeapon)

function onPlayerTakeWeapon(itemName,slot,action)
	if action == "toCarry" then
		local ammoData,weapID = getWeaponAmmoFromName(itemName)
		takeWeapon(source,weapID)
	elseif action == "toHold" then
		local ammoData,weapID = getWeaponAmmoFromName(itemName)
		if (ammoData == "others") then
			giveWeapon(source,weapID,1, false )
		else
			local ammoData,weapID = getWeaponAmmoFromName(itemName)
			giveWeapon(source,weapID,getElementData(source,ammoData),false)
		end
	end
end
addEvent("onPlayerTakeWeapon",true)
addEventHandler("onPlayerTakeWeapon",root,onPlayerTakeWeapon)

weaponIDtoObjectID = {
{30,355},
{31,356},
{25,349},
{26,350},
{27,351},
{33,357},
{34,358},
{36,360},
{35,359},
{2,333},
{5,336},
{6,337},
{8,339},
}

function getWeaponObjectID (weaponID)
	for i,weaponData in ipairs(weaponIDtoObjectID) do
		if weaponID == weaponData[1] then
			return weaponData[2]
		end
	end
end

function weaponDelete(dataName,oldValue)
	if getElementType(source) == "player" then
		if getElementData(source,"logedin") then
			local weapon1 = playerStatusTable[source]["currentweapon_1"]
			local weapon2 = playerStatusTable[source]["currentweapon_2"]
			local weapon3 = playerStatusTable[source]["currentweapon_3"]
			if dataName == weapon1 or dataName == weapon2 or dataName == weapon3 then
				if getElementData (source,dataName) == 0 then
					local ammoData,weapID = getWeaponAmmoFromName(dataName)
					takeWeapon (source,weapID)
					if dataName == weapon1 then
						playerStatusTable[source]["currentweapon_1"] = false
					elseif dataName == weapon2 then
						playerStatusTable[source]["currentweapon_2"] = false
					elseif dataName == weapon3 then
						playerStatusTable[source]["currentweapon_3"] = false
					end
				end
			end
			local weapon1 = playerStatusTable[source]["currentweapon_1"]
			local weapon2 = playerStatusTable[source]["currentweapon_2"]
			local weapon3 = playerStatusTable[source]["currentweapon_3"]
			local ammoData1,weapID1 = getWeaponAmmoFromName(weapon1)
			local ammoData2,weapID2 = getWeaponAmmoFromName(weapon2)
			local ammoData3,weapID3 = getWeaponAmmoFromName(weapon3)
			if dataName == ammoData1 then
				if not oldValue then return end
				local newammo = oldValue - getElementData (source,dataName)
				if newammo == 1 then return end
				if getElementData (source,dataName) < oldValue then
					takeWeapon (source,weapID1,newammo) 
					if elementWeaponBack[source] then
						detachElementFromBone(elementWeaponBack[source])
						destroyElement(elementWeaponBack[source])	
						elementWeaponBack[source] = false
					end	
				elseif getElementData (source,dataName) > oldValue then
					giveWeapon(source,weapID1,getElementData (source,dataName)-oldValue,true)
				end
			end	
			if dataName == ammoData2 then
				if not oldValue then return end
				local newammo = oldValue - getElementData (source,dataName)
				if newammo == 1 then return end
				if getElementData (source,dataName) < oldValue then
					takeWeapon (source,weapID2,newammo) 
				elseif getElementData (source,dataName) > oldValue then
					giveWeapon(source,weapID2,getElementData (source,dataName)-oldValue,false)
				end
			end	
			if dataName == ammoData3 then
				if not oldValue then return end
				local newammo = oldValue - getElementData (source,dataName)
				if newammo == 1 then return end
				if getElementData (source,dataName) < oldValue then
					takeWeapon (source,weapID3,newammo) 
				elseif getElementData (source,dataName) > oldValue then
					giveWeapon(source,weapID3,getElementData (source,dataName)-oldValue,false)
				end	
			end
		end
	end
end
addEventHandler("onElementDataChange",getRootElement(),weaponDelete)

function onPlayerChangeStatus(status,value)
	if status == "isInBuilding" then
		setElementData(source,status,value)
	end
end
addEvent("onPlayerChangeStatus",true)
addEventHandler("onPlayerChangeStatus",root,onPlayerChangeStatus)
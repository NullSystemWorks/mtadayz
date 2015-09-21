--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: damage_zombies.lua					*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: CLIENT														*----
#-----------------------------------------------------------------------------#
]]

function zombieDayZDamage(attacker,weapon,bodypart,loss)
	if getElementData(source,"zombie") then
		if attacker and getElementType(attacker) == "player" then
			damage = 100
			if weapon == 37 or weapon == 54 or weapon == 55 then
				setElementHealth(source,100)
				return
			end
			if weapon then
				if weapon == 63 or weapon == 51 or weapon == 19 then
					setElementHealth(source,100)
					setElementData(source,"blood",0)
					if getElementData(source,"blood") <= 0 then
						triggerServerEvent("onZombieGetsKilled",source,attacker)
					end
				elseif weapon ~= 0 then
					damage = getWeaponDamage(weapon,attacker)
					local x1,y1,z1 = getElementPosition(source)
					local x2,y2,z2 = getElementPosition(attacker)
					local distance = getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2)
					damage = damage-(distance*5)
					setElementHealth(source,100)
					if bodypart == 9 then
						damage = damage*gameplayVariables["headshotdamage_zombie"]
						headshot = true
						if isPedHeadless(source) and weapon == 8 then
							setPedHeadless(source,false)
						end
					end
					setElementData(source,"blood",getElementData(source,"blood")-math.floor(damage))
					local soundnumber =  math.random(0,6)
					playSound(":DayZ/sounds/zombies/hit_"..soundnumber..".ogg",false)
					if getElementData(source,"blood") <= 0 then
						triggerServerEvent("onZombieGetsKilled",source,attacker,headshot)
					end
				elseif weapon == 0 then
					setElementHealth(source,100)
					return
				end
			end
		elseif attacker and getElementType(attacker) == "vehicle" then
			damage = 100
			if weapon == 37 or weapon == 54 or weapon == 55 then
				setElementHealth(source,100)
				return
			end
			if weapon then
				if weapon == 63 or weapon == 51 or weapon == 19 then
					setElementHealth(source,100)
					setElementData(source,"blood",0)
					if getElementData(source,"blood") <= 0 then
						triggerServerEvent("onZombieGetsKilled",source,attacker)
					end
				elseif weapon == 49 then
					damage = 700
					setElementHealth(source,100)
					setElementData(source,"blood",getElementData(source,"blood")-damage)
					if getElementData(source,"blood") <= 0 then
						triggerServerEvent("onZombieGetsKilled",source,attacker,headshot)
					end
				elseif weapon == 50 then
					damage = 0
					setElementHealth(source,100)
					setElementData(source,"blood",getElementData(source,"blood")-damage)
					if getElementData(source,"blood") <= 0 then
						triggerServerEvent("onZombieGetsKilled",source,attacker,headshot)
					end
				end
			end
		end
	end
end
addEventHandler ("onClientPedDamage",root,zombieDayZDamage)
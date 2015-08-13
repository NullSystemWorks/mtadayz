--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: kill_zombies.lua						*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]

function destroyDeadZombie (ped,pedCol)
	destroyElement(ped)
	destroyElement(pedCol)
end

function killZombie(killer,headshot)
	if killer then
		setElementData(killer,"zombieskilled",getElementData(killer,"zombieskilled")+1)
	end	
	local skin = getElementModel(source)
	local x,y,z = getElementPosition(source)
	local ped = createPed(skin,x,y,z)
	local pedCol = createColSphere(x,y,z,1.5)
	killPed(ped)
	setTimer(destroyDeadZombie,360000 ,1,ped,pedCol)
	attachElements (pedCol,ped,0,0,0)
	setElementData(pedCol,"parent",ped)
	setElementData(pedCol,"playername","Zombie")
	setElementData(pedCol,"deadman",true)
	setElementData(ped,"deadzombie",true)
	setElementData(pedCol,"deadman",true)
	local time = getRealTime()
	local hours = time.hour
	local minutes = time.minute
	local loot_table = ""
	setElementData(pedCol,"deadreason","Looks like it's finally dead. Estimated time of death: "..hours..":"..minutes)
	for i, id in ipairs(ZombieLoot) do
		if skin == id[1] then
			loot_table = tostring(id[2])
		end
	end
	for i, item in ipairs(zombieLootType[loot_table]) do
		local value = math.percentChance(item[5],math.random(1,3))
		setElementData(pedCol,item[1],value)
		local ammoData,weapID = getWeaponAmmoFromName (item[1],true)
		if ammoData and value > 0 then
			setElementData(pedCol,ammoData,math.random(1,3))
		end
	end
	local zombieCreator = getElementData(source,"owner")
	setElementData(zombieCreator,"spawnedzombies",getElementData(zombieCreator,"spawnedzombies")-1)
	destroyElement(source)
	if headshot then
		setElementData(killer,"headshots",getElementData(killer,"headshots")+1)
	end	
end
addEvent("onZombieGetsKilled",true)
addEventHandler("onZombieGetsKilled",root,killZombie)
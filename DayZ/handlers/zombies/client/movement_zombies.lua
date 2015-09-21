--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: movement_zombies.lua					*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: CLIENT														*----
#-----------------------------------------------------------------------------#
]]

function zombieMovement(ped)
local rotation = math.random(1,359)
local setStance = math.random(0,50)
setPedRotation(ped,rotation)
	if setStance >= 0 and setStance <= 49 then
		setPedAnimation (ped, "RYDER", "RYD_Die_PT1", -1, true, true, true)
	elseif setStance == 50 then
		setPedAnimation(ped,"PED","WEAPON_crouch",-1,true,true,true)
	end
end
addEvent("onZombieMove",true)
addEventHandler("onZombieMove",getRootElement(),zombieMovement)

function getWeaponNoise(weapon)
	for i,weapon2 in ipairs(weaponNoiseTable) do
		if weapon == weapon2[1] then
			return weapon2[2]
		end
	end
	return 0
end

function getWeaponNoiseFactor(weapon)
    for i,weapon2 in ipairs(weaponNoiseTable) do
        if weapon == weapon2[1] then
            return weapon2[3]
        end
    end
	return 5
end

function setPlayerShootingLevel()
	if getControlState("fire") then
		local weapon = getPedWeapon(localPlayer)
		local noise = getWeaponNoise(weapon) or 0
		setElementData(localPlayer,"shooting",noise)
		if shootTimer then
			killTimer(shootTimer)
		end
		shootTimer = setTimer(resetPlayerShootingLevel,1000,1)
	end
end
setTimer(setPlayerShootingLevel,100,0)

function resetPlayerShootingLevel()
	setElementData(localPlayer,"shooting",0)
	shootTimer = false
end

function checkAliveZombies()
	local zombiesalive = 0
	local zombiestotal = 0
	for i,ped in ipairs(getElementsByType("ped")) do
		if getElementData(ped,"zombie") then
			zombiesalive = zombiesalive + 1
		end
		if getElementData(ped,"deadzombie") then
			zombiestotal = zombiestotal + 1
		end
	end
	setElementData(getRootElement(),"zombiesalive",zombiesalive)
	setElementData(getRootElement(),"zombiestotal",zombiestotal+zombiesalive)
end
setTimer(checkAliveZombies,5000,0)

function checkZombiePlayerStealth()
    local x,y,z = getElementPosition(localPlayer)
    for i,ped in ipairs(getElementsByType("ped")) do
        if getElementData(ped,"zombie") then
			if getElementData(localPlayer,"shooting") and getElementData(localPlayer,"shooting") > 0 then
				value = getWeaponNoiseFactor(getPedWeapon(localPlayer))
			else
				value = 5
			end
			local sound = getElementData(localPlayer,"volume")/value
            local visibly = getElementData(localPlayer,"visibly")/5
            local xZ,yZ,zZ = getElementPosition(ped)
            if getDistanceBetweenPoints3D (x,y,z,xZ,yZ,zZ) <= sound+visibly then
                if getElementData ( ped, "leader" ) == nil then
					if not getElementData(ped,"deadzombie") then
						triggerServerEvent("botAttack",localPlayer,ped)
					end
                end
            else
				if getElementData ( ped, "target" ) == localPlayer then
					setElementData(ped,"target",nil)
					triggerEvent("onZombieMove",root,ped)
				end
                if getElementData ( ped, "leader" ) == localPlayer then
                    triggerServerEvent("botStopFollow",localPlayer,ped)
                    triggerEvent("onZombieMove",root,ped)
                end
            end
        end
    end
end
setTimer(checkZombiePlayerStealth,500,0)

function zombieSpawning()
	if getElementData(localPlayer,"logedin") then
		if not isPedInVehicle(localPlayer) then
			local x, y, z = getElementPosition(getLocalPlayer())
			local material,hitX, hitY, hitZ = isObjectAroundPlayer2 ( getLocalPlayer(), 30, 3 )
			triggerServerEvent("createZomieForPlayer",getLocalPlayer(),hitX, hitY, hitZ)
		end
	end
end
setTimer(zombieSpawning,3000,0)
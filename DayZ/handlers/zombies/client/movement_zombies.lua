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

local targetBySound = false
local targetByVisibility = false

function checkZombiePlayerStealth()
local x,y,z = getElementPosition(localPlayer)
	for i,ped in ipairs(getElementsByType("ped")) do
        if getElementData(ped,"zombie") then
            local xZ,yZ,zZ = getElementPosition(ped)
			local sound,visibility = getSoundAndVisibilityLevel()
			local ZedDistance = getDistanceBetweenPoints3D(x,y,z,xZ,yZ,zZ)
			-- Noise Detection
            if ZedDistance <= sound/2 then
				if sound > 80 then
					targetBySound = true		
                else
					local LOSChance = checkLOSChance(ZedDistance,sound)
					if math.random(0,100) < LOSChance then
						targetBySound = true
					end
				end
            else
				targetBySound = false
			end
			-- Visibility Detection
			if ZedDistance <= visibility/2 then
				local LOSChance = checkLOSChance(ZedDistance,visibility)
				if math.random(0,100) < LOSChance then
					targetByVisibility = true
				end
			else
				targetByVisibility = false
			end
			if targetBySound or targetByVisibility then
				if getElementData ( ped, "leader" ) == nil then
					if not getElementData(ped,"deadzombie") then
						triggerServerEvent("botAttack",localPlayer,ped)
					end
				end
			else
				if getElementData ( ped, "target" ) == localPlayer then
					setElementData(ped,"target",nil)
					zombieMovement(ped)
				end
                if getElementData ( ped, "leader" ) == localPlayer then
                   triggerServerEvent("botStopFollow",localPlayer,ped)
                   zombieMovement(ped)
                end
            end
        end
    end
end
setTimer(checkZombiePlayerStealth,500,0)

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

function zombieSpawning()
	if not gameplayVariables["newzombiespawnsystem"] then
		if getElementData(localPlayer,"logedin") then
			if not isPedInVehicle(localPlayer) then
				local material,hitX, hitY, hitZ = isObjectAroundPlayer2(localPlayer, 30,3)
				if material == 0 or material == 1 or material == 2 or material == 3 then
					local x, y, z = getElementPosition(getLocalPlayer())
					triggerServerEvent("createZomieForPlayer",getLocalPlayer(),x,y,z)
				end
			end
		end
	end
end
setTimer(zombieSpawning,3000,0)

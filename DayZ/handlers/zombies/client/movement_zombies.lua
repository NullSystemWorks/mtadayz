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
		shootTimer = setTimer(resetPlayerShootingLevel,2000,1)
	end
end
--setTimer(setPlayerShootingLevel,100,0)

local playerHasShot = 0
local shootTimer = false
function setPlayerShootingLevel(weapon)
	local noise = getWeaponNoise(weapon) or 0
	playerHasShot = noise
	if shootTimer then
		killTimer(shootTimer)
	end
	shootTimer = setTimer(resetPlayerShootingLevel,1500,1)
end
addEventHandler("onClientPlayerWeaponFire",localPlayer,setPlayerShootingLevel)

function resetPlayerShootingLevel()
	playerHasShot = 0
	shootTimer = false
end

-- New sound & visibility calculation
local initialValue = 0

-- returns a float number between 0 and 1, with 0 = moon and 1 = sun
function isSunOrMoon()
	local hours,minutes = getTime()
	local sunOrMoon = 0
	if hours > 12 then
		sunOrMoon = 2-(hours/12)
	else
		sunOrMoon = hours/12
	end
	return sunOrMoon
end

-- returns a float number between 0 and 1, with 0 = no fog and 1 = fog
function isFogOrNot()
	local fog = getFogDistance()
	local getFog = 0
	if fog < 0 then
		getFog = 1
	else
		getFog = 1-(fog/400)
	end
	return getFog
end

-- returns a float number between 0 and 1, representing moon light intensity
function getMoonIntensity()
	local moonIntensity = math.sin(math.pi*exports.DayZ:getMoonPhaseValue())*1
	return moonIntensity
end

function getCurrentLightLevel()
	local hours,minutes = getTime()
	local weather = getWeather()
	local moonSunLevel = isSunOrMoon()
	local moonLightIntensity = getMoonIntensity()
	local rain = getRainLevel()
	local fog = isFogOrNot()
	local cloudy = 0
	local lightLevel = 0
	-- Workaround for cloud density
	if weather == 4 or weather == 7 or weather == 12 or weather == 15 then
		cloudy = tonumber(weather)/15
	end
	if hours > 6 and hours < 20 then
		moonLightIntensity = 0
	end
	local lightLevel = (moonSunLevel*2)+moonLightIntensity-(cloudy*0.2)-(rain*0.2)-(fog*0.5)
	initialValue = 20+(moonSunLevel*20)
	return lightLevel
end

-- For muffling sounds due to weather
function getCurrentMuffleLevel()
	local rain = getRainLevel()
	local muffleLevel = 0
	muffleLevel = 1-(rain*0.3)
	return muffleLevel
end

function getPlayerPoseVisibility()
	local block, animation = getPedAnimation(localPlayer)
	local moveState = getPedMoveState(localPlayer)
	local scalePose = 0.9
	local scaleMovement = 0.2
	if block == "ped" or block == "SHOP" or block == "BEACH" then
		scalePose = 0.14
		scaleMovement = 0.3
	end
	if moveState == "crouch" or moveState == "crawl" then
		scalePose = 0.6
		scaleMovement = 0.2
	end
	return scalePose,scaleMovement
end

local terrainTable = {
["grass"] = {9,10,11,12,13,14,15,16,17,20,80,81,82,115,116,117,118,119,120,121,122,125,146,147,148,149,150,151,152,153,160},
["concrete"] = {4,5,7,8,34,89,127,135,136,137,138,139,144,165},
["forest"] = {23,41,111,112,113,114,19,21,22,24,25,26,27,40,83,84,87,88,100,110,123,124,126,128,130,132,141,142,145,155,156},
["rock"] = {18,35,36,37,69,109,154,161,6,85,101,134,140},
}

function getTerrainProperties()
	local x,y,z = getElementPosition(localPlayer)
	local material = getGroundMaterial(x,y,z)
	local scale,movement = getPlayerPoseVisibility()
	local terrainVisibility = false
	local terrainNoise = false
	local moveState = getPedMoveState(localPlayer)
	for i, terrain in ipairs(terrainTable["grass"]) do
		if terrain == material then
			initialValue = initialValue*0.65
			terrainVisibility = movement-0.05
			if moveState == "sprint" then
				terrainNoise = 28
			elseif moveState == "jog" then
				terrainNoise = 23
			elseif moveState == "powerwalk" or moveState == "walk" then
				terrainNoise = 19
			elseif moveState == "crawl" then
				terrainNoise = 20
			elseif moveState == "crouch" or moveState == "stand" then
				terrainNoise = 1
			else
				terrainNoise = 23
			end
		end
	end
	for i, terrain in ipairs(terrainTable["concrete"]) do
		if terrain == material then
			initialValue = initialValue*0.85
			terrainVisibility = movement+0.1
			if moveState == "sprint" then
				terrainNoise = 28
			elseif moveState == "jog" then
				terrainNoise = 25
			elseif moveState == "powerwalk" or moveState == "walk" then
				terrainNoise = 19
			elseif moveState == "crawl" then
				terrainNoise = 20
			elseif moveState == "crouch" or moveState == "stand" then
				terrainNoise = 1
			else
				terrainNoise = 25
			end
		end
	end
	for i, terrain in ipairs(terrainTable["forest"]) do
		if terrain == material then
			initialValue = initialValue*0.5
			terrainVisibility = movement-0.1
			if moveState == "sprint" then
				terrainNoise = 32
			elseif moveState == "jog" then
				terrainNoise = 27
			elseif moveState == "powerwalk" or moveState == "walk" then
				terrainNoise = 22
			elseif moveState == "crawl" then
				terrainNoise = 20
			elseif moveState == "crouch" or moveState == "stand" then
				terrainNoise = 1
			else
				terrainNoise = 27
			end
		end
	end
	for i, terrain in ipairs(terrainTable["rock"]) do
		if terrain == material then
			initialValue = initialValue*0.80
			terrainVisibility = movement+0.05
			if moveState == "sprint" then
				terrainNoise = 30
			elseif moveState == "jog" then
				terrainNoise = 23
			elseif moveState == "powerwalk" or moveState == "walk" then
				terrainNoise = 19
			elseif moveState == "crawl" then
				terrainNoise = 20
			elseif moveState == "crouch" or moveState == "stand" then
				terrainNoise = 1
			else
				terrainNoise = 23
			end
		end
	end
	if material == 0 or material == 1 or material == 2 or material == 3 then
		initialValue = initialValue*1.3
		terrainVisibility = movement+0.2
		if moveState == "sprint" then
				terrainNoise = 30
			elseif moveState == "jog" then
				terrainNoise = 23
			elseif moveState == "powerwalk" or moveState == "walk" then
				terrainNoise = 18
			elseif moveState == "crawl" then
				terrainNoise = 20
			elseif moveState == "crouch" or moveState == "stand" then
				terrainNoise = 1
			else
				terrainNoise = 23
			end
	end
	if not terrainVisibility then
		terrainVisibility = 1
	end
	if not terrainNoise then
		terrainNoise = 1
	end
	if isPedInVehicle(localPlayer) then
		if getElementModel(getPedOccupiedVehicle(localPlayer)) ~= 509 then
			terrainNoise = 50
			terrainVisibility = movement+1
		end
	end
	return terrainVisibility,terrainNoise,initialValue
end

function getPlayerSpeed()
	if not isPedInVehicle(localPlayer) then
		local speedx, speedy, speedz = getElementVelocity(localPlayer)
		local actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5) 
		mps = actualspeed * 50
	else
		playerSpeed = 20
	end
	playerSpeed = math.floor(mps*3.5)
	return playerSpeed
end

--[[
We check the chance for a zombie to detect a player based on his
visibility and sound. The closer the player is to a zombie, the 
bigger the chance to be detected.
]]
function checkLOSChance(distance,value)
	local var = math.max((value-distance),0)
	distance = math.max(0.1,distance)
	local maxExp = math.exp(2)*distance
	local myExp = (math.exp(2)*var)/maxExp
	myExp = math.min(myExp*5,100)
	return myExp
end

-- Working the magic math
-- Left to do: light exposure to fireplace and roadflare, is player in building?
function getSoundAndVisibilityLevel()
	local rain = getRainLevel()
	local fog = isFogOrNot()
	local moonSunLevel = isSunOrMoon()
	local moonLightIntensity = getMoonIntensity()
	local muffleLevel = getCurrentMuffleLevel()
	local lightLevel = getCurrentLightLevel()
	local scale,movement = getPlayerPoseVisibility()
	local terrainVisibility,terrainNoise,initialValue = getTerrainProperties()
	local playerSpeed = getPlayerSpeed()
	totalSound = math.ceil((playerSpeed*terrainNoise*movement*muffleLevel)+playerHasShot)
	totalVisibility = math.ceil((initialValue+(playerSpeed*3))*scale*lightLevel)*1.5
	if isPedInVehicle(localPlayer) then
		totalSound = 100
		totalVisibility = 20
	end
	return totalSound,totalVisibility
end

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
	if getElementData(localPlayer,"logedin") then
		if not isPedInVehicle(localPlayer) then
			local material,hitX, hitY, hitZ = isObjectAroundPlayer2(localPlayer, 30,3)
			if material == 0 then
				local x, y, z = getElementPosition(getLocalPlayer())
				triggerServerEvent("createZomieForPlayer",getLocalPlayer(),x,y,z)
			end
		end
	end
end
setTimer(zombieSpawning,3000,0)

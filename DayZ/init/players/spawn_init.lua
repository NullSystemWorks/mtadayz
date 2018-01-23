--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: spawn_init.lua						*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]

spawnX,spawnY,spawnZ = 0,0,0
spawnSelected = false
function onSpawnSelectionEnabled(x,y,z)
	spawnX = x
	spawnY = y
	spawnZ = z
	spawnSelected = true
	spawnDayZPlayer(source)
end
addEvent("onSpawnSelectionEnabled",true)
addEventHandler("onSpawnSelectionEnabled",root,onSpawnSelectionEnabled)

function spawnDayZPlayer(player)
	if not gameplayVariables["spawnselection"] then
		local number = math.random(table.size(spawnPositions))
		spawnX,spawnY,spawnZ = spawnPositions[number][1],spawnPositions[number][2],spawnPositions[number][3]
		spawnSelected = true
	end
	if spawnSelected then
		if not gameplayVariables["newclothingsystem"] then
			skin = 73
		end
		spawnPlayer (player, spawnX,spawnY,spawnZ, math.random(0,360), skin, 0, 0)
		setElementFrozen(player, true)
		fadeCamera (player, true)
		setCameraTarget (player)
		setTimer( function(player)
			if isElement(player) then
				setElementFrozen(player, false)
			end
		end,500,1,player)
		playerCol = createColSphere(spawnX,spawnY,spawnZ,1.5)
		setElementData(player,"playerCol",playerCol)
		attachElements ( playerCol, player, 0, 0, 0 )
		setElementData(playerCol,"parent",player)
		setElementData(playerCol,"player",true)
		if gameplayVariables["MySQL"] then
			-- need to code it in MySQL
		else
			local account = getPlayerAccount(player)
			setAccountData(account,"isDead",false)
			setElementData(player,"admin",getAccountData(account,"admin") or false)
			setElementData(player,"supporter",getAccountData(account,"supporter") or false)
		end
		setElementData(player,"isDead",false)
		setElementData(player,"logedin",true)
		
		playerStatusTable[player] = {}
		
		playerStatusTable[player] = {
		["alivetime"] = 0,
		["daysalive"] = 0,
		["skin"] = 0,
		["gender"] = "male",
		["bleeding"] = 0,
		["sepsis"] = false,
		["unconscious"] = false,
		["hoursalive"] = 0,
		["achievements"] = toJSON({}),
		["MAX_Slots"] = 8,
		["CURRENT_Slots"] = 0,
		["Weapon_Slots"] = 0,
		["Item_Slots"] = 1,
		["Backpack_Slots"] = 8,
		["Backpack_Item_Slots"] = 8,
		["Backpack_Weapon_Slots"] = 1,
		["isBandit"] = false,
		["blood"] = 12000,
		["food"] = 100,
		["thirst"] = 100,
		["temperature"] = 37,
		["currentweapon_1"] = false,
		["currentweapon_2"] = false,
		["currentweapon_3"] = false,
		["bleeding"] = 0,
		["brokenbone"] = false,
		["fracturedArms"] = false,
		["fracturedLegs"] = false,
		["pain"] = false,
		["cold"] = false,
		["infection"] = false,
		["unconscious"] = false,
		["sepsis"] = false,
		["humanity"] = 2500,
		["killedZombies"] = 0,
		["headshots"] = 0,
		["murders"] = 0,
		["killedBandits"] = 0,
		["hasFuel"] = false,
		["bloodtype"] = "?",
		["bloodtypediscovered"] = "?",
		["isZombie"] = false,
		}
		
		for i,data in ipairs(playerDataTable) do
			setElementData(player,data[1],data[2])
		end
		
		determineBloodType(player)
		setPlayerFracturedBones(player,false)
		addBackpackToPlayer(playerStatusTable[player]["MAX_Slots"])
		
		if not gameplayVariables["newclothingsystem"] then
			playerStatusTable[player]["skin"] = 73
		end
		
		if gameplayVariables["newclothingsystem"] then
			for i,clothes in ipairs(clothesTable["Collar"]) do
			local randomChance = math.random(0,100)
				if randomChance < 11 then
					local randomCloth = clothes[math.random(#clothesTable["Collar"])]
					if randomCloth then
						setElementData(player,randomCloth,1)
						break
					end
				end
			end
			for i,clothes in ipairs(clothesTable["Head"]) do
				local randomChance = math.random(0,100)
				if randomChance < 26 then
					local randomCloth = clothes[math.random(#clothesTable["Head"])]
					if randomCloth then
						setElementData(player,randomCloth,1)
						break
					end
				end
			end
			for i,clothes in ipairs(clothesTable["Feet"]) do
				local randomChance = math.random(0,100)
				if randomChance < 95 then
					local randomCloth = clothes[math.random(#clothesTable["Feet"])]
					if randomCloth then
						setElementData(player,randomCloth,1)
						break
					end
				end
			end
			for i,clothes in ipairs(clothesTable["Legs"]) do
				local randomChance = math.random(0,100)
				if randomChance < 95 then
					local randomCloth = clothes[math.random(#clothesTable["Legs"])]
					if randomCloth then
						setElementData(player,randomCloth,1)
						break
					end
				end
			end
			for i,clothes in ipairs(clothesTable["Torso"]) do
				local randomChance = math.random(0,100)
				if randomChance < 95 then
					local randomCloth = clothes[math.random(#clothesTable["Torso"])]
					if randomCloth then
						setElementData(player,randomCloth,1)
						break
					end
				end
			end
			for i,clothes in ipairs(clothesTable["Eyes"]) do
				local randomChance = math.random(0,100)
				if randomChance < 11 then
					local randomCloth = clothes[math.random(#clothesTable["Eyes"])]
					if randomCloth then
						setElementData(player,randomCloth,1)
						break
					end
				end
			end
		end
	end
	
	if gameplayVariables["newclothingsystem"] then
		triggerEvent("onPlayerChangeClothes", player)
	end
	setElementData(player,"spawnedzombies",0)
end

function killVehicleOccupantsOnExplode()
	for i,player in pairs(getVehicleOccupants(source)) do
		triggerEvent("kilLDayZPlayer",player)
	end
end
addEventHandler("onVehicleExplode", getRootElement(), killVehicleOccupantsOnExplode)

function destroyDeadPlayer (ped,pedCol)
	local x,y,z = getElementPosition(ped)
	local tCol = createColCircle(x,y,z,20)
	for i, v in ipairs(getElementsByType("player")) do
		local detection = isElementWithinColShape(ped, tCol)
			if detection then
				setTimer(destroyDeadPlayer,300000,1,ped,pedCol) --If player found exit loop and re-check in 5 minutes.
			return end
	end
	destroyElement(ped)
	destroyElement(pedCol)
	destroyElement(tCol)
end

function checkBuggedAccount()
	if gameplayVariables["newclothingsystem"] then return end
	for i,player in ipairs(getElementsByType("player")) do
		local account = getPlayerAccount(player)
		if not account then return end
		if getElementData(player,"logedin") then
			if getElementModel(player) == 0 then
				spawnDayZPlayer(player)
				outputSideChat(getPlayerName(player).."'s Account was buggy and has been reset",root,255,255,255)
			end
		end
	end	
end
setTimer(checkBuggedAccount,90000,0)

function kilLDayZPlayer(killer,headshot)
	pedCol = false
	local account = getPlayerAccount(source)
	if not account then return end
	killPed(source)
	triggerClientEvent(source,"hideInventoryManual",source)
	if not isElementInWater(source) then
		local x,y,z = getElementPosition(source)
		if getDistanceBetweenPoints3D (x,y,z,6000,6000,0) > 200 then
			local x,y,z = getElementPosition(source)
			local rotX,rotY,rotZ = getElementRotation(source)
			local skin = getElementModel(source)
			ped = createPed(skin,x,y,z,rotZ)
			pedCol = createColSphere(x,y,z,1.5)
			killPed(ped)
			setTimer(destroyDeadPlayer,600000,1,ped,pedCol) -- 3600000*0.75
			attachElements (pedCol,ped,0,0,0)
			setElementData(pedCol,"parent",ped)
			setElementData(pedCol,"playername",getPlayerName(source))
			setElementData(pedCol,"deadman",true)
			setElementData(pedCol,"MAX_Slots",getElementData(source,"MAX_Slots"))
			local hours, minutes = getTime()
			if hours < 10 then
				hour = "0"..hours
			else
				hours = hours
			end
			if minutes < 10 then
				minutes  = "0"..minutes
			else
				minutes = minutes
			end
			setElementData(pedCol,"deadreason","His name was "..tostring(getPlayerName(source))..", it appears they died at "..hours..":"..minutes..".")
		end	
	end
	triggerClientEvent(source,"onClientPlayerDeathInfo",source)
	if killer then
		if not getElementData(killer,"zombie") then
			if not playerStatusTable[killer]["isZombie"] then
				setElementData(pedCol,"killedBy",killer)
				if playerStatusTable[killer]["humanity"] <= 0 then
					playerStatusTable[killer]["isBandit"] = true
				end
				if playerStatusTable[source]["bandit"] then
					playerStatusTable[killer]["killedBandits"] = playerStatusTable[killer]["killedBandits"]+1
				end
				if headshot then
					playerStatusTable[killer]["headshots"] = playerStatusTable[killer]["headshots"]+1
				end
			end
		end
	end
	--SetElementDatas
	if pedCol then
		for i,data in ipairs(playerDataTable) do
			local plusData = getElementData(source,data[1])
			if data[1] == "11.43x23mm Cartridge" then
				plusData = math.floor(getElementData(source,data[1])/7)
			elseif data[1] == "9x18mm Cartridge" then
				plusData = math.floor(getElementData(source,data[1])/8)
			elseif data[1] == "9x19mm Cartridge" then
				plusData = math.floor(getElementData(source,data[1])/17)
			elseif data[1] == ".303 British Cartridge" then
				plusData = math.floor(getElementData(source,data[1])/10)
			elseif data[1] == "5.45x39mm Cartridge" then
				plusData = math.floor(getElementData(source,data[1])/30)
			elseif data[1] == "7.62x39mm Cartridge" then
				plusData = math.floor(getElementData(source,data[1])/30)
			elseif data[1] == "7.62x51mm Cartridge" then
				plusData = math.floor(getElementData(source,data[1])/20)
			elseif data[1] == "5.56x45mm Cartridge" then
				plusData = math.floor(getElementData(source,data[1])/20)
			elseif data[1] == "7.62x54mm Cartridge" then
				plusData = math.floor(getElementData(source,data[1])/10)
			elseif data[1] == "1866 Slug" then
				plusData = math.floor(getElementData(source,data[1])/15)
			elseif data[1] == "Gauge 12 Pellet" then
				plusData = math.floor(getElementData(source,data[1])/7)
			elseif data[1] == "Bolt" then
				plusData = math.floor(getElementData(source,data[1])/7)
			end
			
			setElementData(pedCol,data[1],plusData)
		end
		--Skin
		if not gameplayVariables["newclothingsystem"] then
			local skinID = playerStatusTable[source]["skin"]
			local skin = getSkinNameFromID(skinID)
			setElementData(pedCol,skin,1)
		end
		--Backpack
		local backpackSlots = playerStatusTable[source]["MAX_Slots"]
		if backpackSlots == gameplayVariables["assaultpack_slots"] then
			setElementData(pedCol,"Assault Pack (ACU)",1)
		elseif backpackSlots == gameplayVariables["czechvest_slots"] then
			setElementData(pedCol,"Czech Vest Pouch",1)
		elseif backpackSlots == gameplayVariables["alice_slots"] then
			setElementData(pedCol,"ALICE Pack",1)
		elseif backpackSlots == gameplayVariables["survival_slots"] then
			setElementData(pedCol,"Survival ACU",1)
		elseif backpackSlots == gameplayVariables["britishassault_slots"] then
			setElementData(pedCol,"British Assault Pack",1)
		elseif backpackSlots == gameplayVariables["coyote_slots"] then
			setElementData(pedCol,"Backpack (Coyote)",1)
		elseif backpackSlots == gameplayVariables["czech_slots"] then
			setElementData(pedCol,"Czech Backpack",1)
		end
	end
	setTimer(setElementPosition,500,1,source,6000,6000,0)
	if not gameplayVariables["MySQL"] then
		setAccountData(account,"isDead",true)
	end
	setElementData(source,"isDead",true)
	setElementData(source,"hasHelmet",false)
	outputSideChat("Player "..getPlayerName(source).." was killed",root,255,255,255)
	destroyElement(getElementData(source,"playerCol"))
	setTimer(function(source)
		if gameplayVariables["spawnselection"] then
			triggerClientEvent(source,"showSpawnSelectionWindow",source)
		else
			spawnDayZPlayer(source)
		end
	end,gameplayVariables["playerRespawnCountdown"] * 1000,1,source)
	sendPlayerStatusInfoToClient()
end
addEvent("kilLDayZPlayer",true)
addEventHandler("kilLDayZPlayer",getRootElement(),kilLDayZPlayer)

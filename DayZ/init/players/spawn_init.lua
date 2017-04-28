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
		setElementData(player,"gender","male")
		setElementData(player,"bleeding", 0)
		setElementData(player,"sepsis",0)
		setElementData(player,"unconscious",false)
		setElementData(player, "hoursalive", 0)

		----------------------------------
		--Player Items on Respawn
		for i,data in ipairs(playerDataTable) do
			if data[1] == "bloodtype" then
				determineBloodType(player)
			elseif data[1] == "achievements" then
				--
			elseif data[1] == "skin" then
				if not gameplayVariables["newclothingsystem"] then
					setElementData(player,"skin",73)
				end
			else
				setElementData(player,data[1],data[2])
			end
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
		setElementData(source,"killedBy",killer)
		if getElementData(killer,"humanity") <= 0 then
			setElementData(killer,"bandit",true)
		end
		if getElementData(source,"bandit") == true then
			setElementData(killer,"banditskilled",getElementData(killer,"banditskilled")+1)
		end
		if headshot == true then
			setElementData(killer,"headshots",getElementData(killer,"headshots")+1)
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
			local skinID = getElementData(source,"skin")
			local skin = getSkinNameFromID(skinID)
			setElementData(pedCol,skin,1)
		end
		--Backpack
		local backpackSlots = getElementData(source,"MAX_Slots")
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
	outputSideChat("Player "..getPlayerName(source).." was killed",root,255,255,255)
	destroyElement(getElementData(source,"playerCol"))
	setTimer(function(source)
		if gameplayVariables["spawnselection"] then
			triggerClientEvent(source,"showSpawnSelectionWindow",source)
		else
			spawnDayZPlayer(source)
		end
	end,30000,1,source)
end
addEvent("kilLDayZPlayer",true)
addEventHandler("kilLDayZPlayer",getRootElement(),kilLDayZPlayer)

--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: spawn_init.lua						*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]

function spawnDayZPlayer(player)
	local number = math.random(table.size(spawnPositions))
	local x,y,z = spawnPositions[number][1],spawnPositions[number][2],spawnPositions[number][3]
	local gender = getElementData(player,"gender")
	local skin = 73
	if gender == "male" then
		skin = 73
	elseif gender == "female" then
		skin = 172
	end
	spawnPlayer (player, x,y,z, math.random(0,360), skin, 0, 0)
	setElementFrozen(player, true)
	fadeCamera (player, true)
	setCameraTarget (player)
	setTimer( function(player)
		if isElement(player) then
			setElementFrozen(player, false)
		end
	end,500,1,player)
	playerCol = createColSphere(x,y,z,1.5)
	setElementData(player,"playerCol",playerCol)
	attachElements ( playerCol, player, 0, 0, 0 )
	setElementData(playerCol,"parent",player)
	setElementData(playerCol,"player",true)
	local account = getPlayerAccount(player)
	setAccountData(account,"isDead",false)
	setElementData(player,"isDead",false)
	setElementData(player,"logedin",true)
	setElementData(player,"admin",getAccountData(account,"admin") or false)
	setElementData(player,"supporter",getAccountData(account,"supporter") or false)
	----------------------------------
	--Player Items on Start
	for i,data in ipairs(playerDataTable) do
		if data[1] =="Bandage" then
			setElementData(player,data[1],2)	
		elseif data[1] =="Painkiller" then
			setElementData(player,data[1],1)
		elseif data[1] == "Flashlight" then
			setElementData(player,data[1],1)
		elseif data[1] == "MAX_Slots" then
			setElementData(player,data[1],8)
		elseif data[1] =="Item_Slots" then
			setElementData(player,data[1],12)
		elseif data[1] == "Weapon_Slots" then
			setElementData(player,data[1],1)
		elseif data[1] =="Backpack_Slots" then
			setElementData(player,data[1],8)
		elseif data[1] == "Backpack_Item_Slots" then
			setElementData(player,data[1],8)
		elseif data[1] =="Back_Weapon_Slots" then
			setElementData(player,data[1],0)
		elseif data[1] =="skin" then
			setElementData(player,data[1],skin)
		elseif data[1] =="blood" then
			setElementData(player,data[1],12000)
		elseif data[1] =="temperature" then
			setElementData(player,data[1],37)
		elseif data[1] =="brokenbone" then
			setElementData(player,data[1],false)	
		elseif data[1] =="pain" then
			setElementData(player,data[1],false)
		elseif data[1] =="cold" then
			setElementData(player,data[1],false)
		elseif data[1] =="infection" then
			setElementData(player,data[1],false)
		elseif data[1] =="unconscious" then
			setElementData(player,data[1],false)
		elseif data[1] =="food" then
			setElementData(player,data[1],100)
		elseif data[1] =="thirst" then
			setElementData(player,data[1],100)
		elseif data[1] =="currentweapon_1" then
			setElementData(player,data[1],false)
		elseif data[1] =="currentweapon_2" then
			setElementData(player,data[1],false)	
		elseif data[1] =="currentweapon_3" then
			setElementData(player,data[1],false)	
		elseif data[1] =="bandit" then
			setElementData(player,data[1],false)
		elseif data[1] =="humanity" then
			setElementData(player,data[1],2500)
		elseif data[1] =="gender" then
			setElementData(player,data[1],gender)
		elseif data[1] == "bloodtype" then
			determineBloodType(player)
		elseif data[1] == "bloodtypediscovered" then
			setElementData(player,"bloodtypediscovered","?")
		else
			setElementData(player,data[1],0)
		end
	end
	----------------------------------
end

function checkBuggedAccount()
	for i,player in ipairs(getElementsByType("player")) do
		local account = getPlayerAccount(player)
		if not account then return end
		if getElementData(player,"logedin") then
			if getElementModel(player) == 0 then
				spawnDayZPlayer(player)
				outputChatBox(getPlayerName(player).."s Account was buggy and has been reset.",getRootElement(),22,255,22,true)
			end
		end
	end	
end
setTimer(checkBuggedAccount,90000,0)

function notifyAboutExplosion2()
	for i,player in pairs(getVehicleOccupants(source)) do
		triggerEvent("kilLDayZPlayer",player)
	end
end
addEventHandler("onVehicleExplode", getRootElement(), notifyAboutExplosion2)

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

function kilLDayZPlayer (killer,headshot,weapon)
	pedCol = false
	local account = getPlayerAccount(source)
	if not account then return end
	killPed(source)
	triggerClientEvent(source,"hideInventoryManual",source)
	if getElementData(source,"alivetime") > 10 then 
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
				if getElementData(source,"gender") == "male" then
					genderstring = "His"
					genderstring2 = "he"
				else
					genderstring = "Her"
					genderstring2 = "she"
				end
				setElementData(pedCol,"deadreason",genderstring.." name was "..tostring(getPlayerName(source))..", it appears "..genderstring2.." died at "..hours..":"..minutes..".")
			end	
		end
	end
	triggerClientEvent(source,"onClientPlayerDeathInfo",source)
	if killer then
		setElementData(killer,"murders",getElementData(killer,"murders")+1)
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
		local skinID = getElementData(source,"skin")
		local skin = getSkinNameFromID(skinID)
		setElementData(pedCol,skin,1)
		--Backpack
		local backpackSlots = getElementData(source,"MAX_Slots")
		if backpackSlots == 12 then
			setElementData(pedCol,"Assault Pack (ACU)",1)
		elseif backpackSlots == 13 then
			setElementData(pedCol,"Czech Vest Pouch",1)
		elseif backpackSlots == 16 then
			setElementData(pedCol,"ALICE Pack",1)
		elseif backpackSlots == 17 then
			setElementData(pedCol,"Survival ACU",1)
		elseif backpackSlots == 18 then
			setElementData(pedCol,"British Assault Pack",1)
		elseif backpackSlots == 24 then
			setElementData(pedCol,"Backpack (Coyote)",1)
		elseif backpackSlots == 30 then
			setElementData(pedCol,"Czech Backpack",1)
		end
	end
	setTimer(setElementPosition,500,1,source,6000,6000,0)
	setAccountData(account,"isDead",true)
	setElementData(source,"isDead",true)
	outputSideChat("Player "..getPlayerName(source).." was killed",root,255,255,255)
	destroyElement(getElementData(source,"playerCol"))
	setTimer(spawnDayZPlayer,30000,1,source)
end
addEvent("kilLDayZPlayer",true)
addEventHandler("kilLDayZPlayer",getRootElement(),kilLDayZPlayer)
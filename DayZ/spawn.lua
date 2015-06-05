local spawnPositions = {
{-278.6669921875,-2882.1572265625,32.104232788086},
{-958.5595703125,-2887.9912109375,64.82421875},
{-1816.9375,-2748.18359375,1.7327127456665},
{-2816.166015625,-2439.0546875,2.4004096984863},
{-2941.5673828125,-1206.2373046875,2.7848854064941},
{-2911.51171875,-895.22265625,2.4013109207153},
{-2185.6669921875,2957.380859375,11.474840164185},
{272.2265625,2928.505859375,1.3713493347168},
{2803.943359375,595.9365234375,7.7612648010254},
{2883.7509765625,-178.4658203125,3.2714653015137},
{-233.46484375,-1735.8173828125,1.5520644187927},
{-1056.8720703125,2939.068359375,42.311294555664},
}

local playerDataTable = {
{"alivetime"},
{"daysalive"},
{"skin"},
{"MAX_Slots"},
{"bandit"},
{"blood"},
{"food"},
{"thirst"},
{"temperature"},
{"currentweapon_1"},
{"currentweapon_2"},
{"currentweapon_3"},
{"bleeding"},
{"brokenbone"},
{"pain"},
{"cold"},
{"infection"},
{"humanity"},
{"zombieskilled"},
{"headshots"},
{"murders"},
{"banditskilled"},

-- [[ Weapons ]] --
{"M4"},
{"CZ 550"},
{"Winchester 1866"},
{"SPAZ-12 Combat Shotgun"},
{"Sawn-Off Shotgun"},
{"AK-47"},
{"Lee Enfield"},
{"Sporter 22"},
{"Mosin 9130"},
{"Crossbow"},
{"SKS"},
{"Blaze 95 Double Rifle"},
{"Remington 870"},
{"FN FAL"},
{"G36C"},
{"Sa58V CCO"},
{"SVD Dragunov"},
{"DMR"},
{"M1911"},
{"M9 SD"},
{"PDW"},
{"G17"},
{"MP5A5"},
{"Desert Eagle"},
{"Bizon PP-19"},
{"Revolver"},
{"Hunting Knife"},
{"Hatchet"},
{"Baseball Bat"},
{"Shovel"},
{"Golf Club"},
{"Machete"},
{"Crowbar"},
{"Parachute"},
{"Tear Gas"},
{"Grenade"},
{"Binoculars"},

-- [[ Ammo ]] --
{".45 ACP Cartridge"},
{"9x19mm SD Cartridge"},
{"9x19mm Cartridge"},
{"9x18mm Cartridge"},
{"5.45x39mm Cartridge"},
{"5.56x45mm Cartridge"},
{"1866 Slug"},
{"2Rnd. Slug"},
{"12 Gauge Pellet"},
{"9.3x62mm Cartridge"},
{".303 British Cartridge"},
{"Bolt"},

-- [[ Food / Drinks ]] --
{"Baked Beans"},
{"Pasta"},
{"Sardines"},
{"Frank & Beans"},
{"Can (Corn"},
{"Can (Peas"},
{"Can (Pork"},
{"Can (Stew)"},
{"Can (Ravioli"},
{"Can (Fruit"},
{"Can (Chowder"},
{"Pistachios"},
{"Trail Mix"},
{"MRE"},
{"Water Bottle"},
{"Soda Can (Pepsi)"},
{"Soda Can (Cola)"},
{"Soda Can (Mountain Dew)"},
{"Can (Milk)"},

-- [[ Items ]] --

{"Wood Pile"},
{"Bandage"},
{"Road Flare"},
{"Empty Gas Canister"},
{"Full Gas Canister"},
{"Medic Kit"},
{"Heat Pack"},
{"Painkiller"},
{"Morphine"},
{"Blood Bag"},
{"Wire Fence"},
{"Raw Meat"},
{"Tire"},
{"Engine"},
{"Tank Parts"},
{"Tent"},
{"Box of Matches"},
{"Watch"},
{"GPS"},
{"Map"},
{"Toolbox"},
{"IR Goggles"},
{"NV Goggles"},
{"Cooked Meat"},
{"Radio Device"},
{"Compass"},
{"Camouflage Clothing"},
{"Civilian Clothing"},
{"Survivor Clothing"},
{"Ghillie Suit"},
{"Empty Water Bottle"},
{"Empty Soda Can"},
{"Assault Pack (ACU)"},
{"Alice Pack"},
{"Ghillie Backpack"},
{"OS Backpack"},
{"Coyote Backpack"},
{"Czech Backpack"},

-- [[ Blueprints ]] --
{"M4 Blueprint"},
{"CZ 550 Blueprint"},
{"Winchester 1866 Blueprint"},
{"SPAZ-12 C. Shtgn. Blueprint"},
{"Sawn-Off Shtgn. Blueprint"},
{"AK-47 Blueprint"},
{"Lee Enfield Blueprint"},
{"Sporter 22 Blueprint"},
{"Mosin 9130 Blueprint"},
{"Crossbow Blueprint"},
{"SKS Blueprint"},
{"Blaze 95 D. R. Blueprint"},
{"Remington 870 Blueprint"},
{"FN FAL Blueprint"},
{"G36C Blueprint"},
{"Sa58V CCO Blueprint"},
{"SVD Dragunov Blueprint"},
{"DMR Blueprint"},
{"M1911 Blueprint"},
{"M9 SD Blueprint"},
{"PDW Blueprint"},
{"G17 Blueprint"},
{"MP5A5 Blueprint"},
{"Bizon PP-19 Blueprint"},
{"Revolver Blueprint"},
{"Desert Eagle Blueprint"},
{"Hunting Knife Blueprint"},
{"Hatchet Blueprint"},
{"Baseball Bat Blueprint"},
{"Shovel Blueprint"},
{"Golf Club Blueprint"},
{"Machete Blueprint"},
{"Crowbar Blueprint"},
{"Parachute Blueprint"},
{"Tear Gas Blueprint"},
{"Grenade Blueprint"},
{"Binoculars Blueprint"},
{".45 ACP Cartridge Blueprint"},
{"9x19mm SD Cartridge Blueprint"},
{"9x19mm Cartridge Blueprint"},
{"9x18mm Cartridge Blueprint"},
{"5.45x39mm Cartridge Blueprint"},
{"5.56x45mm Cartridge Blueprint"},
{"1866 Slug Blueprint"},
{"2Rnd. Slug Blueprint"},
{"12 Gauge Pellet Blueprint"},
{"9.3x62mm Cartridge Blueprint"},
{".303 British Cartridge Blueprint"},
{"Bolt Blueprint"},
{"Medic Kit Blueprint"},
{"Wire Fence Blueprint"},
{"Tent Blueprint"},
{"Camouflage Clthng. Blueprint"},
{"Survivor Clthng. Blueprint"},
{"Civilian Clthng. Blueprint"},
{"Ghillie Suit Blueprint"},
{"Roadflare Blueprint"},
{"Toolbox Blueprint"},
{"Radio Device Blueprint"},
{"Infrared Goggles Blueprint"},
{"Night Vision Goggles Blueprint"},
{"Gun Barrel"},
{"Short Gun Barrel"},
{"Gun Stock"},
{"Thread"},
{"Cloth"},
{"Gun Powder"},
{"Mechanical Supplies"},
{"Cables"},
{"Nails"},
{"Sheet"},
{"Barbed Wire"},
{"Duct Tape"},
{"Glue"},
{"Drugs"},
{"Bandaid"},
{"Vitamins"},
{"Tissue"},
{"Small Box"},
{"String"},
{"Needle"},
{"Microchips"},
{"Optics"},
{"Sharp Metal"},
{"Handle"},
{"Wooden Stick"},
{"Hand Saw"},
{"Metal Plate"},
{"Metallic Stick"},
{"Small Casing"},
}


local vehicleDataTable = {
{"MAX_Slots"},
{"Tire_inVehicle"},
{"Engine_inVehicle"},
{"Parts_inVehicle"},
{"fuel"},

-- [[ Weapons ]] --
{"M4"},
{"CZ 550"},
{"Winchester 1866"},
{"SPAZ-12 Combat Shotgun"},
{"Sawn-Off Shotgun"},
{"AK-47"},
{"Lee Enfield"},
{"Sporter 22"},
{"Mosin 9130"},
{"Crossbow"},
{"SKS"},
{"Blaze 95 Double Rifle"},
{"Remington 870"},
{"FN FAL"},
{"G36C"},
{"Sa58V CCO"},
{"SVD Dragunov"},
{"DMR"},
{"M1911"},
{"M9 SD"},
{"PDW"},
{"G17"},
{"MP5A5"},
{"Desert Eagle"},
{"Bizon PP-19"},
{"Revolver"},
{"Hunting Knife"},
{"Hatchet"},
{"Baseball Bat"},
{"Shovel"},
{"Golf Club"},
{"Machete"},
{"Crowbar"},
{"Parachute"},
{"Tear Gas"},
{"Grenade"},
{"Binoculars"},

-- [[ Ammo ]] --
{".45 ACP Cartridge"},
{"9x19mm SD Cartridge"},
{"9x19mm Cartridge"},
{"9x18mm Cartridge"},
{"5.45x39mm Cartridge"},
{"5.56x45mm Cartridge"},
{"1866 Slug"},
{"2Rnd. Slug"},
{"12 Gauge Pellet"},
{"9.3x62mm Cartridge"},
{".303 British Cartridge"},
{"Bolt"},

-- [[ Food / Drinks ]] --
{"Baked Beans"},
{"Pasta"},
{"Sardines"},
{"Frank & Beans"},
{"Can (Corn"},
{"Can (Peas"},
{"Can (Pork"},
{"Can (Stew)"},
{"Can (Ravioli"},
{"Can (Fruit"},
{"Can (Chowder"},
{"Pistachios"},
{"Trail Mix"},
{"MRE"},
{"Water Bottle"},
{"Soda Can (Pepsi)"},
{"Soda Can (Cola)"},
{"Soda Can (Mountain Dew)"},
{"Can (Milk)"},

-- [[ Items ]] --

{"Wood Pile"},
{"Bandage"},
{"Road Flare"},
{"Empty Gas Canister"},
{"Full Gas Canister"},
{"Medic Kit"},
{"Heat Pack"},
{"Painkiller"},
{"Morphine"},
{"Blood Bag"},
{"Wire Fence"},
{"Raw Meat"},
{"Tire"},
{"Engine"},
{"Tank Parts"},
{"Tent"},
{"Box of Matches"},
{"Watch"},
{"GPS"},
{"Map"},
{"Toolbox"},
{"IR Goggles"},
{"NV Goggles"},
{"Cooked Meat"},
{"Radio Device"},
{"Compass"},
{"Camouflage Clothing"},
{"Civilian Clothing"},
{"Survivor Clothing"},
{"Ghillie Suit"},
{"Empty Water Bottle"},
{"Empty Soda Can"},
{"Assault Pack (ACU)"},
{"Alice Pack"},
{"Ghillie Backpack"},
{"OS Backpack"},
{"Coyote Backpack"},
{"Czech Backpack"},

-- [[ Blueprints ]] --
{"M4 Blueprint"},
{"CZ 550 Blueprint"},
{"Winchester 1866 Blueprint"},
{"SPAZ-12 C. Shtgn. Blueprint"},
{"Sawn-Off Shtgn. Blueprint"},
{"AK-47 Blueprint"},
{"Lee Enfield Blueprint"},
{"Sporter 22 Blueprint"},
{"Mosin 9130 Blueprint"},
{"Crossbow Blueprint"},
{"SKS Blueprint"},
{"Blaze 95 D. R. Blueprint"},
{"Remington 870 Blueprint"},
{"FN FAL Blueprint"},
{"G36C Blueprint"},
{"Sa58V CCO Blueprint"},
{"SVD Dragunov Blueprint"},
{"DMR Blueprint"},
{"M1911 Blueprint"},
{"M9 SD Blueprint"},
{"PDW Blueprint"},
{"G17 Blueprint"},
{"MP5A5 Blueprint"},
{"Bizon PP-19 Blueprint"},
{"Revolver Blueprint"},
{"Desert Eagle Blueprint"},
{"Hunting Knife Blueprint"},
{"Hatchet Blueprint"},
{"Baseball Bat Blueprint"},
{"Shovel Blueprint"},
{"Golf Club Blueprint"},
{"Machete Blueprint"},
{"Crowbar Blueprint"},
{"Parachute Blueprint"},
{"Tear Gas Blueprint"},
{"Grenade Blueprint"},
{"Binoculars Blueprint"},
{".45 ACP Cartridge Blueprint"},
{"9x19mm SD Cartridge Blueprint"},
{"9x19mm Cartridge Blueprint"},
{"9x18mm Cartridge Blueprint"},
{"5.45x39mm Cartridge Blueprint"},
{"5.56x45mm Cartridge Blueprint"},
{"1866 Slug Blueprint"},
{"2Rnd. Slug Blueprint"},
{"12 Gauge Pellet Blueprint"},
{"9.3x62mm Cartridge Blueprint"},
{".303 British Cartridge Blueprint"},
{"Bolt Blueprint"},
{"Medic Kit Blueprint"},
{"Wire Fence Blueprint"},
{"Tent Blueprint"},
{"Camouflage Clthng. Blueprint"},
{"Survivor Clthng. Blueprint"},
{"Civilian Clthng. Blueprint"},
{"Ghillie Suit Blueprint"},
{"Roadflare Blueprint"},
{"Toolbox Blueprint"},
{"Radio Device Blueprint"},
{"Infrared Goggles Blueprint"},
{"Night Vision Goggles Blueprint"},
{"Gun Barrel"},
{"Short Gun Barrel"},
{"Gun Stock"},
{"Thread"},
{"Cloth"},
{"Gun Powder"},
{"Mechanical Supplies"},
{"Cables"},
{"Nails"},
{"Sheet"},
{"Barbed Wire"},
{"Duct Tape"},
{"Glue"},
{"Drugs"},
{"Bandaid"},
{"Vitamins"},
{"Tissue"},
{"Small Box"},
{"String"},
{"Needle"},
{"Microchips"},
{"Optics"},
{"Sharp Metal"},
{"Handle"},
{"Wooden Stick"},
{"Hand Saw"},
{"Metal Plate"},
{"Metallic Stick"},
{"Small Casing"},
}



function spawnDayZPlayer(player)
	local number = math.random(table.size(spawnPositions))
	local x,y,z = spawnPositions[number][1],spawnPositions[number][2],spawnPositions[number][3]
	spawnPlayer (player, x,y,z, math.random(0,360), 73, 0, 0)
	setElementFrozen(player, true)
	fadeCamera (player, true)
	setCameraTarget (player, player)
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
		elseif data[1] =="MAX_Slots" then
			setElementData(player,data[1],8)	
		elseif data[1] =="skin" then
			setElementData(player,data[1],73)
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
		else
			setElementData(player,data[1],0)
		end
	end
	----------------------------------
end
--addEvent("onPlayerLoginToDayZ",true)
--addEventHandler("onPlayerLoginToDayZ",getRootElement(),spawnDayZPlayer)
--addEventHandler("onPlayerJoin",getRootElement(),spawnDayZPlayer)

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
	destroyElement(ped)
	destroyElement(pedCol)
end

check = false
deadVariable = {}

function kilLDayZPlayer (killer,headshot,weapon)
	pedCol = false
	deadVariable["counter"] = 30000
	local account = getPlayerAccount(source)
	--if getElementData(source,"isInEvent") then removePlayerEvent(source) return end
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
				if not check then
					setTimer(destroyDeadPlayer,3600000*0.75,1,ped,pedCol) -- 3600000*0.75
				else return
				end
				attachElements (pedCol,ped,0,0,0)
				setElementData(pedCol,"parent",ped)
				setElementData(pedCol,"playername",getPlayerName(source))
				setElementData(pedCol,"deadman",true)
				setElementData(pedCol,"MAX_Slots",getElementData(source,"MAX_Slots"))
				setElementData(pedCol,"hidebody",ped)
				local time = getRealTime()
				local hours = time.hour
				local minutes = time.minute
				setElementData(pedCol,"deadreason",getPlayerName(source).." is dead. Cause of death: "..(weapon or "Unknown")..". Time of death: "..hours..":"..minutes.." o'clock.")
			end	
		end
	end
	if killer then
		if not getElementData(source,"bandit") then
			addPlayerStats (killer,"humanity",math.random(-2500,-1000))
		else
			addPlayerStats (killer,"humanity",math.random(1000,2500))
		end
		setElementData(killer,"murders",getElementData(killer,"murders")+1)
		if getElementData(killer,"humanity") < 0 then
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
			if data[1] == ".45 ACP Cartridge" then
				plusData = math.floor(getElementData(source,data[1])/7)
			elseif data[1] == "9x19mm SD Cartridge" then
				plusData = math.floor(getElementData(source,data[1])/15)
			elseif data[1] == "9x19mm Cartridge" then
				plusData = math.floor(getElementData(source,data[1])/30)
			elseif data[1] == "9x18mm Cartridge" then
				plusData = math.floor(getElementData(source,data[1])/20)
			elseif data[1] == "5.45x39mm Cartridge" then
				plusData = math.floor(getElementData(source,data[1])/30)
			elseif data[1] == "5.56x45mm Cartridge" then
				plusData = math.floor(getElementData(source,data[1])/20)
			elseif data[1] == "9.3x62mm Cartridge" then
				plusData = math.floor(getElementData(source,data[1])/5)
			elseif data[1] == ".303 British Cartridge" then
				plusData = math.floor(getElementData(source,data[1])/10)
			elseif data[1] == "1866 Slug" then
				plusData = math.floor(getElementData(source,data[1])/7)
			elseif data[1] == "Gauge 12 Pellet" then
				plusData = math.floor(getElementData(source,data[1])/7)
			elseif data[1] == "2Rnd. Slug" then
				plusData = math.floor(getElementData(source,data[1])/2)
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
	triggerClientEvent(source,"onClientPlayerDeathInfo",source)
	setAccountData(account,"isDead",true)
	setElementData(source,"isDead",true)
	triggerClientEvent ( "onRollMessageStart", getRootElement(),"#FFFFFF"..getPlayerName(source).." #FFFFFFwas killed",0,22,255, "died")
	destroyElement(getElementData(source,"playerCol"))
	setTimer(spawnDayZPlayer,5000,1,source)
end
addEvent("kilLDayZPlayer",true)
addEventHandler("kilLDayZPlayer",getRootElement(),kilLDayZPlayer)
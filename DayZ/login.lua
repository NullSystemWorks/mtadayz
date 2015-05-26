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
{"Wood Pile"},
{"Bandage"},
{"Water Bottle"},
{"Pasta Can"},
{"Beans Can"},
{"Burger"},
{"Box of Matches"},
{"M1911"},
{"M9 SD"},
{"Winchester 1866"},
{"PDW"},
{"Hunting Knife"},
{"Hatchet"},
{"Pizza"},
{"Morphine"},
{"Soda Bottle"},
{"Empty Gas Canister"},
{"Full Gas Canister"},
{"Roadflare"},
{"Milk"},
{"Tear Gas"},
{"Grenade"},
{"Desert Eagle"},
{"Sawn-Off Shotgun"},
{"SPAZ-12 Combat Shotgun"},
{"MP5A5"},
{"Watch"},
{"Medic Kit"},
{"Heat Pack"},
{"Lee Enfield"},
{"AK-47"},
{"Blood Bag"},
{"GPS"},
{"Map"},
{"Toolbox"},
{"Wire Fence"},
{"Tire"},
{"Engine"},
{"Tank Parts"},
{"M136 Rocket"},
{"M4"},
{"CZ 550"},
{"Satchel"},
{"Infrared Goggles"},
{"Night Vision Goggles"},
{"Tent"},
{"Raw Meat"},
{"Cooked Meat"},
{"Camouflage Clothing"},
{"Ghillie Suit"},
{"Civilian Clothing"},
{"Survivor Clothing"},
{"Painkiller"},
{"Binoculars"},
{"Empty Water Bottle"},
{"Empty Soda Cans"},
{"Scruffy Burgers"},
{"Radio Device"},
{"Baseball Bat"},
{"Shovel"},
{"Golf Club"},
{"Parachute"},
{"Compass"},

{"Mosin 9130"},
{"Sporter 22"},
{"Crossbow"},
{"SKS"},
{"Blaze 95 Double Rifle"},
{"Remington 870"},
{"FN FAL"},
{"G36C"},
{"Sa58V CCO"},
{"SVD Dragunov"},
{"DMR"},
{"Bizon PP-19"},
{"Revolver"},
{"Machete"},
{"Crowbar"},
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

-- [[ PRIMARY WEAPONS ]] --
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

-- [[ SECONDARY WEAPONS ]]-- 
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

-- [[ SPECIAL WEAPONS ]] --
{"Parachute Blueprint"},
{"Tear Gas Blueprint"},
{"Grenade Blueprint"},
{"Binoculars Blueprint"},

-- [[ AMMO ]] -- TO DO!!!
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

-- [[ ITEMS ]] --
{"Medic Kit Blueprint"},
{"Wire Fence Blueprint"},
{"Tent Blueprint"},
{"Camouflage Clthng. Blueprint"},
{"Survivor Clthng. Blueprint"},
{"Civilian Clthng. Blueprint"},
{"Ghillie Suit Blueprint"},
{"Roadflare Blueprint"},

-- [[ TOOLBELT ]] --
{"Toolbox Blueprint"},
{"Radio Device Blueprint"},
{"Infrared Goggles Blueprint"},
{"Night Vision Goggles Blueprint"},

-- [[ BLUEPRINT PARTS ]] --
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



function playerLogin(username, pass, player)
	local playerID = getAccountData(getPlayerAccount(player),"playerID")
	account = getPlayerAccount(player)
	local x,y,z =  getAccountData(account,"last_x"),getAccountData(account,"last_y"),getAccountData(account,"last_z")
	local skin = getAccountData(account,"skin")
	createZombieTable (player)
	if getAccountData(account,"isDead") then
		spawnDayZPlayer(player)
		return
	end
	spawnPlayer (player, x,y,z+0.5, math.random(0,360), skin, 0, 0)
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
	for i,data in ipairs(playerDataTable) do
		local elementData = getAccountData(account,data[1])
		if not elementData then
			if data[1] == "brokenbone" or data[1] == "pain" or data[1] == "cold" or data[1] == "infection" or data[1] == "currentweapon_1" or data[1] == "currentweapon_2" or data[1] == "currentweapon_3" or data[1] == "bandit" then
				elementData = elementData
			else
				elementData = 0
			end
		end
		setElementData(player,data[1],elementData)
	end
	setElementData(player,"logedin",true)
	--Weapons
	--Old Weapons
	local weapon = getElementData(player,"currentweapon_1")
	if weapon then
		local ammoData,weapID = getWeaponAmmoType (weapon)
		giveWeapon(player,weapID,getElementData(player,ammoData), true )
	end
	local weapon = getElementData(player,"currentweapon_2")
	if weapon then
		local ammoData,weapID = getWeaponAmmoType (weapon)
		giveWeapon(player,weapID,getElementData(player,ammoData), false )
	end
	local weapon = getElementData(player,"currentweapon_3")
	if weapon then
		local ammoData,weapID = getWeaponAmmoType (weapon)
		giveWeapon(player,weapID,getElementData(player,ammoData), false )
	end
	setElementModel(player, getElementData(player,"skin"))

	setElementData(player,"admin",getAccountData(account,"admin") or false)
	setElementData(player,"supporter",getAccountData(account,"supporter") or false)
	triggerClientEvent(player, "onClientPlayerDayZLogin", player)
	
end
addEvent("onPlayerDayZLogin", true)
addEventHandler("onPlayerDayZLogin", getRootElement(), playerLogin)


function playerRegister(username, pass, player)
	local number = math.random(table.size(spawnPositions))
	local x,y,z = spawnPositions[number][1],spawnPositions[number][2],spawnPositions[number][3]
	spawnPlayer (player, x,y,z, math.random(0,360), 73, 0, 0)
	fadeCamera (player, true)
	setCameraTarget (player, player)
	playerCol = createColSphere(x,y,z,1.5)
	attachElements ( playerCol, player, 0, 0, 0 )
	setElementData(playerCol,"parent",player)
	setElementData(playerCol,"player",true)
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
	account = getAccount(username)
	local value = getAccounts()
	local value = #value
	setElementData(player,"playerID",value+1)
	setAccountData(account,"playerID",value+1)
	setElementData(player,"logedin",true)
	createZombieTable (player)
	
end
addEvent("onPlayerDayZRegister", true)
addEventHandler("onPlayerDayZRegister", getRootElement(), playerRegister)



function saveAccounts () -- Save in the database
	local account = getPlayerAccount(source)
	if account then
	for i,data in ipairs(playerDataTable) do
		setAccountData(account,data[1],getElementData(source,data[1]))
	end
		local x,y,z =  getElementPosition(source)
		setAccountData(account,"last_x",x)
		setAccountData(account,"last_y",y)
		setAccountData(account,"last_z",z)
		destroyElement(getElementData(source,"playerCol"))
	end	
	setElementData(source,"logedin",false)
end
addEventHandler ( "onPlayerQuit", getRootElement(), saveAccounts )

function saveAccounts2 () -- Save in the database
for i, player in ipairs(getElementsByType("player")) do
	local account = getPlayerAccount(player)
	if account then
	for i,data in ipairs(playerDataTable) do
		setAccountData(account,data[1],getElementData(player,data[1]))
	end
		local x,y,z =  getElementPosition(player)
		setAccountData(account,"last_x",x)
		setAccountData(account,"last_y",y)
		setAccountData(account,"last_z",z)
	end	
	--setElementData(player,"logedin",false)
end
outputDebugString("Player Accounts Saved.")
end
addEventHandler ( "onResourceStop", getResourceRootElement(getThisResource()), saveAccounts2 )

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
local vehicleDataTable = {
{"MAX_Slots"},
{"Tire_inVehicle"},
{"Engine_inVehicle"},
{"Parts_inVehicle"},
{"fuel"},
{"Wood Pile"},
{"Bandage"},
{"Water Bottle"},
{"Pasta Can"},
{"Beans Can"},
{"Burger"},
{"Box of Matches"},
{"M1911"},
{"M9 SD"},
{"Winchester 1866"},
{"PDW"},
{"Hunting Knife"},
{"Morphine"},
{"Hatchet"},
{"Pizza"},
{"Soda Bottle"},
{"Empty Gas Canister"},
{"Full Gas Canister"},
{"Roadflare"},
{"Milk"},
{"Tear Gas"},
{"Grenade"},
{"Desert Eagle"},
{"Sawn-Off Shotgun"},
{"SPAZ-12 Combat Shotgun"},
{"MP5A5"},
{"Watch"},
{"Medic Kit"},
{"Heat Pack"},
{"Lee Enfield"},
{"AK-47"},
{"Blood Bag"},
{"GPS"},
{"Map"},
{"Toolbox"},
{"Wire Fence"},
{"Tire"},
{"Engine"},
{"Tank Parts"},
{"M136 Rocket"},
{"M4"},
{"CZ 550"},
{"Satchel"},
{"Infrared Goggles"},
{"Night Vision Goggles"},
{"Tent"},
{"Raw Meat"},
{"Cooked Meat"},
{"Camouflage Clothing"},
{"Ghillie Suit"},
{"Civilian Clothing"},
{"Survivor Clothing"},
{"Painkiller"},
{"Binoculars"},
{"Empty Water Bottle"},
{"Empty Soda Cans"},
{"Scruffy Burgers"},
{"Assault Pack (ACU)"},
{"Alice Pack"},
{"Czech Backpack"},
{"Coyote Backpack"},
{"Radio Device"},
{"Baseball Bat"},
{"Shovel"},
{"Golf Club"},
{"Parachute"},
{"Compass"},

{"Mosin 9130"},
{"Sporter 22"},
{"Crossbow"},
{"SKS"},
{"Blaze 95 Double Rifle"},
{"Remington 870"},
{"FN FAL"},
{"G36C"},
{"Sa58V CCO"},
{"SVD Dragunov"},
{"DMR"},
{"Bizon PP-19"},
{"Revolver"},
{"Machete"},
{"Crowbar"},

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

{"Ghillie Backpack"},
{"OS Backpack"},
-- [[ PRIMARY WEAPONS ]] --
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

-- [[ SECONDARY WEAPONS ]]-- 
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

-- [[ SPECIAL WEAPONS ]] --
{"Parachute Blueprint"},
{"Tear Gas Blueprint"},
{"Grenade Blueprint"},
{"Binoculars Blueprint"},

-- [[ AMMO ]] -- TO DO!!!
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

-- [[ ITEMS ]] --
{"Medic Kit Blueprint"},
{"Wire Fence Blueprint"},
{"Tent Blueprint"},
{"Camouflage Clthng. Blueprint"},
{"Survivor Clthng. Blueprint"},
{"Civilian Clthng. Blueprint"},
{"Ghillie Suit Blueprint"},
{"Roadflare Blueprint"},

-- [[ TOOLBELT ]] --
{"Toolbox Blueprint"},
{"Radio Device Blueprint"},
{"Infrared Goggles Blueprint"},
{"Night Vision Goggles Blueprint"},

-- [[ BLUEPRINT PARTS ]] --
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


--local vehicleManager = getAccount("vehicleManager","ds4f9$")
	--if not vehicleManager then
	--addAccount("vehicleManager","ds4f9$")
	--end

function saveallvehicles(ps,command)
	counter = 0
	counterTent = 0
	--delete Accounts 
	local vehicleManager = getAccount("vehicleManager","ds4f9$")
	--for i = 1, (getAccountData(vehicleManager,"vehicleamount") or 0) do
		--local account = getAccount("vehicle_number_"..i,"ds4f9$")
		--if not account then break end
		--removeAccount (account)
	--end
	--new Accounts + set
	for i, col in ipairs (getElementsByType("colshape")) do
		local veh = getElementData(col,"vehicle")
		local helicrash = getElementData(col,"helicrash")
		local hospitalbox = getElementData(col,"hospitalbox")
		local tent = getElementData(col,"tent")
		if veh and not helicrash or veh and not hospitalbox then
			if tent then
				counterTent = counterTent +1
				account = getAccount("tent_number_"..counterTent,"ds4f9$") or false
				if not account then
					account = addAccount("tent_number_"..counterTent,"ds4f9$")
				end	
				local tent = getElementData(col,"parent")
				local x,y,z = getElementPosition(tent)
				local rx,ry,rz = getElementRotation(tent)
				setAccountData(account,"last_x",x)
				setAccountData(account,"last_y",y)
				setAccountData(account,"last_z",z)
				setAccountData(account,"last_rx",rx)
				setAccountData(account,"last_ry",ry)
				setAccountData(account,"last_rz",rz)
				for i, data in ipairs(vehicleDataTable) do 
					setAccountData(account,data[1],getElementData(col,data[1]))
				end
			else 
				counter = counter +1
				account = getAccount("vehicle_number_"..counter,"ds4f9$") or false
				if not account then
					account = addAccount("vehicle_number_"..counter,"ds4f9$")
				end	
				setAccountData(account,"spawn_x",getElementData(col,"spawn")[2])
				setAccountData(account,"spawn_y",getElementData(col,"spawn")[3])
				setAccountData(account,"spawn_z",getElementData(col,"spawn")[4])
				for i, data in ipairs(vehicleDataTable) do 
					setAccountData(account,data[1],getElementData(col,data[1]))
				end
				local vehicle = getElementData(col,"parent")
				local model = getElementModel(vehicle)
				local x,y,z = getElementPosition(vehicle)
				local rx,ry,rz = getElementRotation(vehicle)
				local health = getElementHealth(vehicle)
				setAccountData(account,"last_x",x)
				setAccountData(account,"last_y",y)
				setAccountData(account,"last_z",z)
				setAccountData(account,"last_rx",rx)
				setAccountData(account,"last_ry",ry)
				setAccountData(account,"last_rz",rz)
				setAccountData(account,"health",health)
				setAccountData(account,"model",model)
				setAccountData(account,"isExploded",getElementData(vehicle,"isExploded") or false)
			end
		end
		setAccountData(vehicleManager,"vehicleamount",counter)
		setAccountData(vehicleManager,"tentamount",counterTent)
	end
	outputDebugString("Vehicles And Tents Saved.")
end
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), saveallvehicles)

function doBackup ()
		outputChatBox ("BACKUP OF ALL VEHICLES AND TENTS, PLEASE STAND IDLE!",getRootElement(),255,0,0,true)
		saveallvehicles()
		outputChatBox ("BACKUP: DONE!",getRootElement(),0,255,0,true)
		outputDebugString("Vehicles And Tents Saved.")
end
setTimer(doBackup,3600000,0)
--addCommandHandler("backup",doBackup,false)


function createVehicleOnServerStart()
	local vehicleManager = getAccount("vehicleManager","ds4f9$")
	for i = 1, (getAccountData(vehicleManager,"vehicleamount") or 0) do
		wastedVehicle = false
		vehicle = getAccount("vehicle_number_"..i,"ds4f9$")
		if not vehicle then break end
		if getAccountData(vehicle,"isExploded") == true then
			setAccountData(vehicle,"health",1000)
			wastedVehicle = true
		end
		local veh = createVehicle(getAccountData(vehicle,"model"),getAccountData(vehicle,"last_x"),getAccountData(vehicle,"last_y"),getAccountData(vehicle,"last_z"),getAccountData(vehicle,"last_rx"),getAccountData(vehicle,"last_ry"),getAccountData(vehicle,"last_rz"))
		vehCol = createColSphere(getAccountData(vehicle,"last_x"),getAccountData(vehicle,"last_y"),getAccountData(vehicle,"last_z"),4)
		attachElements ( vehCol, veh, 0, 0, 0 )
		setElementData(vehCol,"parent",veh)
		setElementData(veh,"parent",vehCol)
		setElementData(vehCol,"vehicle",true)
		setElementData(vehCol,"MAX_Slots",getAccountData(vehicle,"MAX_Slots"))
		setElementHealth(veh,getAccountData(vehicle,"health"))
		--vehicle_indentifikation
		xxx,yyy,zzz = getAccountData(vehicle,"spawn_x"),getAccountData(vehicle,"spawn_y"),getAccountData(vehicle,"spawn_z")
		setElementData(vehCol,"spawn",{getAccountData(vehicle,"model"),xxx,yyy,zzz})
		if wastedVehicle then
			if getAccountData(vehicle,"model") == 497 then
				item_id = math.random(table.size(hunterSpawns))
				xxx,yyy,zzz = hunterSpawns[item_id][1],hunterSpawns[item_id][2],hunterSpawns[item_id][3]
			end
			if getAccountData(vehicle,"model") == 487 then
				local item_id = math.random(table.size(maverikSpawns))
				x,y,z = maverikSpawns[item_id][1],maverikSpawns[item_id][2],maverikSpawns[item_id][3]
			end
			setElementPosition(veh,xxx,yyy,zzz+1)
			setElementRotation(veh,0,0,0)
			--Engine + Tires + Tank Parts
			local tires,engine,parts = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
		end
		--others
		setElementData(vehCol,"fuel",getAccountData(vehicle,"fuel"))
		if not wastedVehicle then
			for i, data in ipairs(vehicleDataTable) do 
				setElementData(vehCol,data[1],getAccountData(vehicle,data[1]))
			end
		else
			if getElementModel(veh) == 433 or getElementModel(veh) == 470 then
				for i,items in ipairs(lootItems["helicrashsides"]) do
					local randomNumber = math.random(1,10)
					if randomNumber == 5 then
						setElementData(vehCol,items[1],math.random(1,2))
					end
				end
			end	
			setElementData(vehCol,"fuel",10)
		end
	end
	for i = 1, (getAccountData(vehicleManager,"tentamount") or 0) do
		tentData = getAccount("tent_number_"..i,"ds4f9$")
		if not tentData then break end
		tent = createObject(3243,getAccountData(tentData,"last_x"),getAccountData(tentData,"last_y"),getAccountData(tentData,"last_z"),0,0,(getAccountData(tentData,"last_rz") or 0))
		setObjectScale(tent,1.3)
		tentCol = createColSphere(getAccountData(tentData,"last_x"),getAccountData(tentData,"last_y"),getAccountData(tentData,"last_z"),4)
		attachElements ( tentCol, tent, 0, 0, 0 )
		setElementData(tentCol,"parent",tent)
		setElementData(tent,"parent",tentCol)
		setElementData(tentCol,"tent",true)
		setElementData(tentCol,"vehicle",true)
		setElementData(tentCol,"MAX_Slots",100)
		for i, data in ipairs(vehicleDataTable) do 
			setElementData(tentCol,data[1],getAccountData(tentData,data[1]))
		end
	end
	outputDebugString("Vehicles And Tents Created.")
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), createVehicleOnServerStart)


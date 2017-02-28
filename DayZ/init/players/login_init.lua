--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: login_init.lua						*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]

function playerLogin(username, pass, player)
	if client then player = client end
	account = getPlayerAccount(player)
	local playerID = getAccountData(account,"playerID")
	local x,y,z =  getAccountData(account,"last_x"),getAccountData(account,"last_y"),getAccountData(account,"last_z")
	local skin = getAccountData(account,"skin")
	local weight = getAccountData(account, "player.weight")
	local hoursalive = getAccountData(account, "player.hoursalive")
	setElementData(player, "hoursalive", hoursalive)
	--setPedStat(player, 21, weight)

	createZombieTable (player)
	if getAccountData(account,"isDead") then
		spawnDayZPlayer(player)
		return
	end
	spawnPlayer (player, x,y,z+0.5, math.random(0,360), skin, 0, 0)
	setElementFrozen(player, true)
	fadeCamera (player, false,2000,0,0,0)
	setCameraTarget (player, player)
	setTimer( function(player)
		if isElement(player) then
			setElementFrozen(player, false)
			fadeCamera(player,true)
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
			if data[1] == "brokenbone" or data[1] == "unconscious" or data[1] == "sepsis" or data[1] == "bloodtype" or data[1] == "bloodtypediscovered" or data[1] == "pain" or data[1] == "cold" or data[1] == "infection" or data[1] == "currentweapon_1" or data[1] == "currentweapon_2" or data[1] == "currentweapon_3" or data[1] == "bandit" or data[1] == "achievements" then
				elementData = elementData
			else
				elementData = 0
			end
		end
		setElementData(player,data[1],elementData)
	end
	if not getElementData(player,"bloodtype") then
		determineBloodType(player)
		setElementData(player,"bloodtypediscovered","?")
	end
	setElementData(player,"logedin",true)
	triggerEvent("onPlayerChangeClothes", player)
	--Weapons
	--Old Weapons
	local weapon = getElementData(player,"currentweapon_1")
	if weapon then
		local ammoData,weapID = getWeaponAmmoFromName (weapon)
		giveWeapon(player,weapID,getElementData(player,ammoData), true )
	end
	local weapon = getElementData(player,"currentweapon_2")
	if weapon then
		local ammoData,weapID = getWeaponAmmoFromName (weapon)
		giveWeapon(player,weapID,getElementData(player,ammoData), false )
	end
	local weapon = getElementData(player,"currentweapon_3")
	if weapon then
		local ammoData,weapID = getWeaponAmmoFromName (weapon)
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
	if client then player = client end
	local number = math.random(table.size(spawnPositions))
	local x,y,z = spawnPositions[number][1],spawnPositions[number][2],spawnPositions[number][3]

	spawnPlayer (player, x,y,z, math.random(0,360), skin, 0, 0)
	fadeCamera (player, false,2000,0,0,0)
	setCameraTarget (player, player)
	setElementData(player, "hoursalive", 0)

	setTimer( function(player)
		if isElement(player) then
			setElementFrozen(player, false)
			fadeCamera(player,true)
		end
	end,500,1,player)
	playerCol = createColSphere(x,y,z,1.5)
	setElementData(player,"playerCol",playerCol)
	attachElements ( playerCol, player, 0, 0, 0 )
	setElementData(playerCol,"parent",player)
	setElementData(playerCol,"player",true)
	setPedStat(player, 21, math.random(200,400))
	----------------------------------
	--Player Items on Start
	for i,data in ipairs(playerDataTable) do
		if data[1] =="Bandage" then
			setElementData(player,data[1],2)
		elseif data[1] =="Painkiller" then
			setElementData(player,data[1],1)
		elseif data[1] == "Flashlight" then
			setElementData(player,data[1],1)
		elseif data[1] == "Beige Pants" then
      		setElementData(player, data[1], 1)
	    elseif data[1] == "Beige Vest" then
	    	setElementData(player, data[1], 1)
	    elseif data[1] == "Black Shoe" then
	    	setElementData(player, data[1], 1)
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
			setElementData(player,data[1],0)
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
		elseif data[1] == "bloodtype" then
			determineBloodType(player)
		elseif data[1] == "bloodtypediscovered" then
			setElementData(player,"bloodtypediscovered","?")
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
	createZombieTable(player)
	triggerEvent("onPlayerChangeClothes", player)
end
addEvent("onPlayerDayZRegister", true)
addEventHandler("onPlayerDayZRegister", getRootElement(), playerRegister)

function savePlayerAccount() -- Save in the database
	local account = getPlayerAccount(source)
	if account then
	for i,data in ipairs(playerDataTable) do
		setAccountData(account,data[1],getElementData(source,data[1]))
	end
		local x,y,z =  getElementPosition(source)
		local weight = getPedStat(source, 21) or 0
		local hoursalive = getElementData(source, "hoursalive")
		setAccountData(account,"last_x",x)
		setAccountData(account,"last_y",y)
		setAccountData(account,"last_z",z)
		setAccountData(account, "player.weight", weight)
		setAccountData(account, "hoursalive", hoursalive)
		if getElementData(source,"logedin") then
			destroyElement(getElementData(source,"playerCol"))
		end
		if getElementData(source,"sepsis") == 4 then
			setAccountData(account,"infection",true)
		end
	end	
	setElementData(source,"logedin",false)
	outputServerLog("[DayZ] Player account "..getAccountName(account).." has been saved.")
end
addEventHandler ( "onPlayerQuit", getRootElement(), savePlayerAccount)

function saveAllAccounts() -- Save in the database
	for i, player in ipairs(getElementsByType("player")) do
		local account = getPlayerAccount(player)
		if account then
			for i,data in ipairs(playerDataTable) do
				setAccountData(account,data[1],getElementData(player,data[1]))
			end
			local x,y,z =  getElementPosition(player)
			local weight = getPedStat(player, 21) or 0
			local hoursalive = getElementData(player, "hoursalive")
			setAccountData(account,"last_x",x)
			setAccountData(account,"last_y",y)
			setAccountData(account,"last_z",z)
			setAccountData(account, "player.weight", weight)
			setAccountData(account, "hoursalive", hoursalive)
			if getElementData(player,"sepsis") == 4 then
				setAccountData(account,"infection",true)
			end
		end
	end
	outputServerLog("[DayZ] All accounts have been saved.")
end
addEventHandler ( "onResourceStop", getResourceRootElement(getThisResource()), saveAllAccounts)

--[[
We determine the blood type using real world statistics

Breakdown:

0: 39%
A: 32%
B: 23%
AB: 6%
]]

function determineBloodType(player)
local bloodType = math.random(0,99)
	if bloodType >= 0 and bloodType <= 6 then -- 6%
		setElementData(player,"bloodtype","AB")
	elseif bloodType >= 7 and bloodType <= 30 then -- 23%
		setElementData(player,"bloodtype","B")
	elseif bloodType >= 31 and bloodType <= 63 then -- 32%
		setElementData(player,"bloodtype","A")
	elseif bloodType >= 64 and bloodType <= 99 then -- 39%
		setElementData(player,"bloodtype","0")
	end
end

--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: login_init.lua						*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]
something = {} -- Secret thing
local sDataNames = { --Add your elementdata's here for them to be saved.
	["brokenbone"] = {false},
	["unconscious"] = {false},
	["sepsis"] = {0},
	["bloodtype"] = {false},
	["bloodtypediscovered"] = {"?"},
	["pain"] = {false},
	["cold"] = {false},
	["infection"] = {false},
	["currentweapon_1"] = {false},
	["currentweapon_2"] = {false},
	["currentweapon_3"] = {false},
	["bandit"] = {false},
	["skin"] = {0},
	["achievements"] = {}
}
local dbConnection
if gameplayVariables["MySQL"] then
	dbConnection = dbConnect( "mysql", "dbname="..gameplayVariables["MySQL_DB"]..";host="..gameplayVariables["MySQL_host"]..";port="..gameplayVariables["MySQL_port"], gameplayVariables["MySQL_user"], gameplayVariables["MySQL_pass"], "share=1" )
	dbExec(dbConnection,"CREATE TABLE IF NOT EXISTS `accounts` (`ID` int(11) NOT NULL AUTO_INCREMENT,`username` text NOT NULL,`password` text NOT NULL,`userdata` text NOT NULL,  `rank` text NOT NULL, `creationDate` text NOT NULL,`lastLogin` text NOT NULL, PRIMARY KEY (`ID`))")
end

function playerLogin(username, pass, player)
	if client then player = client end
	local playerID,x,y,z,skin,hoursalive,isAdmin,isSupporter;
	setElementData(player,"spawnedzombies",0)
	if gameplayVariables["MySQL"] then
		something[player] = username
		account = username
		local qh = dbQuery(dbConnection, "SELECT * FROM accounts WHERE `username`=? LIMIT 1",account)
		local result = dbPoll(qh, -1)
		local tableE = {}
		for i, row in ipairs(result) do
			tableE = fromJSON(row["userdata"])
			playerID = row["ID"]
		end
		x,y,z = tableE["last_x"] or 0, tableE["last_y"] or 0, tableE["last_z"] or 0
		skin = tableE["skin"]
		hoursalive = tableE["hoursalive"]
		for i,data in ipairs(playerDataTable) do
			local elementData = tableE[data[1]]
			--outputChatBox(tostring(elementData))
			if not elementData then
				if sDataNames[data[1]] then    
					elementData = sDataNames[data[1]][1] --Grabs default value for these from sDataNames
				else
					elementData = 0
				end
			end
			setElementData(player,data[1],elementData)
		end
		if tableE["isDead"] then
			spawnDayZPlayer(player)
			return
		end
		if tableE["rank"] == "Admin" then
			isAdmin = true
		else
			isAdmin = false -- to avoid chance of bug
		end
		if tableE["rank"] == "Supporter" then
			isSupporter = true
		else
			isSupporter = false -- to avoid chance of bug
		end
	else
		account = getPlayerAccount(player)
		playerID = getAccountData(account,"playerID")
		x,y,z =  getAccountData(account,"last_x")or 0,getAccountData(account,"last_y")or 0,getAccountData(account,"last_z")or 0
		skin = getAccountData(account,"skin")
		hoursalive = getAccountData(account, "player.hoursalive")
		for i,data in ipairs(playerDataTable) do
			local elementData = getAccountData(account,data[1])
			if not elementData then
				if sDataNames[data[1]] then	
					elementData = sDataNames[data[1]][1] --Grabs default value for these from sDataNames
				else
					elementData = 0
				end
			end
			setElementData(player,data[1],elementData)
		end
		isAdmin = getAccountData(account,"admin") or false
		isSupporter = getAccountData(account,"supporter") or false
		if getAccountData(account,"isDead") then
			spawnDayZPlayer(player)
			return
		end
	end
	if not skin then
		if not gameplayVariables["newclothingsystem"] then
			skin = 73
		end
	else
		if not gameplayVariables["newclothingsystem"] then
			if skin == 0 then
				skin = 73
			end
		end
	end
	setElementData(player, "hoursalive", hoursalive)
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
	attachElements(playerCol,player,0,0,0)
	setElementData(playerCol,"parent",player)
	setElementData(playerCol,"player",true)

	if not getElementData(player,"bloodtype") then
		determineBloodType(player)
		setElementData(player,"bloodtypediscovered","?")
	end
	setElementData(player,"logedin",true)
	setElementData(player,"gender","male")
	if gameplayVariables["newclothingsystem"] then
		triggerEvent("onPlayerChangeClothes", player)
	end
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
	if gameplayVariables["newclothingsystem"] then
		setElementModel(player,0)
		setElementData(player,"skin",0)
	else
		if getElementModel(player) == 0 or getElementData(player,"skin") == 0 or skin == 0 then
			setElementModel(player,73)
			setElementData(player,"skin",73)
		else
			setElementModel(player, getElementData(player,"skin"))
		end
	end
	setElementData(player,"admin",isAdmin)
	setElementData(player,"supporter",isSupporter)
	triggerClientEvent(player, "onClientPlayerDayZLogin", player)
end
addEvent("onPlayerDayZLogin", true)
addEventHandler("onPlayerDayZLogin", getRootElement(), playerLogin)

function playerRegister(username, pass, player)
	if client then player = client end
	something[player] = username
	local number = math.random(table.size(spawnPositions))
	x,y,z = spawnPositions[number][1],spawnPositions[number][2],spawnPositions[number][3]
	if not gameplayVariables["newclothingsystem"] then
		skin = 73
	end
	spawnPlayer(player,x,y,z, math.random(0,360), skin, 0, 0)
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
	for i,data in ipairs(playerDataTable) do
		if data[1] == "bloodtype" then
			determineBloodType(player)
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
	if not gameplayVariables["MySQL"] then
		account = getAccount(username)
		local value = getAccounts()
		local value = #value
		setElementData(player,"playerID",value+1)
		setAccountData(account,"playerID",value+1)
	end
	setElementData(player,"logedin",true)
	setElementData(player,"gender","male")
	setElementData(player,"spawnedzombies",0)
	if gameplayVariables["newclothingsystem"] then
		triggerEvent("onPlayerChangeClothes", player)
	end
end
addEvent("onPlayerDayZRegister", true)
addEventHandler("onPlayerDayZRegister", getRootElement(), playerRegister)

function savePlayerAccount() -- Save in the database
	local x,y,z =  getElementPosition(source)
	local weight = getPedStat(source, 21) or 0
	local hoursalive = getElementData(source, "hoursalive")
	if gameplayVariables["MySQL"] then
		local account = something[source]
		if account then
			local tbl = {}
			for i,data in ipairs(playerDataTable) do
				tbl[data[1]] = getElementData(source,data[1])
				--tbl[data[1]] = getElementData(player,data[1])
			end
			tbl["hoursalive"] = getElementData(source,"hoursalive") or 0
			tbl["last_x"] = x
			tbl["last_y"] = y
			tbl["last_z"] = z
			tbl["player.weight"] = weight
			tbl["isDead"] = getElementData(source,"isDead")
			dbExec(dbConnection,"UPDATE accounts SET `userdata`=? WHERE `username`=?",toJSON(tbl),account)
		end
		outputServerLog("[DayZ] Player account "..account.." has been saved.")
	else
		local account = getPlayerAccount(source)
		if account then
			for i,data in ipairs(playerDataTable) do
				setAccountData(account,data[1],getElementData(source,data[1]))
			end
			setAccountData(account,"last_x",x)
			setAccountData(account,"last_y",y)
			setAccountData(account,"last_z",z)
			setAccountData(account, "player.weight", weight)
			setAccountData(account, "hoursalive", hoursalive)
			if getElementData(source,"sepsis") == 4 then
				setAccountData(account,"infection",true)
			end
		end
		outputServerLog("[DayZ] Player account "..getAccountName(account).." has been saved.")
	end
	if getElementData(source,"logedin") then
		destroyElement(getElementData(source,"playerCol"))
	end
	setElementData(source,"logedin",false)
end
addEventHandler ( "onPlayerQuit", getRootElement(), savePlayerAccount)

function saveAllAccounts() -- Save in the database
	for i, player in ipairs(getElementsByType("player")) do
		local x,y,z =  getElementPosition(player)
		local weight = getPedStat(player, 21) or 0
		local hoursalive = getElementData(player, "hoursalive")
		if gameplayVariables["MySQL"] then
			local account = something[player]
			if account then
				local tbl = {}
				for i,data in ipairs(playerDataTable) do
					tbl[data[1]] = getElementData(player,data[1])
					--tbl[data[1]] = getElementData(player,data[1])
				end
				tbl["hoursalive"] = getElementData(player,"hoursalive") or 0
				tbl["last_x"] = x
				tbl["last_y"] = y
				tbl["last_z"] = z
				tbl["player.weight"] = weight
				tbl["isDead"] = getElementData(player,"isDead")
				if getElementData(player,"sepsis") == 4 then
					tbl["infection"] = true
				end
				dbExec(dbConnection,"UPDATE accounts SET `userdata`=? WHERE `username`=?",toJSON(tbl),account)
			end
		else
			local account = getPlayerAccount(player)
			if account then
				for i,data in ipairs(playerDataTable) do
					setAccountData(account,data[1],getElementData(player,data[1]))
				end
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

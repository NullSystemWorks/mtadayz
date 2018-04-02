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
	["fracturedArms"] = {false},
	["fracturedLegs"] = {false},
	["unconscious"] = {false},
	["sepsis"] = {false},
	["bloodtype"] = {"?"},
	["bloodtypediscovered"] = {"?"},
	["pain"] = {false},
	["cold"] = {false},
	["infection"] = {false},
	["currentweapon_1"] = {false},
	["currentweapon_2"] = {false},
	["currentweapon_3"] = {false},
	["isBandit"] = {false},
	["skin"] = {0},
	["achievements"] = {}
}
local dbConnection
if gameplayVariables["MySQL"] then
	dbConnection = dbConnect( "mysql", "dbname="..gameplayVariables["MySQL_DB"]..";host="..gameplayVariables["MySQL_host"]..";port="..gameplayVariables["MySQL_port"], gameplayVariables["MySQL_user"], gameplayVariables["MySQL_pass"], "share=1" )
	dbExec(dbConnection,"CREATE TABLE IF NOT EXISTS `accounts` (`ID` int(11) NOT NULL AUTO_INCREMENT,`username` text NOT NULL,`password` text NOT NULL,`userdata` text NOT NULL,  `rank` text NOT NULL, `creationDate` text NOT NULL,`lastLogin` text NOT NULL, PRIMARY KEY (`ID`))")
end

function initDefaultStatusTable(player)
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
end

function initDefaultSkillsTable(player)
	playerSkillsTable[player] = {
		["XP"] = 0,
		["SP"] = 0,
		["usedSP"] = 0,
		["conversionRate"] = 1.0,
		["conversionXP"] = 20,
		
		["SoldierActive"] = false,
		["SoldierDodge"] = 0,
		["SoldierTough"] = 0,
		["SoldierCrit"] = 0,
		["SoldierDodgeChance"] = 0,
		["SoldierToughChance"] = 0,
		["SoldierCritChance"] = 0,

		["MedicActive"] = false,
		["MedicChance"] = 0,
		["MedicProf"] = 0,
		["MedicBorders"] = 0,
		["MedicChanceChance"] = 0,
		["MedicProfChance"] = 0,
		["MedicBordersChance"] = 0,
		
		["ScavengerActive"] = false,
		["ScavengerGood"] = 0,
		["ScavengerCamouflage"] = 0,
		["ScavengerShadow"] = 0,
		["ScavengerGoodChance"] = 0,
		["ScavengerCamouflageChance"] = 0,
		["ScavengerShadowChance"] = 0,
		
		["EngineerActive"] = false,
		["EngineerAmmo"] = 0,
		["EngineerDuct"] = 0,
		["EngineerAnalysis"] = 0,
		["EngineerAmmoChance"] = 0,
		["EngineerDuctChance"] = 0,
		["EngineerAnalysisChance"] = 0,
	}
	outputDebugString("Default Skills Table initialized!")
end

function initDefaultJobTable(player)
	playerJobTable[player] = {}
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
		
		playerStatusTable[player] = {}
		playerStatusTable[player]["alivetime"] = tableE["alivetime"]
		playerStatusTable[player]["daysalive"] = tableE["daysalive"]
		playerStatusTable[player]["skin"] = tableE["skin"]
		playerStatusTable[player]["gender"] = tableE["gender"]
		playerStatusTable[player]["bleeding"] = tableE["bleeding"]
		playerStatusTable[player]["sepsis"] = tableE["sepsis"]
		playerStatusTable[player]["unconscious"] = tableE["unconscious"]
		playerStatusTable[player]["hoursalive"] = tableE["hoursalive"]
		playerStatusTable[player]["achievements"] = toJSON(tableE["achievements"])
		playerStatusTable[player]["MAX_Slots"] = tableE["MAX_Slots"]
		playerStatusTable[player]["CURRENT_Slots"] = tableE["CURRENT_Slots"]
		playerStatusTable[player]["Weapon_Slots"] = tableE["Weapon_Slots"]
		playerStatusTable[player]["Item_Slots"] = tableE["Item_Slots"]
		playerStatusTable[player]["Backpack_Slots"] = tableE["Backpack_Slots"]
		playerStatusTable[player]["Backpack_Item_Slots"] = tableE["Backpack_Item_Slots"]
		playerStatusTable[player]["Backpack_Weapon_Slots"] = tableE["Backpack_Weapon_Slots"]
		playerStatusTable[player]["isBandit"] = tableE["isBandit"]
		playerStatusTable[player]["blood"] = tableE["blood"]
		playerStatusTable[player]["food"] = tableE["food"]
		playerStatusTable[player]["thirst"] = tableE["thirst"]
		playerStatusTable[player]["temperature"] = tableE["temperature"]
		playerStatusTable[player]["currentweapon_1"] = tableE["currentweapon_1"]
		playerStatusTable[player]["currentweapon_2"] = tableE["currentweapon_2"]
		playerStatusTable[player]["currentweapon_3"] = tableE["currentweapon_3"]
		playerStatusTable[player]["bleeding"] = tableE["bleeding"]
		playerStatusTable[player]["brokenbone"] = tableE["brokenbone"]
		playerStatusTable[player]["fracturedArms"] = tableE["fracturedArms"]
		playerStatusTable[player]["fracturedLegs"] = tableE["fracturedLegs"]
		playerStatusTable[player]["pain"] = tableE["pain"]
		playerStatusTable[player]["cold"] = tableE["cold"]
		playerStatusTable[player]["infection"] = tableE["infection"]
		playerStatusTable[player]["unconscious"] = tableE["unconscious"]
		playerStatusTable[player]["humanity"] = tableE["humanity"]
		playerStatusTable[player]["killedZombies"] = tableE["killedZombies"]
		playerStatusTable[player]["headshots"] = tableE["headshots"]
		playerStatusTable[player]["murders"] = tableE["murders"]
		playerStatusTable[player]["killedBandits"] = tableE["killedBandits"]
		playerStatusTable[player]["hasFuel"] = tableE["hasFuel"]
		playerStatusTable[player]["bloodtype"] = tableE["bloodtype"]
		playerStatusTable[player]["bloodtypediscovered"] = tableE["bloodtypediscovered"]
		playerStatusTable[player]["isZombie"] = tableE["isZombie"]
		
		if not gameplayVariables["newclothingsystem"] then
			playerStatusTable[player]["skin"] = 73
		end
		
		for i,data in ipairs(playerDataTable) do
			local elementData = tableE[data[1]] -- actual value derived from MySQl table
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
		
		local inventoryData = fromJSON(getAccountData(account,"PlayerInventory"))	
		for i, data in ipairs(playerDataTable) do
			local elementData = inventoryData[data[1]]
			setElementData(player,data[1],elementData)
		end
		
		initDefaultStatusTable(player)
		initDefaultSkillsTable(player)
		initDefaultJobTable(player)
		
		local statusData = fromJSON(getAccountData(account,"PlayerStatus"))
		for i, data in pairs(playerStatusTable[player]) do
			local status = statusData[i]
			playerStatusTable[player][i] = status
		end
		hoursalive = getAccountData(account, "player.hoursalive")
		
		local jsonJobData = getAccountData(account,"PlayerCurrentJob")
		local jobData = {}
		if jsonJobData then
			jobData = fromJSON(jsonJobData)
			for i, job in pairs(jobData) do
				local job = jobData[i]
				playerJobTable[player][i] = job
			end
		end
		
		triggerClientEvent(player,"onClientJobLoad",player,playerJobTable[player])
		
		dbQuery(loadSkillsFromDB, {player,username}, skillsDB, "SELECT skillsData FROM skills WHERE playerName = ?",username)
		
	
		--[[
		for i, data in pairs(playerStatusTable[player]) do
			local accountData = getAccountData(account,i)
			playerStatusTable[player][i] = accountData
		end
		]]
		skin = playerStatusTable[player]["skin"]
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
	setTimer(fadeCamera,500,1,player,true,3.0,255,255,255)
	spawnPlayer (player, x,y,z+0.5, math.random(0,360), skin, 0, 0)
	setElementFrozen(player, true)
	setCameraTarget (player, player)
	setTimer( function(player)
		if isElement(player) then
			setElementFrozen(player, false)	
		end
	end,500,1,player)
	playerCol = createColSphere(x,y,z,1.5)
	setElementData(player,"playerCol",playerCol)
	attachElements(playerCol,player,0,0,0)
	setElementData(playerCol,"parent",player)
	setElementData(playerCol,"player",true)
	
	local backpackSlots = playerStatusTable[player]["MAX_Slots"]
	addBackpackToPlayer(player,backpackSlots)

	if not playerStatusTable[player]["bloodtype"] then
		determineBloodType(player)
	end
	setElementData(player,"logedin",true)
	if gameplayVariables["newclothingsystem"] then
		triggerEvent("onPlayerChangeClothes", player)
	end
	local weapon = playerStatusTable[player]["currentweapon_1"] 
	if weapon then
		local ammoData,weapID = getWeaponAmmoFromName (weapon)
		giveWeapon(player,weapID,getElementData(player,ammoData), true )
	end
	local weapon = playerStatusTable[player]["currentweapon_2"] 
	if weapon then
		local ammoData,weapID = getWeaponAmmoFromName (weapon)
		giveWeapon(player,weapID,getElementData(player,ammoData), false )
	end
	local weapon = playerStatusTable[player]["currentweapon_3"] 
	if weapon then
		local ammoData,weapID = getWeaponAmmoFromName (weapon)
		giveWeapon(player,weapID,getElementData(player,ammoData), false )
	end
	if gameplayVariables["newclothingsystem"] then
		setElementModel(player,0)
		playerStatusTable[player]["skin"] = 0
	else
		if getElementModel(player) == 0 or playerStatusTable[player]["skin"] == 0 or skin == 0 then
			setElementModel(player,73)
			playerStatusTable[player]["skin"] = 73
		else
			setElementModel(player, playerStatusTable[player]["skin"])
		end
	end
	setElementData(player,"admin",isAdmin)
	setElementData(player,"supporter",isSupporter)
	triggerClientEvent(player, "onClientPlayerDayZLogin", player)
	sendPlayerStatusInfoToClient()
	triggerClientEvent(player,"onPlayerUpdateSkillsToJournal",player,playerSkillsTable[player])
	
	if gameplayVariables["armachat"] then
		triggerClientEvent(player,"showChatBox",player,true)
	else
		showChat(player,true)
	end
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
	setTimer(fadeCamera,500,1,player,true,3.0,255,255,255)
	spawnPlayer(player,x,y,z, math.random(0,360), skin, 0, 0)
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
		setElementData(player,data[1],data[2])
	end
	
	initDefaultStatusTable(player)
	initDefaultSkillsTable(player)
	initDefaultJobTable(player)
	
	dbQuery(loadSkillsFromDB, {player,username}, skillsDB, "SELECT skillsData FROM skills WHERE playerName = ?",username)
	--dbExec(skillsDB, "INSERT INTO skills (playerName,skillsData) VALUES(?,?)",username,toJSON(playerSkillsTable[player]))
	
	determineBloodType(player)
	addBackpackToPlayer(player,playerStatusTable[player]["MAX_Slots"])
	
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
	if not gameplayVariables["MySQL"] then
		account = getAccount(username)
		local value = getAccounts()
		local value = #value
		setElementData(player,"playerID",value+1)
		setAccountData(account,"playerID",value+1)
	end
	setElementData(player,"logedin",true)
	setElementData(player,"spawnedzombies",0)
	if gameplayVariables["newclothingsystem"] then
		triggerEvent("onPlayerChangeClothes", player)
	end
	sendPlayerStatusInfoToClient()
	triggerClientEvent(player,"onPlayerUpdateSkillsToJournal",player,playerSkillsTable[player])
	
	if gameplayVariables["armachat"] then
		triggerClientEvent(player,"showChatBox",player,true)
	else
		showChat(player,true)
	end
end
addEvent("onPlayerDayZRegister", true)
addEventHandler("onPlayerDayZRegister", getRootElement(), playerRegister)

function savePlayerAccount() -- Save in the database
	if getElementData(source,"logedin") then
		local x,y,z = getElementPosition(source)
		local isDead = getElementData(source,"isDead") or false
		if gameplayVariables["MySQL"] then
			local account = something[source]
			if account then
				local tbl = {}
				for i,data in ipairs(playerDataTable) do
					tbl[data[1]] = getElementData(source,data[1])
				end
				for k, status in pairs(playerStatusTable[source]) do
					tbl[k] = status
				end
				tbl["last_x"] = x
				tbl["last_y"] = y
				tbl["last_z"] = z
				tbl["isDead"] = getElementData(source,"isDead")
				dbExec(dbConnection,"UPDATE accounts SET `userdata`=? WHERE `username`=?",toJSON(tbl),account)
			end
			outputServerLog("[DayZ] Player account "..getPlayerName(source).." has been saved.")
		else
			local account = getPlayerAccount(source)
			if account then
				local tablePlayerInventory = {}
				for i,data in ipairs(playerDataTable) do
					tablePlayerInventory[data[1]] = getElementData(source,data[1])
				end
				
				local tablePlayerStatus = {}
				if playerStatusTable[source] then
					for k, status in pairs(playerStatusTable[source]) do
						tablePlayerStatus[k] = status
					end
				end
				
				local tablePlayerSkills = {}
				if playerSkillsTable[source] then
					for k, skills in pairs(playerSkillsTable[source]) do
						tablePlayerSkills[k] = skills
					end
				end
				
				local tablePlayerJob = {}
				if playerJobTable[source] then
					for k, job in pairs(playerJobTable[source]) do
						tablePlayerJob[k] = job
					end
				end
					
					
				setAccountData(account,"PlayerInventory",toJSON(tablePlayerInventory))
				setAccountData(account,"PlayerStatus",toJSON(tablePlayerStatus))
				setAccountData(account,"PlayerCurrentJob",toJSON(tablePlayerJob))
				setAccountData(account,"isDead",isDead)
				setAccountData(account,"last_x",x)
				setAccountData(account,"last_y",y)
				setAccountData(account,"last_z",z)
				dbExec(skillsDB, "DELETE FROM skills WHERE playerName=?",getPlayerName(source))
				dbExec(skillsDB, "INSERT INTO skills (playerName,skillsData) VALUES(?,?)",getPlayerName(source),toJSON(playerSkillsTable[source]))
			end
			outputServerLog("[DayZ] Player account "..getAccountName(account).." has been saved.")
		end
		if getElementData(source,"logedin") then
			destroyElement(getElementData(source,"playerCol"))
		end
		setElementData(source,"logedin",false)
	end
end
addEventHandler ( "onPlayerQuit", getRootElement(), savePlayerAccount)

function saveAllAccounts() -- Save in the database
	for i, player in ipairs(getElementsByType("player")) do
		local x,y,z =  getElementPosition(player)
		if gameplayVariables["MySQL"] then
			local account = something[player]
			if account then
				local tbl = {}
				for i,data in ipairs(playerDataTable) do
					tbl[data[1]] = getElementData(player,data[1])
				end
				for k, status in pairs(playerStatusTable[player]) do
					tbl[k] = status
				end
				tbl["last_x"] = x
				tbl["last_y"] = y
				tbl["last_z"] = z
				tbl["isDead"] = getElementData(player,"isDead")
				dbExec(dbConnection,"UPDATE accounts SET `userdata`=? WHERE `username`=?",toJSON(tbl),account)
			end
		else
			local account = getPlayerAccount(player)
			if account then
				local tablePlayerInventory = {}
				for i,data in ipairs(playerDataTable) do
					tablePlayerInventory[data[1]] = getElementData(player,data[1])
				end
				
				local tablePlayerStatus = {}
				for k, status in pairs(playerStatusTable[player]) do
					tablePlayerStatus[k] = status
				end

				local tablePlayerJob = {}
				if playerJobTable[player] then
					for k, job in pairs(playerJobTable[player]) do
						tablePlayerJob[k] = job
					end
				end
				
				setAccountData(account,"PlayerInventory",toJSON(tablePlayerInventory))
				setAccountData(account,"PlayerStatus",toJSON(tablePlayerStatus))
				setAccountData(account,"PlayerCurrentJob",toJSON(tablePlayerJob))
				setAccountData(account,"isDead",getElementData(player,"isDead"))
				setAccountData(account,"last_x",x)
				setAccountData(account,"last_y",y)
				setAccountData(account,"last_z",z)
			end
		end
	end
	outputServerLog("[DayZ] All accounts have been saved.")
end
addEventHandler ( "onResourceStop", getResourceRootElement(getThisResource()), saveAllAccounts)

function loadSkillsFromDB(query,player,username)
	if query then
		local poll = dbPoll(query,-1)
		local skillsData = {}
		if #poll > 0 then
			for i, data in pairs(poll) do
				for k, skills in pairs(data) do
					skillsData = fromJSON(skills)			
				end
			end
			for i, data in pairs(playerSkillsTable[player]) do
				local skills = skillsData[i]
				playerSkillsTable[player][i] = skills
			end
			triggerClientEvent(player,"onPlayerUpdateSkillsToJournal",player,playerSkillsTable[player])
		else
			dbExec(skillsDB, "INSERT INTO skills (playerName,skillsData) VALUES(?,?)",username,toJSON(playerSkillsTable[player]))
		end
	end
end


--[[
We determine the blood type using real world statistics

Breakdown:

0: 39%
A: 32%
B: 23%
AB: 6%
]]

function determineBloodType(player)
local bloodTypeChance = math.random(0,100)
local determinedType = "0"
	if bloodTypeChance >= 0 and bloodTypeChance <= 6 then -- 6%
		determinedType = "AB"
	elseif bloodTypeChance >= 7 and bloodTypeChance <= 30 then -- 23%
		determinedType = "B"
	elseif bloodTypeChance >= 31 and bloodTypeChance <= 63 then -- 32%
		determinedType = "A"
	elseif bloodTypeChance >= 64 and bloodTypeChance <= 100 then -- 39%
		determinedType = "0"
	end
	if player then
		playerStatusTable[player]["bloodtypediscovered"] = determinedType
		playerStatusTable[player]["bloodtype"] = "?"
	end
end

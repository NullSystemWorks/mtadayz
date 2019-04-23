--List of system accounts that shouldn't be logged into by normal players
local blockedAccounts = {
	{"vehicleManager"},
	{"tent_number"},
	{"vehicle_number"},
	{"seasonmanager"}
}

-- ***If uncommented, this breaks the whole login.***
-- secretKey = exports["DayZ"].getGameplayVariablesServerPairs()["secret_key"]
-- ***Unfortunately, this also causes the use of MySQL to be difficult - if not impossible - until fixed.***

local loginSkin = 0
local x,y,z = 0,0,0
local reason = ""
local pedDimension = 0
local loginPed = {}

function spawnPedFromPlayerInfo()
	pedDimension = pedDimension+1
	local playerName = getPlayerName(source) -- we assume the player name matches the account name, needs a better solution (pull from XML)
	local account = getAccount(playerName)
	setCameraMatrix(source,-1645.4077,-2221.677001,31.8351001,-1644.5368,-2222.152099,31.7088756,0,70)
	setElementDimension(source,666)
	fadeCamera(source,true)
	if account then
		if exports["DayZ"].getGameplayVariablesServerPairs()["MySQL"] then
			local newSkinSystem = exports.DayZ:getGameplayVariable("newclothingsystem")
			if newSkinSystem then
				loginSkin = 0
			else
				loginSkin = 73
			end
		else
			local playerData = fromJSON(getAccountData(account,"PlayerStatus"))
			loginSkin = playerData["skin"]
		end
		loginPed[source] = createPed(loginSkin,-1642.3599,-2224.3393,30.793333053589,31.854591369629)
		setElementDimension(loginPed[source],666+pedDimension)
		setElementDimension(source,666+pedDimension)
	else
		local newSkinSystem = exports.DayZ:getGameplayVariable("newclothingsystem")
		local skinID = 0
		if newSkinSystem then
			skinID = 0
		else
			skinID = 73
		end
		loginPed[source] = createPed(skinID,-1642.3599,-2224.3393,30.793333053589,31.854591369629)
		setElementDimension(loginPed[source],666+pedDimension)
		setElementDimension(source,666+pedDimension)
	end
end
addEventHandler("onPlayerJoin",root,spawnPedFromPlayerInfo)

function removePedDimensionOnPlayerQuit()
	pedDimension = pedDimension-1
	if isElement(loginPed[source]) then
		destroyElement(loginPed[source])
	end
end
addEventHandler("onPlayerQuit",root,removePedDimensionOnPlayerQuit)

--LOGIN THE PLAYER FROM GUI
function tryToLoginPlayer (username, password)
	--Parse through our blockedAccounts array for system accounts
	for k,v in ipairs(blockedAccounts) do
		local found = string.find(username:lower(),v[1]:lower())
		if found then
			reason = "You cannot log into "..username
			triggerClientEvent("onErrorOutputReason",source,reason)
			return false
		end
	end
	
	--Proceed with logging in...
	
	if exports["DayZ"].getGameplayVariablesServerPairs()["MySQL"] then
		local dbConnection = dbConnect( "mysql", "dbname="..exports["DayZ"].getGameplayVariablesServerPairs()["MySQL_DB"]..";host="..exports["DayZ"].getGameplayVariablesServerPairs()["MySQL_host"]..";port="..exports["DayZ"].getGameplayVariablesServerPairs()["MySQL_port"], exports["DayZ"].getGameplayVariablesServerPairs()["MySQL_user"], exports["DayZ"].getGameplayVariablesServerPairs()["MySQL_pass"], "share=1" )
		dbExec(dbConnection,"CREATE TABLE IF NOT EXISTS `accounts` (`ID` int(11) NOT NULL AUTO_INCREMENT,`username` text NOT NULL,`password` text NOT NULL,`userdata` text NOT NULL,  `rank` text NOT NULL, `creationDate` text NOT NULL,`lastLogin` text NOT NULL, PRIMARY KEY (`ID`))")
		local qh = dbQuery(dbConnection, "SELECT * FROM accounts WHERE `username`=? AND `password`=? LIMIT 1",username,md5(password..secretKey))
		local result = dbPoll(qh, -1)
		dbFree(qh) -- Just to avoid console flood or security vulnerability, but it's not necessary.
		if #result > 0 then
			if getPlayerAccount(client) then
				logOut(client)
			end
			local cc = getAccount(username) -- Why we're still using internal DB with MySQL? That's the solution to avoid script bugs (scripts that still uses ACL or something)
			if cc then
				if getAccount(username, password) then
					logIn(source, cc, password)
				else
					if delAccount(cc) then
						cc = addAccount(username, password)
						if not logIn(source, cc, password) then
							reason = "Unknown error"
							triggerClientEvent("onErrorOutputReason",source,reason)
							return
						end
					end
				end
			else
				cc = addAccount(username, password)
				if not logIn(source, cc, password) then
					reason = "Unknown error"
					triggerClientEvent("onErrorOutputReason",source,reason)
					return
				end
			end
			fadeCamera(source,false,3.0,0,0,0)
			triggerClientEvent(source,"checkIfRegisterOrLoginOkay",source,"login")
			triggerClientEvent(source,"getTheServerName", source, getServerName())
			triggerClientEvent(source,"onPlayerDoneLogin", source, username, password)			
			setTimer(triggerEvent,3000,1,"onPlayerDayZLogin", getRootElement(), username, password, source)
			local theTime = getRealTime()
			local hour = theTime.hour
			local minute = theTime.minute
			local seconds = theTime.second
			local theAccount = getPlayerAccount(client)
			exports.DayZ:saveLog("["..hour..":"..minute..":"..seconds.."] [LOGIN] "..username.." has logged in. Player: "..getPlayerName(client).."\n","accounts")
			if isElement(loginPed[source]) then
				destroyElement(loginPed[source])
			end
		else
			reason = "Account does not exist or wrong password"
			triggerClientEvent(source,"checkIfRegisterOrLoginOkay",source,false)
			triggerClientEvent("onErrorOutputReason",source,reason)
			return
		end
	else
		local account = getAccount(username, password)
		if not account then
			reason = "Account does not exist or wrong password"
			triggerClientEvent("onErrorOutputReason",source,reason)
			triggerClientEvent(source,"checkIfRegisterOrLoginOkay",source,false)
			return
		elseif account then
			fadeCamera(source,false,3.0,0,0,0)
			triggerClientEvent(source,"checkIfRegisterOrLoginOkay",source,"login")
			local accountName = getAccountName(account)
			logIn(source, account, password)
			triggerClientEvent(source,"onPlayerDoneLogin", source, accountName, password)		
			setTimer(triggerEvent,3000,1,"onPlayerDayZLogin", getRootElement(),username,password,source)
			local theTime = getRealTime()
			local hour = theTime.hour
			local minute = theTime.minute
			local seconds = theTime.second
			local theAccount = getPlayerAccount(source)
			exports.DayZ:saveLog("["..hour..":"..minute..":"..seconds.."] [LOGIN] "..username.." has logged in. Player: "..getPlayerName(source).."\n","accounts")
			if isElement(loginPed[source]) then
				destroyElement(loginPed[source])
			end
		end
	end
end
addEvent("onClientSendLoginDataToServer", true)
addEventHandler("onClientSendLoginDataToServer", root, tryToLoginPlayer)

function tryToRegsiterPlayer(username, pass)
	--Parse through our blockedAccounts array for system accounts
	for k,v in ipairs(blockedAccounts) do
		local found = string.find(username:lower(),v[1]:lower())
		if found then
			reason = "You cannot register as "..username
			triggerClientEvent("onErrorOutputReason",source,reason)
			return
		end
	end
	if exports["DayZ"].getGameplayVariablesServerPairs()["MySQL"] then
		local dbConnection = dbConnect( "mysql", "dbname="..exports["DayZ"].getGameplayVariablesServerPairs()["MySQL_DB"]..";host="..exports["DayZ"].getGameplayVariablesServerPairs()["MySQL_host"]..";port="..exports["DayZ"].getGameplayVariablesServerPairs()["MySQL_port"], exports["DayZ"].getGameplayVariablesServerPairs()["MySQL_user"], exports["DayZ"].getGameplayVariablesServerPairs()["MySQL_pass"], "share=1" )
		dbExec(dbConnection,"CREATE TABLE IF NOT EXISTS `accounts` (`ID` int(11) NOT NULL AUTO_INCREMENT,`username` text NOT NULL,`password` text NOT NULL,`userdata` text NOT NULL,  `rank` text NOT NULL, `creationDate` text NOT NULL,`lastLogin` text NOT NULL, PRIMARY KEY (`ID`))")		local qh = dbQuery(dbConnection, "SELECT * FROM accounts WHERE `username`=? LIMIT 1",username)
		local qh = dbQuery(dbConnection, "SELECT * FROM accounts WHERE `username`=? LIMIT 1",username)
		local result = dbPoll(qh, -1)
		dbFree(qh) -- Just to avoid console flood or security vulnerability, but it's not necessary.
		if #result == 0 then
			if getPlayerAccount(client) then
				logOut(client)
			end
			local theTime = getRealTime()
			local hour = theTime.hour
			local minute = theTime.minute
			local seconds = theTime.second
			local currentTime = theTime.monthday.."/"..(theTime.month+1).."/"..(theTime.year+1900)
			local exec = dbExec(dbConnection, "INSERT INTO accounts VALUES (?,?,?,?,?,?,?)", nil, username, md5(pass..secretKey), toJSON({}), "Survivor", currentTime, currentTime)
			if exec then
				local cc = getAccount(username) -- Why we're still using internal DB with MySQL? That's the solution to avoid script bugs (scripts that still uses ACL or something)
				if cc then
					if getAccount(username,pass) then
						logIn(source, cc, pass)
					else
						if delAccount(cc) then
							cc = addAccount(username,pass)
							if not logIn(source, cc, pass) then
								reason = "Unknown error"
								triggerClientEvent("onErrorOutputReason",source,reason)
								triggerClientEvent(source,"checkIfRegisterOrLoginOkay",source,false)
								return
							end
						end
					end
				else
					cc = addAccount(username,pass)
					if not logIn(source, cc, pass) then
						reason = "Unknown error"
						triggerClientEvent("onErrorOutputReason",source,reason)
						triggerClientEvent(source,"checkIfRegisterOrLoginOkay",source,false)
						return
					end
				end
				fadeCamera(source,false,3.0,0,0,0)
				triggerClientEvent(source,"checkIfRegisterOrLoginOkay",source,"register")
				outputChatBox("You successfully registered account '" ..username.. "' for player '" ..getPlayerName(source).. "'#FFFFFF with password '" ..pass.."'!", source, 255, 255, 255, true)
				triggerClientEvent(source,"onPlayerDoneLogin", source,username,pass)	
				setTimer(triggerEvent,3000,1,"onPlayerDayZRegister", getRootElement(),username,pass,source)
				exports.DayZ:saveLog("["..currentTime.." - "..hour..":"..minute..":"..seconds.."] [REGISTER]: "..username.." registered this account. Initial player: "..getPlayerName(client).."\n","accounts")
				if isElement(loginPed[source]) then
					destroyElement(loginPed[source])
				end
				return true
			else
				reason = "Was unable to add account"
				return
			end
		else
			reason = "Account already exists"
			return
		end
	else
		if not getAccount(username,pass) then
			theAccount = addAccount(username, pass)
			if (theAccount) then
				logIn(source, theAccount, pass)
				outputChatBox("You successfully registered account '" ..username.. "' for player '" ..getPlayerName(source).. "'#FFFFFF with password '" ..pass.."'!", source, 255, 255, 255, true)
				fadeCamera(source,false,3.0,0,0,0)
				triggerClientEvent(source,"checkIfRegisterOrLoginOkay",source,"register")
				triggerClientEvent(source,"onPlayerDoneLogin", source,username,pass)	
				setTimer(triggerEvent,3000,1,"onPlayerDayZRegister", getRootElement(),username,pass,source)
				local theTime = getRealTime()
				local hour = theTime.hour
				local minute = theTime.minute
				local seconds = theTime.second
				exports.DayZ:saveLog("["..hour..":"..minute..":"..seconds.."] [REGISTER]: "..username.." registered this account. Initial player: "..getPlayerName(client).."\n","accounts")
				if isElement(loginPed[source]) then
					destroyElement(loginPed[source])
				end
				return true
			else
				reason = "Was unable to add account"
				triggerClientEvent("onErrorOutputReason",source,reason)
				triggerClientEvent(source,"checkIfRegisterOrLoginOkay",source,false)
				return
			end
		else
			reason = "Account exists already or wrong password" 
			triggerClientEvent("onErrorOutputReason",source,reason)
			triggerClientEvent(source,"checkIfRegisterOrLoginOkay",source,false)
			return
		end
	end
end
addEvent("onClientSendRegisterDataToServer", true)
addEventHandler("onClientSendRegisterDataToServer", getRootElement(), tryToRegsiterPlayer)

function pullChangelog(news)
	local player = client -- idk how to send it correctly to function()
	if news then
		fetchRemote("https://raw.githubusercontent.com/NullSystemWorks/mtadayz/master/news.txt",function(data,err)
			triggerClientEvent(player,"loadAPIData",player,"changelog",data)
		end)
	end
	fetchRemote("https://api.github.com/repos/NullSystemWorks/mtadayz/contributors",function(data,err)
		triggerClientEvent(player,"loadAPIData",player,"contributors",data)
	end)
end
addEvent("pullChangelog", true)
addEventHandler("pullChangelog", getRootElement(), pullChangelog)

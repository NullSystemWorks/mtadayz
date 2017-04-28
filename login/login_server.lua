--List of system accounts that shouldn't be logged into by normal players
local blockedAccounts = {
	{"vehicleManager"},
	{"tent_number"},
	{"vehicle_number"},
	{"seasonmanager"}
}

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
		local qh = dbQuery(dbConnection, "SELECT * FROM accounts WHERE `username`=? AND `password`=? LIMIT 1",username,md5(password))
		local result = dbPoll(qh, -1)
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
			triggerClientEvent(source,"onPlayerDoneLogin", source, username, password)		
			triggerEvent("onPlayerDayZLogin", getRootElement(), username, password, source)
			local theTime = getRealTime()
			local hour = theTime.hour
			local minute = theTime.minute
			local seconds = theTime.second
			local theAccount = getPlayerAccount(client)
			exports.DayZ:saveLog("["..hour..":"..minute..":"..seconds.."] [LOGIN] "..username.." has logged in. Player: "..getPlayerName(client).."\n","accounts")
		else
			reason = "Account does not exist"
			triggerClientEvent("onErrorOutputReason",source,reason)
			return
		end
	else
		local account = getAccount(username, password)
		if not account then
			reason = "Account does not exist"
			triggerClientEvent("onErrorOutputReason",source,reason)
			return
		elseif account then
			local accountName = getAccountName(account)
			logIn(source, account, password)
			triggerClientEvent(source,"onPlayerDoneLogin", source, accountName, password)		
			triggerEvent("onPlayerDayZLogin", getRootElement(),username,password,source)
			local theTime = getRealTime()
			local hour = theTime.hour
			local minute = theTime.minute
			local seconds = theTime.second
			local theAccount = getPlayerAccount(client)
			exports.DayZ:saveLog("["..hour..":"..minute..":"..seconds.."] [LOGIN] "..username.." has logged in. Player: "..getPlayerName(client).."\n","accounts")
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
		local result = dbPoll(qh, -1)
		if #result == 0 then
			local theTime = getRealTime()
			local hour = theTime.hour
			local minute = theTime.minute
			local seconds = theTime.second
			local currentTime = theTime.monthday.."/"..(theTime.month+1).."/"..(theTime.year+1900)
			local exec = dbExec(dbConnection, "INSERT INTO accounts VALUES (?,?,?,?,?,?,?)", nil, username, md5(pass), toJSON({}), "Survivor", currentTime, currentTime)
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
								return
							end
						end
					end
				else
					cc = addAccount(username,pass)
					if not logIn(source, cc, pass) then
						reason = "Unknown error"
						triggerClientEvent("onErrorOutputReason",source,reason)
						return
					end
				end
				outputChatBox("You successfully registered account '" ..username.. "' for player '" ..getPlayerName(source).. "'#FFFFFF with password '" ..pass.."'!", source, 255, 255, 255, true)
				triggerClientEvent(source,"onPlayerDoneLogin", source,username,pass)	
				triggerEvent("onPlayerDayZRegister", getRootElement(),username,pass,source)
				--triggerEvent("onPlayerDayZLogin", getRootElement(),username,pass,source)
				exports.DayZ:saveLog("["..currentTime.." - "..hour..":"..minute..":"..seconds.."] [REGISTER]: "..username.." registered this account. Initial player: "..getPlayerName(client).."\n","accounts")
				return true
			else
				reason = "Was unable to add account"
			end
		else
			reason = "Account already exists"
		end
	else
		if not getAccount(username) then
			theAccount = addAccount(username, pass)
			if (theAccount) then
				logIn(source, theAccount, pass)
				outputChatBox("You successfully registered account '" ..username.. "' for player '" ..getPlayerName(source).. "'#FFFFFF with password '" ..pass.."'!", source, 255, 255, 255, true)
				triggerClientEvent(source,"onPlayerDoneLogin", source,username,pass)	
				triggerEvent("onPlayerDayZRegister", getRootElement(),username,pass,source)
				--triggerEvent("onPlayerDayZLogin", getRootElement(),username,pass,source)
				local theTime = getRealTime()
				local hour = theTime.hour
				local minute = theTime.minute
				local seconds = theTime.second
				exports.DayZ:saveLog("["..hour..":"..minute..":"..seconds.."] [REGISTER]: "..username.." registered this account. Initial player: "..getPlayerName(client).."\n","accounts")
				return true
			else
				reason = "Was unable to add account"
			end
		else
			reason = "Account already exists"
		end
	end
	
	triggerClientEvent("onErrorOutputReason",source,reason)
	return
end
addEvent("onClientSendRegisterDataToServer", true)
addEventHandler("onClientSendRegisterDataToServer", getRootElement(), tryToRegsiterPlayer)

function pullChangelog(news)
	local player = client -- idk how to send it correctly to function()
	if news then
		fetchRemote("https://raw.githubusercontent.com/ciber96/mtadayz/master/news.txt",function(data,err)
			triggerClientEvent(player,"loadAPIData",player,"changelog",data)
		end)
	end
	fetchRemote("https://api.github.com/repos/ciber96/MTADayZ/contributors",function(data,err)
		triggerClientEvent(player,"loadAPIData",player,"contributors",data)
	end)
end
addEvent("pullChangelog", true)
addEventHandler("pullChangelog", getRootElement(), pullChangelog)

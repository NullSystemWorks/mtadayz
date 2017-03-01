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
	local account = getAccount(username, password)
	if not account then
		reason = "Account does not exist"
		triggerClientEvent("onErrorOutputReason",source,reason)
		return
	elseif account then
		local accountName = getAccountName(account)
		logIn(source, account, password)
		triggerClientEvent(source,"onPlayerDoneLogin", source, accountName, password)		
		triggerEvent("onPlayerDayZLogin", getRootElement(),username,pass,source)
		local theTime = getRealTime()
		local hour = theTime.hour
		local minute = theTime.minute
		local seconds = theTime.second
		local theAccount = getPlayerAccount(client)
		exports.DayZ:saveLog("["..hour..":"..minute..":"..seconds.."] [LOGIN] "..username.." has logged in. Player: "..getPlayerName(client).."\n","accounts")
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
	if not getAccount(username) then
		theAccount = addAccount(username, pass)
		if (theAccount) then
			logIn(source, theAccount, pass)
			outputChatBox("You successfully registered account '" ..username.. "' for player '" ..getPlayerName(source).. "'#FFFFFF with password '" ..pass.."'!", source, 255, 255, 255, true)
			triggerClientEvent(source,"onPlayerDoneLogin", source,username,pass)	
			triggerEvent("onPlayerDayZRegister", getRootElement(),username,pass,source)
			triggerEvent("onPlayerDayZLogin", getRootElement(),username,pass,source)
			local theTime = getRealTime()
			local hour = theTime.hour
			local minute = theTime.minute
			local seconds = theTime.second
			local theAccount = getPlayerAccount(client)
			exports.DayZ:saveLog("["..hour..":"..minute..":"..seconds.."] [REGISTER]: "..username.." registered this account. Initial player: "..getPlayerName(client).."\n","accounts")
			return true
		else
			reason = "Was unable to add account"
			return
		end
	else
		reason = "Account already exists"
		return
	end
	
	triggerClientEvent("onErrorOutputReason",source,reason)
	return
end
addEvent("onClientSendRegisterDataToServer", true)
addEventHandler("onClientSendRegisterDataToServer", getRootElement(), tryToRegsiterPlayer)

function pullChangelog()
	local player = client -- idk how to send it correctly to function()
	fetchRemote("https://raw.githubusercontent.com/ciber96/mtadayz/master/changelog.txt",function(data,err)
		triggerClientEvent(player,"loadAPIData",player,"changelog",data)
	end)
	fetchRemote("https://api.github.com/repos/ciber96/MTADayZ/contributors",function(data,err)
		triggerClientEvent(player,"loadAPIData",player,"contributors",data)
		
		--[[local majorTable = split(data,"},")
		local name, contri = "",""
		local tbl = {}
		for i, all in pairs(majorTable) do
			if string.find(all,"login") then
				if(i==3)then
					name = string.sub(all,13,#all-1)
				else
					name = string.sub(all,11,#all-1)
				end
			end
			if(string.find(all,"contributions"))then
				contri = string.sub(all,17,#all)
				table.insert(tbl,{name,contri})
			end
		end
		]]
	end)
end
addEvent("pullChangelog", true)
addEventHandler("pullChangelog", getRootElement(), pullChangelog)

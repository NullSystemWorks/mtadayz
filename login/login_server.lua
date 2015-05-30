local root = getRootElement()


--LOGIN THE PLAYER FROM GUI
function tryToLoginPlayer (username, password)
	local account = getAccount(username, password)
	if account then
		local accountName = getAccountName(account)
		logIn(source, account, password)
		triggerClientEvent(source,"onPlayerDoneLogin", source, accountName, password)		
		triggerEvent("onPlayerDayZLogin", getRootElement(),username,pass,source)
		local theTime = getRealTime()
		local hour = theTime.hour
		local minute = theTime.minute
		local seconds = theTime.second
		local theAccount = getPlayerAccount(client)
		exports.DayZ:saveLog("["..hour..":"..minute..":"..seconds.."] [LOGIN] "..username.." has logged in. Player: "..getPlayerName(client),"accounts")
	else
		outputChatBox("[LOGIN ERROR]#FF9900 Wrong password or username!",source,255,255,255,true)
	end
end
addEvent("onClientSendLoginDataToServer", true)
addEventHandler("onClientSendLoginDataToServer", root, tryToLoginPlayer)

function tryToRegsiterPlayer(username, pass)
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
			exports.DayZ:saveLog("["..hour..":"..minute..":"..seconds.."] [REGISTER]: "..username.." registered this account. Initial player: "..getPlayerName(client),"accounts")
		else
			reason = "Unknown Error!"
			outputChatBox("[LOGIN ERROR]#FF9900 "..reason,source,255,255,255,true)
		end
	else
		reason = "Account already exists!"
		outputChatBox("[LOGIN ERROR]#FF9900 "..reason,source,255,255,255,true)
	end
end
addEvent("onClientSendRegisterDataToServer", true)
addEventHandler("onClientSendRegisterDataToServer", getRootElement(), tryToRegsiterPlayer)


addEventHandler("onPlayerJoin", getRootElement(),
function()
	fadeCamera(source, true) 
	setCameraMatrix(source, 1468.8785400391, -919.25317382813, 100.153465271, 1468.388671875, -918.42474365234, 99.881813049316)
end)

addEvent("requestServerNews", true)
addEventHandler("requestServerNews", root, 
	function()
		local text1 = get("news1")
		local text2 = get("news2")
		local text3 = get("news3")
		local text4 = get("news4")
		local bool1 = get("news1new")
		local bool2 = get("news2new")
		local bool3 = get("news3new")
		local bool4 = get("news4new")
		triggerClientEvent(source,"onClientGetNews",root,text1,text2,text3,text4,bool1,bool2,bool3,bool4)	
	end
)




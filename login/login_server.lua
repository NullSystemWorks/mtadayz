local root = getRootElement()

--List of system accounts that shouldn't be logged into by normal players. (Jack)
local blockedAccounts = {
	{"vehicleManager"},
	{"tent_number"},
	{"vehicle_number"},
	{"seasonmanager"}
}

function callClientFunction(client, funcname, ...)
    local arg = { ... }
    if (arg[1]) then
        for key, value in next, arg do
            if (type(value) == "number") then arg[key] = tostring(value) end
        end
    end
    -- If the clientside event handler is not in the same resource, replace 'resourceRoot' with the appropriate element
    triggerClientEvent(client, "onServerCallsClientFunction", resourceRoot, funcname, unpack(arg or {}))
end

--LOGIN THE PLAYER FROM GUI
function tryToLoginPlayer (username, password)
	--Parse through our blockedAccounts array for system accounts
	for k,v in ipairs(blockedAccounts) do
		local found = string.find(username:lower(),v[1]:lower())
		if found then
			outputChatBox("[LOGIN ERROR]#FF9900 You cannot log into "..username.." as it is a system account.",source,255,255,255,true)
			return false
		end
	end
	
	--Proceed with logging in...
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
		exports.DayZ:saveLog("["..hour..":"..minute..":"..seconds.."] [LOGIN] "..username.." has logged in. Player: "..getPlayerName(client).."\n","accounts")
	else
		outputChatBox("[LOGIN ERROR]#FF9900 Wrong password or username!",source,255,255,255,true)
	end
end
addEvent("onClientSendLoginDataToServer", true)
addEventHandler("onClientSendLoginDataToServer", root, tryToLoginPlayer)

function tryToRegsiterPlayer(username, pass)
	--Parse through our blockedAccounts array for system accounts
	for k,v in ipairs(blockedAccounts) do
		local found = string.find(username:lower(),v[1]:lower())
		if found then
			outputChatBox("[LOGIN ERROR]#FF9900 You cannot register "..username.." as it is a system account.",source,255,255,255,true)
			return false
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
			reason = "Unknown Error!"
		end
	else
		reason = "Account already exists!"
	end
	
	outputChatBox("[LOGIN ERROR]#FF9900 "..reason,source,255,255,255,true)
	return false
end
addEvent("onClientSendRegisterDataToServer", true)
addEventHandler("onClientSendRegisterDataToServer", getRootElement(), tryToRegsiterPlayer)

addEventHandler("onPlayerJoin", getRootElement(),
function()
	fadeCamera(source, true)
	--triggerClientEvent("onJoinPlayTrack",source)
	--callClientFunction(source,"onJoinPlayTrack")
	sX = math.random(-3000,3000)	-- start X
	sY = math.random(-3000,3000)	-- start Y
	sZ = math.random(50,100)		-- start Z
	rX = math.random(90,270)		-- Rotation X
	rY = math.random(90,270)		-- Rotation Y
	rZ = 0							-- Rotation Z
	tX = math.random(-3000,3000)	-- Target X
	tY = math.random(-3000,3000)	-- Target Y
	tZ = sZ							-- Target Z
	
	callClientFunction(source,"smoothMoveCamera",sX,sY,sZ,rX,rY,rZ,tX,tY,tZ,rX,rY,rZ,100000)
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




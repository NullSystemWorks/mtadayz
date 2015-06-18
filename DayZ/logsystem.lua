--[[

	Author: CiBeR
	Version: 0.3
	Copyright: DayZ Gamemode. All rights reserved to Developers
	Current Devs: Lawliet, CiBeR, Jboy
	
]]--
function saveLog(tstring,logtype)
	if logtype and logtype == "admin" and tstring then 			-- For all admin related actions (such as giving items, kicking player, ...)
		local file = fileOpen("logs/admin.log")
		local size = fileGetSize( file )
		local set = fileSetPos( file, size )
		local writ = fileWrite( file, tstring )
		fileClose( file )
		return true
	elseif logtype and logtype == "debug" and tstring then		-- For debug purposes when testing, for example, addons
		local file = fileOpen("logs/debug.log")
		local size = fileGetSize( file )
		local set = fileSetPos( file, size )
		local writ = fileWrite( file, tstring )
		fileClose( file )
		return true
	elseif logtype and logtype == "updates" and tstring then	-- 	For updates on the script itself
		local file = fileOpen("logs/updates.log")
		local size = fileGetSize( file )
		local set = fileSetPos( file, size )
		local writ = fileWrite( file, tstring )
		fileClose( file )
		return true
	elseif logtype and logtype == "accounts" and tstring then	-- For all account-related actions (created account, logged in, logged out, ...)
		local file = fileOpen("logs/accounts.log")
		local size = fileGetSize( file )
		local set = fileSetPos( file, size )
		local writ = fileWrite( file, tstring )
		fileClose( file )
		return true
	elseif logtype and logtype == "game" and tstring then		-- For everything related to things happening in-game (picking up items, placing tent, ...)
		local file = fileOpen("logs/game.log")
		local size = fileGetSize( file )
		local set = fileSetPos( file, size )
		local writ = fileWrite( file, tstring )
		fileClose( file )
		return true
	elseif logtype and logtype == "chat" and tstring then		-- For chat protocol
		local file = fileOpen("logs/chat.log")
		local size = fileGetSize( file )
		local set = fileSetPos( file, size )
		local writ = fileWrite( file, tstring )
		fileClose( file )
		return true
	else
	outputDebugString("[DayZ Logs] Error in saveLog Function. Invalid Arguments?")
	return false
	end

end
function returnLog(logtype)
	if logtype and logtype == "admin" then
	local file = fileOpen("logs/admin.log")
	local size = fileGetSize( file )
	buf = fileRead(file,size)
	fileClose(file)
	return buf
	elseif logtype and logtype == "debug" then
	local file = fileOpen("logs/debug.log")
	local size = fileGetSize( file )
	buf = fileRead(file,size)
	fileClose(file)
	return buf
	elseif logtype and logtype == "updates" then
	local file = fileOpen("logs/updates.log")
	local size = fileGetSize( file )
	buf = fileRead(file,size)
	fileClose(file)
	return buf
	elseif logtype and logtype == "accounts" then
	local file = fileOpen("logs/accounts.log")
	local size = fileGetSize( file )
	buf = fileRead(file,size)
	fileClose(file)
	return buf
	elseif logtype and logtype == "game" then
	local file = fileOpen("logs/game.log")
	local size = fileGetSize( file )
	buf = fileRead(file,size)
	fileClose(file)
	return buf
	elseif logtype and logtype == "chat" then
	local file = fileOpen("logs/chat.log")
	local size = fileGetSize( file )
	buf = fileRead(file,size)
	fileClose(file)
	return buf
	else
	outputDebugString("[DayZ Logs] Error in returnLog Function. Invalid Arguments?")
	return false
	end
end
local logFiles = { "logs/admin.log", "logs/debug.log", "logs/updates.log", "logs/accounts.log", "logs/game.log", "logs/chat.log" }
addEventHandler("onResourceStart",resourceRoot,
	function ()
		for i, v in ipairs(logFiles)do
			if not fileExists(v) then
				outputDebugString("[DayZ Logs] File: "..v.." not found. Creating it.")
				local newFile = fileCreate(v)
				fileClose(newFile)
			end
		end
	end
)
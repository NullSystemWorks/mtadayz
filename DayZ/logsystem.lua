--[[
	Author: CiBeR
	Version: 0.3
	Copyright: DayZ Gamemode. All rights reserved to Developers
	Current Devs: Lawliet, CiBeR, Jboy
	
]]--

local logTypes = { "admin", "debug", "updates", "accounts", "game", "chat" }


function saveLog( tstring, logtype )
	local isCorrectLogType = false
	for _, v in ipairs( logTypes ) do
		if v == logtype then
			isCorrectLogType = true
			break
		end
	end
	
	if not isCorrectLogType then
		outputDebugString( "[DayZ Logs] Error in 'saveLog' function. Wrong log type '".. logtype .."'!"  )
		return false
	end
	
	local file = fileOpen("logs/".. logtype .. ".log")
	local size = fileGetSize( file )
	local set = fileSetPos( file, size )
	local writ = fileWrite( file, tstring )
	fileClose( file )
	return true
end


function returnLog( logtype )
	local isCorrectLogType = false
	for _, v in ipairs( logTypes ) do
		if v == logtype then
			isCorrectLogType = true
			break
		end
	end
	
	if not isCorrectLogType then
		outputDebugString( "[DayZ Logs] Error in 'returnLog' function. Wrong log type '".. logtype .."'!" )
		return false
	end

	local file = fileOpen( "logs/".. logtype .. ".log" )
	local size = fileGetSize( file )
	local buf = fileRead( file, size )
	fileClose( file )
	return buf
end


addEventHandler("onResourceStart", resourceRoot,
	function()
		for _, typeLog in ipairs( logTypes )do
			local logFile = "logs/" .. typeLog .. ".log"
			if not fileExists( logFile ) then
				outputDebugString( "[DayZ Logs] File: " .. logFile .. " not found. " )
				local newFile = fileCreate( logFile )
				if not newFile then
					outputDebugString( "[DayZ Logs] File: cannot create file " .. logFile .. "." )	
				else
					outputDebugString( "[DayZ Logs] File: " .. logFile .. " has been created." )
				end
				fileClose( newFile )
			end
		end
	end
)

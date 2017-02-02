--[[
	Author: CiBeR
	Version: 0.3
	Copyright: DayZ Gamemode. All rights reserved to Developers
	Current Devs: Lawliet, CiBeR, Jboy
	
]]--

local logTypes = { "admin", "debug", "updates", "accounts", "game", "chat" }

function isCorrectLogType(logtype)
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
end

function fileLog(logtype,tstring)
	local file = fileOpen("logs/".. logtype .. ".log")
	local size = fileGetSize( file )
	if tstring then
		local set = fileSetPos( file, size )
		local writ = fileWrite( file, tstring )
		local ret = true
	else
		local ret = fileRead( file, size )
	end
	fileClose( file )
	return ret
end


function saveLog( tstring, logtype )	
	if isCorrectLogType(logtype) ~= false then
		return fileLog(logtype,tstring)
	else
		return false
	end
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

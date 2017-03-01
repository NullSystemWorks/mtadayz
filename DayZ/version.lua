--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: version.lua						    *----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]


local timer
local checkType = "stable" -- stable = Only check for stable versions; beta = check for most recent version (including unstables)
version = "0.9.9a"

addEventHandler("onResourceStart",resourceRoot,
function()
	checkVersion()
	timer = setTimer(checkVersion,60000*60,0) --Update hourly [It help to avoid overcharging from GitHub API]
end)

function checkVersion()
	if (checkType == "stable") then
		fetchRemote("https://api.github.com/repos/ciber96/mtadayz/releases/latest",onVersionReturn)
	elseif (checkType == "beta") then
		fetchRemote("https://api.github.com/repos/ciber96/mtadayz/releases",onVersionReturn)
	end
end

function onVersionReturn(json)
	v = fromJSON(json)
	if (json == "ERROR" or not v["name"]) then
		outputServerLog("[DayZ] Can't check for updates")
		return
	end
	local new = ""
	local old = ""
	local index1 = string.find(v["name"],"a")
	local index2 = string.find(version,"a")
	if not index1 then
		index1 = tonumber(string.len(v["name"]))+1
	end
	if not index2 then
		index2 = tonumber(string.len(version))+1
	end
	
	for num in string.gmatch(string.sub(v["name"],0,index1-1),".") do
		if(num ~= ".") then
			if(num == " ") then
				break;
			end
			new = new..num
		end
	end
	for num in string.gmatch(string.sub(version,0,index2-1),".") do
		if(num ~= ".") then
			if(num == " ") then
				break;
			end
			old = old..num
		end
	end
	-- most recent = 0.9.9 // current = 0.9.8.1 (0.9.8.1 > 0.9.9 = false)
	if (tonumber(new) > tonumber(old)) and (string.len(tostring(old)) == string.len(tostring(new))) then -- that conversion system is to avoid appointment to older versions when the most recent wasn't released
		return onVersionCheck(false,version,v["name"],v["body"])
	elseif (string.len(tostring(old)) ~= string.len(tostring(new))) then -- Check the most recent version in a situation like: Most recent: 0.9.9a; Actual: 0.9.8.1a
		local sactual = tostring(old)
		local snew = tostring(new)
		local draw = 0
		if(string.len(sactual) > string.len(snew)) then
			for i=0,string.len(snew)-1,1 do
				if(tonumber(string.sub(snew,i,i+1))) > tonumber(string.sub(sactual,i,i+1)) then
					return onVersionCheck(false,version,v["name"],v["body"])
				end
			end
		else
			for i=0,string.len(sactual)-1,1 do
				if(tonumber(string.sub(snew,i,i+1))) > tonumber(string.sub(sactual,i,i+1)) then
					return onVersionCheck(false,version,v["name"],v["body"])
				end
			end
		end
	end
	if(tonumber(new) == tonumber(old)) then -- Check if version is same and has a newer version that modifies only a letter / Ex: New: 0.9.8.1a and current: 0.9.8.1 and vice-versa.
		if (string.len(tostring(version)) ~= string.len(tostring(v["name"]))) then
			return onVersionCheck(false,version,v["name"],v["body"])
		end
	end
	
	return onVersionCheck(true)
end

--onVersionCheck: Simplified way of calling ServerLog rather than repeating the same functionality 4 times, resulting in smaller script (and you can just call it if you need another if statement) (1B0Y)
function onVersionCheck(state,old,new,changes)
	if not state then
		outputServerLog("[DayZ] A new version of MTA DayZ is available!")
		outputServerLog("[DayZ] Current Version: "..version.." | New Version: "..v["name"])
		outputServerLog("[DayZ] Some changes: \n"..v["body"])
		outputServerLog("[DayZ] Download the new version at https://github.com/mtadayz/MTADayZ/releases")
	else
		outputServerLog("[DayZ] MTA DayZ is up-to-date.")
	end
	
	return true
end
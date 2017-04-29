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
version = "v0.9.9a"

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
	if (json == "ERROR" or not v["tag_name"]) then
		outputServerLog("[DayZ] Can't check for updates")
		return
	end
	local new = ""
	local old = ""
	if string.find(v["tag_name"],"a") then
		v["tag_name"] = string.gsub(v["tag_name"],"a","")
	end
	if string.find(version,"a") then
		version = string.sub(version,0,string.len(version)-1)
	end
	if string.find(v["tag_name"],"v") then
		v["tag_name"] = string.gsub(v["tag_name"],"v","")
	end
	if string.find(version,"v") then
		version = string.gsub(version,"v","")
	end
	for num in string.gmatch(string.sub(v["tag_name"],0,string.len(v["tag_name"])),".") do
		if(num ~= ".") then
			if(num == " ") then
				break;
			end
			new = new..num
		end
	end
	for num in string.gmatch(string.sub(version,0,string.len(version)),".") do
		if(num ~= ".") then
			if(num == " ") then
				break;
			end
			old = old..num
		end
	end
	--outputServerLog(old..":"..new)
	-- most recent = 0.9.9 // current = 0.9.8.1 (0.9.8.1 > 0.9.9 = false)
	if (tonumber(new) > tonumber(old)) and (string.len(tostring(old)) == string.len(tostring(new))) then -- that conversion system is to avoid appointment to older versions when the most recent wasn't released
		return onVersionCheck(false,version,v["tag_name"],v["body"])
	elseif (string.len(tostring(old)) ~= string.len(tostring(new))) then -- Check the most recent version in a situation like: Most recent: 0.9.9a; Actual: 0.9.8.1a
		local sactual = tostring(old)
		local snew = tostring(new)
		local draw = 0
		if(string.len(sactual) > string.len(snew)) then
			for i=0,string.len(snew),1 do
				if(tonumber(string.sub(snew,i,i+1))) > tonumber(string.sub(sactual,i,i+1)) then
					return onVersionCheck(false,version,v["tag_name"],v["body"])
				end
			end
		else 
			return onVersionCheck(false,version,v["tag_name"],v["body"])
		end
	end
	if(tonumber(new) == tonumber(old)) then -- Check if version is same and has a newer version that modifies only a letter / Ex: New: 0.9.8.1a and current: 0.9.8.1 and vice-versa.
		if (string.len(tostring(version)) ~= string.len(tostring(v["tag_name"]))) then
			return onVersionCheck(false,version,v["tag_name"],v["body"])
		end
	end
	
	return onVersionCheck(true)
end

--onVersionCheck: Simplified way of calling ServerLog rather than repeating the same functionality 4 times, resulting in smaller script (and you can just call it if you need another if statement) (1B0Y)
function onVersionCheck(state,old,new,changes)
	if not state then
		outputServerLog("[DayZ] A new version of MTA DayZ is available!")
		outputServerLog("[DayZ] Current Version: "..version.." | New Version: "..new)
		outputServerLog("[DayZ] Some changes: \n "..changes)
		outputServerLog("\n[DayZ] Download the new version at https://github.com/mtadayz/MTADayZ/releases")
	else
		outputServerLog("[DayZ] MTA DayZ is up-to-date.")
	end
	
	return true
end




------------------------------------ AUTOUPDATER
local lastCommit = "c10d90f46e7b38a12b082ac97acdd71b8ea1bc79"
local commits = nil

addEventHandler("onResourceStop",resourceRoot,function()
	local file = fileCreate("SHA.commit")
	fileWrite(file,tostring(lastCommit))
	fileClose(file)
end)

addEventHandler("onResourceStart",resourceRoot,function()
	if fileExists("SHA.commit") then
		local file = fileOpen("SHA.commit",true)
		local rd = fileRead(file,500)
		fileClose(file)
		if string.len(rd) == 40 then
			lastCommit = rd
		end
	end
end)

function init(player, cmd)
	if (hasObjectPermissionTo(player, "command.banPlayer")) then
		outputChatBox("[DayZ] Starting Update.... Check server console for more informations.", player)
		if (checkType == "stable") then
			fetchRemote("https://api.github.com/repositories/82748264/commits?sha=stable",detectChanges)
		elseif (checkType == "beta") then
			fetchRemote("https://api.github.com/repositories/82748264/commits",detectChanges)
		end
	else
		outputChatBox("[DayZ] You don't have permissions to execute this action", player)
	end
end
addCommandHandler("dayzupdate",init)

function detectChanges(json,err)
	if err == 0 then
		local tbl = {fromJSON(json)}
		commits = {}
		for i, all in ipairs(tbl) do
			table.insert(commits,all["sha"])
			if all["sha"] == lastCommit then
				initUpdate(i-1) -- download all except current release
				break
			end
		end
		lastCommit = tbl[1]["sha"]
	end
end

function initUpdate(changesCount)
	if commits and changesCount > 0 then
		outputServerLog("[DayZ] Starting download...")
		for i,all in ipairs(commits) do
			if (checkType == "stable") then
				fetchRemote("https://api.github.com/repos/ciber96/mtadayz/commits/"..all.."?sha=stable",startDownload,"",false,all)
			elseif (checkType == "beta") then
				fetchRemote("https://api.github.com/repos/ciber96/mtadayz/commits/"..all,startDownload,"",false,all)
			end
		end
	else
		onVersionCheck(true)
	end
end

local totalFiles = 0
function startDownload(json, err, commitSHA)
	if err == 0 then
		local files = fromJSON("["..json.."]")
		files = files["files"]
		if files then
			for i, all in ipairs(files) do
				if all["status"] == "removed" then
					download("",0,all["filename"],"removed")
				else
					fetchRemote("https://raw.githubusercontent.com/ciber96/mtadayz/"..commitSHA.."/"..all["filename"],download,"",false,all["filename"],all["status"], i, #files)
				end
			end
		end
	end
end

local commitsDownloaded = 0
function download(DATA, err, path, status, downloadIndex, totalFiles)
	if err == 0 then
		if((downloadIndex/totalFiles) == 1) then
			commitsDownloaded = commitsDownloaded+1
			outputServerLog("[DayZ] AutoUpdater: Download "..math.round(tostring((commitsDownloaded/#commits)*100),2).."% completed")
		end
		if commitsDownloaded == #commits then
			outputServerLog("[DayZ] Download completed")
		end
		if string.find(path,"/") then
			path = ":"..path
		end
		if string.find(path,"login") then -- That's to avoid line 246 and 247 (database_credentials_protection is to protect resources with MySQL usage)
			exports["login"]:createfile(DATA,path,status)
		end
		if status == "removed" then
			if fileExists(path) then
				fileDelete(path)
			end
		else
			local fileHandler = fileCreate(path)
			if fileHandler then
				fileWrite(fileHandler,DATA)
				fileClose(fileHandler)
			else
				outputServerLog("[DayZ AutoUpdater] You need to set database_credentials_protection (mtaserver.conf) to 0 to use autoupdater correctly")
				outputServerLog("[DayZ AutoUpdater] For your security, we hightly recommend to set it back to 1 after update")
			end
		end
	end
end
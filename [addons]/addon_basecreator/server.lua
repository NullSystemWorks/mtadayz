--[[

	Author: CiBeR
	Version: 0.1
	Copyright: DayZ Gamemode. All rights reserved to Developers
	Info: MTA:DayZ Base Creation Addon
	Current Devs: Lawliet, CiBeR, Jboy, Remi, Renkon
	
]]--
local db
local count = 0
function onStart()
	if not fileExists("db/bases.db") then
		local h = fileCreate("db/bases.db")
		if h then
		fileClose(h)
		outputDebugString("[DayZ] Bases database not found, creating...")
		end
		db = dbConnect( "sqlite", "db/bases.db" )
		outputDebugString("[DayZ] Inserting tables into database...")
		dbExec(db, "CREATE TABLE IF NOT EXISTS base_objects(id INT AUTO_INCREMENT, model INT, owner VARCHAR, x FLOAT, y FLOAT, z FLOAT, rx FLOAT, ry FLOAT, rz FLOAT)")
		outputDebugString("[DayZ] Tables inserted.")
	else
		db = dbConnect( "sqlite", "db/bases.db" )
		local qh = dbQuery( db, "SELECT * FROM base_objects" )
		local result = dbPoll( qh, 10000 )
			for i, ob in ipairs(result) do
				local tOb = createObject(ob['model'], ob['x'], ob['y'], ob['z'], ob['rx'], ob['ry'], ob['rz'])
				setTimer(function()
					triggerClientEvent("setTheObjectUnbreakable",root,tOb)
				end,1000,1,tOb)
				setElementData(tOb, "bc.creator", ob['owner'])
				setElementData(tOb, "bc.ID", ob['id'])
				count = count + 1
			end
			outputDebugString("[DayZ] Base objects loaded. TOTAL: "..tostring(count))
	end
end
addEventHandler("onResourceStart", resourceRoot, onStart)

function newObject(model,x,y,z,rx,ry,rz)
	if model and x and y and z and rx and ry and rz then
		local ob = createObject(model, x, y, z, rx, ry, rz)
		local acName = getAccountName(getPlayerAccount(client))
		setElementData(ob, "bc.creator", acName)
		triggerClientEvent("setTheObjectUnbreakable",root,ob)
		if ob then
			local x,y,z = getElementPosition(ob)
			local rx,ry,rz = getElementRotation(ob)
			local model = getElementModel(ob)
			dbExec(db, "INSERT INTO base_objects VALUES (?,?,?,?,?,?,?,?,?)", 0, model, acName, x, y, z, rx, ry, rz)
		else
		
		end
	end
end
addEvent("addon.basecreator:newObject", true)
addEventHandler("addon.basecreator:newObject", root, newObject)
--[[

	Author: CiBeR
	Version: 0.1
	Copyright: DayZ Gamemode. All rights reserved to Developers
	Info: MTA:DayZ Base Creation Addon
	Current Devs: Lawliet, CiBeR, Jboy, Remi, Renkon
	
]]--
local db
local count = 0
local DoorsTable = {}
function onStart()
	if not fileExists("db/bases.db") then
		local h = fileCreate("db/bases.db")
		if h then
		fileClose(h)
		outputDebugString("[DayZ] Bases database not found, creating...")
		end
		db = dbConnect( "sqlite", "db/bases.db" )
		outputDebugString("[DayZ] Inserting tables into database...")
		dbExec(db, "CREATE TABLE IF NOT EXISTS base_objects(id INT AUTO_INCREMENT, model INT, owner VARCHAR, x FLOAT, y FLOAT, z FLOAT, rx FLOAT, ry FLOAT, rz FLOAT, health FLOAT, encampment VARCHAR)")
		outputDebugString("[DayZ] Tables inserted.")
	else
		db = dbConnect( "sqlite", "db/bases.db" )
		local qh = dbQuery( db, "SELECT * FROM base_objects" )
		local result = dbPoll( qh, 10000 )
			for i, ob in ipairs(result) do
				local tOb = createObject(ob['model'], ob['x'], ob['y'], ob['z'], ob['rx'], ob['ry'], ob['rz'])
				setTimer(function()
					if ob['health'] > 0 then
						triggerClientEvent("setTheObjectUnbreakable",root,tOb)
					end
				end,1000,1,tOb)
				setElementData(tOb, "bc.creator", ob['owner'])
				setElementData(tOb, "bc.ID", ob['id'])
				if ob['model'] == 3093 or ob['model'] == 3029 then
					setupDoor(tOb,ob['encampment'])
				end
				setElementData(tOb,"object.health",ob['health'])
				if getElementData(tOb,"object.health") <= 0 then
					if getElementData(tOb,"parent") then
						destroyElement(getElementData(tOb,"parent"))
					end
					destroyElement(tOb)
				end
				count = count + 1
			end
			outputDebugString("[DayZ] Base objects loaded. TOTAL: "..tostring(count))
	end
end
addEventHandler("onResourceStart", resourceRoot, onStart)

function newObject(model,x,y,z,rx,ry,rz,health)
	if model and x and y and z and rx and ry and rz then
		local ob = createObject(model, x, y, z, rx, ry, rz)
		local acName = getAccountName(getPlayerAccount(client))
		setElementData(ob, "bc.creator", acName)
		setElementData(ob,"object.health",health)
		triggerClientEvent("setTheObjectUnbreakable",root,ob)
		local encampment = getElementData(client,"Group")
		if model == 3093 or model == 3029 then
			setupDoor(ob,encampment)
		end
		if ob then
			local x,y,z = getElementPosition(ob)
			local rx,ry,rz = getElementRotation(ob)
			local model = getElementModel(ob)
			count = count+1
			dbExec(db, "INSERT INTO base_objects VALUES (?,?,?,?,?,?,?,?,?,?,?)", count, model, acName, x, y, z, rx, ry, rz, health, tostring(encampment))
		end
	end
end
addEvent("addon.basecreator:newObject", true)
addEventHandler("addon.basecreator:newObject", root, newObject)

function onObjectDamage(object,health,id)
	if object then
		dbExec(db,'UPDATE base_objects SET health=? WHERE id=?',health,id)
	end
end
addEvent("onObjectDamage",true)
addEventHandler("onObjectDamage",root,onObjectDamage)

function onObjectDestroy(object,id)
	if object then
		dbExec(db,"DELETE FROM base_objects WHERE id=?",id)
		if getElementData(object,"parent") then
			destroyElement(getElementData(object,"parent"))
		end
		destroyElement(object)
		count = count-1
	end
end
addEvent("onObjectDestroy",true)
addEventHandler("onObjectDestroy",root,onObjectDestroy)

function setupDoor(object,encampment)
	local x,y,z = getElementPosition(object)
	local rx,ry,rz = getElementRotation(object)
	local col = createColSphere(x,y,z,2)
	setElementData(object,"parent",col)
	setElementData(col,"parent",object)
	DoorsTable[col] = {pos = {x = x,y = y,z = z}, rot= {x = rx,y = ry,z = rz}, col = col, camp = encampment, door = object}
end

function closeDoorForReal(doorCol)
	local data = DoorsTable[doorCol]
	setElementRotation(data.door,data.rot.x,data.rot.y,data.rot.z)
end
	
function closeDoor(doorCol)
	local data = DoorsTable[doorCol]
	moveObject(data.door,2000,data.pos.x,data.pos.y,data.pos.z,0,0,-90)
	setTimer(closeDoorForReal,2050,1,doorCol)
end

function openDoor(hitElement)
	local data = DoorsTable[source]
	if data == nil then return end
	local rx,ry,rz=getElementRotation(data["door"])
	if getElementData(hitElement,"Group") == data["camp"] or data.camp == "false" or not data["camp"] then
		moveObject(data["door"],2000,data.pos.x,data.pos.y,data.pos.z,0,0,90)
		setTimer(closeDoor,5000,1,source)
	end
end
addEventHandler("onColShapeHit",resourceRoot,openDoor)
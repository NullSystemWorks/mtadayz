--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: vehicles_init.lua						*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]



-- Vehicles
ATV_Spawns = gameplayVariables["atvspawns"]
Bus_Spawns = gameplayVariables["busspawns"]
Bike_Spawns = gameplayVariables["bikespawns"]
GAZ_Spawns = gameplayVariables["gazspawns"]
MilitaryO_Spawns = gameplayVariables["militaryoffroadspawns"]
Motorcycle_Spawns = gameplayVariables["motorcyclespawns"]
PickupO_Spawns = gameplayVariables["pickupoffroadspawns"]
Hatchback_Spawns = gameplayVariables["hatchbackspawns"]
Pickup_Spawns = gameplayVariables["pickupspawns"]
SVan_Spawns = gameplayVariables["svanspawns"]
Skoda_Spawns = gameplayVariables["skodaspawns"]
Tractor_Spawns = gameplayVariables["tractorspawns"]
UAZ_Spawns = gameplayVariables["uazspawns"]
UralC_Spawns = gameplayVariables["uralcivilianspawns"]
SUV_Spawns = gameplayVariables["suvspawns"]
V3SC_Spawns = gameplayVariables["v3scivilianspawns"]

-- Aircraft
AH6XLB_Spawns = gameplayVariables["ah6xspawns"]
UH1HHuey_Spawns = gameplayVariables["hueyspawns"]
Mi17_Spawns = gameplayVariables["mi17spawns"]
MH6J_Spawns = gameplayVariables["mh6jspawns"]
An2BP_Spawns = gameplayVariables["an2biplanespawns"]

-- Boats
FishingBoat_Spawns = gameplayVariables["fishingboatspawns"]
SmallBoat_Spawns = gameplayVariables["smallboatspawns"]
PBX_Spawns = gameplayVariables["pbxspawns"]

-- Others
tentSpawns = gameplayVariables["tentsspawns"]

addEventHandler("onResourceStart",getResourceRootElement(getThisResource()), function()
	local vehicleManager = getAccount("vehicleManager","ds4f9$")
	if not vehicleManager then
		addAccount("vehicleManager","ds4f9$")
	end
	vehicledatabase = dbConnect("sqlite", "database/vehicles.db","","","share=0")
	tentdatabase = dbConnect("sqlite", "database/tents.db","","","share=0")
	local vehicle_table = dbExec(vehicledatabase, "CREATE TABLE IF NOT EXISTS vehicles (model INT, Veh_Health FLOAT, last_x FLOAT, last_y FLOAT, last_z FLOAT, last_rX FLOAT, last_rY FLOAT, last_rZ FLOAT, MAX_Slots INT, fuel FLOAT, Tire_inVehicle INT, Engine_inVehicle INT, Parts_inVehicle INT, Scrap_inVehicle INT, Glass_inVehicle INT, Rotary_inVehicle INT, vehicle_name TEXT, ColSize FLOAT, ID INT, initial_X FLOAT, initial_Y FLOAT, initial_Z FLOAT)")
	local tent_table = dbExec(tentdatabase, "CREATE TABLE IF NOT EXISTS tents (model INT, last_x FLOAT, last_y FLOAT, last_z FLOAT, last_rX FLOAT, last_rY FLOAT, last_rZ FLOAT, MAX_Slots INT, objectscale FLOAT, ColsphereSize FLOAT, Owner TEXT)")
	if vehicledatabase and tentdatabase then
		outputServerLog("[DayZ] CONNECTED TO VEHICLE DATABASE.")
		outputServerLog("[DayZ] CONNECTED TO TENTS DATABASE.")
	else
		outputServerLog("[DayZ] FAILED TO CONNECT TO DATABASE 'vehicles' and 'tents'. CHECK IF THEY EXIST.")
	end	
end)


theItems = {}
theTentItems = {}

function saveVehiclesToDB()
    dbExec(vehicledatabase, "DROP TABLE vehicles")
    dbExec(vehicledatabase, "CREATE TABLE IF NOT EXISTS vehicles (model INT, Veh_Health FLOAT, last_x FLOAT, last_y FLOAT, last_z FLOAT, last_rX FLOAT, last_rY FLOAT, last_rZ FLOAT, MAX_Slots INT, fuel FLOAT, Tire_inVehicle INT, Engine_inVehicle INT, Parts_inVehicle INT, Scrap_inVehicle INT, Glass_inVehicle INT, Rotary_inVehicle INT, vehicle_name TEXT, ColSize FLOAT, ID INT, initial_X FLOAT, initial_Y FLOAT, initial_Z FLOAT)")
    for i, data in ipairs(vehicleDataTable) do
		dbExec(vehicledatabase,'ALTER TABLE vehicles ADD "'..data[1]..'" INT')
	end
	for i, col in ipairs(getElementsByType("colshape")) do
		local veh = getElementData(col,"vehicle")
		local tent = getElementData(col,"tent")
		if veh and not tent then
			local vehicle = getElementData(col,"parent")
			local model = getElementModel(vehicle)
			local veh_health = getElementHealth(vehicle)
			local x, y, z = getElementPosition(vehicle)
			local rotx, roty, rotz = getElementRotation(vehicle)
			local slots = getElementData(getElementData(vehicle, "parent"), "MAX_Slots") or 0
			local fuel = getElementData(getElementData(vehicle, "parent"), "fuel") or 0
			local tires = getElementData(getElementData(vehicle, "parent"), "Tire_inVehicle")
			local engines = getElementData(getElementData(vehicle, "parent"), "Engine_inVehicle") or 0
			local parts = getElementData(getElementData(vehicle, "parent"), "Parts_inVehicle") or 0
			local scrap = getElementData(getElementData(vehicle, "parent"), "Scrap_inVehicle") or 0
			local glass = getElementData(getElementData(vehicle, "parent"), "Glass_inVehicle") or 0
			local rotary = getElementData(getElementData(vehicle, "parent"), "Rotary_inVehicle") or 0
			local name = getElementData(getElementData(vehicle,"parent"),"vehicle_name") or getVehicleName(model)
			local veh_ID = getElementID(getElementData(vehicle,"parent"))
			local model2, initial_X, initial_Y, initial_Z = getElementData(getElementData(vehicle,"parent"),"spawn")[1],getElementData(getElementData(vehicle,"parent"),"spawn")[2],getElementData(getElementData(vehicle,"parent"),"spawn")[3],getElementData(getElementData(vehicle,"parent"),"spawn")[4]
			local tires2,engine2,parts2,scrap2,glass2,rotary2,name2,colsphere,slots2,fuel2 = getVehicleAddonInfos(model)
			dbExec(vehicledatabase, "INSERT INTO vehicles (model, Veh_Health, last_x, last_y, last_z, last_rX, last_rY, last_rZ, MAX_Slots, fuel, Tire_inVehicle, Engine_inVehicle, Parts_inVehicle, Scrap_inVehicle, Glass_inVehicle, Rotary_inVehicle, vehicle_name, ColSize, ID, initial_X, initial_Y, initial_Z) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", model, veh_health, x, y, z, rotx, roty, rotz, slots, fuel, tires, engines, parts, scrap, glass, rotary, name, colsphere, veh_ID, initial_X, initial_Y, initial_Z)
			for key,item in ipairs(vehicleDataTable) do
				local itemAmount = getElementData(col, item[1]) or 0
				dbExec(vehicledatabase, 'UPDATE vehicles SET "'..item[1]..'"=? WHERE ID=?',itemAmount,veh_ID)
			end
		end
	end
	outputServerLog("[DayZ] VEHICLES HAVE BEEN SAVED TO THE DATABASE.")
end
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), saveVehiclesToDB)

function createBackupOfVehicles(playerSource,command)
	if gameplayVariables["backupenabled"] then
		if hasObjectPermissionTo (playerSource, "command.mute") then
			outputServerLog("[DayZ] CREATING BACKUP OF VEHICLES...")
			saveVehiclesToDB()
		else
			outputChatBox("You are not allowed to use this command!",playerSource,255,0,0)
		end
	else
		outputChatBox("Backup for vehicles is turned off!",playerSource,255,0,0)
	end
end
addCommandHandler("backup",createBackupOfVehicles)

function createBackupOfVehiclesOnInterval()
	if gameplayVariables["backupenabled"] then
		outputServerLog("[DayZ] CREATING BACKUP OF VEHICLES...")
		saveVehiclesToDB()
	end
end
setTimer(createBackupOfVehiclesOnInterval,gameplayVariables["backupinterval"],0)

local v_counter = 0
function createVehiclesFromDB(model, Veh_Health, last_x, last_y, last_z, last_rX, last_rY, last_rZ, MAX_Slots, fuel, Tire_inVehicle, Engine_inVehicle, Parts_inVehicle, Scrap_inVehicle, Glass_inVehicle, Rotary_inVehicle, vehicle_name, ColSize, ID, theItems, initial_X, initial_Y, initial_Z)
	local veh = createVehicle(model, last_x, last_y, last_z, last_rX, last_rY, last_rZ)
    local vehCol = createColSphere(last_x, last_y, last_z, tonumber(ColSize))
    attachElements(vehCol, veh, 0, 0, 0)
    setElementData(vehCol, "parent", veh)
    setElementData(veh, "parent", vehCol)
    setElementData(vehCol,"vehicle", true)
    setElementData(vehCol,"MAX_Slots",tonumber(MAX_Slots))
    setElementData(vehCol,"Tire_inVehicle",tonumber(Tire_inVehicle))
    setElementData(vehCol,"Engine_inVehicle",tonumber(Engine_inVehicle))
    setElementData(vehCol,"Parts_inVehicle",tonumber(Parts_inVehicle))
	setElementData(vehCol,"Scrap_inVehicle",tonumber(Scrap_inVehicle))
	setElementData(vehCol,"Glass_inVehicle",tonumber(Glass_inVehicle))
	setElementData(vehCol,"Rotary_inVehicle",tonumber(Rotary_inVehicle))
    setElementData(vehCol, "spawn", {model, initial_X, initial_Y, initial_Z})
    setElementData(vehCol, "fuel", tonumber(fuel))
	setElementID(vehCol, tostring(ID))
	if tonumber(ID) >= tonumber(v_counter) then -- Optimization to avoid search in other loop
		v_counter = tonumber(ID)+1
	end
	setElementData(vehCol,"vehicle_name",tostring(vehicle_name))
	setElementHealth(veh,tonumber(Veh_Health))
    for i, data in ipairs(theItems) do
		if getElementID(vehCol) == tostring(data[1]) then
			setElementData(vehCol, tostring(data[2]),tonumber(data[3]))
		end
	end
end

function loadVehiclesFromDB(q)
    if (q) then
        local p = dbPoll( q, -1 )
        if (#p > 0) then
            for _, d in pairs (p) do
				for i,item in ipairs(vehicleDataTable) do
					if d[item[1]] then
						table.insert(theItems,{d["ID"],item[1],d[item[1]]})
					end
				end
				createVehiclesFromDB( d["model"], d["Veh_Health"], d["last_x"], d["last_y"], d["last_z"], d["last_rX"], d["last_rY"], d["last_rZ"], d["MAX_Slots"], d["fuel"], d["Tire_inVehicle"], d["Engine_inVehicle"], d["Parts_inVehicle"], d["Scrap_inVehicle"], d["Glass_inVehicle"], d["Rotary_inVehicle"], d["vehicle_name"], d["ColSize"], d["ID"], theItems, d["initial_X"], d["initial_Y"], d["initial_Z"])
			end
        end
    end
end

function loadVehiclesOnServerStart()
	dbQuery(loadVehiclesFromDB, { }, vehicledatabase, "SELECT * FROM vehicles")
	outputServerLog("[DayZ] VEHICLES HAVE BEEN LOADED.")
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), loadVehiclesOnServerStart)

function saveTentsToDB()
    dbExec(tentdatabase, "DROP TABLE tents")
    dbExec(tentdatabase, "CREATE TABLE IF NOT EXISTS tents (model INT, last_x FLOAT, last_y FLOAT, last_z FLOAT, last_rX FLOAT, last_rY FLOAT, last_rZ FLOAT, MAX_Slots INT, objectscale FLOAT, ColsphereSize FLOAT, Owner TEXT)")
    for i, data in ipairs(tentTable) do
		dbExec(tentdatabase,'ALTER TABLE tents ADD "'..data[1]..'" INT')
	end
	for i, col in ipairs(getElementsByType("colshape")) do
        local isTent = getElementData(col, "tent")
        if isTent then
            local theTent = getElementData(col,"parent")
            local x,y,z = getElementPosition(theTent)
            local rx,ry,rz = getElementRotation(theTent)
            local model = getElementModel(theTent)
            local MAX_Slots = getElementData(getElementData(theTent,"parent"),"MAX_Slots") or 100
            local scale = getObjectScale(theTent)
			local owner = getElementID(getElementData(theTent,"parent"))
            dbExec(tentdatabase, "INSERT INTO tents (model, last_x, last_y, last_z, last_rX, last_rY, last_rZ, MAX_Slots, objectscale, ColSphereSize, Owner) VALUES(?,?,?,?,?,?,?,?,?,?,?)", model, x, y, z, rx, ry, rz, MAX_Slots, scale, 4, owner)
            for key,item in ipairs(tentTable) do
				local itemAmount = getElementData(getElementData(theTent,"parent"), item[1]) or 0
				dbExec(tentdatabase, 'UPDATE tents SET "'..item[1]..'"=? WHERE Owner=?',itemAmount,owner)
			end
        end
    end
	outputServerLog("[DayZ] TENTS HAVE BEEN SAVED TO DATABASE.")
end
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), saveTentsToDB)

function createTentsFromDB(model, last_x, last_y, last_z, last_rX, last_rY, last_rZ, MAX_Slots, objectscale, ColSphereSize, Owner, theTentItems)
	local tent = createObject(model, last_x, last_y, last_z, last_rX, last_rY, last_rZ)
    local tentCol = createColSphere(last_x, last_y, last_z, 4)
    attachElements(tentCol, tent, 0, 0, 0)
	setObjectScale(tent,objectscale)
    setElementData(tentCol, "parent", tent)
    setElementData(tent, "parent", tentCol)
    setElementData(tentCol,"vehicle", true)
	setElementData(tentCol,"tent",true)
    setElementData(tentCol,"MAX_Slots",tonumber(MAX_Slots))
	setElementID(tentCol, tostring(Owner))
    for i, data in ipairs(theTentItems) do
		if getElementID(tentCol) == tostring(data[1]) then
			setElementData(tentCol, tostring(data[2]),tonumber(data[3]))
		end
	end
end

function loadTentsFromDB(q)
    if (q) then
        local p = dbPoll( q, -1 )
        if (#p > 0) then
            for _, d in pairs (p) do
				for i,item in ipairs(tentTable) do
					if d[item[1]] then
						table.insert(theTentItems,{d["Owner"],item[1],d[item[1]]})
					end
				end
				createTentsFromDB( d["model"], d["last_x"], d["last_y"], d["last_z"], d["last_rX"], d["last_rY"], d["last_rZ"], d["MAX_Slots"], d["objectscale"],  d["ColSphereSize"], d["Owner"], theTentItems)
			end
        end
    end
end

function loadTentsOnServerStart()
	dbQuery(loadTentsFromDB, { }, tentdatabase, "SELECT * FROM tents")
	outputServerLog("[DayZ] TENTS HAVE BEEN LOADED.")
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), loadTentsOnServerStart)


function spawnDayZVehicles()
if getAccount("vehicleManager") and getAccountData(getAccount("vehicleManager"),"serverhasloadvehicles") then return end
	for i,veh in ipairs(vehicleAddonsInfo) do
		local modelID = veh[1]
		local tires = veh[2]
		local engine = veh[3]
		local parts = veh[4]
		local scrap = veh[5]
		local glass = veh[6]
		local rotary = veh[7]
		local name = veh[8]
		local colSphereRadius = veh[9]
		local maxslots = veh[10]
		local fuel = veh[11]
		local varName = veh[13]
		local veh
		local vehCol
		local x,y,z
		local rX,rY,rZ
		for k, spawnpos in ipairs(gameplayVariables[varName.."spawns"]) do
			local spawnChance = math.percentChance(spawnpos[7],8)
			if spawnChance and spawnChance >= 1 then
				v_counter = v_counter+1
				x,y,z = spawnpos[1],spawnpos[2],spawnpos[3]
				rX,rY,rZ = spawnpos[4],spawnpos[5],spawnpos[6]
				veh = createVehicle(modelID,x,y,z,rX,rY,rZ)
				vehCol = createColSphere(x,y,z,colSphereRadius)
				attachElements ( vehCol, veh, 0, 0, 0 )
				setElementData(vehCol,"parent",veh)
				setElementData(veh,"parent",vehCol)
				setElementData(vehCol,"vehicle",true)
				setElementData(vehCol,"MAX_Slots",maxslots)
				--Engine + Tires
				--getElementModel(veh)
				setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
				setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
				setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
				setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
				setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
				setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
				setElementData(vehCol,"vehicle_name",name)
				--vehicle_indentifikation	
				setElementData(vehCol,"spawn",{modelID,x,y,z})
				--others
				setElementData(vehCol,"fuel",math.random(0,fuel))
				setElementID(vehCol,tostring(v_counter))
				setElementHealth(veh,math.random(300,1000))
				setAccountData(getAccount("vehicleManager"),"serverhasloadvehicles",true)
				exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
			end
		end
	end
end
setTimer(spawnDayZVehicles,10000,1)

--[[
-- Not needed anymore, keeping it just in case
function spawnDayZVehicles()
if getAccount("vehicleManager") and getAccountData(getAccount("vehicleManager"),"serverhasloadvehicles") then return end
	for i,veh in ipairs(ATV_Spawns) do
		local number = math.percentChance(veh[7],8)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(471,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,2)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",50)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{471,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(Bus_Spawns) do	
		local number = math.percentChance(veh[7],4)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(431,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,5)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",50)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation
			setElementData(vehCol,"spawn",{431,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(Bike_Spawns) do
		local number = math.percentChance(veh[7],14)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			veh = createVehicle(509,x,y,z)
			vehCol = createColSphere(x,y,z,2)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",1)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation
			setElementData(vehCol,"spawn",{509,x,y,z})
			--others
			setElementData(vehCol,"fuel",0)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(GAZ_Spawns) do
		local number = math.percentChance(veh[7],2)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(546,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,3)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",50)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation
			setElementData(vehCol,"spawn",{546,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(Military_O_Spawns) do
		local number = math.percentChance(veh[7],2)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			veh = createVehicle(433,x,y,z)
			vehCol = createColSphere(x,y,z,4)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",50)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation
			setElementData(vehCol,"spawn",{433,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementData(vehCol,"Grenade",10)
			setElementData(vehCol,"9.3x62mm Cartridge",10)
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(Motorcycle_Spawns) do
		local number = math.percentChance(veh[7],4)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(468,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,2)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",5)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation
			setElementData(vehCol,"spawn",{468,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(Pickup_O_Spawns) do
		local number = math.percentChance(veh[7],4)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(543,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,3)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",50)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{543,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(Hatchback_Spawns) do
		local number = math.percentChance(veh[7],2)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(426,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,3)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",50)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{426,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(Pickup_Spawns) do
		local number = math.percentChance(veh[7],2)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(422,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,3)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",50)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{422,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(SVan_Spawns) do
		local number = math.percentChance(veh[7],2)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(418,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,3)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",50)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{418,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(Skoda_Spawns) do
		local number = math.percentChance(veh[7],2)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(426,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,3)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",75)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{426,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(Tractor_Spawns) do
		local number = math.percentChance(veh[7],4)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(531,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,3)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",50)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{531,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(UAZ_Spawns) do
		local number = math.percentChance(veh[7],4)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(470,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,3)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",50)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{470,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(Ural_C_Spawns) do
		local number = math.percentChance(veh[7],2)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(455,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,5)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",200)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{455,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(SUV_Spawns) do
		local number = math.percentChance(veh[7],2)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(490,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,3)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",50)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{490,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(V3S_C_Spawns) do
		local number = math.percentChance(veh[7],1)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(478,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,5)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",200)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{478,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	-- AIRCRAFT
	for i,veh in ipairs(AH6X_LB_Spawns) do
		local number = math.percentChance(veh[7],3)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(469,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,7)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",20)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{469,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(UH1H_Huey_Spawns) do
		local number = math.percentChance(veh[7],3)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(417,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,7)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",50)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{417,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(Mi17_Spawns) do
		local number = math.percentChance(veh[7],3)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(487,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,7)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",20)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{487,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(MH6J_Spawns) do
		local number = math.percentChance(veh[7],3)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(488,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,7)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",20)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{488,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(An2_BP_Spawns) do
		local number = math.percentChance(veh[7],2)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(511,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,7)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",100)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{511,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	-- BOATS
	for i,veh in ipairs(FishingBoat_Spawns) do
		local number = math.percentChance(veh[7],1)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(453,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,4)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",400)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{453,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(SmallBoat_Spawns) do
		local number = math.percentChance(veh[7],2)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(595,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,3)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",0)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{595,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,veh in ipairs(PBX_Spawns) do
		local number = math.percentChance(veh[7],1)
		if number and number >= 1 then
			v_counter = v_counter+1
			local x,y,z = veh[1],veh[2],veh[3]
			local rX,rY,rZ = veh[4],veh[5],veh[6]
			veh = createVehicle(473,x,y,z,rX,rY,rZ)
			vehCol = createColSphere(x,y,z,2)
			attachElements ( vehCol, veh, 0, 0, 0 )
			setElementData(vehCol,"parent",veh)
			setElementData(veh,"parent",vehCol)
			setElementData(vehCol,"vehicle",true)
			setElementData(vehCol,"MAX_Slots",0)
			--Engine + Tires
			local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
			setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
			setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
			setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
			setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
			setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
			setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
			setElementData(vehCol,"vehicle_name",name)
			--vehicle_indentifikation	
			setElementData(vehCol,"spawn",{473,x,y,z})
			--others
			setElementData(vehCol,"fuel",10)
			setElementID(vehCol,tostring(v_counter))
			setElementHealth(veh,math.random(300,1000))
			exports.DayZ:saveLog("Vehicle "..getVehicleName(veh).." has been created (ID: "..getElementID(vehCol)..")\r\n","debug")
		end
	end
	for i,tent in ipairs(tentSpawns) do
		v_counter = v_counter+1
		local x,y,z = tent[1],tent[2],tent[3]
		tent = createObject(3243,x,y,z-1)
		setObjectScale(tent,0.5)
		tentCol = createColSphere(x,y,z,4)
		attachElements ( tentCol, tent, 0, 0, 0 )
		setElementData(tentCol,"parent",tent)
		setElementData(tent,"parent",tentCol)
		setElementData(tentCol,"tent",true)
		setElementData(tentCol,"vehicle",true)
		setElementData(tentCol,"MAX_Slots",30)
		setElementData(tentCol,"veh_ID",v_counter)
	end
	setAccountData(getAccount("vehicleManager"),"serverhasloadvehicles",true)
	exports.DayZ:saveLog("----- END OF SPAWNING VEHICLES -----\r\n","debug")
end
--setTimer(spawnDayZVehicles,10000,1)
]]

function respawnDayZVehicle(id,x,y,z,veh,col,max_slots)
	if isElement(veh) then 
		destroyElement(veh)
	end
	if isElement(col) then
		destroyElement(col)
	end
	v_counter = v_counter+1
	veh = createVehicle(id,x,y,z+1)
	vehCol = createColSphere(x,y,z,4)
	attachElements ( vehCol, veh, 0, 0, 0 )
	setElementData(vehCol,"parent",veh)
	setElementData(veh,"parent",vehCol)
	setElementID(vehCol,tostring(v_counter))
	setElementData(vehCol,"vehicle",true)
	setElementData(vehCol,"MAX_Slots",max_slots)
	--Engine + Tires
	local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
	setElementData(vehCol,"Tire_inVehicle",math.random(0,tires))
	setElementData(vehCol,"Engine_inVehicle",math.random(0,engine))
	setElementData(vehCol,"Parts_inVehicle",math.random(0,parts))
	setElementData(vehCol,"Scrap_inVehicle",math.random(0,scrap))
	setElementData(vehCol,"Glass_inVehicle",math.random(0,glass))
	setElementData(vehCol,"Rotary_inVehicle",math.random(0,rotary))
	setElementData(vehCol,"vehicle_name",name)
	--vehicle_indentifikation
	setElementData(vehCol,"spawn",{id,x,y,z})
	--others
	setElementData(vehCol,"fuel",10)
	setElementData(veh,"isExploded",false)
	setElementData(vehCol,"deadVehicle",false)
end

-- onVehicleEngineState: Pre-sets some data for onPlayerVehicleInteract to determine if the engine is already on or not
-- As we can't correctly validate this with onVehicleEnter/Exit
function onVehicleEngineState(vehicle,state)
	if not vehicle then return end
	
	setElementData(vehicle,"engine_state",state)
end
addEventHandler("onVehicleStartEnter",root,function(player,seat) onVehicleEngineState(source,getVehicleEngineState(source)) end)

-- onPlayerVehicleInteract: Handles keeping the engine off due to a GTA bug.
function onPlayerVehicleInteract(player,seat,state)
	if state then
		if (seat ~= 0) then
			--Determine if the engine is on, otherwise don't turn the engine on for passengers (GTA engine bug?)
			if (not getElementData(source,"engine_state")) then
				setVehicleEngineState(source,false)
			end
		end
	else
		if (seat ~= 0) then return end
		if (wasEventCancelled()) then return end --Prevents engine_state being invalid in the events of onVehicleEnter/Exit being cancelled.
		
		setElementData(source,"engine_state",getVehicleEngineState(source))
	end
end
addEventHandler("onVehicleEnter",root,function(player,seat) onPlayerVehicleInteract(player,seat,true) end)
addEventHandler("onVehicleExit",root,function(player,seat) onPlayerVehicleInteract(player,seat,false) end)

--[[
#---------------------------------------------------------------#
----*			DayZ MTA Script vehicle_save.lua			*----
----* This Script is owned by Marwin, you are not allowed to use or own it.
----* Owner: Marwin W., Germany, Lower Saxony, Otterndorf
----* Skype: xxmavxx96
----*														*----
#---------------------------------------------------------------#
]]

itemsDataTable = {
	{"M4"},
	{"CZ 550"},
	{"Winchester 1866"},
	{"SPAZ-12 Combat Shotgun"},
	{"Sawn-Off Shotgun"},
	{"AK-47"},
	{"Lee Enfield"},
	{"Sporter 22"},
	{"Mosin 9130"},
	{"Crossbow"},
	{"SKS"},
	{"Blaze 95 Double Rifle"},
	{"Remington 870"},
	{"FN FAL"},
	{"G36C"},
	{"Sa58V CCO"},
	{"SVD Dragunov"},
	{"DMR"},
	{"M1911"},
	{"M9 SD"},
	{"PDW"},
	{"G17"},
	{"MP5A5"},
	{"Desert Eagle"},
	{"Bizon PP-19"},
	{"Revolver"},
	{"Hunting Knife"},
	{"Hatchet"},
	{"Baseball Bat"},
	{"Shovel"},
	{"Golf Club"},
	{"Machete"},
	{"Crowbar"},
	{"Parachute"},
	{"Tear Gas"},
	{"Grenade"},
	{"Binoculars"},
	{"45 ACP Cartridge"},
	{"9x19mm SD Cartridge"},
	{"9x19mm Cartridge"},
	{"9x18mm Cartridge"},
	{"545x39mm Cartridge"},
	{"556x45mm Cartridge"},
	{"1866 Slug"},
	{"2Rnd Slug"},
	{"12 Gauge Pellet"},
	{"93x62mm Cartridge"},
	{"303 British Cartridge"},
	{"Bolt"},
	{"Baked Beans"},
	{"Pasta"},
	{"Sardines"},
	{"Frank_Beans"},
	{"Can (Corn)"},
	{"Can (Peas)"},
	{"Can (Pork)"},
	{"Can (Stew)"},
	{"Can (Ravioli)"},
	{"Can (Fruit)"},
	{"Can (Chowder)"},
	{"Pistachios"},
	{"Trail Mix"},
	{"MRE"},
	{"Water Bottle"},
	{"Soda Can (Pepsi)"},
	{"Soda Can (Cola)"},
	{"Soda Can (Mountain Dew)"},
	{"Can (Milk)"},
	{"Wood Pile"},
	{"Bandage"},
	{"Road Flare"},
	{"Empty Gas Canister"},
	{"Full Gas Canister"},
	{"Medic Kit"},
	{"Heat Pack"},
	{"Painkiller"},
	{"Morphine"},
	{"Blood Bag"},
	{"Wire Fence"},
	{"Raw Meat"},
	{"Tire"},
	{"Engine"},
	{"Tank Parts"},
	{"Tent"},
	{"Box of Matches"},
	{"Watch"},
	{"GPS"},
	{"Map"},
	{"Toolbox"},
	{"IR Goggles"},
	{"NV Goggles"},
	{"Cooked Meat"},
	{"Radio Device"},
	{"Compass"},
	{"Camouflage Clothing"},
	{"Civilian Clothing"},
	{"Survivor Clothing"},
	{"Ghillie Suit"},
	{"Empty Water Bottle"},
	{"Empty Soda Can"},
	{"Assault Pack (ACU)"},
	{"ALICE Pack"},
	{"British Assault Pack"},
	{"Czech Vest Pouch"},
	{"Backpack (Coyote)"},
	{"Czech Backpack"},
	{"Survival ACU"},
	{"M4 Blueprint"},
	{"CZ 550 Blueprint"},
	{"Winchester 1866 Blueprint"},
	{"SPAZ-12 C Shtgn Blueprint"},
	{"Sawn-Off Shtgn Blueprint"},
	{"AK-47 Blueprint"},
	{"Lee Enfield Blueprint"},
	{"Sporter 22 Blueprint"},
	{"Mosin 9130 Blueprint"},
	{"Crossbow Blueprint"},
	{"SKS Blueprint"},
	{"Blaze 95 D R Blueprint"},
	{"Remington 870 Blueprint"},
	{"FN FAL Blueprint"},
	{"G36C Blueprint"},
	{"Sa58V CCO Blueprint"},
	{"SVD Dragunov Blueprint"},
	{"DMR Blueprint"},
	{"M1911 Blueprint"},
	{"M9 SD Blueprint"},
	{"PDW Blueprint"},
	{"G17 Blueprint"},
	{"MP5A5 Blueprint"},
	{"Bizon PP-19 Blueprint"},
	{"Revolver Blueprint"},
	{"Desert Eagle Blueprint"},
	{"Hunting Knife Blueprint"},
	{"Hatchet Blueprint"},
	{"Baseball Bat Blueprint"},
	{"Shovel Blueprint"},
	{"Golf Club Blueprint"},
	{"Machete Blueprint"},
	{"Crowbar Blueprint"},
	{"Parachute Blueprint"},
	{"Tear Gas Blueprint"},
	{"Grenade Blueprint"},
	{"Binoculars Blueprint"},
	{"45 ACP Cartridge Blueprint"},
	{"9x19mm SD Cartridge Blueprint"},
	{"9x19mm Cartridge Blueprint"},
	{"9x18mm Cartridge Blueprint"},
	{"545x39mm Cartridge Blueprint"},
	{"556x45mm Cartridge Blueprint"},
	{"1866 Slug Blueprint"},
	{"2Rnd Slug Blueprint"},
	{"12 Gauge Pellet Blueprint"},
	{"93x62mm Cartridge Blueprint"},
	{"303 British Cartridge Blueprint"},
	{"Bolt Blueprint"},
	{"Medic Kit Blueprint"},
	{"Wire Fence Blueprint"},
	{"Tent Blueprint"},
	{"Camouflage Clthng Blueprint"},
	{"Survivor Clthng Blueprint"},
	{"Civilian Clthng Blueprint"},
	{"Ghillie Suit Blueprint"},
	{"Road Flare Blueprint"},
	{"Toolbox Blueprint"},
	{"Radio Device Blueprint"},
	{"IR Goggles Blueprint"},
	{"NV Goggles Blueprint"},
	{"Gun Barrel"},
	{"Short Gun Barrel"},
	{"Gun Stock"},
	{"Thread"},
	{"Cloth"},
	{"Gun Powder"},
	{"Mechanical Supplies"},
	{"Cables"},
	{"Nails"},
	{"Sheet"},
	{"Barbed Wire"},
	{"Duct Tape"},
	{"Glue"},
	{"Drugs"},
	{"Bandaid"},
	{"Vitamins"},
	{"Tissue"},
	{"Small Box"},
	{"String"},
	{"Needle"},
	{"Microchips"},
	{"Optics"},
	{"Sharp Metal"},
	{"Handle"},
	{"Wooden Stick"},
	{"Hand Saw"},
	{"Metal Plate"},
	{"Metallic Stick"},
	{"Small Casing"},
}

addEventHandler("onResourceStart",getResourceRootElement(getThisResource()), function()
	vehicledatabase = dbConnect("sqlite", "database/vehicles.db","","","share=1")
	dbExec(vehicledatabase,"DROP TABLE vehicles")
	local vehicle_table = dbExec(vehicledatabase, "CREATE TABLE IF NOT EXISTS vehicles (model INT, last_x FLOAT, last_y FLOAT, last_z FLOAT, last_rX FLOAT, last_rY FLOAT, last_rZ FLOAT, MAX_Slots INT, OCC_Slots INT, fuel FLOAT, Tire_inVehicle INT, Engine_inVehicle INT, Parts_inVehicle INT, ID INT)")
	if vehicledatabase then
		outputServerLog("[DayZ] CONNECTED TO VEHICLE DATABASE.")
	else
		outputServerLog("[DayZ] FAILED TO CONNECT TO DATABASE 'vehicles'. CHECK IF IT EXISTS.")
	end
	if vehicle_table then
		outputServerLog("[DayZ] Table 'vehicles' has been created.")
	else
		outputServerLog("[DayZ] Failed to create table 'vehicles'!")
	end
	-- This can be removed once testing phase is done, since it only adds all items to the database
	for i, data in ipairs(itemsDataTable) do
		dbExec(vehicledatabase,'ALTER TABLE vehicles ADD "'..data[1]..'" INT')
	end
	
end)

vehicleAddonsInfo = {
	{422,4,1,1},
	{470,4,1,1},
	{468,2,1,1},
	{433,6,1,1},
	{437,6,1,1},
	{509,0,0,0},
	{487,0,1,1},
	{497,0,1,1},
	{453,0,1,1},
	{483,4,1,1},
	{508,4,1,1},
}

function getVehicleAddonInfos(id)
    for i, veh in ipairs(vehicleAddonsInfo) do
        if veh[1] == id then
            return veh[2], veh[3], veh[4]
        end
    end
end

function assignIDToItem(item)
    for i, item in ipairs(itemsDataTable) do
        if item[1] == item then
            return i
        end
    end
end

function getItemFromID(itemid)
    for i, id in ipairs(itemsDataTable) do
        if i == itemid then
            return id[1]
        end
    end
end

local theItems = {}

function saveVehiclesToDB()
    dbExec(vehicledatabase, "DROP TABLE vehicles")
    dbExec(vehicledatabase, "CREATE TABLE IF NOT EXISTS vehicles (model INT, last_x FLOAT, last_y FLOAT, last_z FLOAT, last_rX FLOAT, last_rY FLOAT, last_rZ FLOAT, MAX_Slots INT, OCC_Slots INT, fuel FLOAT, Tire_inVehicle INT, Engine_inVehicle INT, Parts_inVehicle INT, ID INT)")
    for i, data in ipairs(itemsDataTable) do
		dbExec(vehicledatabase,'ALTER TABLE vehicles ADD "'..data[1]..'" INT')
	end
	for i, col in ipairs(getElementsByType("colshape")) do
		local veh = getElementData(col,"vehicle")
		local tent = getElementData(col,"tent")
		if veh and not tent then
			local vehicle = getElementData(col,"parent")
			local model = getElementModel(vehicle)
			local x, y, z = getElementPosition(vehicle)
			local rotx, roty, rotz = getElementRotation(vehicle)
			local slots = getElementData(getElementData(vehicle, "parent"), "MAX_Slots") or 0
			local occupied_slots = getLootCurrentSlots(vehicle) or 0
			local fuel = getElementData(getElementData(vehicle, "parent"), "fuel") or 0
			local tires = getElementData(getElementData(vehicle, "parent"), "Tire_inVehicle")
			local engines = getElementData(getElementData(vehicle, "parent"), "Engine_inVehicle") or 0
			local parts = getElementData(getElementData(vehicle, "parent"), "Parts_inVehicle") or 0
			local veh_ID = getElementData(getElementData(vehicle,"parent"),"veh_ID") or 0
			dbExec(vehicledatabase, "INSERT INTO vehicles (model, last_x, last_y, last_z, last_rX, last_rY, last_rZ, MAX_Slots, OCC_Slots, fuel, Tire_inVehicle, Engine_inVehicle, Parts_inVehicle, ID) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)", model, x, y, z, rotx, roty, rotz, slots, occupied_slots, fuel, tires, engines, parts, veh_ID)
			for key,item in ipairs(itemsDataTable) do
				local itemAmount = getElementData(col, item[1])
				dbExec(vehicledatabase, 'UPDATE vehicles SET "'..item[1]..'"=? WHERE ID=?', itemAmount, veh_ID)
			end
		end
	end
	outputServerLog("[DayZ] VEHICLES HAVE BEEN SAVED TO THE DATABASE.")
end


-- Current Problems: ID becomes 0, only last item is loaded
function createVehiclesFromDB(model, last_x, last_y, last_z, last_rX, last_rY, last_rZ, MAX_Slots, fuel, Tire_inVehicle, Engine_InVehicle, Parts_inVehicle, ID, itemName, itemAmount)
    if (not model and not last_x and not last_y and not last_z and not last_rX and not last_rY and not last_rZ and not MAX_Slots and not fuel and not Tire_inVehicle and not Engine_inVehicle and not Parts_inVehicle) then
		local itemName, itemAmount = Items
		setElementData(vehCol, tostring(itemName), tonumber(itemAmount))
        return
    end
    veh = createVehicle(model, last_x, last_y, last_z, last_rX, last_rY, last_rZ)
    vehCol = createColSphere(last_x, last_y, last_z, 3)
    attachElements(vehCol, veh, 0, 0, 0)
    setElementData(vehCol, "parent", veh)
    setElementData(veh, "parent", vehCol)
    setElementData(vehCol, "vehicle", true)
    setElementData(vehCol, "MAX_Slots", tonumber(MAX_Slots))
    local tires, engine, parts = getVehicleAddonInfos(getElementModel(veh))
    setElementData(vehCol, "Tire_inVehicle", tonumber(Tire_inVehicle))
    setElementData(vehCol, "Engine_inVehicle", tonumber(Engine_inVehicle))
    setElementData(vehCol, "Parts_inVehicle", tonumber(Parts_inVehicle))
    setElementData(vehCol, "spawn", {model, last_x, last_y, last_z})
    setElementData(vehCol, "fuel", tonumber(fuel))
    local item, amount = itemName, itemAmount
	setElementData(vehCol,"veh_ID",ID)
	setElementData(vehCol, tostring(item), tonumber(amount))
	if item then
		outputChatBox("itemName: "..item..", itemAmount: "..tostring(amount)..", ID: "..ID,root,255,255,255,true) -- Debug
	else
		outputChatBox("Error. No item.",root,255,255,255,true) -- Debug
	end
end

itemName = ""
itemAmount = 0
function loadVehiclesFromDB(q)
    if (q) then
        local p = dbPoll( q, -1 )
        if (#p > 0) then
            for _, d in pairs (p) do
				for i, data in ipairs(itemsDataTable) do
					if d[data[1]] >= 1 then
						itemName = data[1]
						itemAmount = d[data[1]]
					end
				end
				createVehiclesFromDB( d["model"], d["last_x"], d["last_y"], d["last_z"], d["last_rX"], d["last_rY"], d["last_rZ"], d["MAX_Slots"], d["fuel"], d["Tire_inVehicle"], d["Engine_inVehicle"], d["Parts_inVehicle"], d["ID"], itemName, itemAmount)
            end
        end
    end
end

function executeCommand(cmd)
    if isObjectInACLGroup("user."..getAccountName(getPlayerAccount(source)), aclGetGroup("Admin")) then
        else cmd == "loadvehs" then
            dbQuery(loadVehiclesFromDB, { }, vehicledatabase, "SELECT * FROM vehicles")
        elseif cmd == "vehbk" then
            saveVehiclesToDB()
        elseif cmd == "togbk" then
            if isTimer(bktime) and isTimer(bkttime) then
                killTimer(bktime)
                killTimer(bkttime)
            else
                bktime = setTimer(saveVehiclesToDB, 30 * 60000, 0)
                bkttime = setTimer(saveTentsToDB, 30 * 60000, 0)
            end
        end    
    end
end
addEventHandler("onPlayerCommand", root, executeCommand)

--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: table_functions.lua					*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SHARED														*----
#-----------------------------------------------------------------------------#
]]

-- // Vehicles // --
function getVehicleAddonInfos (id)
	for i,veh in ipairs(vehicleAddonsInfo) do
		if veh[1] == id then
			return veh[2], veh[3], veh[4], veh[5], veh[6], veh[7], veh[8], veh[9], veh[10], veh[11], veh[12]
		end
	end
end

function getVehicleMaxFuel(loot)
	local modelID = getElementModel(getElementData(loot,"parent"))
	for i,vehicle in ipairs(vehicleFuelTable) do
		if modelID == vehicle[1] then
			 return vehicle[2]
		end
	end
	return false
end

-- // Players // --
function getWeaponAmmoFromID(weaponID)
	for i,weaponData in ipairs(weaponAmmoTable["others"]) do
		if weaponID == weaponData[2] then
			return weaponData[1],weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["11.43x23mm Cartridge"]) do
        if weaponID == weaponData[2] then
            return "11.43x23mm Cartridge",weaponData[2]
        end
    end
	for i,weaponData in ipairs(weaponAmmoTable["9x18mm Cartridge"]) do
        if weaponID == weaponData[2] then
            return "9x18mm Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["9x19mm Cartridge"]) do
        if weaponID == weaponData[2] then
            return "9x19mm Cartridge",weaponData[2]
        end
    end
	for i,weaponData in ipairs(weaponAmmoTable[".303 British Cartridge"]) do
        if weaponID == weaponData[2] then
            return ".303 British Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["5.45x39mm Cartridge"]) do
        if weaponID == weaponData[2] then
            return "5.45x39mm Cartridge",weaponData[2]
        end
    end
	for i,weaponData in ipairs(weaponAmmoTable["7.62x39mm Cartridge"]) do
        if weaponID == weaponData[2] then
            return "7.62x39mm Cartridge",weaponData[2]
        end
    end
	for i,weaponData in ipairs(weaponAmmoTable["7.62x51mm Cartridge"]) do
        if weaponID == weaponData[2] then
            return "7.62x51mm Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["5.56x45mm Cartridge"]) do
        if weaponID == weaponData[2] then
            return "5.56x45mm Cartridge",weaponData[2]
        end
    end
	for i,weaponData in ipairs(weaponAmmoTable[".308 Winchester Cartridge"]) do
        if weaponID == weaponData[2] then
            return ".308 Winchester Cartridge",weaponData[2]
        end
    end
	for i,weaponData in ipairs(weaponAmmoTable["7.62x54mm Cartridge"]) do
        if weaponID == weaponData[2] then
            return "9.3x62mm Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["1866 Slug"]) do
        if weaponID == weaponData[2] then
            return "1866 Slug",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["12 Gauge Pellet"]) do
        if weaponID == weaponData[2] then
            return "12 Gauge Pellet",weaponData[2]
        end
    end
	for i,weaponData in ipairs(weaponAmmoTable["Bolt"]) do
		if weaponID == weaponData[2] then
			return "Bolt",weaponData[2]
		end
	end
end

function getWeaponAmmoFromName(weaponName)
    for i,weaponData in ipairs(weaponAmmoTable["others"]) do
		if weaponName == weaponData[1] then
			return weaponData[1],weaponData[2]
		end
	end
	for i,weaponData in ipairs(weaponAmmoTable["11.43x23mm Cartridge"]) do
        if weaponName == weaponData[1] then
            return "11.43x23mm Cartridge",weaponData[2]
        end
    end
	for i,weaponData in ipairs(weaponAmmoTable["9x18mm Cartridge"]) do
        if weaponName == weaponData[1] then
            return "9x18mm Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["9x19mm Cartridge"]) do
        if weaponName == weaponData[1] then
            return "9x19mm Cartridge",weaponData[2]
        end
    end
	for i,weaponData in ipairs(weaponAmmoTable[".303 British Cartridge"]) do
        if weaponName == weaponData[1] then
            return ".303 British Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["5.45x39mm Cartridge"]) do
        if weaponName == weaponData[1] then
            return "5.45x39mm Cartridge",weaponData[2]
        end
    end
	for i,weaponData in ipairs(weaponAmmoTable["7.62x39mm Cartridge"]) do
        if weaponName == weaponData[1] then
            return "7.62x39mm Cartridge",weaponData[2]
        end
    end
	for i,weaponData in ipairs(weaponAmmoTable["7.62x51mm Cartridge"]) do
        if weaponName == weaponData[1] then
            return "7.62x51mm Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["5.56x45mm Cartridge"]) do
        if weaponName == weaponData[1] then
            return "5.56x45mm Cartridge",weaponData[2]
        end
    end
	for i,weaponData in ipairs(weaponAmmoTable[".308 Winchester Cartridge"]) do
        if weaponName == weaponData[1] then
            return ".308 Winchester Cartridge",weaponData[2]
        end
    end
	for i,weaponData in ipairs(weaponAmmoTable["7.62x54mm Cartridge"]) do
        if weaponName == weaponData[1] then
            return "7.62x54mm Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["1866 Slug"]) do
        if weaponName == weaponData[1] then
            return "1866 Slug",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["12 Gauge Pellet"]) do
        if weaponName == weaponData[1] then
            return "12 Gauge Pellet",weaponData[2]
        end
    end
	for i,weaponData in ipairs(weaponAmmoTable["Bolt"]) do
		if weaponName == weaponData[1] then
			return "Bolt",weaponData[2]
		end
	end
end

function getWeaponDamage(weapon,attacker)
	local weapon_1 = getElementData(attacker,"currentweapon_1")
	local weapon_2 = getElementData(attacker,"currentweapon_2")
	for i,weap in ipairs(damageTable) do
		if weapon == 25 or weapon == 26 or weapon == 27 or weapon == 30 or weapon == 31 or weapon == 33 or weapon == 34 or weapon == 8 then
			if weap[1] == weapon_1 then
				return weap[2]
			end
		else
			if weap[1] == weapon_2 then
				if getElementData(attacker,"humanity") >= 5000 then
					if weapon_2 == "M1911" or weapon_2 == "Makarov SD" or weapon_2 == "PDW" then
						return weap[2]*1.3
					else
						return weap[2]
					end
				else
					return weap[2]
				end
			end
		end
	end
end

-- // Loot // --
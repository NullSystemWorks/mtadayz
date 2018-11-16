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
    for key,value in pairs(weaponAmmoTable) do 
        for j,weaponData in ipairs(weaponAmmoTable[key]) do
            if weaponID == weaponData[2] then
                return key,weaponData[2]
            end
        end
    end
end

function getWeaponAmmoFromName(weaponName)
    for key,value in pairs(weaponAmmoTable) do 
        for j,weaponData in ipairs(weaponAmmoTable[key]) do
            if weaponName == weaponData[1] then
                return key,weaponData[2]
            end
        end
    end
end

function getWeaponDamage(weapon,attacker)
	local weapon_1 = playerStatusTable[attacker]["currentweapon_1"]
	local weapon_2 = playerStatusTable[attacker]["currentweapon_2"]
	for i,weap in ipairs(damageTable) do
		if weapon == 25 or weapon == 26 or weapon == 27 or weapon == 30 or weapon == 31 or weapon == 33 or weapon == 34 or weapon == 8 then
			if weap[1] == weapon_1 then
				return weap[2]
			end
		else
			if weap[1] == weapon_2 then
				if playerStatusTable[attacker]["humanity"] >= 5000 then
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

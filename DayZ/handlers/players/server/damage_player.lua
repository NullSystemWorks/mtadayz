--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: damage_player.lua						*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]

setWeaponProperty ("m4","poor","maximum_clip_ammo",30)
setWeaponProperty ("m4","std","maximum_clip_ammo",30)
setWeaponProperty ("m4","pro","maximum_clip_ammo",30)

function getWeaponAmmoType (weaponName,notOthers)
	if not notOthers then
		for i,weaponData in ipairs(weaponAmmoTable["others"]) do
			if weaponName == weaponData[1] then
				return weaponData[1],weaponData[2]
			end
		end
	end	
	for i,weaponData in ipairs(weaponAmmoTable[".45 ACP Cartridge"]) do
        if weaponName == weaponData[1] then
            return ".45 ACP Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["9x19mm SD Cartridge"]) do
        if weaponName == weaponData[1] then
            return "9x19mm SD Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["9x19mm Cartridge"]) do
        if weaponName == weaponData[1] then
            return "9x19mm Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["9x18mm Cartridge"]) do
        if weaponName == weaponData[1] then
            return "9x18mm Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["5.45x39mm Cartridge"]) do
        if weaponName == weaponData[1] then
            return "5.45x39mm Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["5.56x45mm Cartridge"]) do
        if weaponName == weaponData[1] then
            return "5.56x45mm Cartridge",weaponData[2]
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
    for i,weaponData in ipairs(weaponAmmoTable["2Rnd. Slug"]) do
        if weaponName == weaponData[1] then
            return "2Rnd. Slug",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["9.3x62mm Cartridge"]) do
        if weaponName == weaponData[1] then
            return "9.3x62mm Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable[".303 British Cartridge"]) do
        if weaponName == weaponData[1] then
            return ".303 British Cartridge",weaponData[2]
        end
    end
    for i,weaponData in ipairs(weaponAmmoTable["M136 Rocket"]) do
        if weaponName == weaponData[1] then
            return "M136 Rocket",weaponData[2]
        end
    end
	for i,weaponData in ipairs(weaponAmmoTable["Bolt"]) do
		if weaponName == weaponData[1] then
			return "Bolt",weaponData[2]
		end
	end
	return false
end

function rearmPlayerWeapon (weaponName,slot)
	takeAllWeapons (source)
	--Rearm
	local ammoData,weapID = getWeaponAmmoType (weaponName)
	if getElementData(source,ammoData) <= 0 then triggerClientEvent (source, "displayClientInfo", source,"Rearm",shownInfos["nomag"],255,22,0) return end
	setElementData(source,"currentweapon_"..slot,weaponName)
	--Old Weapons
	local weapon = getElementData(source,"currentweapon_1")
	if weapon then
		local ammoData,weapID = getWeaponAmmoType (weapon)
		giveWeapon(source,weapID,getElementData(source,ammoData), true )
	end
	local weapon = getElementData(source,"currentweapon_2")
	if weapon then
		local ammoData,weapID = getWeaponAmmoType (weapon)
		giveWeapon(source,weapID,getElementData(source,ammoData), false )
	end
	local weapon = getElementData(source,"currentweapon_3")
	if weapon then
		local ammoData,weapID = getWeaponAmmoType (weapon)
		giveWeapon(source,weapID,getElementData(source,ammoData), false )
	end
	if elementWeaponBack[source] then
		detachElementFromBone(elementWeaponBack[source])
		destroyElement(elementWeaponBack[source])
		elementWeaponBack[source] = false
	end	
	setElementModel(source, getElementData(source,"skin"))
end
addEvent("onPlayerRearmWeapon",true)
addEventHandler("onPlayerRearmWeapon",getRootElement(),rearmPlayerWeapon)

weaponIDtoObjectID = {
{30,355},
{31,356},
{25,349},
{26,350},
{27,351},
{33,357},
{34,358},
{36,360},
{35,359},
{2,333},
{5,336},
{6,337},
}

function getWeaponObjectID (weaponID)
	for i,weaponData in ipairs(weaponIDtoObjectID) do
		if weaponID == weaponData[1] then
			return weaponData[2]
		end
	end
end

function weaponDelete(dataName,oldValue)
	if getElementType(source) == "player" then -- check if the element is a player
		local weapon1 = getElementData(source,"currentweapon_1")
		local weapon2 = getElementData(source,"currentweapon_2")
		local weapon3 = getElementData(source,"currentweapon_3")
		if dataName == weapon1 or dataName == weapon2 or dataName == weapon3 then
			if getElementData (source,dataName) == 0 then
				local ammoData,weapID = getWeaponAmmoType(dataName)
				takeWeapon (source,weapID)
				if dataName == weapon1 then
					setElementData(source,"currentweapon_1",false)
				elseif dataName == weapon2 then
					setElementData(source,"currentweapon_2",false)
				elseif dataName == weapon3 then
					setElementData(source,"currentweapon_3",false)
				end
			end
		end
		local weapon1 = getElementData(source,"currentweapon_1")
		local weapon2 = getElementData(source,"currentweapon_2")
		local weapon3 = getElementData(source,"currentweapon_3")
		local ammoData1,weapID1 = getWeaponAmmoType(weapon1)
		local ammoData2,weapID2 = getWeaponAmmoType(weapon2)
		local ammoData3,weapID3 = getWeaponAmmoType(weapon3)
		if dataName == ammoData1 then
			if not oldValue then return end
			local newammo = oldValue - getElementData (source,dataName)
			if newammo == 1 then return end
			if getElementData (source,dataName) < oldValue then
				takeWeapon (source,weapID1,newammo) 
				if elementWeaponBack[source] then
					detachElementFromBone(elementWeaponBack[source])
					destroyElement(elementWeaponBack[source])	
					elementWeaponBack[source] = false
				end	
			elseif getElementData (source,dataName) > oldValue then
				giveWeapon(source,weapID1,getElementData (source,dataName)-oldValue,true)
			end
		end	
		if dataName == ammoData2 then
			if not oldValue then return end
			local newammo = oldValue - getElementData (source,dataName)
			if newammo == 1 then return end
			if getElementData (source,dataName) < oldValue then
				takeWeapon (source,weapID2,newammo) 
			elseif getElementData (source,dataName) > oldValue then
				giveWeapon(source,weapID2,getElementData (source,dataName)-oldValue,false)
			end
		end	
		if dataName == ammoData3 then
			if not oldValue then return end
			local newammo = oldValue - getElementData (source,dataName)
			if newammo == 1 then return end
			if getElementData (source,dataName) < oldValue then
				takeWeapon (source,weapID3,newammo) 
			elseif getElementData (source,dataName) > oldValue then
				giveWeapon(source,weapID3,getElementData (source,dataName)-oldValue,false)
			end	
		end
	end
end
addEventHandler("onElementDataChange",getRootElement(),weaponDelete)

function onPlayerChangeStatus(status,value)
	if status == "humanity" then
		setElementData(source,status,getElementData(source,status)+value)
	elseif status == "isInBuilding" then
		setElementData(source,status,value)
	end
end
addEvent("onPlayerChangeStatus",true)
addEventHandler("onPlayerChangeStatus",root,onPlayerChangeStatus)
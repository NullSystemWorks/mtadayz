--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: other_loot.lua						*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]

heliCrashSites = gameplayVariables["helicrashsides"]

function onStart()
	--Create Crash sites, hospital packs, ...
	createHeliCrashSite()
	createHospitalPacks()
	
	for i,petrol in ipairs(petrolPoints) do
		local x,y,z = petrol[1],petrol[2],petrol[3]
		petrolCol = createColSphere(x,y,z,3)
		setElementData(petrolCol,"petrolstation",true)
		setElementData(petrolCol,"petrolQuantity",gameplayVariables["maxPetrolFuelAmount"]) --1 Quantity = 1 full jerry can. (1B0Y)
	end
end
addEventHandler("onResourceStart",resourceRoot,onStart)

function createHeliCrashSite()
	if heliLoot then
		destroyElement(getElementData(heliLoot,"parent"))
		destroyElement(heliLoot)
	end
	local item_id = math.random(table.size(heliCrashSites))
	local x,y,z = heliCrashSites[item_id][1],heliCrashSites[item_id][2],heliCrashSites[item_id][3]
	cargobob = createVehicle(548,x,y,z,nil,nil,nil)
	setElementHealth(cargobob,0)
	setElementFrozen(cargobob,true)
	for i = 1, 6 do
		heliLoot = createColSphere(x+math.random(3,12),y+math.random(3,12),z-0.5,1.25)
		local x2,y2,z2 = getElementPosition(heliLoot)
		object = createObject(1271,x2,y2,z2-0.5)
		setObjectScale(object,2)
		setElementCollisionsEnabled(object,false)
		setElementData(object,"parent",cargobob)
		setElementData(heliLoot,"itemloot",true)
		setElementData(heliLoot,"helicrash",true)
		setElementData(heliLoot,"parent",cargobob)
		setElementData(heliLoot,"MAX_Slots",30)
		for i, item in ipairs(otherLootItems["helicrashsides"]) do
			local value =  math.percentChance (item[5]*3.5,math.random(1,2))
			setElementData(heliLoot,item[1],value)
			local ammoData = getWeaponAmmoFromID(item[1])
			if ammoData and value > 0 then
				setElementData(heliLoot,ammoData,math.random(1,2))
			end
		end
	end
	setTimer(createHeliCrashSite,3600000,1)
end

function updateHospitals ()
	for i,box in pairs(hospitalCol) do
		for _,items in ipairs(otherLootItems["hospital"]) do
			setElementData(hospitalCol[i],items[1],items[5])
		end
	end
	setTimer(updateHospitals,3600000,1)
end

hospitalCol = {}
function createHospitalPacks()
	number1 = 0
	for i,box in ipairs(hospitalPacks) do
		if 0.4 > math.random() then
			number1 = number1+1
			local x,y,z = box[1],box[2],box[3]
			object = createObject(1558,x,y,z-0.3,nil,nil,nil)
			setObjectScale(object,3)
			hospitalCol[i] = createColSphere(x,y,z,2)
			setElementData(hospitalCol[i],"parent",object)
			setElementData(hospitalCol[i],"hospitalbox",true)
			setElementData(hospitalCol[i],"MAX_Slots",40)
			for _,items in ipairs(otherLootItems["hospital"]) do
				setElementData(hospitalCol[i],items[1],items[5])
			end
		end
	end
	setTimer(updateHospitals,3600000,1)
end
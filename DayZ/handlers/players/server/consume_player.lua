--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: consume_player.lua					*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]

function addPlayerStats (player,data,value)
	if data == "food" then
		local current = getElementData(player,data)
		if current + value > 100 then
			setElementData(player,data,100)
		elseif current + value < 1 then
			setElementData(player,data,0)
			setElementData(player,"blood",getElementData(player,"blood")-math.random(50,120))
		else
			setElementData(player,data,current+value)
		end
	elseif data == "thirst" then
		local current = getElementData(player,data)
		if current + value > 100 then
			setElementData(player,data,100)
		elseif 	current + value < 1 then
			setElementData(player,data,0)
			setElementData(player,"blood",getElementData(player,"blood")-math.random(50,120))
		else
			setElementData(player,data,current+value)
		end
	elseif data == "blood" then
		local current = getElementData(player,data)
		if current + value > 12000 then
			setElementData(player,data,12000)
		elseif 	current + value < 1 then
			setElementData(player,data,0)
		else
			setElementData(player,data,current+value)
		end
	elseif data == "temperature" then
		local current = getElementData(player,data)
		if current + value > 41 then
			setElementData(player,data,41)
		elseif 	current + value <= 31 then
			setElementData(player,data,31)
		else
			setElementData(player,data,current+value)
		end
	elseif data == "humanity" then
		local current = getElementData(player,data)
		if current + value > 5000 then
			setElementData(player,data,5000)
		else
			setElementData(player,data,current+value)
		end
	--[[
	elseif data == "calories" then
		local current = getElementData(player,data)
		if current + value > 3610 then
			setElementData(player,data,3610)
		else
			setElementData(player,data,current+value)
		end
	]]
	end
end

function onPlayerRequestChangingStats(itemName,itemInfo,data)
	for i, value in ipairs(gameplayVariables["nutritions"]) do
		if itemName == value[1] then
			bloodRegen = value[2]
			calorieGain = value[3]/10
			foodGain = value[4]/10
			waterGain = value[5]/10
			temperatureGain = value[6]
		end
	end
	if data == "food" then
		setPedAnimation (source,"FOOD","EAT_Burger",4000,false,false,nil,false)
	elseif data == "thirst" then
		setPedAnimation (source,"VENDING","VEND_Drink2_P",4000,false,false,nil,false) 
		if itemName == "Water Bottle" then
			setElementData(source,"Empty Water Bottle",(getElementData(source,"Empty Water Bottle") or 0)+1)
		end
	end
	setElementData(source,itemName,getElementData(source,itemName)-1)
	addPlayerStats (source,"blood",bloodRegen)
	--addPlayerStats (source,"calories",calorieGain)
	addPlayerStats (source,"food",foodGain)
	addPlayerStats (source,"thirst",waterGain)
	if getElementData(source,"temperature") <= 35 then
		setElementData(source,"temperature",getElementData(source,"temperature")+temperatureGain)
	end
	triggerClientEvent (source, "displayClientInfo", source,"Food",shownInfos["youconsumed"].." "..itemName,22,255,0)
	triggerClientEvent(source,"refreshInventoryManual",source)
end
addEvent("onPlayerRequestChangingStats",true)
addEventHandler("onPlayerRequestChangingStats",getRootElement(),onPlayerRequestChangingStats)

function onPlayerUseMedicObject(itemName)
	local playersource = source
	setPedAnimation (playersource,"BOMBER","BOM_Plant",4000,false,false,nil,false)
	setTimer( function ()
		if itemName == "Bandage" then
			setElementData(playersource,"bleeding",0)
			setElementData(playersource,itemName,getElementData(playersource,itemName)-1)
		elseif itemName == "Medic Kit" then
			addPlayerStats (playersource,"blood",7000)
			setElementData(playersource,"bleeding",0)
			setElementData(playersource,itemName,getElementData(playersource,itemName)-1)
		elseif itemName == "Heat Pack" then
			setElementData(playersource,"cold",false)
			setElementData(playersource,"temperature",37)
			setElementData(playersource,itemName,getElementData(playersource,itemName)-1)
		elseif itemName == "Painkiller" then
			setElementData(playersource,"pain",false)
			setElementData(playersource,itemName,getElementData(playersource,itemName)-1)
		elseif itemName == "Antibiotics" then
			setElementData(playersource,"cold",false)
			setElementData(playersource,itemName,getElementData(playersource,itemName)-1)
		elseif itemName == "Morphine" then
			setElementData(playersource,"brokenbone",false)
			setElementData(playersource,itemName,getElementData(playersource,itemName)-1)
		elseif itemName == "Blood Bag" then
			addPlayerStats (playersource,"blood",12000)
			setElementData(playersource,itemName,getElementData(playersource,itemName)-1)
		end
	end,1500,1)	
	triggerClientEvent(playersource,"refreshInventoryManual",playersource)
end
addEvent("onPlayerUseMedicObject",true)
addEventHandler("onPlayerUseMedicObject",getRootElement(),onPlayerUseMedicObject)

function onPlayerGiveMedicObject(itemName,player)
	local playersource = source
	setPedAnimation (playersource,"BOMBER","BOM_Plant",4000,false,false,nil,false)
	setTimer( function ()
		if itemName == "bandage" then
			setElementData(player,"bleeding",0)
			setElementData(playersource,"Bandage",getElementData(playersource,"Bandage")-1)
			addPlayerStats (playersource,"humanity",40)
		elseif itemName == "giveblood" then
			addPlayerStats (player,"blood",12000)
			setElementData(playersource,"Blood Bag",getElementData(playersource,"Blood Bag")-1)
			addPlayerStats (playersource,"humanity",250)
		end
	end,1500,1)	
end
addEvent("onPlayerGiveMedicObject",true)
addEventHandler("onPlayerGiveMedicObject",getRootElement(),onPlayerGiveMedicObject)

function onPlayerRefillWaterBottle (itemName)
	if isElementInWater(source) then
		setElementData(source,"Water Bottle",getElementData(source,"Water Bottle")+1)
		setElementData(source,itemName,getElementData(source,itemName)-1)
		triggerClientEvent(source,"refreshInventoryManual",source)
		triggerClientEvent (source, "displayClientInfo", source,"Water Bottle",shownInfos["filledup"],22,255,0)
	else
		triggerClientEvent (source, "displayClientInfo", source,"Water Bottle",shownInfos["needwatersource"],255,22,0)
	end	
end
addEvent("onPlayerRefillWaterBottle",true)
addEventHandler("onPlayerRefillWaterBottle",getRootElement(),onPlayerRefillWaterBottle)

function addPlayerCookMeat ()
	local playersource = source
	setPedAnimation (playersource,"BOMBER","BOM_Plant",1300,false,false,nil,false)
	local meat = getElementData(playersource,"Raw Meat")
	setTimer(function()
			setElementData(playersource,"Raw Meat",0)
			setElementData(playersource,"Cooked Meat",getElementData(playersource,"Cooked Meat")+meat)
			triggerClientEvent (playersource, "displayClientInfo", playersource,"Fireplace","You cooked "..meat.." Raw Meat.",22,255,0)
	end,5000,1)
end
addEvent("addPlayerCookMeat",true)
addEventHandler("addPlayerCookMeat",getRootElement(),addPlayerCookMeat)
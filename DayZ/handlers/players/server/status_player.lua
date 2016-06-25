--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: status_player.lua						*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]

function regenerateBlood()
	for i,player in ipairs(getElementsByType("player")) do
		if getElementData(player,"logedin") then
			blood = getElementData(player,"blood")
			if blood < 12000 then
				if blood >= 11940 then
					setElementData(player,"blood",12000)
				elseif blood <= 11940 and blood >= (12000*75)/100 then
					setElementData(player,"blood",blood+60)
				elseif blood <= (12000*74)/100 and blood >= (12000*50)/100 then
					setElementData(player,"blood",blood+30)
				elseif blood <= (12000*49)/100 and blood >= (12000*0.001)/100 then
					setElementData(player,"blood",blood+10)
				elseif blood >= 12001 then
					setElementData(player,"blood",12000)
				end
			end
		end
	end
end
setTimer(regenerateBlood,60000,0)

function checkTemperature()
	for i,player in ipairs(getElementsByType("player")) do
		if getElementData(player,"logedin") then
			local value = 0
			for k,v in ipairs(gameplayVariables["weather"]) do
				local weatherID = getWeather()
				if weatherID == v[1] then
					value = v[2]
				end
			end
			local hour, minutes = getTime()
			if hour >= 21 and hour <= 8 then
				value = value-0.05
			end
			local x,y,z = getElementPosition(player)
			triggerClientEvent("isPlayerInBuilding",player,x,y,z)
			if not getElementData(player,"isInBuilding") then
				addPlayerStats(player,"temperature",value)
			else
				if getElementData(player,"temperature") < 37 then
					value = 0.02
					addPlayerStats(player,"temperature",value)
				end
			end
		end
	end
end
setTimer(checkTemperature,30000,0)

function checkTemperature2()
	for i,player in ipairs(getElementsByType("player")) do
		if getElementData(player,"logedin") then
			value = 0
			if isElementInWater(player) then
				value = value+gameplayVariables["temperaturewater"]
			end	
			if getControlState (player,"sprint") then
				if getElementData(player,"temperature") <= 37 then
					value = value+gameplayVariables["temperaturesprint"]
				end
			end
			if isPedInVehicle(player) then
				if getElementData(player,"temperature") <= 37 then
					value = value+0.008
				end
			end
			addPlayerStats (player,"temperature",value)
		end	
	end
end
setTimer(checkTemperature2,10000,0)

--[[
function setHunger()
	for i,player in ipairs(getElementsByType("player")) do
		if getElementData(player,"logedin") then
			value = gameplayVariables["loseHunger"]
			addPlayerStats (player,"food",value)
		end	
	end
end
setTimer(setHunger,60000,0)

function setThirsty()
	for i,player in ipairs(getElementsByType("player")) do
		if getElementData(player,"logedin") then
			value = gameplayVariables["loseThirst"]
			addPlayerStats (player,"thirst",value)
		end
	end
end
setTimer(setThirsty,60000,0)

function checkThirsty()
	for i,player in ipairs(getElementsByType("player")) do
		if getElementData(player,"logedin") then
			value = 0
			if getControlState (player,"sprint") then
				value = gameplayVariables["sprintthirst"]
			end	
			addPlayerStats (player,"thirst",value)
		end
	end
end
setTimer(checkThirsty,10000,0)
]]

function checkHumanity()
	for i,player in ipairs(getElementsByType("player")) do
		if getElementData(player,"logedin") then
			if getElementData(player,"humanity") < 2500 then
				addPlayerStats (player,"humanity",30)
				if getElementData(player,"humanity") > 2000 then
					setElementData(player,"bandit",false)
				end
			end
		end	
	end
end
setTimer(checkHumanity,60000,0)

function checkInfection()
	for i,player in ipairs(getElementsByType("player")) do
		if getElementData(player,"logedin") then
			if getElementData(player,"infection") then
				addPlayerStats(player,"blood",-3)
			end
		end
	end
end
setTimer(checkInfection,1000,0)

function onPlayerHasContractedSepsis(level,loss)
	if getElementData(source,"sepsis") == level then
		addPlayerStats(source,"blood",loss)
	end
end
addEvent("onPlayerHasContractedSepsis",true)
addEventHandler("onPlayerHasContractedSepsis",root,onPlayerHasContractedSepsis)

function onPlayerTransmitSepsis()
	setElementData(source,"sepsis",1)
end
addEvent("onPlayerTransmitSepsis",true)
addEventHandler("onPlayerTransmitSepsis",root,onPlayerTransmitSepsis)

function onPlayerHideBody()
    local col = getElementData(source,"currentCol")
    if getElementData(source, "Shovel") > 0 then
        if isElement (col) then
          setPedAnimation(source,"BOMBER","BOM_Plant",-1,false,false,nil,false)
            if getElementData(col,"deadman") or getElementData(col,"deadzombie") then
                setElementData(source,"loot",false)
                setElementData(source,"currentCol",false)
                triggerClientEvent(source, "displayClientInfo", source, "Info","You hide the body", 22, 255, 0)
                setTimer(function(colision)
                    if isElement (getElementData(colision,"parent")) then
                        destroyElement(getElementData(colision,"parent"))
                    end
                    destroyElement(colision)
                end,2000,1,col)
            end 
        end
    else
      triggerClientEvent(source, "displayClientInfo", source, "Info", "You must have a shovel !", 255, 51, 51)
    end
end
addEvent("onPlayerHideBody",true)
addEventHandler("onPlayerHideBody",getRootElement(),onPlayerHideBody)
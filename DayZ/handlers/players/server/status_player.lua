--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: status_player.lua						*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf and	*----
----* 							PicardRemi                              *----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]

local dataInfoTable = {}
function sendPlayerStatusInfoToClient()
	for i, player in ipairs(getElementsByType("player")) do
		if getElementData(player,"logedin") then
			triggerClientEvent(player,"onClientPullPlayerStatusInfoFromServer",player,playerStatusTable[player])
		end
	end
end
setTimer(sendPlayerStatusInfoToClient,1000,0)

function onPlayerRetrieveStatusInfo(status,value)
	triggerClientEvent(source,"onClientPlayerPullSingleStatusInfoFromServer",source,status,value)
end
addEvent("onPlayerRetrieveStatusInfo",true)
addEventHandler("onPlayerRetrieveStatusInfo",root,onPlayerRetrieveStatusInfo)

function updatePlayerCurrentSlots(isHoldingWeapon)
	local current_SLOTS = 0
	for id,item in ipairs(itemWeightTable) do
		if getElementData(client, item[1]) and getElementData(client, item[1]) >= 1 then
			current_SLOTS = current_SLOTS + item[2] * getElementData(client, item[1])
		end
	end
	if isHoldingWeapon then
		playerStatusTable[client]["CURRENT_Slots"] = math.floor(current_SLOTS)-10
	else
		playerStatusTable[client]["CURRENT_Slots"] = math.floor(current_SLOTS)
	end
	triggerEvent("onPlayerRetrieveStatusInfo",client,"CURRENT_Slots",playerStatusTable[client]["CURRENT_Slots"])
end
addEvent("onUpdatePlayerCurrentSlots",true)
addEventHandler("onUpdatePlayerCurrentSlots",root,updatePlayerCurrentSlots)

function regenerateBlood()
	for i, player in ipairs(getElementsByType("player")) do
		if getElementData(player,"logedin") then
			local blood = playerStatusTable[player]["blood"]
			local thirst = playerStatusTable[player]["thirst"]
			local hunger = playerStatusTable[player]["food"]
			local bloodRegen = 0
			if blood < 12000 then
				local isWellFed = ((hunger+thirst)/2)/100
				if isWellFed <= 0.50 then
					return
				else
					if isPedDucked(player) then
						bloodRegen = math.round((1+4*math.sqrt((12000-blood)/12000)),0)
					else
						bloodRegen = math.round((1+10*(12000-blood)/12000))
					end
				end
				playerStatusTable[player]["blood"] = playerStatusTable[player]["blood"]+bloodRegen
			end
		end
	end
end
setTimer(regenerateBlood,60000,0)

function processBleeding()
	for i, player in ipairs(getElementsByType("player")) do
		if getElementData(player,"logedin") then
			local blood = playerStatusTable[player]["blood"]
			local hunger = playerStatusTable[player]["food"]
			local thirst = playerStatusTable[player]["thirst"]
			local bloodLossPerSec = playerStatusTable[player]["bleeding"] or 0
			local x,y,z = getElementPosition(player)
			if hunger <= 0 or thirst <= 0 then
				bloodLossPerSec = bloodLossPerSec+1
			end
			if bloodLossPerSec > 0 then
				triggerClientEvent(player,"onClientPlayerAddBloodFX",player,bloodLossPerSec)		
				playerStatusTable[player]["blood"] = playerStatusTable[player]["blood"]-bloodLossPerSec
			end
		end
	end	
end
setTimer(processBleeding,5000,0)

function setPlayerFracturedBones(player,fracturedBone)
	if getElementData(player,"logedin") then
		if fracturedBone == "fracturedLegs" then
			toggleControl(player,"jump",false)
			toggleControl(player,"sprint",false)
		elseif fracturedBone == "fracturedArms" then
			toggleControl(player,"aim_weapon",false)
			toggleControl(player,"fire",false)
		elseif not fracturedBone then
			toggleControl(player,"aim_weapon",true)
			toggleControl(player,"fire",true)
			toggleControl(player,"jump",true)
			toggleControl(player,"sprint",true)
		end
	end
end

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
				--addPlayerStats(player,"temperature",value)	
				if value == -0.01 then
					setElementData(player,"temperature_status",1)
				elseif value == -0.02 then
					setElementData(player,"temperature_status",2)
				elseif value <= -0.03 then
					setElementData(player,"temperature_status",3)
				elseif value == 0.01 then
					setElementData(player,"temperature_status",4)
				elseif value == 0.02 then
					setElementData(player,"temperature_status",5)
				elseif value >= 0.03 then
					setElementData(player,"temperature_status",6)
				end
			else
				if playerStatusTable[player]["temperature"] < 37 then
					value = 0.02
					setElementData(player,"temperature_status",5)
				end
			end
			if isElementInWater(player) then
				value = value+gameplayVariables["temperaturewater"]
				setElementData(player,"temperature_status",3)
			end	
			if getControlState (player,"sprint") and not playerStatusTable[player]["unconscious"] then
				if playerStatusTable[player]["temperature"] <= 37 then
					value = value+gameplayVariables["temperaturesprint"]
					setElementData(player,"temperature_status",4)
				end
			end
			if isPedInVehicle(player) then
				if playerStatusTable[player]["temperature"] <= 37 then
					value = value+0.008
					setElementData(player,"temperature_status",4)
				end
			end
			addPlayerStats (player,"temperature",value)
		end
	end
end
setTimer(checkTemperature,30000,0)

function setPlayerCold()
	for i, player in ipairs(getElementsByType("players")) do
		if getElementData(player,"logedin") then
			if playerStatusTable[player]["temperature"] <= 33 then
				playerStatusTable[player]["cold"] = true
				local x,y,z = getElementPosition(player)
				triggerClientEvent(player,"onClientPlayerCreateSneezeShake",player,x,y,z)
			elseif playerStatusTable[player]["temperature"] > 33 then
				playerStatusTable[player]["cold"] = false
			end
		end
	end
end
setTimer(setPlayerCold,40000,0)


local backpackLoadTable = {}
local ammoLoadTable = {}
local itemLoadTable = {}
local weaponLoadTable = {}
local mps = 0
local ammoLoad = 0
local itemLoad = 0
local weaponLoad = 0
local playerSpeed = 0
local playerHunger = 0
local playerThirst = 0
function getPlayerLoad()
	for i,player in ipairs(getElementsByType("player")) do
		if getElementData(player,"logedin") then
			backpackLoadTable = {}
			ammoLoadTable = {}
			itemLoadTable = {}
			weaponLoadTable = {}
			ammoLoad = 0
			itemLoad = 0
			weaponLoad = 0
			-- We iterate through the weight table and insert the appropriate values into the appropriate tables, depending on if the player has the item in his inventory
			for i, item in ipairs(itemWeightTable) do
			if getElementData(player,item[1]) and getElementData(player,item[1]) > 0 then
					if item[3] == "Weapon" then
						table.insert(weaponLoadTable,{item[2],getElementData(player,item[1])})
					elseif item[3] == "Ammo" then
						table.insert(ammoLoadTable,{item[2],getElementData(player,item[1])})
					elseif item[3] == "Item" then
						table.insert(itemLoadTable,{item[2],getElementData(player,item[1])})
					end
				end
			end
			-- Now we calculate the amount of all items in the player's inventory + their respective weight
			for i, load in ipairs(ammoLoadTable) do
				ammoLoad = ammoLoad+(load[1]*load[2])
			end
			for i, load in ipairs(itemLoadTable) do
				itemLoad = itemLoad+(load[1]*load[2])
			end
			for i, load in ipairs(weaponLoadTable) do
				weaponLoad = weaponLoad+(load[1]*load[2])
			end
			-- Merging every value together to create a specific value for further calculation
			local myLoad = (ammoLoad*0.2)+(itemLoad*0.1)+(weaponLoad*0.5)
			-- Checking the player's speed, since that's also important for determing how much hunger/thirst the player should lose, keeping in mind if the player is in a vehicle
			if not isPedInVehicle(player) then
				local speedx, speedy, speedz = getElementVelocity (player)
				local actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5) 
				mps = actualspeed * 50
			else
				mps = 20
			end
			playerSpeed = math.floor(mps*3.5)
			-- Final calculation for hunger based on blood, speed and weight of all items combined
			local hunger = (math.abs((((12000 - playerStatusTable[player]["blood"]) / 12000) * 5) + playerSpeed + myLoad) * 3)
			playerHunger = 0
			playerHunger = playerHunger+(hunger/70)
			--playerHunger = math.max(math.min(playerHunger,2160,0))
			-- Determining the thirst decrease value by using player speed and temperature
			local thirst = 2
			thirst = (playerSpeed+4)*3
			playerThirst = 0
			playerThirst = playerThirst+(thirst/60)*(playerStatusTable[player]["temperature"])/37
			--playerThirst = math.max(math.min(playerThirst,1440,0))
			local hungerMultiplier = 1
			if playerStatusTable[player]["food"] > 0 then
				if gameplayVariables["difficulty"] then
					if gameplayVariables["difficulty"] == "normal" then
						hungerMultiplier = 1
					elseif gameplayVariables["difficulty"] == "veteran" then
						hungerMultiplier = 1.5
					elseif gameplayVariables["difficulty"] == "hardcore" then
						hungerMultiplier = 3
					else
						hungerMultiplier = 1
					end
				else
					hungerMultiplier = 1
				end
				playerStatusTable[player]["food"] = playerStatusTable[player]["food"]-(playerHunger*hungerMultiplier)
			else
				playerStatusTable[player]["food"] = 0
			end
			
			local thirstMultiplier = 1
			if playerStatusTable[player]["thirst"] > 0 then
				if gameplayVariables["difficulty"] then
					if gameplayVariables["difficulty"] == "normal" then
						thirstMultiplier = 1
					elseif gameplayVariables["difficulty"] == "veteran" then
						thirstMultiplier = 1.5
					elseif gameplayVariables["difficulty"] == "hardcore" then
						thirstMultiplier = 3
					else
						thirstMultiplier = 1
					end
				else
					thirstMultiplier = 1
				end
				playerStatusTable[player]["thirst"] = playerStatusTable[player]["thirst"]-(playerThirst*thirstMultiplier)
			else
				playerStatusTable[player]["thirst"] = 0
			end
			
		end
	end
end
setTimer(getPlayerLoad,60000,0)

function checkHumanity()
	for i,player in ipairs(getElementsByType("player")) do
		if getElementData(player,"logedin") then
			if playerStatusTable[player]["humanity"] < 2500 then
				addPlayerStats (player,"humanity",30)
				if playerStatusTable[player]["humanity"] > 2000 then
					playerStatusTable[player]["bandit"] = false
				end
			end
		end	
	end
end
setTimer(checkHumanity,60000,0)

function checkInfection()
	for i,player in ipairs(getElementsByType("player")) do
		if getElementData(player,"logedin") then
			if playerStatusTable[player]["infection"] then
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
                triggerClientEvent(source, "displayClientInfo", source, "Info","Body has been buried...", 22, 255, 0)
                setTimer(function(colision)
                    if isElement (getElementData(colision,"parent")) then
                        destroyElement(getElementData(colision,"parent"))
                    end
                    destroyElement(colision)
                end,2000,1,col)
            end 
        end
    else
      triggerClientEvent(source, "displayClientInfo", source, "Info", "You need a shovel!", 255, 51, 51)
    end
end
addEvent("onPlayerHideBody",true)
addEventHandler("onPlayerHideBody",getRootElement(),onPlayerHideBody)

function changePlayerBeardAndHair()
	for k, player in ipairs(getElementsByType("player")) do
	  if getElementModel(player) == 0 then
		 editPlayerBeardAndHair(player)
	  end
    end
end

if gameplayVariables["newclothingsystem"] then
	setTimer(changePlayerBeardAndHair, 120000, 0)
end

function editPlayerBeardAndHair(thePlayer)
	local pAliveTime = getElementData(thePlayer, "hoursalive")
	if getElementData(thePlayer, "logedin") then
		if not pAliveTime then return end
		if pAliveTime == 0 or pAliveTime == 1 then
			addPedClothes(thePlayer, "player_face", "head", 1)
		elseif pAliveTime == 2 or pAliveTime == 3 then
			addPedClothes(thePlayer, "tash", "head", 1)
		elseif pAliveTime == 4 or pAliveTime == 5 or pAliveTime == 6 then
			addPedClothes(thePlayer, "goatee", "head", 1)
		elseif pAliveTime == 7 or pAliveTime == 8 or pAliveTime == 9 then
			addPedClothes(thePlayer, "afrogoatee", "afro", 1)
		elseif pAliveTime >= 10 then
			addPedClothes(thePlayer, "afrobeard", "afro", 1)
		end
	end
end

function resetPlayerBeard(source) -- Not working for the moment
	addPedClothes(source, "afrobeard", "afro", 1)
end
addEvent("onPlayerUsingHaircut", true)
addEventHandler("onPlayerUsingHaircut", getRootElement(), resetPlayerBeard)


function setPlayerUnconsciousAnimation(value,player)
	if value == "unconscious" then
		setPedAnimation(player,"ped","FLOOR_hit_f",-1,false)
	elseif value == "awake" then
		setPedAnimation(player,"ped","getup_front",-1,false)
		setTimer(function() setPedAnimation (player,false) end,1300,1)
	end
end
addEvent("onPlayerUnconsciousAnimation",true)
addEventHandler("onPlayerUnconsciousAnimation",root,setPlayerUnconsciousAnimation)


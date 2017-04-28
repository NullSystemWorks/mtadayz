--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: actions_vehicles.lua					*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]


function onPlayerEnterDayzVehicle(veh,seat)
	local col = getElementData(veh,"parent")
	local id = getElementModel(veh)
	if not seat == 1 then return end
	local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (id)
	setVehicleEngineState ( veh, false )
	setElementData(veh,"maxfuel",getVehicleMaxFuel(col))
	setElementData(veh,"needtires",tires)
	setElementData(veh,"needengines",engine)
	setElementData(veh,"needparts",parts)
	setElementData(veh,"needscrap",scrap)
	setElementData(veh,"needglass",glass)
	setElementData(veh,"needrotary",rotary)
	setElementData(col,"vehicle_name",name)
	if ((getElementData(col,"Tire_inVehicle") or 0) < tonumber(tires)) then
		setVehicleEngineState ( veh, false )
		return	
	end
	if ((getElementData(col,"Engine_inVehicle") or 0) < tonumber(engine)) then
		setVehicleEngineState ( veh, false )
		return
	end
	if ((getElementData(col,"Rotary_inVehicle") or 0) < tonumber(rotary)) then
		setVehicleEngineState ( veh, false )
		return
	end
	if not getElementData(col,"Parts_inVehicle") then
		setElementData(col,"Parts_inVehicle",math.random(0,parts))
	end
	if (getElementData(col,"fuel") or 0) < 0 then
		if getElementModel(veh) ~= 509 then
			triggerClientEvent (source, "displayClientInfo", source,"Vehicle","No tank left in this vehicle!",22,255,0)
			setVehicleEngineState ( veh, false )
			return
		end
	end
	setVehicleEngineState ( veh, true )
	if id == 490 then
		setElementData(source,"GPS",getElementData(source,"GPS")+1)
	end
	if getElementModel(veh) ~= 509 then
		bindKey(source,"k","down",setEngineStateByPlayer)
		outputChatBox("Press 'K' to turn the engine on/off!",source)
	end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), onPlayerEnterDayzVehicle )

function onPlayerExitDayzVehicle(veh,seat)
	if seat == 0 then
		local id = getElementModel(veh)
		setVehicleEngineState ( veh, false )
		unbindKey(source,"k","down",setEngineStateByPlayer)
		if id == 490 then
			setElementData(source,"GPS",getElementData(source,"GPS")-1)
		end
	end	
end
addEventHandler ( "onPlayerVehicleExit", getRootElement(), onPlayerExitDayzVehicle )

function getVehicleFuelRemove (id,col)
	for i,veh in ipairs(vehicleFuelConsumption) do
		if veh[1] == id then
			if not getElementData(col,"Parts_inVehicle") == 1 then
				return veh[2]*2
			end
			return veh[2]
		end
	end
end

function setVehiclesFuelPerMinute ()
	if not gameplayVariables["fuelEnabled"] == true then return end
	for i,veh in ipairs(getElementsByType("vehicle")) do
		if getVehicleEngineState(veh) == true then
			if getElementModel(veh) ~= 509 then 
				if getElementData(getElementData(veh,"parent"),"fuel") > 0 then
					setElementData(getElementData(veh,"parent"),"fuel",getElementData(getElementData(veh,"parent"),"fuel")-getVehicleFuelRemove(getElementModel(veh),getElementData(veh,"parent")))
				else
					setVehicleEngineState ( veh, false )
				end
			end
		end
	end
end
setTimer(setVehiclesFuelPerMinute,10000,0)

function isVehicleReadyToStart2 (veh)
	if getElementData(getElementData(veh,"parent"),"fuel") > 0 then
		local tires,engine,parts,scrap,glass,rotary = getVehicleAddonInfos (getElementModel(veh))
		if (getElementData(getElementData(veh,"parent"),"Tire_inVehicle") or 0) > tonumber(tires) and (getElementData(getElementData(veh,"parent"),"Engine_inVehicle") or 0) > tonumber(engine) and (getElementData(getElementData(veh,"parent"),"Rotary_inVehicle") or 0) > tonumber(rotary) then 
			setVehicleEngineState ( veh, true )
		end
	end
	setTimer(isVehicleReadyToStart2,1000,1,veh)
end

repairTimer = {}
function repairVehicle (veh)
	if repairTimer[veh] then triggerClientEvent (source, "displayClientInfo", source,"Vehicle",name.." is currently being repaired!",255,0,0) return end
	local tires,engine,parts,scrap,glass,rotary,name = getVehicleAddonInfos (getElementModel(veh))
	if getElementData(source,"Toolbox") and getElementData(source,"Toolbox") > 0 and getElementData(source,"Scrap Metal") and getElementData(source,"Scrap Metal") > 0 then
		local health = math.floor(getElementHealth(veh))
		repairTimer[veh] = setTimer(fixVehicleDayZ,(1000-health)*120,1,veh,source,name)
		setElementFrozen (veh,true)
		setElementData(veh,"repairer",source)
		setElementData(source,"repairingvehicle",veh)
		triggerClientEvent(source,"onPlayerActionPlaySound",source,"repair")
		setPedAnimation (source,"SCRATCHING","sclng_r",-1,false)
		triggerClientEvent (source, "displayClientInfo", source,"Vehicle","You started to repair "..name,0,255,0)
	else
		triggerClientEvent (source, "displayClientInfo", source,"Vehicle","You need Scrap Metal to repair a vehicle!",255,0,0)
	end
end
addEvent("repairVehicle",true)
addEventHandler("repairVehicle",getRootElement(),repairVehicle)

function fixVehicleDayZ(veh,player,name)
	local scrap = getElementData(player,"Scrap Metal")
	if scrap then
		setElementHealth(veh,getElementHealth(veh)+200)
		if getElementHealth(veh) >= 1000 then 
			setElementHealth(veh,1000) 
			fixVehicle (veh) 
		end
		setPedAnimation(player,false)
		setElementData(player,"Scrap Metal",getElementData(player,"Scrap Metal")-1)
		setElementFrozen (veh,false)
		repairTimer[veh] = nil
		setElementData(veh,"repairer",nil)
		setElementData(player,"repairingvehicle",nil)
		triggerClientEvent (player, "displayClientInfo", player,"Vehicle","You finished repairing "..name,0,255,0)
	end
end

function stopFixxingWhileMoving()
	local veh = getElementData(source,"repairingvehicle")
	setPedAnimation(source)
	setElementFrozen (veh,false)
	setElementData(veh,"repairer",nil)
	setElementData(source,"repairingvehicle",nil)
	triggerClientEvent (source, "displayClientInfo", source,"Vehicle","You stopped repairing "..getVehicleName(veh),255,22,0)
	killTimer(repairTimer[veh])
	repairTimer[veh] = nil
end
addEvent("onClientMovesWhileAnimation",true)
addEventHandler("onClientMovesWhileAnimation",getRootElement(),stopFixxingWhileMoving)

function debugFixxing()
	for i,veh in ipairs(getElementsByType("vehicle")) do
		if getElementData(veh,"repairer") == source then
			outputDebugString("Vehicle repairer disconnected - destroyed tables")
			killTimer(repairTimer[veh])
			setElementFrozen (veh,false)
			repairTimer[veh] = nil
			setElementData(veh,"repairer",nil)
		end	
	end
end
addEventHandler("onPlayerQuit",getRootElement(),debugFixxing)

function setEngineStateByPlayer (playersource)
	local veh = getPedOccupiedVehicle (playersource)
	if (getPedOccupiedVehicleSeat(playersource) ~= 0) then return end
	if getElementData(getElementData(veh,"parent"),"fuel") <= 0 then 
		return
	else
		setVehicleEngineState (veh, not getVehicleEngineState(veh))
	end
	if getVehicleEngineState(veh) then
		triggerClientEvent (playersource, "displayClientInfo", playersource,"Vehicle","Engine started!",22,255,0)
	else
		triggerClientEvent (playersource, "displayClientInfo", playersource,"Vehicle","Engine stopped!",255,22,0)
	end
end

function takeVehicleComponent(veh,action,itemName)
	if getElementData(source,"Toolbox") > 0 then
		setPedAnimation (source,"BOMBER","BOM_Plant",3000,false,false,nil,false)
		setTimer(function(source,veh,action)
			if action == "takewheel" then
				local col = getElementData(veh,"parent")
				setElementData(col,"Tire_inVehicle",getElementData(col,"Tire_inVehicle")-1)
				setElementData(source,"Tire",getElementData(source,"Tire")+1)
				triggerClientEvent (source, "displayClientInfo", source,"Vehicle","You took a wheel out.",0,255,0)
			elseif action == "takeengine" then
				local col = getElementData(veh,"parent")
				setElementData(col,"Engine_inVehicle",getElementData(col,"Engine_inVehicle")-1)
				setElementData(source,"Engine",getElementData(source,"Engine")+1)
				triggerClientEvent (source, "displayClientInfo", source,"Vehicle","You took the engine out.",0,255,0)
			elseif action == "siphon" then
				local col = getElementData(veh,"parent")
				local fuel = getElementData(col,"fuel")
				if fuel >= 20 then
					setElementData(col,"fuel",getElementData(col,"fuel")-20)
				else
					setElementData(col,"fuel",0)
				end
				setElementData(source,"Full Gas Canister",getElementData(source,"Full Gas Canister")+1)
				setElementData(source,"Empty Gas Canister",getElementData(source,"Empty Gas Canister")-1)
				triggerClientEvent (source, "displayClientInfo", source,"Vehicle","You siphoned some fuel.",0,255,0)
			end
		end,3000,1,source,veh,action)
	else
		triggerClientEvent (source, "displayClientInfo", source,"Vehicle","You need a toolbox!",255,0,0)
	end
end
addEvent("takeVehicleComponent",true)
addEventHandler("takeVehicleComponent",root,takeVehicleComponent)

function respawnVehiclesInWater()
	for i,veh in ipairs(getElementsByType("vehicle")) do
		if isElementInWater(veh) then
			if getElementModel(veh) ~= 453 or getElementModel(veh) ~= 595 or getElementModel(veh) ~= 473 then
				local col = getElementData(veh,"parent")
				if col then
					id,x,y,z  = getElementData(col,"spawn")[1],getElementData(col,"spawn")[2],getElementData(col,"spawn")[3],getElementData(col,"spawn")[4]
					respawnDayZVehicle(id,x,y,z,veh,col,getElementData(col,"MAX_Slots"))
				end
			end
		end
	end
end
setTimer(respawnVehiclesInWater,gameplayVariables["watervehiclerespawn"],0)

local respawnExplodedVehicleTimer = 0
function respawnDayZVehicles(player)
    if player then
        if (not hasObjectPermissionTo(player,"function.banPlayer")) then
            return --Stops players from using the respawn command
        end
    end
	
for k, veh in ipairs(getElementsByType("vehicle")) do
		if isVehicleBlown(veh) or isElementInWater(veh) then
			if getElementModel(veh) ~= 453 or getElementModel(veh) ~= 595 or getElementModel(veh) ~= 473  then
				local col = getElementData(veh,"parent")
				if col then
					id,x,y,z  = getElementData(col,"spawn")[1],getElementData(col,"spawn")[2],getElementData(col,"spawn")[3],getElementData(col,"spawn")[4]
					respawnDayZVehicle(id,x,y,z,veh,col,getElementData(col,"MAX_Slots"))
					if isTimer(respawnExplodedVehicleTimer) then
						killTimer(respawnExplodedVehicleTimer)
					end
				end
			end
		end
	end
end
addCommandHandler ( "respawndayzvehicles", respawnDayZVehicles ) -- Respawn blown and sunken vehicles when typed.	

function notifyAboutExplosion()
	local col = getElementData(source,"parent")
	local x1,y1,z1 = getElementPosition(source)
	id,x,y,z  = getElementData(col,"spawn")[1],getElementData(col,"spawn")[2],getElementData(col,"spawn")[3],getElementData(col,"spawn")[4]
    respawnExplodedVehicleTimer = setTimer(respawnDayZVehicle,gameplayVariables["explodedvehiclesrespawn"],1,id,x,y,z,source,col,getElementData(col,"MAX_Slots"))
	setElementData(col,"deadVehicle",true)
	setElementData(source,"isExploded",true)
	createExplosion (x1+4,y1+1,z1,4)
	createExplosion (x1+2,y1-4,z1,4)
	createExplosion (x1-1,y1+5,z1,4)
	createExplosion (x1-4,y1,z1-2,4)
end
addEventHandler("onVehicleExplode", getRootElement(), notifyAboutExplosion)

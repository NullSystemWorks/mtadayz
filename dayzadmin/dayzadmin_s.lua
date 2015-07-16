--[[
/**
	Name: DayZ Admin Panel
	Author: L
	Version: 1.0.0
	Description: Comprehensive administration tool for MTA DayZ
*/
]]

local vehicleInfo = {
-- {Model, Wheels, Engine, TankParts, ScrapMetal, WindscreenGlass, RotaryParts, Name, ColsphereSize, Slots, Fuel,RealName}

-- VEHICLES
{471,4,1,1,1,0,0,"ATV",2,50,30,"Quadbike"},
{431,6,1,1,1,4,0,"Bus",5,50,100,"Bus"},
{509,2,0,0,1,0,0,"Old Bike",2,0,0,"Bike"},
{546,4,1,1,1,4,0,"GAZ",3,50,200,"Intruder"},
{433,8,1,1,1,3,0,"Military Offroad",4,50,200,"Barracks"},
{468,2,1,1,1,0,0,"Motorcycle",2,5,55,"Sanchez"},
{543,4,1,1,1,4,0,"Offroad Pickup Truck",3,50,100,"Sadler"},
{426,4,1,1,1,5,0,"Old Hatchback",3,50,50,"Premier"},
{422,4,1,1,1,2,0,"Pickup Truck",3,50,200,"Bobcat"},
{418,4,4,1,1,0,0,"S1203 Van",3,50,60,"Moonbeam"},
{400,4,1,1,1,4,0,"Skoda",3,75,200,"Landstalker"},
{531,4,1,1,1,3,0,"Tractor",3,50,100,"Tractor"},
{470,4,1,1,1,6,0,"UAZ",3,50,100,"Patriot"},
{455,6,1,1,1,0,0,"Ural Civilian",5,200,200,"Flatbed"},
{490,4,1,1,1,4,0,"SUV",3,50,200,"FBI Rancher"},
{478,6,1,1,1,0,0,"V3S Civilian",5,200,160,"Walton"},

-- AIRCRAFT
{469,0,1,0,4,8,1,"AH6X Little Bird",7,20,1000,"Sparrow"},
{417,0,1,0,4,8,1,"UH-1H Huey",7,50,1000,"Leviathan"},
{487,0,1,0,4,8,1,"Mi-17",7,20,1000,"Maverick"},
{488,0,1,0,2,4,1,"MH6J",7,20,600,"News Chopper"},
{511,2,1,0,1,2,2,"An-2 Biplane",7,100,400,"Beagle"},

-- BOATS
{453,0,1,0,1,2,0,"Fishing Boat",4,400,100,"Reefer"},
{595,0,1,0,1,2,0,"Small Boat",3,0,100,"Launch"},
{473,0,1,0,1,1,0,"PBX",2,0,100,"Dinghy"},
}

function getVehicleInfos(id)
	for i,veh in ipairs(vehicleInfo) do
		if veh[1] == id then
			return veh[2],veh[3], veh[4], veh[5], veh[6], veh[7],veh[8],veh[9], veh[10], veh[11], veh[12]
		end
	end
end

-- Check if the player can open the Admin Panel by lil_Toady
addEventHandler("onPlayerLogin", root, 
function()
	if (hasObjectPermissionTo(source, "general.adminpanel")) then
		initialiseAdminPanel(source)
	end
end)

local PanelIsOpen = false

-- Second check, in case something goes wrong or player loses permission to open Admin Panel
function openDayZAdminPanel (player,cmd)
	if (hasObjectPermissionTo (player, "general.adminpanel")) then
		if not PanelIsOpen then
			triggerClientEvent (player, "onAdminPanelOpen", root)
			PanelIsOpen = true
		else
			triggerClientEvent (player, "onAdminPanelClose", root)
			PanelIsOpen = false
		end
	end
end
addCommandHandler ("dayz", openDayZAdminPanel)

function initialiseAdminPanel(player)
	bindKey (player, "F7", "down", "dayz" )
end

addEventHandler("onPlayerChat", root,
	function(msg, msgType)
		triggerClientEvent("onPlayerMessageEditMemo",root,source,msg,msgType)
	end)

addEvent("onAdminPanelEditInventory",true)
addEventHandler("onAdminPanelEditInventory", root,
function(pName, item, quantity)
	local theTime = getRealTime()
	local hour = theTime.hour
	local minute = theTime.minute
	local seconds = theTime.second
	if hour < 10 then
		hour = "0"..hour
	else
		hour = theTime.hour
	end
	if minute < 10 then
		minute  = "0"..minute
	else
		minute = theTime.minute
	end
	if seconds < 10 then
		minute = "0"..seconds
	else
		seconds = theTime.second
	end
	setElementData(getPlayerFromName(pName), item, quantity)
	outputChatBox("Given "..quantity.." "..item.." to "..pName, source, 255, 255, 0)
	outputChatBox(getAccountName(getPlayerAccount(client)).." gave you "..quantity.." "..item, getPlayerFromName(pName), 255, 255, 0)
	exports.DayZ:saveLog("["..hour..":"..minute..":"..seconds.."] "..getAccountName(getPlayerAccount(getPlayerFromName(pName))).." got an item via DayZ Admin Panel: "..item.."(x"..quantity..") by "..getAccountName(getPlayerAccount(client)).."\n","admin")
end)

function onAdminPanelSetPlayerStat(name, stat, value)
	setElementData(getPlayerFromName(name), string.lower(stat), tonumber(value))
	outputChatBox("Set "..stat.." of "..name.." to "..value,source,0,255,0)
end
addEvent("onAdminPanelSetPlayerStat",true)
addEventHandler("onAdminPanelSetPlayerStat",root,onAdminPanelSetPlayerStat)

function onAdminPanelSendGlobalMessage(message)
	outputChatBox("[GLOBAL MESSAGE]"..getPlayerName(source)..": "..message,root,255,0,0,true)
end
addEvent("onAdminPanelSendGlobalMessage",true)
addEventHandler("onAdminPanelSendGlobalMessage",root,onAdminPanelSendGlobalMessage)

function onAdminPanelKillPlayer(player)
	setElementData(getPlayerFromName(player), "blood", -1)
	outputChatBox("You killed "..player.."!",source,255,0,0)
end
addEvent("onAdminPanelKillPlayer",true)
addEventHandler("onAdminPanelKillPlayer",root,onAdminPanelKillPlayer)

function onAdminPanelHealPlayer(player)
	setElementData(getPlayerFromName(player), "blood", 12000)
	setElementData(getPlayerFromName(player), "food", 100)
	setElementData(getPlayerFromName(player), "thirst", 100)
	setElementData(getPlayerFromName(player), "temperature", 37)
	setElementData(getPlayerFromName(player), "cold", false)
	setElementData(getPlayerFromName(player), "pain", false)
	setElementData(getPlayerFromName(player), "infection", false)
	outputChatBox("You healed "..player..".",source,0,255,0)
end
addEvent("onAdminPanelHealPlayer",true)
addEventHandler("onAdminPanelHealPlayer",root,onAdminPanelHealPlayer)

local skinTable = {
{"Camouflage",287,"male"},
{"Civilian",179,"male"},
{"Ghillie Suit",285,"male"},
{"Survivor",73,"male"},

{"Survivor (Female)",192,"female"},
{"Civilian (Female)",172,"female"},
}

function onAdminPanelSetPlayerSkin(player,skin)
	for i,data in ipairs(skinTable) do
		if skin == data[1] then
			setElementModel(getPlayerFromName(player),data[2])
			setElementData(getPlayerFromName(player),"skin",data[2])
			setElementData(getPlayerFromName(player),"gender",data[3])
			outputChatBox("Skin of "..player.." has been changed to "..data[1],source,0,255,0)
		end
	end
end
addEvent("onAdminPanelSetPlayerSkin",true)
addEventHandler("onAdminPanelSetPlayerSkin",root,onAdminPanelSetPlayerSkin)

function onAdminPanelFixVehicle(vehicle,player)
	fixVehicle(vehicle)
	outputChatBox("Vehicle of "..player.." has been fixed.",source,0,255,0)
end
addEvent("onAdminPanelFixVehicle",true)
addEventHandler("onAdminPanelFixVehicle",root,onAdminPanelFixVehicle)

function onAdminPanelSpawnVehicle(player,vehicle,x,y,z)
	--[[
	-- Do not uncomment this, as the vehicle ID's are currently unfiltered. Said ID's are essential for respawning vehicles and their items.
	local model = getVehicleModelFromName(vehicle)
	local tires,engine,parts,scrap,glass,rotary,name,colsphere,slots,fuel = getVehicleInfos(model)
	local veh = createVehicle(model,x,y+5,z,0,0,0)
	local vehCol = createColSphere(x,y+5,z,colsphere)
	attachElements ( vehCol, veh, 0, 0, 0 )
	setElementData(vehCol,"parent",veh)
	setElementData(veh,"parent",vehCol)
	setElementData(vehCol,"vehicle",true)
	setElementData(vehCol,"MAX_Slots",slots)
	setElementData(vehCol,"Tire_inVehicle",tires)
	setElementData(vehCol,"Engine_inVehicle",engine)
	setElementData(vehCol,"Parts_inVehicle",parts)
	setElementData(vehCol,"Scrap_inVehicle",scrap)
	setElementData(vehCol,"Glass_inVehicle",glass)
	setElementData(vehCol,"Rotary_inVehicle",rotary)
	setElementData(vehCol,"vehicle_name",name)
	--vehicle_indentifikation	
	setElementData(vehCol,"spawn",{473,x,y,z})
	--others
	setElementData(vehCol,"fuel",fuel)
	setElementID(vehCol,"0")
	setElementHealth(veh,1000)
	outputChatBox("You spawned a "..vehicle.." for "..player,source,0,255,0)
	]]
end
addEvent("onAdminPanelSpawnVehicle",true)
addEventHandler("onAdminPanelSpawnVehicle",root,onAdminPanelSpawnVehicle)

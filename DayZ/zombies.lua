--[[
#---------------------------------------------------------------#
----*			DayZ MTA Script zombies.lua				    *----
----* This Script is owned by Marwin, you are not allowed to use or own it.
----* Owner: Marwin W., Germany, Lower Saxony, Otterndorf
----* Skype: xxmavxx96
----* Developers: L, CiBeR,	Jboy							*----
#---------------------------------------------------------------#
]]

ZombiePedSkins = {22,56,67,68,69,70,92,97,105,107,108,126,127,128,152,162,167,188,195,206,209,212,229,230,258,264,277,280 } --ALTERNATE SKIN LISTS FOR ZOMBIES (SHORTER LIST IS TEXTURED ZOMBIES ONLY)

ZombieTypes = {

["zZombie_Base"] = {},
["z_hunter"] = {},
["z_teacher"] = {},
["z_suit1"] = {},
["z_suit2"] = {},
["z_worker1"] = {},
["z_worker2"] = {},
["z_worker3"] = {},
["z_villager1"] = {},
["z_villager1"] = {},
["z_villager1"] = {},
["z_soldier"] = {},
["z_soldier_heavy"] = {},
["z_policeman"] = {},
["z_priest"] = {},

}

local ZombieLoot = {
{22,"civilian"},
{56,"civilian"},
{67,"civilian"},
{68,"civilian"},
{69,"civilian"},
{70,"hunter"},
{92,"hunter"},
{97,"hunter"},
{105,"hunter"},
{107,"generic"},
{108,"generic"},
{126,"generic"},
{127,"generic"},
{264,"generic"},
{277,"generic"},
{280,"generic"},
{128,"medical"},
{152,"medical"},
{162,"medical"},
{167,"medical"},
{188,"military"},
{195,"military"},
{206,"military"},
{209,"military"},
{212,"policeman"},
{229,"policeman"},
{230,"policeman"},
{258,"policeman"}
}

setElementData(getRootElement(),"zombiestotal",0)
setElementData(getRootElement(),"zombiesalive",0)
createTeam("Zombies")

local zombieLootType = {

["civilian"] = {
{"Empty Soda Can",2673,0.5,0,8.82},
{"Empty Tin Can",2673,0.5,0,8.82},
{"Broken Whiskey Bottle",2673,0.5,0,8.82},
{"Soda Can (Cola)",2647,1,0,11.76},
{"Soda Can (Pepsi)",2856,1,0,8.82},
{"Baked Beans",1582,1,0,4.90},
{"Sardines",2770,1,0,4.90},
{"Frank & Beans",2601,1,0,4.90},
{"Pasta",2768,1,0,4.90},
{".45 ACP Cartridge",3013,2,0,4.90},
{"2Rnd. Slug",2358,2,0,4.90},
{"12 Gauge Pellet",2358,2,0,4.90},
{"Bandage",1578,0.5,0,5.88},
{"Painkiller",2709,3,0,5.88},
},

["hunter"] = {
{"Bandage",1578,0.5,0,27.78},
{".45 ACP Cartridge",3013,2,0,5.56},
{"9.3x62mm Cartridge",2358,2,0,13.89},
{".303 British Cartridge",2358,2,0,13.89},
{"Empty Water Bottle",2683,1,0,5.56},
{"Bolt",2041,2,0,27.78},
{"Heat Pack",1576,5,0,5.56},
},

["generic"] = {
{"Empty Soda Can",2673,0.5,0,6},
{"Empty Tin Can",2673,0.5,0,6},
{"Broken Whiskey Bottle",2673,0.5,0,4},
{"Soda Can (Cola)",2647,1,0,6},
{"Soda Can (Pepsi)",2856,1,0,4},
{"Baked Beans",1582,1,0,1},
{"Sardines",2770,1,0,1},
{"Frank & Beans",2601,1,0,1},
{"Pasta",2768,1,0,1},
{"Empty Water Bottle",2683,1,0,1},
{"Water Bottle",2683,1,0,1},
{"Bandage",1578,0.5,0,11},
{".45 ACP Cartridge",3013,2,0,3},
{"9.3x62mm Cartridge",2358,2,0,1},
{".303 British Cartridge",2358,2,0,4},
{"9x19mm SD Cartridge",3013,2,0,4},
{"2Rnd. Slug",2358,2,0,5},
{"12 Gauge Pellet",2358,2,0,5},
{"9x18mm Cartridge",2358,2,0,9},
{"1866 Slug",2358,2,0,2},
{"Bolt",2041,2,0,4},
{"Road Flare",324,1,90,7},
{"Painkiller",2709,3,0,2},
{"Heat Pack",1576,5,0,4},
{"Assault Pack (ACU)",3026,1,0,6},
},

["medical"] = {
{"Bandage",1578,0.5,0,43.48},
{"Painkiller",2709,3,0,21.74},
{"Morphine",1579,1,0,21.74},
{"Heat Pack",1576,5,0,4.35},
},

["military"] = {
{"Empty Tin Can",2673,0.5,0,17.82},
{"Empty Soda Can",2673,0.5,0,8.91},
{"Soda Can (Cola)",2647,1,0,0.99},
{"Soda Can (Pepsi)",2856,1,0,0.99},
{"Bandage",1578,0.5,0,3.96},
{"Painkiller",2709,3,0,3.96},
{"Morphine",1579,1,0,0.99},
{"5.56x45mm Cartridge",1271,2,0,3.96},
{"9.3x62mm Cartridge",2358,2,0,3.96},
{".45 ACP Cartridge",3013,2,0,4.95},
{"9x19mm SD Cartridge",3013,2,0,0.99},
{"5.45x39mm Cartridge",1271,2,0,3.96},
{"12 Gauge Pellet",2358,2,0,3.96},
{"1866 Slug",2358,2,0,3.96},
{"2Rnd. Slug",2358,2,0,3.96},
{"9x19mm Cartridge",2041,2,0,1.98},
{"Bolt",2041,2,0,1.98},
{"Road Flare",324,1,90,4},
{"Wire Fence",933,0.25,0,1},
{"Grenade",342,1,0,0.99},
{"Heat Pack",1576,5,0,3.96},
{"Area 69 Keybard",1581,1,0,7},
{"San Fierro Carrier Keycard",1581,1,0,7},
},

["policeman"] = {
{"Bandage",1578,0.5,0,31.25},
{".45 ACP Cartridge",3013,2,0,25},
{"9x18mm Cartridge",2358,2,0,9.38},
{"1866 Slug",2358,2,0,9.38},
{"12 Gauge Pellet",2358,2,0,16.63},
{"Road Flare",324,1,90,9.38},
{"San Fierro Carrier Keycard",1581,1,0,7},
},
}


function createZombieTable (player)
	setElementData(player,"playerZombies",{"no","no","no","no","no","no","no","no","no"})
	setElementData(player,"spawnedzombies",0)
end

function createZomieForPlayer (x,y,z)
	x,y,z = getElementPosition(source)
	counter = 0
	if getElementData(source,"lastzombiespawnposition") then
		local xL,yL,zL = getElementData(source,"lastzombiespawnposition")[1] or false,getElementData(source,"lastzombiespawnposition")[2] or false,getElementData(source,"lastzombiespawnposition")[3] or false
		if xL then
			if getDistanceBetweenPoints3D (x,y,z,xL,yL,zL) < 50 then
				return
			end
		end
	end	
	if getElementData(source,"spawnedzombies")+3 <= gameplayVariables["playerzombies"] then
	for i = 1, gameplayVariables["amountzombies"] do
		counter = counter+1
		local number1 = math.random(-50,50)
		local number2 = math.random(-50,50)
		if number1 < 18 and number1 > -18 then
			number1 = 20
		end
		if number2 < 18 and number2 > -18 then
			number2 = -20
		end
		randomZskin = math.random ( 1, table.getn ( ZombiePedSkins ) )	
		zombie = call (getResourceFromName("slothbot"),"spawnBot",x+number1,y+number2,z,math.random(0,360),ZombiePedSkins[randomZskin],0,0,getTeamFromName("Zombies"))
		setElementData(zombie,"zombie",true)
		setElementData(zombie,"blood",gameplayVariables["zombieblood"])
		setElementData(zombie,"owner",source)
		call ( getResourceFromName ( "slothbot" ), "setBotGuard", zombie, x+number1,y+number2,z, false)
		setPedAnimation (zombie, "RYDER", "RYD_Die_PT1", -1, true, true, true)
	end
	setElementData(source,"lastzombiespawnposition",{x,y,z})
	setElementData(source,"spawnedzombies",getElementData(source,"spawnedzombies")+gameplayVariables["amountzombies"])
	end
end
addEvent("createZomieForPlayer",true)
addEventHandler("createZomieForPlayer",getRootElement(),createZomieForPlayer)

function zombieCheck1 ()
for i,ped in ipairs(getElementsByType("ped")) do
	if getElementData(ped,"zombie") then 
		goReturn = false
		local zombieCreator = getElementData(ped,"owner")
		if not isElement(zombieCreator) then 
			setElementData ( ped, "status", "dead" )	
			setElementData ( ped, "target", nil )
			setElementData ( ped, "leader", nil )
			destroyElement(ped)
			goReturn = true
		end
		if not goReturn then
		local xZ,yZ,zZ = getElementPosition(getElementData(ped,"owner"))
		local x,y,z = getElementPosition(ped)
		if getDistanceBetweenPoints3D (x,y,z,xZ,yZ,zZ) > 60 then
			if getElementData(zombieCreator,"spawnedzombies")-1 >= 0 then
				setElementData(zombieCreator,"spawnedzombies",getElementData(zombieCreator,"spawnedzombies")-1)
			end	
			setElementData ( ped, "status", "dead" )	
			setElementData ( ped, "target", nil )
			setElementData ( ped, "leader", nil )
			destroyElement(ped)
		end
		end
	end				
end		
end
setTimer(zombieCheck1,20000,0)

function botAttack (ped)
	call ( getResourceFromName ( "slothbot" ), "setBotFollow", ped, source)
	setPedAnimation(ped,false)
end
addEvent("botAttack",true)
addEventHandler("botAttack",getRootElement(),botAttack)

function botStopFollow (ped)
	local x,y,z = getElementPositon(ped)
	call ( getResourceFromName ( "slothbot" ), "setBotGuard", ped, x, y, z, false)
end
addEvent("botStopFollow",true)
addEventHandler("botStopFollow",getRootElement(),botStopFollow)

function outputChange(dataName,oldValue)
	if getElementType(source) == "player" then -- check if the element is a player
		if dataName == "spawnedzombies" then
			local newValue = getElementData(source,dataName) -- find the new value
			outputChatBox(oldValue.." to "..newValue) -- output the change for the affected player
		end
	end
end
--addEventHandler("onElementDataChange",getRootElement(),outputChange)

function destroyTable ()
for i,ped in ipairs(getElementsByType("ped")) do
	if getElementData(ped,"zombie") then 
		if getElementData(ped,"owner") == source then
			setElementData(getElementData(ped,"owner"),"spawnedzombies",getElementData(getElementData(ped,"owner"),"spawnedzombies")-1)
			setElementData ( ped, "status", "dead" )
			setElementData ( ped, "target", nil )
			setElementData ( ped, "leader", nil )
			destroyElement(ped)
		end
	end				
end
end
--addEventHandler("kilLDayZPlayer",getRootElement(),destroyTable)
--addEventHandler("onPlayerQuit",getRootElement(),destroyTable)

function destroyDeadZombie (ped,pedCol)
	destroyElement(ped)
	destroyElement(pedCol)
end

function zombieKilled (killer,headshot)
	if killer then
		setElementData(killer,"zombieskilled",getElementData(killer,"zombieskilled")+1)
	end	
	local skin = getElementModel(source)
	local x,y,z = getElementPosition(source)
	local ped = createPed(skin,x,y,z)
	local pedCol = createColSphere(x,y,z,1.5)
	killPed(ped)
	setTimer(destroyDeadZombie,360000 ,1,ped,pedCol)
	attachElements (pedCol,ped,0,0,0)
	setElementData(pedCol,"parent",ped)
	setElementData(pedCol,"playername","Zombie")
	setElementData(pedCol,"deadman",true)
	setElementData(ped,"deadzombie",true)
	setElementData(pedCol,"deadman",true)
	local time = getRealTime()
	local hours = time.hour
	local minutes = time.minute
	local loot_table = ""
	setElementData(pedCol,"deadreason","Looks like it's finally dead. Estimated time of death: "..hours..":"..minutes.." o'clock.")
	for i, id in ipairs(ZombieLoot) do
		if skin == id[1] then
			loot_table = tostring(id[2])
		end
	end
	for i, item in ipairs(zombieLootType[loot_table]) do
		local value =  math.percentChance(item[5],math.random(1,3))
		setElementData(pedCol,item[1],value)
		local ammoData,weapID = getWeaponAmmoType (item[1],true)
		if ammoData and value > 0 then
			setElementData(pedCol,ammoData,math.random(1,3))
		end
	end
	local zombieCreator = getElementData(source,"owner")
	setElementData(zombieCreator,"spawnedzombies",getElementData(zombieCreator,"spawnedzombies")-1)
	destroyElement(source)
	if headshot then
		setElementData(killer,"headshots",getElementData(killer,"headshots")+1)
	end	
end
addEvent("onZombieGetsKilled",true)
addEventHandler("onZombieGetsKilled",getRootElement(),zombieKilled)
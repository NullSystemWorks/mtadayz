--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: general_zombies.lua					*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]

setElementData(root,"zombiestotal",0)
setElementData(root,"zombiesalive",0)
createTeam("Zombies")

function createZombieTable(player)
	setElementData(player,"playerZombies",{"no","no","no","no","no","no","no","no","no"})
	setElementData(player,"spawnedzombies",0)
end

function spawnZombies(x,y,z)
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
		--local viralzombierand = math.random(0,50)
		for i = 1, gameplayVariables["amountzombies"] do
			local x,y,z = getElementPosition(source)
			counter = counter+1
			local number1 = math.random(-20,20)
			local number2 = math.random(-20,20)
			randomZskin = math.random ( 1, table.getn ( ZombiePedSkins ) )	
			local speedLevel = "normal"
			if gameplayVariables["difficulty"] then
				if gameplayVariables["difficulty"] == "normal" then
					multiplier = 1
					if math.random(0,100) <= 25 then
						speedLevel = "sprint"
					end
				elseif gameplayVariables["difficulty"] == "veteran" then
					multiplier = 1.5
					speedLevel = "sprint"
				elseif gameplayVariables["difficulty"] == "hardcore" then
					multiplier = 3
					speedLevel = "sprint"
				else
					multiplier = 1
					speedLevel = "sprint"
				end
			end
			zombie = call (getResourceFromName("slothbot"),"spawnBot",x+number1,y+number2,z,math.random(0,360),ZombiePedSkins[randomZskin],0,0,getTeamFromName("Zombies"),false,false,false,speedLevel)
			setElementData(zombie,"zombie",true)
			setElementData(zombie,"blood",gameplayVariables["zombieblood"]*multiplier)
			setElementData(zombie,"owner",source)
			call ( getResourceFromName ( "slothbot" ), "setBotGuard", zombie, x+number1,y+number2,z, false)
			setPedAnimation (zombie, "RYDER", "RYD_Die_PT1", -1, true, true, true)
			--[[if viralzombierand >= 1 and viralzombierand <= 25 then
				viralzombie = call(getResourceFromName("slothbot"),"spawnBot",x+number1,y+number2,z+0.1,math.random(0,360),206,0,0,getTeamFromName("Zombies"))
				setElementData(viralzombie,"zombie",true)
				setElementData(viralzombie,"viralzombie",true)
				if gameplayVariables["difficulty"] and gameplayVariables["difficulty"] == "normal" then
				multiplier = 1
				elseif gameplayVariables["difficulty"] and gameplayVariables["difficulty"] == "veteran" then
					multiplier = 1.5
				elseif gameplayVariables["difficulty"] and gameplayVariables["difficulty"] == "hardcore" then
					multiplier = 3
				else
					multiplier = 1
				end
				setElementData(viralzombie,"blood",24000*multiplier)
				setElementData(viralzombie,"owner",source)
				setPedAnimation(viralzombie,"RYDER", "RYD_Die_PT1", -1, true, true, true)
			end
			]]
			
		end
		setElementData(source,"lastzombiespawnposition",{x,y,z})
		setElementData(source,"spawnedzombies",getElementData(source,"spawnedzombies")+gameplayVariables["amountzombies"])
	end
end
addEvent("createZomieForPlayer",true)

--[[
Code for new zombie spawn system
Current Problems:

-- TO DO: Add max limit per client

--]]
local ZedCounter = 0
local colsphereID = 0
local newColSphereID = 0
local ZedSphereCounter = 0
function spawnZombiesCol(hitElement)
	if not getElementData(source,"isZombieSpawn") then return end
	if getElementData(hitElement,"zombie") then return end
	if ZedCounter >= gameplayVariables["maxzombiesglobal"] then 
		return
	end
	local x,y,z = getElementPosition(source)
	colsphereID = getElementData(source,"colsphereZedID")
	if colsphereID == newColSphereID then 
		return 
	end
	local buildingClass = getElementData(source,"parent")
	for i, chance in pairs(zombieBuildingSpawn) do
		if buildingClass == chance[1] then
			if math.random() < chance[2] then
				for i=1, gameplayVariables["maxzombiesperloot"] do
					local number1 = math.random(-gameplayVariables["zombiespawnradius"],gameplayVariables["zombiespawnradius"])
					local number2 = math.random(-gameplayVariables["zombiespawnradius"],gameplayVariables["zombiespawnradius"])
					randomZskin = math.random ( 1, table.getn ( ZombiePedSkins ) )
					local speedLevel = "normal"
					if gameplayVariables["difficulty"] and gameplayVariables["difficulty"] == "normal" then
						multiplier = 1
						if math.random(0,100) <= 25 then
							speedLevel = "sprint"
						end
					elseif gameplayVariables["difficulty"] and gameplayVariables["difficulty"] == "veteran" then
						multiplier = 1.5
						speedLevel = "sprint"
					elseif gameplayVariables["difficulty"] and gameplayVariables["difficulty"] == "hardcore" then
						multiplier = 3
						speedLevel = "sprint"
					else
						multiplier = 1
						speedLevel = "sprint"
					end
					zombie = call (getResourceFromName("slothbot"),"spawnBot",x+number1,y+number2,z+0.3,math.random(0,360),ZombiePedSkins[randomZskin],0,0,getTeamFromName("Zombies"),false,false,false,speedLevel)
					setElementData(zombie,"zombie",true)
					setElementData(zombie,"blood",gameplayVariables["zombieblood"]*multiplier)
					setElementData(zombie,"owner",source)
					call ( getResourceFromName ( "slothbot" ), "setBotGuard", zombie, x+number1,y+number2,z, false)
					setPedAnimation (zombie, "RYDER", "RYD_Die_PT1", -1, true, true, true)
					ZedCounter = ZedCounter+1
					ZedSphereCounter = ZedSphereCounter+1
					-- outputServerLog("Zombies spawned: "..tostring(ZedCounter)) -- Debug
				end
			end
		end
	end
	colsphereID = getElementData(source,"colsphereZedID")
	newColSphereID = colsphereID
end

function determineZombieSpawnSystem()
	if gameplayVariables["newzombiespawnsystem"] then
		addEventHandler("onColShapeHit",root,spawnZombiesCol)
	else
		addEventHandler("createZomieForPlayer",root,spawnZombies)
	end
end
addEventHandler("onResourceStart",resourceRoot,determineZombieSpawnSystem)

function controlZombieSpawning()
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
				ZedCounter = math.max((ZedCounter-1),0)
			end
			if not goReturn then
				local x,y,z = getElementPosition(getElementData(ped,"owner"))
				local Zx,Zy,Zz = getElementPosition(ped)
				if getDistanceBetweenPoints3D (x,y,z,Zx,Zy,Zz) > 60 then
					if not gameplayVariables["newzombiespawnsystem"] then
						if getElementData(zombieCreator,"spawnedzombies")-1 >= 0 then
							setElementData(zombieCreator,"spawnedzombies",getElementData(zombieCreator,"spawnedzombies")-1)
						end	
					end
					setElementData ( ped, "status", "dead" )	
					setElementData ( ped, "target", nil )
					setElementData ( ped, "leader", nil )
					destroyElement(ped)
					ZedCounter = math.max((ZedCounter-1),0)
				end
			end
		end				
	end		
end
setTimer(controlZombieSpawning,20000,0)

function botAttack(ped)
	if isElement(ped) then
		setPedAnimation(ped,false)
	end
	call ( getResourceFromName ( "slothbot" ), "setBotFollow", ped, source)
end
addEvent("botAttack",true)
addEventHandler("botAttack",root,botAttack)

function botStopFollow (ped)
	local x,y,z = getElementPosition(ped)
	call ( getResourceFromName ( "slothbot" ), "setBotGuard", ped, x, y, z, false)
end
addEvent("botStopFollow",true)
addEventHandler("botStopFollow",root,botStopFollow)
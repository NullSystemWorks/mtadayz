--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: animals.lua							*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]

function spawnDayZAnimals()
	for i, animal in ipairs(animalsSpawnTable) do
		local x,y,z = animal[1],animal[2],animal[3]
		local rX,rY = math.random(1,359),math.random(1,359)
		theAnimal = createPed(math.random(12,16),x,y,z)
		setElementRotation(theAnimal,rX,rY,0,"default",true)
		setElementData(theAnimal,"animal",true)
		setPedAnimation (theAnimal, "ped", "Player_Sneak", -1, true, true, true)
	end
end	
spawnDayZAnimals()

function RespawnAnimalsPerTimer()
	spawnDayZAnimals()
end
setTimer(RespawnAnimalsPerTimer,7200000,1,ped,pedCol,x,y,z)
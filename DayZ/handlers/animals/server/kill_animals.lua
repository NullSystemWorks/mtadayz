--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: kill_animals.lua						*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----*																	*----
#-----------------------------------------------------------------------------#
]]

function destroyDeadAnimal (ped,pedCol,x,y,z)
	local ped = createPed(skin,x,y,z)
	local pedCol = createColSphere(x,y,z,1.5)
	destroyElement(ped)
	destroyElement(pedCol)
end

function createDeadAnimal(who)
	local x,y,z = getElementPosition(source)
	local skin = getElementModel(source)
	local ped = createPed(skin,x,y,z)
	local pedCol = createColSphere(x,y,z,1.5)
	local hours,minutes = getTime()
	setElementData(pedCol,"parent",ped)
	setElementData(pedCol,"playername","Animal")
	setElementData(pedCol,"deadman",true)
	setElementData(pedCol,"MAX_Slots",8)
	setElementData(pedCol,"deadreason","This animal was killed around "..hours..":"..minutes..".")
	setElementData(pedCol,"animal",true)
	killPed(ped)
	setElementData(pedCol,"Raw Meat",math.random(1,8))
	destroyElement(source)
	setTimer(destroyDeadAnimal,1800000,1,ped,pedCol,x,y,z)
end
addEvent("createDeadAnimal",true)
addEventHandler ( "createDeadAnimal",root,createDeadAnimal)
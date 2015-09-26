--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: animations_player.lua					*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]

function onPlayerGhillieStateOn()
local getWeapon = getElementData(client,"currentweapon_1")
local getAttach1 = isElementAttachedToBone(elementWeaponBack[source])
local getAttach2 = isElementAttachedToBone(elementBackpack[source])
setElementAlpha(client,50)
	if getAttach1 then
		setElementAlpha(elementWeaponBack[source],50)
	end
	if getAttach2 then
		setElementAlpha(elementBackpack[source],50)
	end
end
addEvent("onPlayerGhillieStateOn",true)
addEventHandler("onPlayerGhillieStateOn",root,onPlayerGhillieStateOn)

function onPlayerGhillieStateOff()
local getWeapon = getElementData(client,"currentweapon_1")
local getAttach1 = isElementAttachedToBone(elementWeaponBack[source])
local getAttach2 = isElementAttachedToBone(elementBackpack[source])
setElementAlpha(client,255)
	if getAttach1 then
		setElementAlpha(elementWeaponBack[source],255)
	end
	if getAttach2 then
		setElementAlpha(elementBackpack[source],255)
	end
end
addEvent("onPlayerGhillieStateOff",true)
addEventHandler("onPlayerGhillieStateOff",root,onPlayerGhillieStateOff)

local handsUp = false
local sitting = false
local lying = false
local saluting = false

function funcBindSit ( player, key, keyState )
	if sitting then
		setPedAnimation (player,false)
		sitting = false
	else
		if isPedInVehicle (player) then return end
		setPedAnimation (player,"BEACH","ParkSit_M_loop",-1,false)
		sitting = true
	end	
end


function funcBindHandsup ( player, key, keyState )
	if handsUp then
		setPedAnimation (player,false)
		handsUp = false
	else
		if isPedInVehicle (player) then return end
		setPedAnimation (player,"SHOP","SHP_Rob_HandsUp",-1,false)
		handsUp = true
	end	
end

function funcBindLie ( player, key, keyState )
	if lying then
		setPedAnimation(player,"ped","getup_front",-1,false)
		setTimer(function() setPedAnimation (player,false) end,1300,1)
		lying = false
	else
		if isPedInVehicle(player) then return end
		setPedAnimation (player,"ped","FLOOR_hit_f", -1,false)
		lying = true
	end
end

function funcBindSalute ( player, key, keyState )
	if saluting then
		setPedAnimation (player,false)
		saluting = false
	else
		if isPedInVehicle(player) then return end
		setPedAnimation(player,"GHANDS","gsign5LH",-1,false)
		setTimer(function() setPedAnimation (player,false) end,2100,1)
		saluting = true
	end
end

--[[
function funcBindLie ( player, key, keyState )
	if lying then
		setPedAnimation(player,"ped","getup_front",-1,false)
		setTimer(function() setPedAnimation (player,false) end,1300,1)
		lying = false
	else
		if isPedInVehicle(player) then return end
		setPedAnimation (player,"ped","FLOOR_hit_f", -1,false)
		lying = true
		
		local x,y,z = getElementPosition(player)
		setElementPosition(player,x,y,z) --Move the player up a little (due to a bug)
	end
	if gameplayVariables["enableprone"] then
		outputChatBox("Attention! Moving while prone is currently disabled!",player,255,0,0,false)
		--triggerClientEvent(player,"onPlayerProne",player,lying)
	end
end
]]

function bindTheKeys()
	bindKey(source,"1","down",funcBindSalute)
	bindKey(source,"2","down",funcBindHandsup)
	bindKey(source,"3","down",funcBindSit)
	bindKey(source,"l","down",funcBindLie)
end
addEventHandler("onPlayerLogin", root, bindTheKeys)

addEventHandler("onResourceStart",resourceRoot,
function()
	for k,v in ipairs(getElementsByType("player")) do
		if not isGuestAccount(getPlayerAccount(v)) then
			bindKey(v,"1","down",funcBindSalute)
			bindKey(v,"2","down",funcBindHandsup)
			bindKey(v,"3","down",funcBindSit)
			bindKey(v,"l","down",funcBindLie)
		end
	end
end)

function unbindFuncKeys()
	unbindKey(source,"1","down",funcBindSalute)
	unbindKey(source,"2","down",funcBindHandsup)
	unbindKey(source,"3","down",funcBindSit)
	unbindKey(source,"l","down",funcBindLie)
end
addEvent("unbindFuncKeys",true)
addEventHandler("unbindFuncKeys",root,unbindFuncKeys)

function bindFuncKeys()
	bindKey(source,"1","down",funcBindSalute)
	bindKey(source,"2","down",funcBindHandsup)
	bindKey(source,"3","down",funcBindSit)
	bindKey(source,"l","down",funcBindLie)
	handsUp = false
	sitting = false
	lying = false
	saluting = false
end
addEvent("bindFuncKeys",true)
addEventHandler("bindFuncKeys",root,bindFuncKeys)

function setPlayerSneak(number)
	setPedWalkingStyle(source,number)
end
addEvent("setPlayerSneak",true)
addEventHandler("setPlayerSneak",root,setPlayerSneak)
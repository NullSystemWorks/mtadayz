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
local siting = false
local lying = false

function funcBindHandsup ( player, key, keyState )
	if handsUp then
		setPedAnimation (player,false)
		handsUp = false
	else
		if isPedInVehicle (player) then return end
		setPedAnimation (player,"BEACH","ParkSit_M_loop",-1,false)
		handsUp = true
	end	
end

function funcBindSit ( player, key, keyState )
	if siting then
		setPedAnimation (player,false)
		siting = false
	else
		if isPedInVehicle (player) then return end
		setPedAnimation (player,"SHOP","SHP_Rob_HandsUp",-1,false)
		siting = true
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
  bindKey(source,",","down",funcBindHandsup)
  bindKey(source,".","down",funcBindSit)
  bindKey(source,"l","down",funcBindLie)
end
addEventHandler("onPlayerLogin", root, bindTheKeys)

addEventHandler("onResourceStart",resourceRoot,
function()
	for k,v in ipairs(getElementsByType("player")) do
		if not isGuestAccount(getPlayerAccount(v)) then
			bindKey(v,",","down",funcBindHandsup)
			bindKey(v,".","down",funcBindSit)
			bindKey(v,"l","down",funcBindLie)
		end
	end
end)

function setPlayerSneak(number)
	setPedWalkingStyle(source,number)
end
addEvent("setPlayerSneak",true)
addEventHandler("setPlayerSneak",root,setPlayerSneak)
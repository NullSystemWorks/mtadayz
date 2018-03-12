--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: damage_player.lua						*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: CLIENT														*----
#-----------------------------------------------------------------------------#
]]

function dayZPlayerDamage(attacker,weapon,bodypart,loss)
	cancelEvent()
	triggerServerEvent("onDayZPlayerDamage",localPlayer,attacker,weapon,bodypart,loss)
end
addEventHandler ("onClientPlayerDamage",localPlayer,dayZPlayerDamage)

function onPlayerDamageShader()
	enableBlackWhite(true)
	setTimer(function() enableBlackWhite(false) end,1000,1)
end
addEvent("onPlayerDamageShader",true)
addEventHandler("onPlayerDamageShader",root,onPlayerDamageShader)

function onClientPlayerPlaySFX(containerID,bankID,soundID,looped)
	playSFX(containerID,bankID,soundID,looped)
end
addEvent("onClientPlayerPlaySFX",true)
addEventHandler("onClientPlayerPlaySFX",root,onClientPlayerPlaySFX)

function onClientPlayerPlaySoundEffect(pathTo,looped)
	playSound(pathTo,looped)
end
addEvent("onClientPlayerPlaySoundEffect",true)
addEventHandler("onClientPlayerPlaySoundEffect",root,onClientPlayerPlaySoundEffect)

function abortAllStealthKills(targetPlayer)
    cancelEvent()
end
addEventHandler("onClientPlayerStealthKill", localPlayer, abortAllStealthKills)

function disableCameraOnSwitch ( prevSlot, newSlot )
	if getPedWeapon(localPlayer,newSlot) == 43 then 
		toggleControl ( "fire", false ) 
	elseif getPedWeapon(localPlayer,newSlot) == 22 then
		if playerStatusTable[localPlayer]["currentweapon_2"] == "Flashlight" then
			toggleControl("fire",false)
		end
	else
		if not isPlayerInsideSafeZone then
			toggleControl ( "fire", true )
		end
	end
end
addEventHandler ("onClientPlayerWeaponSwitch",root,disableCameraOnSwitch)

local binoculars = guiCreateStaticImage(0,0,1,1,":DayZ/gui/gear/items/binoculars.png",true)
local rangefinder = guiCreateStaticImage(0,0,1,1,":DayZ/gui/gear/items/rangefinder.png",true)
guiSetVisible(binoculars,false)
guiSetVisible(rangefinder,false)

function isPlayerUsingBinoculars(button, press)
	if getPedWeapon(localPlayer) == 43 then
		if playerStatusTable[localPlayer]["currentweapon_2"] == "Binoculars" then
			visible = binoculars
		else
			visible = rangefinder
		end
		
		if button == "mouse2" then
			if press then
				guiSetVisible(visible,true)
				showChat(false)
			else
				guiSetVisible(visible,false)
				showChat(true)
			end
		end
	end
end
addEventHandler("onClientKey",root,isPlayerUsingBinoculars)

function rangeFinder()
	local w, h = guiGetScreenSize ()
	local tx, ty, tz = getWorldFromScreenPosition ( w/2, h/2, 500 )
	local px, py, pz = getPedBonePosition(localPlayer,8)
	hit, x, y, z, elementHit = processLineOfSight ( px, py, pz, tx, ty, tz )
	
	if getPedWeapon(localPlayer) == 43 and playerStatusTable[localPlayer]["currentweapon_2"] == "Range Finder" then
		if getPedControlState(localPlayer,"aim_weapon") then
			if x and y and z then
				local distance = getDistanceBetweenPoints3D(px,py,pz,x,y,z)
				dxDrawText(tostring(math.floor(distance)).."m",w/2-50,h/2,w,h,tocolor(0,255,0,255),1.5,"clear")
			else
				local distance = 500
				dxDrawText(">"..tostring(math.floor(distance)).."m",w/2-50,h/2,w,h,tocolor(0,255,0,255),1.5,"clear")
			end
		end
	end
end
addEventHandler("onClientRender",root,rangeFinder)

function weaponBurstFire(weapon)
	if weapon == 30 then
		if playerStatusTable[source]["currentweapon_1"] == "FN FAL" then
			setTimer(function()
				setPedControlState(localPlayer,"fire",true)
				setPedControlState(localPlayer,"fire",false)
				setPedControlState(localPlayer,"fire",true)
				setPedControlState(localPlayer,"fire",false)
			end,200,1)
		end	
	elseif weapon == 33 then
		setTimer(function()
			setPedControlState(localPlayer,"fire",true)
			setPedControlState(localPlayer,"fire",false)
		end,100,1)
	elseif weapon == 34 then
		setTimer(function()
			setPedControlState(localPlayer,"fire",true)
			setPedControlState(localPlayer,"fire",false)
		end,100,1)
	end
end
addEventHandler("onClientPlayerWeaponFire",localPlayer,weaponBurstFire)

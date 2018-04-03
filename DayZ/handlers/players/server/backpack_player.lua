--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: backpack_player.lua					*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]

function addBackpackToPlayer(player,slots)
	local source = player
	local x,y,z = getElementPosition(source)
	local rx,ry,rz = getElementRotation(source)
	if slots == 8 then
		elementBackpack[source] = createObject(3026,x,y,z) -- Patrol Pack
	elseif slots == gameplayVariables["assaultpack_slots"] then
		elementBackpack[source] = createObject(1644,x,y,z) -- Assault Pack (ACU)
	elseif slots == gameplayVariables["czechvest_slots"] then
		elementBackpack[source] = createObject(1248,x,y,z) -- Czech Vest Pouch
	elseif slots == gameplayVariables["alice_slots"] then
		elementBackpack[source] = createObject(2382,x,y,z) -- ALICE Pack
	elseif slots == gameplayVariables["survival_slots"] then
		elementBackpack[source] = createObject(1314,x,y,z) -- Survival ACU
	elseif slots == gameplayVariables["britishassault_slots"] then
		elementBackpack[source] = createObject(1318,x,y,z) -- British Assault Pack
	elseif slots == gameplayVariables["coyote_slots"] then
		elementBackpack[source] = createObject(1252,x,y,z) -- Backpack (Coyote)
	elseif slots == gameplayVariables["czech_slots"] then
		elementBackpack[source] = createObject(1575,x,y,z) -- Czech Backpack
	elseif slots > gameplayVariables["czech_slots"] then
		return
	end
	if slots == gameplayVariables["czech_slots"] then
		attachElementToBone(elementBackpack[source],source,3,0,-0.16,0.05,270,0,180)
	else
		attachElementToBone(elementBackpack[source],source,3,0,-0.225,0.05,90,0,0)
	end	
end
--addEventHandler ("onElementDataChange", root, addBackpackToPlayer)

function backpackRemoveQuit ()
	if getElementData(source,"isDead") then return end
	if elementBackpack[source] then
		detachElementFromBone(elementBackpack[source])
		destroyElement(elementBackpack[source])
	end
	if elementWeaponBack[source] then
		detachElementFromBone(elementWeaponBack[source])
		destroyElement(elementWeaponBack[source])	
		elementWeaponBack[source] = false
	end	
end
addEventHandler ( "onPlayerQuit", getRootElement(), backpackRemoveQuit )

elementWeaponBack = {}
function weaponSwitchBack ( previousWeaponID, currentWeaponID )
	local weapon1 = playerStatusTable[source]["currentweapon_1"]
	if not weapon1 then return end
	local ammoData1,weapID1 = getWeaponAmmoFromName(weapon1)
	local x,y,z = getElementPosition(source)
	local rx,ry,rz = getElementRotation(source)
	if previousWeaponID == weapID1 then
		if elementWeaponBack[source] then
			detachElementFromBone(elementWeaponBack[source])
			destroyElement(elementWeaponBack[source])
			elementWeaponBack[source] = false
		end
		elementWeaponBack[source] = createObject(getWeaponObjectID(weapID1),x,y,z)
		setObjectScale(elementWeaponBack[source],0.875)
		if elementBackpack[source] then
			if weapID1 == 8 then
				attachElementToBone(elementWeaponBack[source],source,3,0.19,-0.25,-0.1,0,0,90)
			else
				attachElementToBone(elementWeaponBack[source],source,3,0.19,-0.31,-0.1,0,270,-90)
			end
		else
			if weapID1 == 8 then
				attachElementToBone(elementWeaponBack[source],source,3,-0.19,-0.11,-0.1,0,0,90)
			else
				attachElementToBone(elementWeaponBack[source],source,3,0.19,-0.11,-0.1,0,270,10)
			end
		end
	elseif currentWeaponID == weapID1 then
		detachElementFromBone(elementWeaponBack[source])
			if elementWeaponBack[source] then
				destroyElement(elementWeaponBack[source])
			end
		elementWeaponBack[source] = false
	end
end
addEventHandler ( "onPlayerWeaponSwitch", getRootElement(), weaponSwitchBack )

function removeBackWeaponOnDrop ()
	if elementWeaponBack[source] then
		detachElementFromBone(elementWeaponBack[source])
		destroyElement(elementWeaponBack[source])	
		elementWeaponBack[source] = false
	end
end
addEvent("removeBackWeaponOnDrop",true)
addEventHandler("removeBackWeaponOnDrop",getRootElement(),removeBackWeaponOnDrop)

function removeAttachedOnDeath ()
	if elementBackpack[source] and playerStatusTable[source]["MAX_Slots"] ~= 8 then
		detachElementFromBone(elementBackpack[source])
		destroyElement(elementBackpack[source])
	end
	if elementWeaponBack[source] then
		detachElementFromBone(elementWeaponBack[source])
		destroyElement(elementWeaponBack[source])	
		elementWeaponBack[source] = false
	end	
end
addEventHandler("killDayZPlayer",getRootElement(),removeAttachedOnDeath)
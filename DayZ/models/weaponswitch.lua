--[[
#---------------------------------------------------------------#
----*			MTA DayZ: weaponswitch.lua					*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf

----* This gamemode is being developed by L, CiBeR96, 1B0Y	*----
----* Type: CLIENT											*----
#---------------------------------------------------------------#
]]

local loaded = false

function onClientPlayerSkinChange(prevSlot,newSlot)
local getSlot = getPedWeaponSlot(localPlayer)
	if getSlot == 0 then
		loaded = false
	elseif getSlot > 0 then
		if getElementData(localPlayer,"currentweapon_1") == "FN FAL" then
			if not loaded then
				engineImportTXD(weaponTXD1, 355)
				engineReplaceModel (weaponDFF1, 355)
				loaded = true
			else return true
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "G36C" then
			if not loaded then
				engineImportTXD (weaponTXD2, 355)
				engineReplaceModel (weaponDFF2, 355)
				loaded = true
			else return true
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "AK-47" then
			if not loaded then
				engineRestoreModel(355)
				loaded = true
			else return true
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "Crossbow" then
			if not loaded then
				engineImportTXD(weaponTXD3, 349)
				engineReplaceModel(weaponDFF3, 349)
				loaded = true
			else return true
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "DMR" then
			if not loaded then
				engineImportTXD(weaponTXD4, 358)
				engineReplaceModel(weaponDFF4, 358)
				loaded = true
			else return true
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "SVD Dragunov" then
			if not loaded then
				engineImportTXD(weaponTXD5, 358)
				engineReplaceModel(weaponDFF5, 358)
				loaded = true
			else return true
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "CZ 550" then
			if not loaded then
				engineRestoreModel(358)
				loaded = true
			else return true
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "Remington 870" then
			if not loaded then
				engineImportTXD(weaponTXD7, 351)
				engineReplaceModel(weaponDFF7, 351)
				loaded = true
			else return true
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "Winchester 1866" then
			if not loaded then
				engineRestoreModel(349)
				loaded = true
			else return true
			end
		elseif getElementData(localPlayer,"currentweapon_2") == "M1911" then
			if not loaded then
				engineImportTXD(weaponTXD9, 346)
				engineReplaceModel(weaponDFF9, 346)
				loaded = true
			else return true
			end
		elseif getElementData(localPlayer,"currentweapon_2") == "Revolver" then
			if not loaded then
				engineImportTXD(weaponTXD8, 348)
				engineReplaceModel(weaponDFF8, 348)
				loaded = true
			else return true
			end
		elseif getElementData(localPlayer,"currentweapon_2") == "Desert Eagle" then
			if not loaded then
				engineRestoreModel(348)
				loaded = true
			else return true
			end
		elseif getElementData(localPlayer,"currentweapon_2") == "Bizon PP-19" then
			if not loaded then
				engineImportTXD(weaponTXD6, 353)
				engineReplaceModel(weaponDFF6, 353)
				loaded = true
			else return true
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "Sa58V CCO" then
			if not loaded then
				engineImportTXD(weaponTXD11, 355)
				engineReplaceModel(weaponDFF11, 355)
				loaded = true
			else return true
			end
		else
			engineRestoreModel(355)
			engineRestoreModel(349)
			engineRestoreModel(358)
			engineRestoreModel(353)
			engineRestoreModel(348)
			engineRestoreModel(351)
			loaded = false
		end
	end
end
addEventHandler("onClientPlayerWeaponSwitch",localPlayer,onClientPlayerSkinChange)
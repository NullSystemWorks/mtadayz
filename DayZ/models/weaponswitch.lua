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
	if newSlot == 0 then
		loaded = false
	elseif newSlot == 1 or newSlot == 2 or newSlot == 4 then
		if getElementData(localPlayer,"currentweapon_2") == "M1911" then
			if not loaded then
				engineImportTXD(weaponTXD[1], 346)
				engineReplaceModel(weaponDFF[1],346)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_2") == "Flashlight" then
			if not loaded then
				engineImportTXD(flashlightTexture,346)
				engineReplaceModel (flashlightModel,346)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_2") == "Revolver" then
			if not loaded then
				engineImportTXD(weaponTXD[2], 348)
				engineReplaceModel(weaponDFF[2],348)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_2") == "Makarov PM" then
			if not loaded then
				engineImportTXD(weaponTXD[3], 346)
				engineReplaceModel(weaponDFF[3],346)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_2") == "Bizon PP-19 SD" then
			if not loaded then
				engineImportTXD(weaponTXD[4], 353)
				engineReplaceModel(weaponDFF[4],353)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_2") == "G17" then
			if not loaded then
				engineImportTXD(weaponTXD[5], 346)
				engineReplaceModel(weaponDFF[5],346)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_2") == "M9" then
			if not loaded then
				engineImportTXD(weaponTXD[6], 346)
				engineReplaceModel(weaponDFF[6],346)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_2") == "Makarov SD" then
			if not loaded then
				engineImportTXD(weaponTXD[7], 347)
				engineReplaceModel(weaponDFF[7],347)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_2") == "PDW" then
			if not loaded then
				engineImportTXD(weaponTXD[8], 352)
				engineReplaceModel(weaponDFF[8],352)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_2") == "MP5A5" then
			if not loaded then
				engineImportTXD(weaponTXD[9], 353)
				engineReplaceModel(weaponDFF[9],353)
				loaded = true
			else
				return
			end
		else
			engineRestoreModel(346)
			engineRestoreModel(348)
			engineRestoreModel(353)
			engineRestoreModel(347)
			engineRestoreModel(357)
			engineRestoreModel(355)
			engineRestoreModel(356)
			engineRestoreModel(358)
			engineRestoreModel(349)
			engineRestoreModel(351)
			loaded = false
		end
	elseif newSlot == 3 or newSlot == 5 or newSlot == 6 or newSlot == 7 then
		if getElementData(localPlayer,"currentweapon_1") == "Lee Enfield" then
			if not loaded then
				engineImportTXD(weaponTXD[10], 357)
				engineReplaceModel(weaponDFF[10],357)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "AK-74" then
			if not loaded then
				engineImportTXD(weaponTXD[11], 355)
				engineReplaceModel(weaponDFF[11],355)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "AKS-74U" then
			if not loaded then
				engineImportTXD(weaponTXD[12], 355)
				engineReplaceModel(weaponDFF[12],355)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "RPK" then
			if not loaded then
				engineImportTXD(weaponTXD[13], 355)
				engineReplaceModel(weaponDFF[13],355)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "AKM" then
			if not loaded then
				engineImportTXD(weaponTXD[14], 355)
				engineReplaceModel(weaponDFF[14],355)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "Sa58V CCO" then
			if not loaded then
				engineImportTXD(weaponTXD[15], 355)
				engineReplaceModel(weaponDFF[15],355)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "Sa58V RCO" then
			if not loaded then
				engineImportTXD(weaponTXD[16], 355)
				engineReplaceModel(weaponDFF[16],355)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "FN FAL" then
			if not loaded then
				engineImportTXD(weaponTXD[17], 355)
				engineReplaceModel (weaponDFF[17], 355)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "M24" then
			if not loaded then
				engineImportTXD(weaponTXD[18], 358)
				engineReplaceModel(weaponDFF[18],358)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "DMR" then
			if not loaded then
				engineImportTXD(weaponTXD[19], 358)
				engineReplaceModel(weaponDFF[19],358)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "M40A3" then
			if not loaded then
				engineImportTXD(weaponTXD[20], 358)
				engineReplaceModel(weaponDFF[20],358)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "G36A CAMO" then
			if not loaded then
				engineImportTXD(weaponTXD[21], 356)
				engineReplaceModel(weaponDFF[21],356)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "G36C" then
			if not loaded then
				engineImportTXD(weaponTXD[22], 356)
				engineReplaceModel(weaponDFF[22],356)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "G36C CAMO" then
			if not loaded then
				engineImportTXD(weaponTXD[23], 356)
				engineReplaceModel(weaponDFF[23],356)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "G36K CAMO" then
			if not loaded then
				engineImportTXD(weaponTXD[24], 356)
				engineReplaceModel(weaponDFF[24],356)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "L85A2 RIS Holo" then
			if not loaded then
				engineImportTXD(weaponTXD[25], 356)
				engineReplaceModel(weaponDFF[25],356)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "M16A2" then
			if not loaded then
				engineImportTXD(weaponTXD[26], 356)
				engineReplaceModel(weaponDFF[26],356)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "M4A1" then
			if not loaded then
				engineImportTXD(weaponTXD[27], 356)
				engineReplaceModel(weaponDFF[27],356)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "M16A4" then
			if not loaded then
				engineImportTXD(weaponTXD[28], 356)
				engineReplaceModel(weaponDFF[28],356)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "CZ 550" then
			if not loaded then
				engineImportTXD(weaponTXD[29], 358)
				engineReplaceModel(weaponDFF[29],358)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "SVD Dragunov" then
			if not loaded then
				engineImportTXD(weaponTXD[30], 358)
				engineReplaceModel(weaponDFF[30],358)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "Mosin-Nagant" then
			if not loaded then
				engineImportTXD(weaponTXD[31], 357)
				engineReplaceModel(weaponDFF[31],357)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "Winchester 1866" then
			if not loaded then
				engineImportTXD(weaponTXD[32], 349)
				engineReplaceModel(weaponDFF[32],349)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "Double-barreled Shotgun" then
			if not loaded then
				engineImportTXD(weaponTXD[33], 351)
				engineReplaceModel(weaponDFF[33],351)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "M1014" then
			if not loaded then
				engineImportTXD(weaponTXD[34], 351)
				engineReplaceModel(weaponDFF[34],351)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "Remington 870" then
			if not loaded then
				engineImportTXD(weaponTXD[35], 351)
				engineReplaceModel(weaponDFF[35],351)
				loaded = true
			else
				return
			end
		elseif getElementData(localPlayer,"currentweapon_1") == "Compound Crossbow" then
			if not loaded then
				engineImportTXD(weaponTXD[36], 349)
				engineReplaceModel(weaponDFF[36], 349)
				loaded = true
			else
				return
			end
		else
			engineRestoreModel(346)
			engineRestoreModel(348)
			engineRestoreModel(353)
			engineRestoreModel(347)
			engineRestoreModel(357)
			engineRestoreModel(355)
			engineRestoreModel(356)
			engineRestoreModel(358)
			engineRestoreModel(349)
			engineRestoreModel(351)
			loaded = false
		end
	else
		engineRestoreModel(346)
		engineRestoreModel(348)
		engineRestoreModel(353)
		engineRestoreModel(347)
		engineRestoreModel(357)
		engineRestoreModel(355)
		engineRestoreModel(356)
		engineRestoreModel(358)
		engineRestoreModel(349)
		engineRestoreModel(351)
		loaded = false
	end
end
addEventHandler("onClientPlayerWeaponSwitch",localPlayer,onClientPlayerSkinChange)
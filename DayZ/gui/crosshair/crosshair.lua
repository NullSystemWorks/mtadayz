
crosshairs = {}
shader = {}

function initCrosshair()
	if gameplayVariables["difficulty"] and gameplayVariables["difficulty"] == "hardcore" then
		default = dxCreateTexture(":DayZ/gui/crosshair/hardcore.png");
	else
		default = dxCreateTexture(":DayZ/gui/crosshair/normal.png");
	end
	crosshairShader = dxCreateShader(":DayZ/gui/crosshair/texreplace.fx")
	assert(crosshairShader, "Could not create Crosshair Replacement Shader")
	engineApplyShaderToWorldTexture(crosshairShader, "siteM16")
	dxSetShaderValue(crosshairShader, "gTexture", default)
	addEventHandler("onClientPlayerWeaponSwitch", localPlayer, crosshairWeaponSwitch)
end

function crosshairWeaponSwitch(prev, now)
	local weapon = getPedWeapon(localPlayer)
	dxSetShaderValue(crosshairShader, "gTexture", crosshairs[weapon] or default)
end

function register(weaponid, crosshairpath)
	if not crosshairpath:find(":") then
		crosshairpath = (":%s/%s"):format(getResourceName(sourceResource), crosshairpath)
	end
	assert(fileExists(crosshairpath), "Invalid File for Crosshair.register")
	if crosshairs[weaponid] then destroyElement(crosshairs[weaponid]) end
	crosshairs[weaponid] = dxCreateTexture(crosshairpath)
end

function unregister(weaponid)
	if crosshairs[weaponid] then destroyElement(crosshairs[weaponid]) end
	crosshairs[weaponid] = nil
end




--setPlayerHudComponentVisible("crosshair",false)
--[[
local screenW, screenH = guiGetScreenSize()
local resizeX, resizeY = 0.0587, 0.0133
local posX, posY, sizeX, sizeY = 0, 0, 0, 0
local addX, addY = 0, 0

function onPlayerIsAiming()
local crosshair = ""
local EquippedWeapon = getPedWeapon(localPlayer)
	-- Pistols
	if EquippedWeapon == 22 or EquippedWeapon == 23 or EquippedWeapon == 24 then
		crosshair = "pistolcrosshair"
		posX, posY, sizeX, sizeY = 0.4998, 0.3950, 0.0587, 0.0133
	-- Shotguns
	elseif EquippedWeapon == 25 or EquippedWeapon == 26 or EquippedWeapon == 27 then
		crosshair = "shotguncrosshair"
		posX, posY, sizeX, sizeY = 0.4598, 0.3850, 0.1388, 0.0300
		addX, addY = 0, 0
	-- M4
	else
		crosshair = "akcrosshair"
		posX, posY, sizeX, sizeY = 0.4898, 0.3850, 0.0787, 0.0333
		addX, addY = 0, 0
	end
	dxDrawImage(screenW * 0.5190, screenH * 0.4000, screenW * 0.0225, screenH * 0.0283, "pistolcrosshair.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	dxDrawImage(screenW * (0.4680-addX), screenH * 0.4000, screenW * 0.0550, screenH * 0.0283, "pistol_left.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	dxDrawImage(screenW * (0.5380+addX), screenH * 0.4000, screenW * 0.0550, screenH * 0.0283, "pistol_right.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	--dxDrawImage(screenW * posX, screenH * posY, screenW * sizeX, screenH * sizeY, crosshair..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
end

function checkIfPlayerAim(button,state)
	if state and button == "mouse2" then
		addEventHandler("onClientRender",root,onPlayerIsAiming)
	elseif not state and button == "mouse2" then
		removeEventHandler("onClientRender",root,onPlayerIsAiming)
	end
end
--addEventHandler("onClientKey",root,checkIfPlayerAim)
]]

initCrosshair()

-- Exports
register 	= register
unregister 	= unregister
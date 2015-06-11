Crosshair = {
	crosshairs = {};
	shader = {};
	default = dxCreateTexture("siteM16_1.png");
	
	register = function(weaponid, crosshairpath)
		if not crosshairpath:find(":") then
			crosshairpath = (":%s/%s"):format(getResourceName(sourceResource), crosshairpath)
		end
		assert(fileExists(crosshairpath), "Invalid File for Crosshair.register")
		
		if Crosshair.crosshairs[weaponid] then destroyElement(Crosshair.crosshairs[weaponid]) end
		Crosshair.crosshairs[weaponid] = dxCreateTexture(crosshairpath)
	end,
	
	unregister = function(weaponid)
		if Crosshair.crosshairs[weaponid] then destroyElement(Crosshair.crosshairs[weaponid]) end
		Crosshair.crosshairs[weaponid] = nil
	end,
	
	init = function()
		Crosshair.shader = dxCreateShader("texreplace.fx")
		assert(Crosshair.shader, "Could not create Crosshair Replacement Shader")
		engineApplyShaderToWorldTexture(Crosshair.shader, "siteM16")
		dxSetShaderValue(Crosshair.shader, "gTexture", Crosshair.default)
		addEventHandler("onClientPlayerWeaponSwitch", localPlayer, Crosshair.weaponSwitch)
	end, 

	weaponSwitch = function(prev, now)
		local weapon = getPedWeapon(localPlayer)
		dxSetShaderValue(Crosshair.shader, "gTexture", Crosshair.crosshairs[weapon] or Crosshair.default)
	end

	
}

Crosshair.init()

-- Exports
register 	= Crosshair.register
unregister 	= Crosshair.unregister

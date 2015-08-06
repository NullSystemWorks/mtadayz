--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: tree_chop.lua							*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: CLIENT														*----
#-----------------------------------------------------------------------------#
]]

local length = 3
function checkIfWeaponIsHatchet(prevSlot,newSlot)
	if getPedWeapon(localPlayer,newSlot) == 8 then
		addEventHandler("onClientPreRender",root,chopTree)
	else
		removeEventHandler("onClientPreRender",root,chopTree)
	end
end
addEventHandler("onClientPlayerWeaponSwitch",localPlayer,checkIfWeaponIsHatchet)

function chopTree()
	local x, y, z = getElementPosition( localPlayer )
	local _, _, rz = getElementRotation( localPlayer )
	local tx = x + - ( length ) * math.sin( math.rad( rz ) )
	local ty = y + length * math.cos( math.rad( rz ) )
	local tz = z
	if getControlState( "fire" ) and getPedWeapon( localPlayer ) == 8 then
		local hit, hitX, hitY, hitZ, hitElement, normalX, normalY, normalZ, material, lighting, piece, worldID, worldX, worldY, worldZ, worldRX, worldRY, worldRZ, worldLODID = processLineOfSight( x, y, z, tx, ty, tz, true, false, false, true, true, false, false, false, localPlayer, true, false )
		if worldID and not startwoodtick and treelist[worldID] then
			local treename = treelist[worldID].name
			local interior = getElementInterior( localPlayer )

			if not startwoodtick then
				startwoodtick = getTickCount()

				triggerServerEvent( "onPlayerChopTree", localPlayer, worldID, worldX, worldY, worldZ, worldRX, worldRY, worldRZ, worldLODID, interior )
				if getPlayerCurrentSlots() <= getPlayerMaxAviableSlots() then
					setElementData(localPlayer,"Wood Pile",getElementData(localPlayer,"Wood Pile")+1)
					startRollMessage2("Chopping", "You got 1 'Wood Pile'!", 0,255,0)
				else
					startRollMessage2("Inventory", "Inventory is full!", 255, 22, 0)
				end
			end
		end
	end
	if startwoodtick then
		currenttick = getTickCount() - startwoodtick
		if currenttick >= 2000 then
			chopping = false
			startwoodtick = nil
		end
	end
end
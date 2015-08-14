--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: tree_chop.lua							*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: CLIENT														*----
#-----------------------------------------------------------------------------#
]]
local numhit = 0
local maxhit = 15 -- 15 = About 5 strokes of axe
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
			local interior = getElementInterior(localPlayer)
			numhit = numhit+1
			if numhit == maxhit then
				if not startwoodtick then
					numhit = numhit-maxhit
					startwoodtick = getTickCount()
					playSound3D(":DayZ/sounds/items/choopwood.ogg", x, y, z, true) 
					triggerServerEvent( "onPlayerChopTree", localPlayer, worldID, worldX, worldY, worldZ, worldRX, worldRY, worldRZ, worldLODID, interior )
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
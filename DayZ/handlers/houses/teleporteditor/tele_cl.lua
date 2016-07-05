local roottelepick = createElement ("Rootmarker", "RootTeleportPickup")
local telepicktargets = {}
local telepickdesc = {}
local telepickdesccol = {}
local restrictions = {}
function conwert(color)
	local hexTodecim = {["0"]=0,["1"]=1,["2"]=2,["3"]=3,["4"]=4,["5"]=5,["6"]=6,["7"]=7,["8"]=8,["9"]=9,["a"]=10,["b"]=11,["c"]=12,["d"]=13,["e"]=14,["f"]=15}
	local red = (hexTodecim[string.lower(string.sub(color, 2, 2))]*16) + hexTodecim[string.lower(string.sub(color, 3, 3))]
	local gren = (hexTodecim[string.lower(string.sub(color, 4, 4))]*16) + hexTodecim[string.lower(string.sub(color, 5, 5))]
	local blue = (hexTodecim[string.lower(string.sub(color, 6, 6))]*16) + hexTodecim[string.lower(string.sub(color, 6, 6))]
	local alpha = (hexTodecim[string.lower(string.sub(color, 8, 8))]*16) + hexTodecim[string.lower(string.sub(color, 9, 9))]
	return red, gren, blue, alpha
end
function StartResourceTE()
	local telepick = getElementsByType("Teleport_p")
	if telepick and table.getn (telepick) > 0 then
		for i,t in ipairs (telepick) do
			local x,y,z = getElementPosition (t)
			local rx,ry,rz = tonumber(getElementData(t, "rotX")),tonumber(getElementData(t, "rotY")),tonumber(getElementData(t, "rotZ"))
			local ttype = getElementData(t, "type")
			local size = tonumber(getElementData(t, "size"))
			if size < 1 then
				size = 1
			end
			local color = getElementData(t, "color")
			local description = getElementData(t, "description") or "test"
			local desccolor = getElementData(t, "desccolor")
			local destynation_id = getElementData(t, "destynation_id")
			local dimension = math.floor(tonumber(getElementData(t, "dimension_"))) or 0
			if dimension < 0 then
				dimension = 0
			end
			local interior = math.floor(tonumber(getElementData(t, "interior_"))) or 0
			if interior < 0 then
				interior = 0
			end
			local restrict = getElementData(t, "restriction")
			local red, gren, blue, alpha = conwert(color)
			local dred, dgren, dblue, dalpha = conwert(desccolor)
			if isElement (getElementByID(destynation_id)) then
				local marker = createMarker(x,y,z,ttype,size,red,gren,blue,alpha)
				setElementDimension (marker, dimension)
				setElementInterior (marker, interior)
				telepicktargets[marker] = getElementByID(destynation_id)
				telepickdesc[marker] = description
				telepickdesccol[marker] = {dred, dgren, dblue, dalpha}
				restrictions[marker] = restrict
				setElementParent(marker,roottelepick)
				if ttype == "ring" then
					local tempobject = createVehicle(594,x,y,z,rx,ry,rz)
					setElementRotation (tempobject,rx,ry,rz)
					local matrix = getElementMatrix ( tempobject )
					destroyElement (tempobject)
					local offX = 0 * matrix[1][1] + 100 * matrix[2][1] + 0 * matrix[3][1] + matrix[4][1]
					local offY = 0 * matrix[1][2] + 100 * matrix[2][2] + 0 * matrix[3][2] + matrix[4][2]
					local offZ = 0 * matrix[1][3] + 100 * matrix[2][3] + 0 * matrix[3][3] + matrix[4][3]
					--outputChatBox(tostring(offX).."' "..tostring(offY)..", "..tostring(offZ)..", "..tostring(x)..", "..tostring(y)..", "..tostring(z)..", "..tostring(getElementType(marker)))
					setMarkerTarget (marker, tonumber(offX), tonumber(offY), tonumber(offZ))
				--[[elseif ttype == "arrow" or ttype == "cylinder" then
					local tempobject = createObject(1318,x,y,z)
					setObjectScale(tempobject,0,001)
					setElementRotation(tempobject,rx,ry,rz)
					attachElements(marker,tempobject)]]
				end
			else
				outputDebugString("TE: Teleport (id: "..getElementID(t)..") has no destination set - this teleport wont be created")
			end
		end
	else
		outputDebugString("TE: No telepotr pickup markers detected in map file...")
	end
end
local localplayer = getLocalPlayer()
addEventHandler("onClientRender",getRootElement(),function()
	if isElement(roottelepick) then
	local telmark = getElementChildren(roottelepick)
	for i,p in ipairs(telmark) do
		if isElement(p) then
		if getElementDimension(p) == getElementDimension(localplayer) and getElementInterior(p) == getElementInterior(localplayer) then
		local ax,ay,az = getElementPosition(p)
		local px,py,pz = getElementPosition(localplayer)
		local d_text = telepickdesc[p] 
		local dt_color = telepickdesccol[p]
		local x1,y1 = getScreenFromWorldPosition(ax,ay,az)
		local dist = getDistanceBetweenPoints3D(ax,ay,az,px,py,pz)
		if (dist < 50) and x1 then
			local llen = string.len(d_text)
			llen = math.floor(llen/2)*6
			local size = (10/dist)
			local sizes = size + 1
			--[[if size > 15 then
				size = 15
			elseif size < 0.2 then
				size = 0.2
			end]]
			dxDrawText(d_text,x1-(llen)*sizes,y1-(60)*size,x1-(llen)*sizes,y1-(60)*size,tocolor(unpack(dt_color)),sizes,"arial") 
		end
		end
		end
	end
	end
end)
function teleportpickuphandler(player,machdimension)
	if (player == localplayer) and machdimension and (getElementInterior(player) == getElementInterior(source)) then
		local target = telepicktargets[source]
		local timrmark = source
		local veh = getPedOccupiedVehicle(player)
		local tx,ty,tz = getElementPosition(target)
		local relativet = getElementData(target, "relative")
		local restrict = restrictions[source]
		local targetdimension = math.floor(tonumber(getElementData(target, "t_dimension"))) or 0
		if targetdimension < 0 then
			targetdimension = 0
		end
		local targetinterior = math.floor(tonumber(getElementData(target, "t_interior"))) or 0
		if targetinterior < 0 then
			targetinterior = 0
		end
		local fixed_speed = tonumber(tonumber(getElementData(target, "fixed_speed"))) or 0
		if fixed_speed < 0 then
			fixed_speed = 0
		end
		local speed_multiplayer = tonumber(tonumber(getElementData(target, "speed_multiplayer"))) or 1
		if speed_multiplayer < 0 then
			speed_multiplayer = 1
		end
		if veh and isElement(veh) and (getVehicleOccupant(veh,0) == player) and restrict ~= "playerOnly" then
			local ax,ay,az = getElementPosition(veh)
			local vx,vy,vz = getElementVelocity(veh)
			setElementFrozen(veh,true)
			local actualspeed = (vx^2 + vy^2 + vz^2)^(0.5)
			local rx,ry,rz = 0,0,0
			if getElementData(target, "use_dest_rot") == "true" then
				rx,ry,rz = tonumber(getElementData(target, "rotX")),tonumber(getElementData(target, "rotY")),tonumber(getElementData(target, "rotZ"))
			else
				rx,ry,rz = getElementRotation(veh)
			end
			setElementRotation (veh,rx,ry,rz)
			local matrix = getElementMatrix(veh)
			if relativet == "coord" then
				tx = tx + ax
				ty = ty + ay
				tz = tz + az
			elseif relativet == "coordNrot" then
				local offx = tx * matrix[1][1] + ty * matrix[2][1] + tz * matrix[3][1] + matrix[4][1]
				local offy = tx * matrix[1][2] + ty * matrix[2][2] + tz * matrix[3][2] + matrix[4][2]
				local offz = tx * matrix[1][3] + ty * matrix[2][3] + tz * matrix[3][3] + matrix[4][3]
				tx = offx
				ty = offy
				tz = offz
			end
			setElementPosition (veh,tx,ty,tz)
			matrix = getElementMatrix(veh)
			camerastuff(player,matrix,tx,ty,tz)
			setCameraTarget(player)
			setTimer(function()
				if targetdimension ~= getElementDimension(timrmark) or targetinterior ~= getElementInterior(timrmark) then
					triggerServerEvent("onTeleport",getLocalPlayer(),veh,targetdimension,targetinterior)
					local ocupants = getVehicleOccupants(veh)
					local attached = getAttachedElements(veh)
					for i,p in pairs(ocupants) do
						triggerServerEvent("onTeleport",getLocalPlayer(),p,targetdimension,targetinterior)
					end
					for i,p in pairs(attached) do
						triggerServerEvent("onTeleport",getLocalPlayer(),p,targetdimension,targetinterior)
					end
				end
				setElementFrozen(veh,false)
				if fixed_speed > 0 then
					fixed_speed = (fixed_speed/180)
					sermatspeed(veh,matrix,fixed_speed,tx,ty,tz)
					--outputChatBox(fixed_speed.." fixed_speed")
				else
					actualspeed = actualspeed * speed_multiplayer
					sermatspeed(veh,matrix,actualspeed,tx,ty,tz)
					--outputChatBox(actualspeed.." actualspeed")
				end
			end,50,1)
		elseif veh and isElement(veh) then
			--nothing
		else
			if not isElementAttached(player) and restrict ~= "inVehicleOnly" then
				local ax,ay,az = getElementPosition(player)
				local vx,vy,vz = getElementVelocity(player)
				--local a1,a2,a3,a4 = getPedSimplestTask(player)
				--outputChatBox(tostring(a1)..tostring(a2)..tostring(a3)..tostring(a4))
				setElementFrozen(player,true)
				local actualspeed = (vx^2 + vy^2 + vz^2)^(0.5)
				local rx,ry,rz = 0,0,0
				if getElementData(target, "use_dest_rot") == "true" then
					rx,ry,rz = tonumber(getElementData(target, "rotX")),tonumber(getElementData(target, "rotY")),tonumber(getElementData(target, "rotZ"))
					--outputChatBox("target rot"..rx..", "..ry..", "..rz)
				else
					rz = getPedRotation(player)
					--outputChatBox("pla rot")
				end
				setPedRotation(player,rz)
				local matrix = getElementMatrix(player)
				if getElementData(target, "use_dest_rot") == "true" then
					--outputChatBox("target rot2"..rx..", "..ry..", "..rz)
					local tempobject = createVehicle(594,tx,ty,tz,rx,ry,rz)
					setElementRotation (tempobject,rx,ry,rz)
					matrix = getElementMatrix ( tempobject )
					destroyElement (tempobject)
				end
				if relativet == "coord" then
					tx = tx + ax
					ty = ty + ay
					tz = tz + az
				elseif relativet == "coordNrot" then
					local offx = tx * matrix[1][1] + ty * matrix[2][1] + tz * matrix[3][1] + matrix[4][1]
					local offy = tx * matrix[1][2] + ty * matrix[2][2] + tz * matrix[3][2] + matrix[4][2]
					local offz = tx * matrix[1][3] + ty * matrix[2][3] + tz * matrix[3][3] + matrix[4][3]
					tx = offx
					ty = offy
					tz = offz
				end
				setElementPosition(player,tx,ty,tz)
				matrix = getElementMatrix(player)
				if getElementData(target, "use_dest_rot") == "true" then
					--outputChatBox("target rot2"..rx..", "..ry..", "..rz)
					local tempobject = createVehicle(594,tx,ty,tz,rx,ry,rz)
					setElementRotation (tempobject,rx,ry,rz)
					matrix = getElementMatrix ( tempobject )
					destroyElement (tempobject)
				end
				camerastuff(player,matrix,tx,ty,tz)
				setCameraTarget(player)
				setTimer(function()
					if targetdimension ~= getElementDimension(timrmark) or targetinterior ~= getElementInterior(timrmark) then
						triggerServerEvent("onTeleport",getLocalPlayer(),player,targetdimension,targetinterior)
					end
					setElementFrozen(player,false)
					if tonumber(fixed_speed) > 0 then
						fixed_speed = fixed_speed/180
						sermatspeed(player,matrix,fixed_speed,tx,ty,tz)
					else
						actualspeed = actualspeed * speed_multiplayer
						sermatspeed(player,matrix,actualspeed,tx,ty,tz)
					end
				end,50,1)
			end
		end
	end
end
addEventHandler("onClientMarkerHit", roottelepick, teleportpickuphandler)
function sermatspeed(element,matrix,ofset,x,y,z)
	local offX = 0 * matrix[1][1] + ofset * matrix[2][1] + 0 * matrix[3][1] + matrix[4][1]
	local offY = 0 * matrix[1][2] + ofset * matrix[2][2] + 0 * matrix[3][2] + matrix[4][2]
	local offZ = 0 * matrix[1][3] + ofset * matrix[2][3] + 0 * matrix[3][3] + matrix[4][3]
	setElementVelocity(element,offX-x,offY-y,offZ-z)
	--outputChatBox(offX-x.."' "..offY-y..", "..offZ-z)
end
function camerastuff(player,matrix,x,y,z)
	local offX = 0 * matrix[1][1] - 2 * matrix[2][1] + 1 * matrix[3][1] + matrix[4][1]
	local offY = 0 * matrix[1][2] - 2 * matrix[2][2] + 1 * matrix[3][2] + matrix[4][2]
	local offZ = 0 * matrix[1][3] - 2 * matrix[2][3] + 1 * matrix[3][3] + matrix[4][3]
	setCameraMatrix(tonumber(offX),tonumber(offY),tonumber(offZ),x,y,z)
	--outputChatBox(getElementType(player)..", "..offX..", "..offY..", "..offZ..", "..x..", "..y..", "..z)
end

setTimer(StartResourceTE,1000,1)

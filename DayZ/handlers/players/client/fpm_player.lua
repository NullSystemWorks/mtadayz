--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: fpm_player.lua						*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: CLIENT														*----
#-----------------------------------------------------------------------------#
]]

local PI = math.pi

local isEnabled = false
local wasInVehicle = isPedInVehicle(localPlayer)

local mouseSensitivity = 0.1
local rotX, rotY = 0,0
local mouseFrameDelay = 0
local idleTime = 2500
local fadeBack = false
local fadeBackFrames = 50
local executeCounter = 0
local recentlyMoved = false
local Xdiff,Ydiff

function toggleFPS()
weapon = getPedWeapon(localPlayer)
	if weapon ~= 34 then
		if (not isEnabled) then
			fadeCamera(false,0,0,0,0)
			setTimer(function() fadeCamera(true,1) end,100,1)
			isEnabled = true
			addEventHandler ("onClientPreRender", root, updateCamera)
			addEventHandler ("onClientCursorMove",root, freecamMouse)
		else
			fadeCamera(false,0,0,0,0)
			setTimer(function() fadeCamera(true,1) end,100,1)
			isEnabled = false
			setCameraTarget (localPlayer, localPlayer)
			removeEventHandler ("onClientPreRender", root, updateCamera)
			removeEventHandler ("onClientCursorMove", root, freecamMouse)
		end
	else
		return
	end
end
bindKey("o","down",toggleFPS)

function toggleViewIfSniper()
weapon = getPedWeapon(localPlayer)
	if isEnabled then
		if weapon == 34 then
			fadeCamera(false,0,0,0,0)
			setTimer(function() fadeCamera(true,1) end,100,1)
			isEnabled = false
			setCameraTarget (localPlayer, localPlayer)
			removeEventHandler ("onClientPreRender", root, updateCamera)
			removeEventHandler ("onClientCursorMove", root, freecamMouse)
		end
	else
		return
	end
end
addEventHandler("onClientPlayerWeaponSwitch",localPlayer,toggleViewIfSniper)

function updateCamera()
	if (isEnabled) then
		local nowTick = getTickCount()
		-- check if the last mouse movement was more than idleTime ms ago
		if wasInVehicle and recentlyMoved and not fadeBack and startTick and nowTick - startTick > idleTime then
			recentlyMoved = false
			fadeBack = true
			if rotX > 0 then
				Xdiff = rotX / fadeBackFrames
			elseif rotX < 0 then
				Xdiff = rotX / -fadeBackFrames
			end
			if rotY > 0 then
				Ydiff = rotY / fadeBackFrames
			elseif rotY < 0 then
				Ydiff = rotY / -fadeBackFrames
			end
		end		
		if fadeBack then	
			executeCounter = executeCounter + 1
			if rotX > 0 then
				rotX = rotX - Xdiff
			elseif rotX < 0 then
				rotX = rotX + Xdiff
			end
			if rotY > 0 then
				rotY = rotY - Ydiff
			elseif rotY < 0 then
				rotY = rotY + Ydiff
			end	
			if executeCounter >= fadeBackFrames then
				fadeBack = false
				executeCounter = 0
			end
		end
		local camPosXr, camPosYr, camPosZr = getPedBonePosition (localPlayer, 6)
		local camPosXl, camPosYl, camPosZl = getPedBonePosition (localPlayer, 7)
		local camPosX, camPosY, camPosZ = (camPosXr + camPosXl) / 2, (camPosYr + camPosYl) / 2, (camPosZr + camPosZl) / 2
		local roll = 0
		inVehicle = isPedInVehicle(localPlayer)
		-- note the vehicle rotation
		if inVehicle then
			local rx,ry,rz = getElementRotation(getPedOccupiedVehicle(localPlayer))	
			roll = -ry
			if rx > 90 and rx < 270 then
				roll = ry - 180
			end
			if not wasInVehicle then
				rotX = rotX + math.rad(rz) --prevent camera from rotation when entering a vehicle
				if rotY > -PI/15 then --force camera down if needed
					rotY = -PI/15 
				end
			end
			cameraAngleX = rotX - math.rad(rz)
			cameraAngleY = rotY + math.rad(rx)
			if getControlState("vehicle_look_behind") or ( getControlState("vehicle_look_right") and getControlState("vehicle_look_left") ) then
				cameraAngleX = cameraAngleX + math.rad(180)
				--cameraAngleY = cameraAngleY + math.rad(180)
			elseif getControlState("vehicle_look_left") then
				cameraAngleX = cameraAngleX - math.rad(90)
				--roll = rx doesn't work out well
			elseif getControlState("vehicle_look_right") then
				cameraAngleX = cameraAngleX + math.rad(90)  
				--roll = -rx
			end
		else
			local rx, ry, rz = getElementRotation(localPlayer)
			if wasInVehicle then
				rotX = rotX - math.rad(rz) --prevent camera from rotating when exiting a vehicle
			end
			cameraAngleX = rotX
			cameraAngleY = rotY
		end
		wasInVehicle = inVehicle
		--Taken from the freecam resource made by eAi
		-- work out an angle in radians based on the number of pixels the cursor has moved (ever)
		local freeModeAngleZ = math.sin(cameraAngleY)
		local freeModeAngleY = math.cos(cameraAngleY) * math.cos(cameraAngleX)
		local freeModeAngleX = math.cos(cameraAngleY) * math.sin(cameraAngleX)

		-- calculate a target based on the current position and an offset based on the angle
		local camTargetX = camPosX + freeModeAngleX * 100
		local camTargetY = camPosY + freeModeAngleY * 100
		local camTargetZ = camPosZ + freeModeAngleZ * 100

		-- Work out the distance between the target and the camera (should be 100 units)
		local camAngleX = camPosX - camTargetX
		local camAngleY = camPosY - camTargetY
		local camAngleZ = 0 -- we ignore this otherwise our vertical angle affects how fast you can strafe

		-- Calulcate the length of the vector
		local angleLength = math.sqrt(camAngleX*camAngleX+camAngleY*camAngleY+camAngleZ*camAngleZ)

		-- Normalize the vector, ignoring the Z axis, as the camera is stuck to the XY plane (it can't roll)
		local camNormalizedAngleX = camAngleX / angleLength
		local camNormalizedAngleY = camAngleY / angleLength
		local camNormalizedAngleZ = 0

		-- We use this as our rotation vector
		local normalAngleX = 0
		local normalAngleY = 0
		local normalAngleZ = 1

		-- Perform a cross product with the rotation vector and the normalzied angle
		local normalX = (camNormalizedAngleY * normalAngleZ - camNormalizedAngleZ * normalAngleY)
		local normalY = (camNormalizedAngleZ * normalAngleX - camNormalizedAngleX * normalAngleZ)
		local normalZ = (camNormalizedAngleX * normalAngleY - camNormalizedAngleY * normalAngleX)

		-- Update the target based on the new camera position (again, otherwise the camera kind of sways as the target is out by a frame)
		camTargetX = camPosX + freeModeAngleX * 100
		camTargetY = camPosY + freeModeAngleY * 100
		camTargetZ = camPosZ + freeModeAngleZ * 100

		-- Set the new camera position and target
		setCameraMatrix (camPosX, camPosY, camPosZ, camTargetX, camTargetY, camTargetZ, roll)
	end
end

function freecamMouse (cX,cY,aX,aY)
	--ignore mouse movement if the cursor or MTA window is on
	--and do not resume it until at least 5 frames after it is toggled off
	--(prevents cursor mousemove data from reaching this handler)
	if isCursorShowing() or isMTAWindowActive() then
		mouseFrameDelay = 5
		return
	elseif mouseFrameDelay > 0 then
		mouseFrameDelay = mouseFrameDelay - 1
		return
	end
	
	startTick = getTickCount()
	recentlyMoved = true
	
	-- check if the mouse is moved while fading back, if so abort the fading
	if fadeBack then
		fadeBack = false
		executeCounter = 0
	end
	
	-- how far have we moved the mouse from the screen center?
	local width, height = guiGetScreenSize()
	aX = aX - width / 2 
	aY = aY - height / 2
	
	rotX = rotX + aX * mouseSensitivity * 0.01745
	rotY = rotY - aY * mouseSensitivity * 0.01745

	local pRotX, pRotY, pRotZ = getElementRotation (localPlayer)
	pRotZ = math.rad(pRotZ)
	
	if rotX > PI then
		rotX = rotX - 2 * PI
	elseif rotX < -PI then
		rotX = rotX + 2 * PI
	end
	
	if rotY > PI then
		rotY = rotY - 2 * PI
	elseif rotY < -PI then
		rotY = rotY + 2 * PI
	end
	-- limit the camera to stop it going too far up or down
	if isPedInVehicle(localPlayer) then
		if rotY < -PI / 4 then
			rotY = -PI / 4
		elseif rotY > -PI/15 then
			rotY = -PI/15
		end
		if rotX < -PI / 4 then
			rotX = -PI / 4
		elseif rotX > -PI/15 then
			rotX = -PI/15
		end			
	else
		if rotY < -PI / 4 then
			rotY = -PI / 4
		elseif rotY > PI / 3.5 then
			rotY = PI / 3.5
		end
		--[[
		-- Disabled till the appropriate math is found
		if rotX < -PI / 2 then
			rotX = -PI / 2
		elseif rotX > PI / 2 then
			rotX = PI / 2
		end
		]]
	end
end
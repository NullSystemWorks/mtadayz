--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: animations_player.lua					*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: CLIENT														*----
#-----------------------------------------------------------------------------#
]]

local proned = false
local proneObject
local speed = 16
local animTimer
checkForHandler = false

function onPlayerProne(state)
	proned = state
	--NOTE: We had to re-apply the animation clientside due to a positioning bug with GTA. Go along with it.
	if not proned then
		setPedAnimation(localPlayer,"ped","getup_front",-1,false)
		if proneObject and isElement(proneObject) then destroyElement(proneObject) end
		if animTimer and isTimer(animTimer) then killTimer(animTimer) end
		animTimer = setTimer(setPedAnimation,1300,1,localPlayer)
		removeEventHandler("onClientRender",root,moveWhileProne)
		checkForHandler = false
	else
		setPedAnimation(localPlayer,"ped","FLOOR_hit_f",-1,false)	
		if proneObject and isElement(proneObject) then destroyElement(proneObject) end
		local x,y,z = getElementPosition(localPlayer)
		local rX,rY,rZ = getElementRotation(localPlayer)
		proneObject = createObject(2061,x,y,z,rX,rY,rZ)
		attachElements(localPlayer,proneObject,0,0,0)
		setElementCollisionsEnabled(proneObject,false)
		setElementAlpha(proneObject,0)
		addEventHandler("onClientRender",root,moveWhileProne)
		checkForHandler = false
	end
end
addEvent("onPlayerProne",true)
addEventHandler("onPlayerProne",root,onPlayerProne)

addEventHandler("onPlayerSpawn",root,
function()
	proned = false
	if checkForHandler then
		removeEventHandler("onClientRender",root,moveWhileProne)
		checkForHandler = false
	end
end)

function moveWhileProne()
	_pos = proneObject:getPosition()
	playerPosX, playerPosY, playerPosZ = getElementPosition(localPlayer)
	local bX,bY,bZ = getPedBonePosition(localPlayer,8)
	
	if isKeyDown("W") then
		pos = Vector3(playerPosX,playerPosY,playerPosZ) + proneObject.matrix.forward / speed	
		sightPos = Vector3(bX,bY,bZ) + proneObject.matrix.forward 
		if not isLineOfSightClear(_pos,sightPos,true,true,true,true,false,true,false,false) then
			-- Currently, the player is able to "glide" past some objects, such as walls of buildings. This causes him to fall below the map. Any fix?
			pos = (Vector3(playerPosX,playerPosY,playerPosZ) + (proneObject.matrix.up/10)) + (proneObject.matrix.forward/8)
		end
	elseif isKeyDown("A") then
		pos = _pos - localPlayer.matrix.right / speed
		sightPos = _pos - localPlayer.matrix.right * 1.25
		if not isLineOfSightClear(_pos,sightPos,true,true,true,true,false,false,false,false) then
			pos = _pos --revert
		end
	elseif isKeyDown("S") then
		pos = Vector3(playerPosX,playerPosY,playerPosZ) - proneObject.matrix.forward / speed
		sightPos = Vector3(bX,bY,bZ) - proneObject.matrix.forward 
		if not isLineOfSightClear(_pos,sightPos,true,true,true,true,false,false,false,false) then
			pos = _pos
		end
	elseif isKeyDown("D") then
		pos = pos + localPlayer.matrix.right / speed
		sightPos = _pos + localPlayer.matrix.right * 1.25
		if not isLineOfSightClear(_pos,sightPos,true,true,true,true,false,false,false,false) then
			pos = _pos
		end
	end
	
	if isKeyDown("W") or isKeyDown("A") or isKeyDown("S") or isKeyDown("D") then
		setElementPosition(proneObject,pos)
	end
	
	isOnGround = isPedOnGround(localPlayer)
	isInWater = isElementInWater(localPlayer)
	x,y,z = getElementPosition(localPlayer)
	gPos = getGroundPosition(x,y,z)
	
	if not isOnGround then
		if not isInWater then
			if gPos > -45 then
				DownPos = (Vector3(playerPosX,playerPosY,playerPosZ) - (proneObject.matrix.up/10)) + (proneObject.matrix.forward/8)
			end
			setElementPosition(proneObject,DownPos)
		end
	end
	
	--Update the rotation based on the camera's rotation
	setElementRotation(localPlayer,0,0,360 - getPedCameraRotation(localPlayer))
	setElementRotation(proneObject,0,0,360 - getPedCameraRotation(localPlayer))
end


function isKeyDown(key)
	if getKeyState(key) then return true else return false end
end
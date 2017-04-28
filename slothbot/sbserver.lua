--SERVER STUFF
function getZombieSpeed()
	ZombieSpeed = get("ZSpeed")
	if tonumber(ZombieSpeed) == 1 then		-- If value in settings is set to 1, then zombies will walk
		speed = "walk"
	elseif tonumber(ZombieSpeed) == 2 then
		speed = "sprint"			-- If value in setting is set to 2, then zombies will sprint
	else
		speed = "sprint"			-- If person was too stupid to set either 1 or 2 as value, punish by setting to sprint
	end
	setTimer(function() triggerClientEvent("onResourceStartSetZombieSpeed",root,speed) end,2000,1,speed)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),getZombieSpeed)


--when a bot dies, tells the bot what to do next
function peddeath(ammo, attacker, weapon, bodypart)
	if (getElementData (source, "slothbot") == true) then -- if its a slothbot
		triggerEvent ( "onBotWasted", source, attacker, weapon, bodypart )
		setElementData ( source, "status", "dead" )	
		local peds = getElementsByType ( "ped" )
		for theKey,thePed in ipairs(peds) do
			if (getElementData ( thePed, "leader" ) ==  source ) then
				if (getElementData ( thePed, "status" ) == "following" ) then
					setElementData ( thePed, "leader", nil )
					setTimer (beginsearch, 800, 1, thePed ) -- move on
				else
					setElementData ( thePed, "leader", nil )
				end
			end
			if (getElementData ( thePed, "target" ) ==  source ) then
				setElementData ( thePed, "target", nil )
			end
		end		
		destroyElement(source)
	else -- if its a non slothbot ped
		if (attacker) then
			if (getElementType(attacker) == "ped") and (getElementData (attacker, "slothbot") == true) then
				--nothing (might add something later)
			end
		end
	end	
end
addEventHandler("onPedWasted", getRootElement(), peddeath)

--when a player dies, tells the bot what to do next
function playerdeath( ammo, attacker, weapon, bodypart )
	if (attacker) then
		if (getElementData (attacker, "slothbot") == true) then
--nothing
		end
	end
	local peds = getElementsByType ( "ped" )
	for theKey,thePed in ipairs(peds) do
		if (getElementData (thePed, "slothbot") == true) then
			if (getElementData ( thePed, "leader" ) ==  source ) then
				if (getElementData ( thePed, "status" ) == "following" ) then
					setTimer (beginsearch, 800, 1, thePed ) -- move on to the next target
					setElementData ( thePed, "leader", nil )
				else
					setElementData ( thePed, "leader", nil )
				end
			end
			if (getElementData ( thePed, "target" ) == source ) then
				setElementData ( thePed, "target", nil )
			end
		end
	end
end
addEventHandler("onPlayerWasted", getRootElement(), playerdeath)


--when a bot sees an enemy
addEvent( "onBotFindEnemy", true )
function assigntarget ( player )
	if ( not wasEventCancelled() ) then
		if (isElement(player)) and (getElementData (source, "slothbot") == true) then
			if (getElementData ( source, "target" ) ~=  player ) and (getElementType ( player ) == "player") then
				setElementData ( source, "target", player )
				if (getElementData ( source, "status" ) ~= "chasing" ) then
					assigncontroller(source)
					setElementData ( source, "status", "chasing" )
				end
			elseif (getElementData ( source, "target" ) ~=  player ) and (getElementType ( player ) == "ped") then
				setElementData ( source, "target", player )
				if (getElementData ( source, "status" ) ~= chasing ) then
					assigncontroller(source)
					setElementData ( source, "status", "chasing" )
				end		
			end
		end
	end
end
addEventHandler( "onBotFindEnemy", getRootElement(), assigntarget )

--initializes the ped to start walking the paths
addEvent( "onHuntStart", true )
function beginsearch (theped)
	if (isElement(theped)) then
		if (getElementData (theped, "slothbot") == true) then
			setElementData ( theped, "target", nil )
			setElementData ( theped, "leader", nil )
			assigncontroller(theped)
			setElementData ( theped, "status", "hunting" )
		end
	end
end
addEventHandler( "onHuntStart", getRootElement(), beginsearch )

--detects what mode the ped is changed to and activates the correct behaviour (hunting, shooting, following, etc)
function changestatus (dataName)
	if getElementType ( source ) == "ped" and dataName == "status" and (getElementData (source, "slothbot") == true) then
		if (getElementData ( source, "status" ) ~= "stasis" ) then
			local allshapes = getElementsByType ( "colshape" )
			for SKey,theShape in ipairs(allshapes) do
				if (isElement(theShape)) then
					if getElementParent (theShape) == source then
						destroyElement (theShape) -- removes the target colshape that the ped was running towards in hunt mode
					end
				end
			end	
		end
		if (getElementData ( source, "status" ) == "chasing" ) then
			local player = getElementData ( source, "target" )
			local oldTx, oldTy, oldTz = getElementPosition( player )
			local oldPx, oldPy, oldPz = getElementPosition( source )
			setTimer ( chase_move, 700, 1, source, oldTx, oldTy, oldTz, oldPx, oldPy, oldPz )
		elseif (getElementData ( source, "status" ) == "hunting" ) then
			setTimer ( findPath, 200, 1, source )
		elseif (getElementData ( source, "status" ) == "waiting" ) then
			setTimer ( wait_mode, 200, 1, source )
		elseif (getElementData ( source, "status" ) == "following" ) then
			local player = getElementData ( source, "leader" )
			local oldTx, oldTy, oldTz = getElementPosition( player )
			local oldPx, oldPy, oldPz = getElementPosition( source )			
			setTimer ( follow_move, 700, 1, source, oldTx, oldTy, oldTz, oldPx, oldPy, oldPz )
		elseif (getElementData ( source, "status" ) == "guarding" ) then			
			local px,py,pz = getElementPosition( source )
			guard_move (source, px, py, pz)
		end
	end
end
addEventHandler( "onElementDataChange", getRootElement(), changestatus )

-- tells the bot how to chase enemies
function chase_move (ped, oldTx, oldTy, oldTz, oldPx, oldPy, oldPz)
	if (isElement(ped)) then
		if (getElementData ( ped, "status" ) ==  "chasing" ) and (getElementData (ped, "slothbot") == true) then
			local px,py,pz = getElementPosition( ped )
			local player = getElementData ( ped, "target" )
			if (isElement(player)) then
				local tx,ty,tz = getElementPosition( player )			
				local pedhp = getElementHealth ( ped )
				if getElementType(player) == "player" then
					if pedhp > 0 and (isPedDead(player) == false) then
						if (getElementData ( ped, "seestarget" ) == true ) then-- if the ped can see the target
							local inrange = 0
							local tdist = (getDistanceBetweenPoints3D (px, py, pz, tx, ty, tz))
							if (getPedWeaponSlot(ped) == 0 ) then -- fists
								triggerClientEvent ( "bot_Forwards", ped )
								inrange = 0
							elseif (getPedWeaponSlot(ped) == 1 ) then -- melee
								triggerClientEvent ( "bot_Forwards", ped )
								inrange = 0							
							elseif (getPedWeaponSlot(ped) == 2 ) then -- pistols				
								if tdist < 14 then
									triggerClientEvent ( "bot_Stop", ped )
									inrange = 1
								else	
									triggerClientEvent ( "bot_Forwards", ped )
									inrange = 0
								end
							elseif (getPedWeaponSlot(ped) == 3 ) then -- shotguns
								if tdist < 10 then
									triggerClientEvent ( "bot_Stop", ped )
									inrange = 1
								else	
									triggerClientEvent ( "bot_Forwards", ped )
									inrange = 0
								end
							elseif (getPedWeaponSlot(ped) == 4 ) then -- submachine
								if tdist < 7 then
									triggerClientEvent ( "bot_Stop", ped )
									inrange = 1
								else	
									triggerClientEvent ( "bot_Forwards", ped )
									inrange = 0
								end
							elseif (getPedWeaponSlot(ped) == 5 ) then -- assault
								if tdist < 14 then
									triggerClientEvent ( "bot_Stop", ped )
									inrange = 1
								else	
									triggerClientEvent ( "bot_Forwards", ped )
									inrange = 0
								end
							elseif (getPedWeaponSlot(ped) == 6 ) then --rifles
								if tdist < 22 then
									triggerClientEvent ( "bot_Stop", ped )
									inrange = 1
								else	
									triggerClientEvent ( "bot_Forwards", ped )
									inrange = 0
								end
							elseif (getPedWeaponSlot(ped) == 7 ) then --heavy
								if tdist < 12 then
									triggerClientEvent ( "bot_Stop", ped )
									inrange = 1
								else	
									triggerClientEvent ( "bot_Forwards", ped )
									inrange = 0
								end
							elseif (getPedWeaponSlot(ped) == 8 ) then	--projectiles (dont work afaik)
								triggerClientEvent ( "bot_Forwards", ped )
								inrange = 0
							elseif (getPedWeaponSlot(ped) == 9 ) then -- special
								if tdist < 2 then
									triggerClientEvent ( "bot_Stop", ped )
									inrange = 1
								else
									triggerClientEvent ( "bot_Forwards", ped )
									inrange = 0
								end
							elseif (getPedWeaponSlot(ped) == 10 ) then -- gifts
								triggerClientEvent ( "bot_Forwards", ped )
								inrange = 0
							elseif (getPedWeaponSlot(ped) == 11 ) then -- special2
								triggerClientEvent ( "bot_Forwards", ped )
								inrange = 0
							elseif (getPedWeaponSlot(ped) == 12 ) then -- detonator
								triggerClientEvent ( "bot_Forwards", ped )
								inrange = 0
							else -- probably useless part.
								triggerClientEvent ( "bot_Forwards", ped )
								inrange = 0
							end
							local pdistance = (getDistanceBetweenPoints3D (oldPx, oldPy, oldPz, px, py, pz))
							if (pdistance < 1 ) and (inrange == 0 ) then -- if the ped is stuck but not in range of the player
								local weap = getPedWeaponSlot(ped)
								if (weap == 1) or (weap == 7) then
									setPedWeaponSlot(ped, 0 )
									triggerClientEvent ( "bot_Jump", ped )
									setTimer ( setPedWeaponSlot, 850, 1, ped, weap)
								else
									triggerClientEvent ( "bot_Jump", ped )
								end
								setTimer ( chase_move, 600, 1, ped, tx, ty, tz, px, py, pz)
							else
								setTimer ( chase_move, 600, 1, ped, tx, ty, tz, px, py, pz)
							end
						else -- if the ped cant see the target
							triggerClientEvent ( "bot_Forwards", ped )
							local pdistance = (getDistanceBetweenPoints3D (oldPx, oldPy, oldPz, px, py, pz))
							if (pdistance < 1.2 ) then --if the ped is stuck
								local decide = math.random( 1, 7 ) -- randomly decide to
								if decide == 1 then -- give up chasing and go back on the hunt
									setTimer (beginsearch, 800, 1, ped )
								elseif decide <4 then -- jump
									local weap = getPedWeaponSlot(ped)
									if (weap == 1) or (weap == 7) then
										setPedWeaponSlot(ped, 0 )
										triggerClientEvent ( "bot_Jump", ped )
										setTimer ( setPedWeaponSlot, 850, 1, ped, weap)
									else
										triggerClientEvent ( "bot_Jump", ped )
									end
									setTimer ( chase_move, 600, 1, ped, tx, ty, tz, px, py, pz)
								else -- randomly turn a new direction, walk a bit, then resume
									local randomangle = math.random( 1, 360 )
									setPedRotation( ped, randomangle )
									setTimer ( chase_move, 1200, 1, ped, tx, ty, tz, px, py, pz)
								end
							else -- if the ped isnt stuck
								local distance = (getDistanceBetweenPoints3D (px, py, pz, oldTx, oldTy, oldTz))
								if (distance > 5 ) then -- if the ped hasnt reached its target
									local flatdist = (getDistanceBetweenPoints2D( px, py, tx, ty))
									if flatdist < 2 then -- if the ped hasnt reached its target, but is directly below or above (for multiple levels in maps)
										setTimer (beginsearch, 800, 1, ped )
									else -- keep going
										local angle = ( 360 - math.deg ( math.atan2 ( ( oldTx - px ), ( oldTy - py ) ) ) ) % 360
									--	setPedRotation( ped, angle )
										setTimer ( chase_move, 600, 1, ped, oldTx, oldTy, oldTz, px, py, pz)
									end
								else -- if the ped has reached its target ( reached the spot it last saw you standing in)
									setTimer (beginsearch, 800, 1, ped )
								end
							end
						end
					else
						setTimer (beginsearch, 800, 1, ped )
					end
				elseif getElementType(player) == "ped" then
					if pedhp > 0 and (getElementHealth(player) > 0) then
						if (getElementData ( ped, "seestarget" ) == true ) then -- if the ped can see the target
							local inrange = 0
							local tdist = (getDistanceBetweenPoints3D (px, py, pz, tx, ty, tz))
							if (getPedWeaponSlot(ped) == 0 ) then -- fists
								triggerClientEvent ( "bot_Forwards", ped )
								inrange = 0
							elseif (getPedWeaponSlot(ped) == 1 ) then -- melee
								triggerClientEvent ( "bot_Forwards", ped )
								inrange = 0							
							elseif (getPedWeaponSlot(ped) == 2 ) then -- pistols				
								if tdist < 14 then
									triggerClientEvent ( "bot_Stop", ped )
									inrange = 1
								else	
									triggerClientEvent ( "bot_Forwards", ped )
									inrange = 0
								end
							elseif (getPedWeaponSlot(ped) == 3 ) then -- shotguns
								if tdist < 10 then
									triggerClientEvent ( "bot_Stop", ped )
									inrange = 1
								else	
									triggerClientEvent ( "bot_Forwards", ped )
									inrange = 0
								end
							elseif (getPedWeaponSlot(ped) == 4 ) then -- submachine
								if tdist < 8 then
									triggerClientEvent ( "bot_Stop", ped )
									inrange = 1
								else	
									triggerClientEvent ( "bot_Forwards", ped )
									inrange = 0
								end
							elseif (getPedWeaponSlot(ped) == 5 ) then -- assault
								if tdist < 17 then
									triggerClientEvent ( "bot_Stop", ped )
									inrange = 1
								else	
									triggerClientEvent ( "bot_Forwards", ped )
									inrange = 0
								end
							elseif (getPedWeaponSlot(ped) == 6 ) then --rifles
								if tdist < 22 then
									triggerClientEvent ( "bot_Stop", ped )
									inrange = 1
								else	
									triggerClientEvent ( "bot_Forwards", ped )
									inrange = 0
								end
							elseif (getPedWeaponSlot(ped) == 7 ) then --heavy
								if tdist < 12 then
									triggerClientEvent ( "bot_Stop", ped )
									inrange = 1
								else	
									triggerClientEvent ( "bot_Forwards", ped )
									inrange = 0
								end
							elseif (getPedWeaponSlot(ped) == 8 ) then	--projectiles (dont work afaik)
								triggerClientEvent ( "bot_Forwards", ped )
								inrange = 0
							elseif (getPedWeaponSlot(ped) == 9 ) then -- special
								if tdist < 2 then
									triggerClientEvent ( "bot_Stop", ped )
									inrange = 1
								else
									triggerClientEvent ( "bot_Forwards", ped )
									inrange = 0
								end
							elseif (getPedWeaponSlot(ped) == 10 ) then -- gifts
								triggerClientEvent ( "bot_Forwards", ped )
								inrange = 0
							elseif (getPedWeaponSlot(ped) == 11 ) then -- special2
								triggerClientEvent ( "bot_Forwards", ped )
								inrange = 0
							elseif (getPedWeaponSlot(ped) == 12 ) then -- detonator
								triggerClientEvent ( "bot_Forwards", ped )
								inrange = 0
							else -- probably useless part.
								triggerClientEvent ( "bot_Forwards", ped )
								inrange = 0
							end
							local pdistance = (getDistanceBetweenPoints3D (oldPx, oldPy, oldPz, px, py, pz))
							if (pdistance < 1 ) and (inrange == 0 ) then -- if the ped is stuck but not in range of the target
								local weap = getPedWeaponSlot(ped)
								if (weap == 1) or (weap == 7) then
									setPedWeaponSlot(ped, 0 )
									triggerClientEvent ( "bot_Jump", ped )
									setTimer ( setPedWeaponSlot, 850, 1, ped, weap)
								else
									triggerClientEvent ( "bot_Jump", ped )
								end
								setTimer ( chase_move, 700, 1, ped, tx, ty, tz, px, py, pz)
							else
								setTimer ( chase_move, 700, 1, ped, tx, ty, tz, px, py, pz)
							end
						else -- if the ped cant see the target
							local pdistance = (getDistanceBetweenPoints3D (oldPx, oldPy, oldPz, px, py, pz))
							if (pdistance < 1.3 ) then --if the ped is stuck
								local decide = math.random( 1, 7 ) -- randomly decide to
								if decide == 1 then -- give up chasing and go back on the hunt						
									setTimer (beginsearch, 800, 1, ped )
								elseif decide <4 then -- jump
									local weap = getPedWeaponSlot(ped)
									if (weap == 1) or (weap == 7) then
										local slot = getPedWeaponSlot(ped)
										setPedWeaponSlot(ped, 0 )
										triggerClientEvent ( "bot_Jump", ped )
										setTimer ( setPedWeaponSlot, 850, 1, ped, slot)
									else
										triggerClientEvent ( "bot_Jump", ped )
									end
									setTimer ( chase_move, 700, 1, ped, tx, ty, tz, px, py, pz)
								else -- randomly turn a new direction, walk a bit, then resume
									local randomangle = math.random( 1, 360 )
									setPedRotation( ped, randomangle )
									setTimer ( chase_move, 1200, 1, ped, tx, ty, tz, px, py, pz)
								end
							else -- if the ped isnt stuck
								local distance = (getDistanceBetweenPoints3D (px, py, pz, oldTx, oldTy, oldTz))
								if (distance > 5 ) then -- if the ped hasnt reached its target
									local flatdist = (getDistanceBetweenPoints2D( px, py, tx, ty))
									if flatdist < 2 then -- if the ped hasnt reached its target, but is directly below or above (for multiple levels in maps)
										setTimer (beginsearch, 800, 1, ped )							
									else -- keep going
										setTimer ( chase_move, 700, 1, ped, oldTx, oldTy, oldTz, px, py, pz)
									end
								else -- if the ped has reached its target ( reached the spot it last saw you standing in)
									setTimer (beginsearch, 800, 1, ped )
								end
							end
						end
					else
						setTimer (beginsearch, 800, 1, ped )
					end
				end
			else
				setTimer (beginsearch, 800, 1, ped )
			end
		end
	end
end

--gets a nearby node, while excluding a particular node so a ped wont backtrack
function getRandomNeighbor(node, excludedNumber)
	numberString = getElementData(node, "neighbors")
	local numbersArray = {}
	local i = 1
	local curNumber = gettok(numberString, i, string.byte(','))
	while (curNumber) do
		if (not excludedNumber or curNumber ~= excludedNumber) then
			table.insert(numbersArray, curNumber)
		end
		i = i + 1
		curNumber = gettok(numberString, i, string.byte(','))
	end
	-- select a random number
	numElements = #numbersArray
	if (numElements == 0) then
		if (excludedNumber) then
			return excludedNumber
		else
			return false
		end
	elseif (numElements == 1) then
		return numbersArray[1]
	else
		return numbersArray[math.random(1, numElements)]
	end
end

--when a ped hits a path node, decides where to go to next.
function pathHit ( hitElement, matchingDimension )
	if getElementType (hitElement) == "ped" and (getElementData (hitElement, "slothbot") == true) then
		if getElementParent (source) == hitElement then
			local oldnode = getElementData(source, "oldspot")
			local oldnodeid = getElementID (oldnode)
			local currentnode = getElementData(source, "currentspot")			
			local newnodeid = getRandomNeighbor(currentnode, oldnodeid) -- calls the function above to decide the new node
			local newnode = getElementByID (newnodeid)
			local nx,ny,nz = getElementPosition(newnode)			
			local newnodecol = createColSphere ( nx,ny,nz, 1.5 )
			setElementInterior(newnodecol, (getElementInterior(hitElement)))
			setElementDimension(newnodecol, (getElementDimension(hitElement)))
			setElementParent ( newnodecol,hitElement)
			setElementData ( newnodecol, "oldspot", currentnode )
			setElementData ( newnodecol, "currentspot", newnode )			
			setElementData ( hitElement, "targetpath", newnode ) --sets the peds target
			destroyElement (source)
		end
	end
end
addEventHandler ( "onColShapeHit", getRootElement(), pathHit )

--triggers a function to the closest player of a ped to find the closest node point in sight, which in return gives the next function down the info to start on the right path
function findPath (ped)
	local allwaypoints = getElementsByType ( "pathpoint" )
	if #allwaypoints > 2 then
		if (isElement(getElementData(ped,"controller"))) then
			triggerClientEvent ( "pedPathfind", getElementData(ped,"controller"), ped)
		end
	else
		if isElement(ped) then
		setElementData ( ped, "target", nil )
		setElementData ( ped, "leader", nil )
		assigncontroller(ped)
		setElementData ( ped, "status", "waiting" )	
		end
	end
end

--ped picks the path node to start with
addEvent( "pedPathChoose", true )	
function setPedOnPath(ped, firstTarget)
	local px,py,pz = getElementPosition( ped )
	local distToBeat = 9999
	if firstTarget == nil then
		local allwaypoints = getElementsByType ( "pathpoint" )
		for PKey,theNode in ipairs(allwaypoints) do --2nd pass in case theres no nodes in sight, just go to closest.
			local wx,wy,wz = getElementPosition( theNode )
			local distance = (getDistanceBetweenPoints3D( px, py, pz, wx, wy, wz ))
			if distance < distToBeat then
				distToBeat = distance
				firstTarget = theNode
			end
		end
	end
	local nx,ny,nz = getElementPosition( firstTarget )
	local newnodecol = createColSphere ( nx,ny,nz, 1.5 )
	setElementInterior(newnodecol, (getElementInterior(ped)))
	setElementDimension(newnodecol, (getElementDimension(ped)))
	setElementParent ( newnodecol,ped)
	setElementData ( newnodecol, "currentspot", firstTarget )
	setElementData ( newnodecol, "oldspot", firstTarget ) -- sets old spot to new current col cause there is no old onew
	setElementData ( ped, "targetpath", firstTarget ) --sets the peds target
	setTimer ( hunt_move, 300, 1, ped, px, py, pz )
end
addEventHandler("pedPathChoose", getRootElement(), setPedOnPath)

--takes the shoot command from the peds target player and sends it to all the clients (this is done in a roundabout way to make sure shooting is somewhat synced)
addEvent( "pedShootTrigger", true )
function makePedShoot(type, length)
	if (isElement(source)) then
		if getElementType (source) == "ped" and (getElementData (source, "slothbot") == true) and (getElementData (source, "AllowFire") ~= false ) then
			if type == "melee" then
				triggerClientEvent (getRootElement(), "onMeleeShoot", source, source )
			elseif type == "chainsawA" then
				triggerClientEvent (getRootElement(), "onChainsawAShoot", source, source, length )
			elseif type == "chainsawB" then
				triggerClientEvent (getRootElement(), "onChainsawBShoot", source, source, length )
			elseif type == "gun" then
				triggerClientEvent (getRootElement(), "onGunShoot", source, source, length )
			elseif type == "sniper" then
				triggerClientEvent (getRootElement(), "onSniperShoot", source, source )
			end
		end
	end
end
addEventHandler("pedShootTrigger", getRootElement(), makePedShoot)

--when a ped gets stuck, set them in the direction of a new node
addEvent( "onPedStuck", true )
function findNewPath (sbot)
	local oldnode = getElementData(sbot, "targetpath")
	local distToBeat = 9999
	local firstTarget = nil
	local px,py,pz = getElementPosition( sbot )
	local allwaypoints = getElementsByType ( "pathpoint" )
	for PKey,theNode in ipairs(allwaypoints) do --first pass to find closest node
		if theNode ~= oldnode then
			local wx,wy,wz = getElementPosition( theNode )
			local distance = (getDistanceBetweenPoints3D( px, py, pz, wx, wy, wz ))
			if distance < distToBeat then
				distToBeat = distance
				firstTarget = theNode
			end
		end
	end
	local nx,ny,nz = getElementPosition( firstTarget )
	local newnodecol = createColSphere ( nx,ny,nz, 1.5 )
	setElementInterior(newnodecol, (getElementInterior(sbot)))
	setElementDimension(newnodecol, (getElementDimension(sbot)))
	setElementParent ( newnodecol,sbot)
	setElementData ( newnodecol, "currentspot", firstTarget )
	setElementData ( newnodecol, "oldspot", firstTarget ) -- sets old spot to new current col cause there is no old onew
	setElementData ( sbot, "targetpath", firstTarget ) --sets the peds target
end
addEventHandler( "onPedStuck", getRootElement(), findNewPath )

--tells bot where to move while in hunt mode
function hunt_move (ped,oldX,oldY,oldZ) --this function keeps the ped running towards whatever element is set as its "targetpath" elementdata
	if (isElement(ped)) then
		if (getElementData ( ped, "status" ) == "hunting" ) and (getElementData (ped, "slothbot") == true) then
			local pedhp = getElementHealth ( ped )
			if pedhp > 0 then
				local target = getElementData( ped, "targetpath")
				local tx,ty,tz = getElementPosition( target )
				local px,py,pz = getElementPosition( ped )			
				triggerClientEvent ( "bot_Forwards", ped )
				setTimer ( hunt_move, 700, 1, ped, px ,py ,pz)
				local distance = (getDistanceBetweenPoints3D( px, py, pz, oldX, oldY, oldZ ))
				if distance < 1 then -- if the ped is stuck while in hunt mode( if the path nodes are done well enough, this should rarely be an issue)
					local decide = math.random( 1, 13 )
					if decide == 1 then -- give up and find a new path node 
						findNewPath (ped)
					elseif decide < 7 then -- jump
						local weap = getPedWeaponSlot(ped)
						if (weap == 1) or (weap == 7) then
							setPedWeaponSlot(ped, 0 )
							triggerClientEvent ( "bot_Jump", ped )
							setTimer ( setPedWeaponSlot, 850, 1, ped, weap)
						else
							triggerClientEvent ( "bot_Jump", ped )
						end
					else -- randomly turn a new direction, walk a bit, then resume
						local randomangle = math.random( 1, 360 )
						setPedRotation( ped, randomangle )
					end
				elseif distance > 3 then -- if the player is greater than a distance of 3 units
					local flatdist = (getDistanceBetweenPoints2D( px, py, tx, ty))
					if flatdist < .8 then -- but is directly above or below (for maps with multiple levels or platforms)
						findNewPath(ped) -- find a new path
					end
				end
			end
		end
	end
end

--auto follow for bots
addEvent( "TeamBot", true )
function autoBotFollow(ped, leader)
	if (isElement(ped)) and (isElement(leader)) then
		if (getElementData ( ped, "status" ) == "hunting" ) or (getElementData ( ped, "status" ) == "waiting" ) then
			if (getElementData ( leader, "status" ) ~= "following" ) and (getElementData ( leader, "status" ) ~= "waiting" ) then
				if getElementType(leader) == "player" then
					if (getElementData ( ped, "BotTeam" ) == getPlayerTeam (leader)) then
						triggerEvent ( "onBotFollow", ped, leader )
						setElementData ( ped, "target", nil )
						setElementData ( ped, "leader", leader )
						assigncontroller(ped)
						setElementData ( ped, "status", "following")
						triggerEvent ( "onBotFollow", ped, leader )
					else 
						return false
					end
				elseif getElementType(leader) == "ped" then
					if getElementData(ped,"BotTeam") == getElementData ( leader, "BotTeam" ) then
						if leader ~= ped then
							triggerEvent ( "onBotFollow", ped, leader )
							setElementData ( ped, "target", nil )
							setElementData ( ped, "leader", leader )
							assigncontroller(ped)
							setElementData ( ped, "status", "following")
							triggerEvent ( "onBotFollow", ped, leader )
						end
					else 
						return false
					end
				else 
					return false
				end
			else 
				return false
			end
		else 
			return false
		end
	else 
		return false
	end
end
addEventHandler( "TeamBot", getRootElement(), autoBotFollow )

--tells the bot how to move and shoot when following
function follow_move (ped, oldTx, oldTy, oldTz, oldPx, oldPy, oldPz)
	if (isElement(ped)) then
		local leader = getElementData ( ped, "leader" )
		if (getElementData ( ped, "status" ) ==  "following" ) and (isElement(leader)) and (getElementData (ped, "slothbot") == true) then
			local pedhp = getElementHealth ( ped )
			local tx,ty,tz = getElementPosition( leader )
			local px,py,pz = getElementPosition( ped )
			local fdist = (getDistanceBetweenPoints3D (px, py, pz, tx, ty, tz))
			if (fdist < 13) and (getElementData (ped, "follow_shooting") == true) then
				setTimer ( follow_move, 1000, 1, ped, tx, ty, tz, px, py, pz)
			else
				if getElementType(leader) == "player" then		
					if pedhp > 0 and (isPedDead(leader) == false) then
						if (getElementData ( ped, "seestarget" ) == true ) then
							local tdist = (getDistanceBetweenPoints3D (px, py, pz, tx, ty, tz))
							if tdist < 3 then
								triggerClientEvent ( "bot_Stop", ped )
							else	
								triggerClientEvent ( "bot_Forwards", ped )
							end
							local pdistance = (getDistanceBetweenPoints3D (oldPx, oldPy, oldPz, px, py, pz))
							if (pdistance < 1 ) then -- if the ped is stuck
								local fdist = (getDistanceBetweenPoints3D (px, py, pz, tx, ty, tz))
								if fdist > 3 then
									local weap = getPedWeaponSlot(ped)
									if (weap == 1) or (weap == 7) then
										setPedWeaponSlot(ped, 0 )
										
										setTimer ( setPedWeaponSlot, 850, 1, ped, weap)
									else
										triggerClientEvent ( "bot_Jump", ped )
									end
								end
								setTimer ( follow_move, 600, 1, ped, tx, ty, tz, px, py, pz)
							else
								setTimer ( follow_move, 600, 1, ped, tx, ty, tz, px, py, pz)
							end
						else -- if the ped cant see the target
							local pdistance = (getDistanceBetweenPoints3D (oldPx, oldPy, oldPz, px, py, pz))
							if (pdistance < 1.3 ) then --if the ped is stuck
								local decide = math.random( 1, 20 ) -- randomly decide to
								if decide == 1 then -- give up following and go back on the hunt
									setTimer (beginsearch, 800, 1, ped )
								elseif decide <4 then -- jump
									local weap = getPedWeaponSlot(ped)
									if (weap == 1) or (weap == 7) then
										setPedWeaponSlot(ped, 0 )
										triggerClientEvent ( "bot_Jump", ped )
										setTimer ( setPedWeaponSlot, 850, 1, ped, weap)
									else
										triggerClientEvent ( "bot_Jump", ped )
									end
									setTimer ( follow_move, 600, 1, ped, tx, ty, tz, px, py, pz)
								else -- randomly turn a new direction, walk a bit, then resume
									local randomangle = math.random( 1, 360 )
									setPedRotation( ped, randomangle )
									setTimer ( follow_move, 1200, 1, ped, tx, ty, tz, px, py, pz)
								end
							else -- if the ped isnt stuck
								local distance = (getDistanceBetweenPoints3D (px, py, pz, oldTx, oldTy, oldTz))
								if (distance > 3 ) then -- if the ped hasnt reached its target
									local flatdist = (getDistanceBetweenPoints2D( px, py, tx, ty))
									if flatdist < 2 then -- if the ped hasnt reached its target, but is directly below or above (for multiple levels in maps)
										setTimer (beginsearch, 800, 1, ped )							
									else -- keep going
										setTimer ( follow_move, 600, 1, ped, oldTx, oldTy, oldTz, px, py, pz)
									end
								else -- if the ped has reached its target ( reached the spot it last saw you standing in)
									setTimer (beginsearch, 800, 1, ped )
								end
							end
						end
					end
				elseif getElementType(leader) == "ped" then
					if pedhp > 0 and (getElementHealth(leader) > 0) then
						if (getElementData ( ped, "seestarget" ) == true ) then
							local tdist = (getDistanceBetweenPoints3D (px, py, pz, tx, ty, tz))
							if tdist < 3 then
								triggerClientEvent ( "bot_Stop", ped )
							else	
								triggerClientEvent ( "bot_Forwards", ped )
							end
							local pdistance = (getDistanceBetweenPoints3D (oldPx, oldPy, oldPz, px, py, pz))
							if (pdistance < 1.3 ) then -- if the ped is stuck
								local fdist = (getDistanceBetweenPoints3D (px, py, pz, tx, ty, tz))
								if fdist > 3 then
									local weap = getPedWeaponSlot(ped)
									if (weap == 1) or (weap == 7) then
										setPedWeaponSlot(ped, 0 )
										triggerClientEvent ( "bot_Jump", ped )
										setTimer ( setPedWeaponSlot, 850, 1, ped, weap)
									else
										triggerClientEvent ( "bot_Jump", ped )
									end
								end
								setTimer ( follow_move, 600, 1, ped, tx, ty, tz, px, py, pz)								
							else
								setTimer ( follow_move, 600, 1, ped, tx, ty, tz, px, py, pz)
							end
						else -- if the ped cant see the target
							local pdistance = (getDistanceBetweenPoints3D (oldPx, oldPy, oldPz, px, py, pz))
							if (pdistance < 1.3 ) then --if the ped is stuck
								local decide = math.random( 1, 7 ) -- randomly decide to
								if decide == 1 then -- give up following and go back on the hunt
									setTimer (beginsearch, 800, 1, ped )
								elseif decide <4 then -- jump
									local weap = getPedWeaponSlot(ped)
									if (weap == 1) or (weap == 7) then
										setPedWeaponSlot(ped, 0 )
										triggerClientEvent ( "bot_Jump", ped )
										setTimer ( setPedWeaponSlot, 850, 1, ped, weap)
									else
										triggerClientEvent ( "bot_Jump", ped )
									end
									setTimer ( follow_move, 600, 1, ped, tx, ty, tz, px, py, pz)
								else -- randomly turn a new direction, walk a bit, then resume
									local randomangle = math.random( 1, 360 )
									setPedRotation( ped, randomangle )
									setTimer ( follow_move, 1200, 1, ped, tx, ty, tz, px, py, pz)
								end
							else -- if the ped isnt stuck
								local distance = (getDistanceBetweenPoints3D (px, py, pz, oldTx, oldTy, oldTz))
								if (distance > 3 ) then -- if the ped hasnt reached its target
									local flatdist = (getDistanceBetweenPoints2D( px, py, tx, ty))
									if flatdist < 2 then -- if the ped hasnt reached its target, but is directly below or above (for multiple levels in maps)
										setTimer (beginsearch, 800, 1, ped )
									else -- keep going
										setTimer ( follow_move, 600, 1, ped, oldTx, oldTy, oldTz, px, py, pz)
									end
								else -- if the ped has reached its target ( reached the spot it last saw you standing in)
									setTimer (beginsearch, 800, 1, ped )
								end
							end
						end
					end
				end
			end
		end
	end
end

--assigns which client controls the peds actions (used for shooting and checking for enemies)
addEvent( "onClientSetBotController", true )
function assigncontroller(ped)
	if (isElement(ped)) then
		local syncer = getElementSyncer(ped)
		if (isElement(syncer)) then
			setElementData ( ped, "controller", syncer )
		else
			local px,py,pz = getElementPosition( ped )
			local distToBeat = 999999
			local closestPlayer = nil
			local allplayers = getElementsByType ( "player" )
			for theKey,thePlayer in ipairs(allplayers) do
				local wx,wy,wz = getElementPosition( thePlayer )
				local distance = (getDistanceBetweenPoints3D( px, py, pz, wx, wy, wz ))
				if distance < distToBeat then
					distToBeat = distance
					closestPlayer = thePlayer
				end
			end
			setElementData ( ped, "controller", closestPlayer )
		end
	end
end
addEventHandler ( "onClientSetBotController", getRootElement(), assigncontroller )


--if a player quits, assign a new player to maintain the bots actions.
function quitPlayer ( quitType )
	local players = getElementsByType ( "player" )
	if #players == 1 then
		local peds = getElementsByType ( "ped" )
		for theKey,thePed in ipairs(peds) do
			if (getElementData (thePed, "slothbot") == true) then
				local pedstatus = getElementData ( thePed, "status" )
				setElementData ( thePed, "stasisstatus", pedstatus )
				setElementData ( thePed, "status", "stasis" )
				triggerClientEvent ( "bot_Stop", thePed )
				setElementData ( thePed, "follow_shooting", false )
				setElementData ( thePed, "guard_shooting", false )
			end
		end
	else
		local peds = getElementsByType ( "ped" )
		for theKey,thePed in ipairs(peds) do
			if (getElementData ( thePed, "controller" ) ==  source ) then
				setTimer ( assigncontroller, 100, 1, thePed)
			end
		end
	end			
end
addEventHandler ( "onPlayerQuit", getRootElement(), quitPlayer )

--this is to correct the problem that unstreamed peds loose all but 1 bullet for the local player
addEvent( "StreamWeapon", true )
function SetBotWeapon (weapon)
	setTimer ( giveWeapon, 300, 1, source, tonumber(weapon), 999999, true )
	if (getElementData ( source, "BotWeapon" ) ~= tonumber(weapon) ) then
		setElementData(source, "BotWeapon", tonumber(weapon))
	end
end
addEventHandler("StreamWeapon", getRootElement(), SetBotWeapon)



function wait_mode(ped)
	if (isElement(ped)) then
		local pedhp = getElementHealth ( ped )
		if (getElementData ( ped, "status" ) ==  "waiting" ) and (getElementData (ped, "slothbot") == true) and (pedhp > 0) then
			triggerClientEvent ( "bot_Stop", ped )
		end
	end
end

--tells the bot how to move when guarding
function guard_move (ped, oldpx, oldpy, oldpz)
	if (isElement(ped)) then
		if (getElementData ( ped, "status" ) ==  "guarding" ) and (getElementData (ped, "slothbot") == true) then
			local guardcol = getElementData ( ped, "guardcol" )
			local pedhp = getElementHealth ( ped )
			if pedhp > 0 then
				local tx,ty,tz = getElementPosition( guardcol )
				local px,py,pz = getElementPosition( ped )
				local fdist = (getDistanceBetweenPoints3D (px, py, pz, tx, ty, tz))
				if fdist > 4 then
					triggerClientEvent ( "bot_Forwards", ped )
					local pdistance = (getDistanceBetweenPoints3D (oldpx, oldpy, oldpz, px, py, pz))
					if (pdistance < 1 ) then
						local decide = math.random( 1, 7 ) -- randomly decide to
						if decide == 1 then -- do nothing
							setTimer ( guard_move, 600, 1, ped, px, py, pz)
						elseif decide <4 then -- jump
							local weap = getPedWeaponSlot(ped)
							if (weap == 1) or (weap == 7) then
								setPedWeaponSlot(ped, 0 )
								triggerClientEvent ( "bot_Jump", ped )
								setTimer ( setPedWeaponSlot, 850, 1, ped, weap)
							else
								triggerClientEvent ( "bot_Jump", ped )
							end
							setTimer ( guard_move, 600, 1, ped, px, py, pz)
						else -- randomly turn a new direction, walk a bit, then resume
							local randomangle = math.random( 1, 360 )
							setPedRotation( ped, randomangle )
							setTimer ( guard_move, 1200, 1, ped, px, py, pz)
						end
					else -- if the ped isnt stuck
						setTimer ( guard_move, 700, 1, ped, px, py, pz)
					end
				else
					triggerClientEvent ( "bot_Stop", ped ) --already arrived at place to guard
					if (getElementData ( ped, "forcedmoving" ) ==  true ) then
						setElementData ( ped, "forcedmoving", false )
					end
					setTimer ( guard_move, 1500, 1, ped, px, py, pz) -- keep looping in case ped gets moved some other way
				end
			end
		end
	end
end

--************************************************************************EXPORTED FUNCTIONS************************************************************************

function setBotHunt (theped)
	if (isElement(theped)) then
		if (getElementData (theped, "slothbot") == true) and (getElementData (theped, "status") ~= "hunting") then
			assigncontroller(theped)
			setElementData ( theped, "target", nil )
			setElementData ( theped, "leader", nil )
			setElementData ( theped, "status", "hunting" )
		else 
			return false
		end
	else 
		return false
	end
end
			
function setBotWait (theped)
	if (isElement(theped)) then
		if (getElementData (theped, "slothbot") == true) and (getElementData (theped, "status") ~= "waiting") then
			assigncontroller(theped)
			setElementData ( theped, "target", nil )
			setElementData ( theped, "leader", nil )
			setElementData ( theped, "status", "waiting" )
		else 
			return false
		end
	else 
		return false
	end
end

function setBotChase (theped, target)
	if (isElement(theped)) and (isElement(target)) then
		if (getElementData (theped, "slothbot") == true) then
			if (getElementData (theped, "status") ~= "chasing") then
				if getElementType(target) == "player" then
					if getPlayerTeam(target) == false then
						assigncontroller(theped)
						setElementData ( theped, "target", target )
						setElementData ( theped, "leader", nil )
						setElementData ( theped, "status", "chasing" )
					elseif (getElementData ( ped, "BotTeam" ) ~= getPlayerTeam (target)) then
						assigncontroller(theped)
						setElementData ( theped, "target", target )
						setElementData ( theped, "leader", nil )
						setElementData ( theped, "status", "chasing" )
					else
						return false
					end
				elseif getElementType(target) == "ped" then
					if (getElementData ( target, "BotTeam" ) == false) then
						assigncontroller(theped)
						setElementData ( theped, "target", target )
						setElementData ( theped, "leader", nil )
						setElementData ( theped, "status", "chasing" )
					elseif getElementData(ped,"BotTeam") ~= getElementData ( target, "BotTeam" ) then
						assigncontroller(theped)
						setElementData ( theped, "target", target )
						setElementData ( theped, "leader", nil )
						setElementData ( theped, "status", "chasing" )
					else
						return false
					end
				else 
					return false
				end
			else
				if getElementType(target) == "player" then
					if getPlayerTeam(target) == false then
						assigncontroller(theped)
						setElementData ( theped, "target", target )
						setElementData ( theped, "leader", nil )
					elseif (getElementData ( ped, "BotTeam" ) ~= getPlayerTeam (target)) then
						assigncontroller(theped)
						setElementData ( theped, "target", target )
						setElementData ( theped, "leader", nil )
					else
						return false
					end
				elseif getElementType(target) == "ped" then
					if (getElementData ( target, "BotTeam" ) == false) then
						assigncontroller(theped)
						setElementData ( theped, "target", target )
						setElementData ( theped, "leader", nil )
					elseif getElementData(ped,"BotTeam") ~= getElementData ( target, "BotTeam" ) then
						assigncontroller(theped)
						setElementData ( theped, "target", target )
						setElementData ( theped, "leader", nil )
					else
						return false
					end
				else 
					return false
				end
			end
		else 
			return false
		end
	else 
		return false
	end
end

function setBotFollow(ped, leader)
	if (isElement(ped)) and (isElement(leader)) then
		if (getElementData ( ped, "status" ) ~= "following" ) then
			if getElementType(leader) == "player" then
				if (getElementData ( ped, "BotTeam" ) == getPlayerTeam (leader)) then
					setElementData ( ped, "target", nil )
					setElementData ( ped, "leader", leader )
					assigncontroller(ped)
					setElementData ( ped, "status", "following")
					triggerEvent ( "onBotFollow", ped, leader )
				else 
					return false
				end
			elseif getElementType(leader) == "ped" then
				if getElementData(ped,"BotTeam") == getElementData ( leader, "BotTeam" ) then
					setElementData ( ped, "target", nil )
					setElementData ( ped, "leader", leader )
					assigncontroller(ped)
					setElementData ( ped, "status", "following")
					triggerEvent ( "onBotFollow", ped, leader )
				else 
					return false
				end
			else 
				return false
			end
		else
			if getElementType(leader) == "player" then
				if (getElementData ( ped, "BotTeam" ) == getPlayerTeam (leader)) then
					setElementData ( ped, "target", nil )
					setElementData ( ped, "leader", leader )
					assigncontroller(ped)
					triggerEvent ( "onBotFollow", ped, leader )
				else 
					return false
				end
			elseif getElementType(leader) == "ped" then
				if getElementData(ped,"BotTeam") == getElementData ( leader, "BotTeam" ) then
					setElementData ( ped, "target", nil )
					setElementData ( ped, "leader", leader )
					assigncontroller(ped)
					triggerEvent ( "onBotFollow", ped, leader )
				else 
					return false
				end
			else 
				return false
			end		
		end			
	else 
		return false
	end
end


function setBotGuard (theped, x, y, z, priority)
	if (isElement(theped)) then
		if (getElementData (theped, "slothbot") == true) then
			if priority == true then
				setElementData ( theped, "forcedmoving", true )
			else
				setElementData ( theped, "forcedmoving", false )
			end
			if ( x == false) or ( y == false) or ( z == false) then
				local x, y, z = getElementPosition( theped )
			end
			local guardcol = getElementData ( theped, "guardcol" )
			if (isElement(guardcol)) then
				destroyElement (guardcol)
				setElementData ( theped, "guardcol", nil )
			end
			local guardcol = createColSphere ( x,y,z, 1.5 )
			assigncontroller(theped)
			setElementData ( theped, "guardcol", guardcol )
			setElementData ( theped, "leader", nil )
			setElementData ( theped, "status", "guarding" )
--			local px,py,pz = getElementPosition( theped )
--			guard_move (theped, px, py, pz)
--			triggerClientEvent ( "bot_Guard", theped )
		else 
			return false
		end
	else 
		return false
	end
end

function spawnBot(x, y, z, rot, skin, interior, dimension, team, weapon, mode, modesubject, speedLevel)
--checks the function commands to see if all neccesary parts are filled, sets defaults if not or returns false.
	if not x then return false end
	if not y then return false end
	if not z then return false end
	if not rot then return false end
	if not skin then skin = 0 end
	if not interior then interior = 0 end
	if not dimension then dimension = 0 end
	if isElement(team) == false then team = nil end
	if not weapon then weapon = 0 end
	if not mode then mode = "hunting" end
	if not modesubject then modesubject = nil end
	if not speedLevel then speedLevel = "sprint" end
	if mode == "following" then
		if not modesubject then return false end
	end
	if mode == "chasing" then
		if not modesubject then return false end
	end
	local slothbot = createPed (tonumber(skin),tonumber(x),tonumber(y),tonumber(z))--spawns the ped
	if (slothbot ~= false) then
		triggerEvent ( "onBotSpawned", slothbot )		
		setTimer ( setElementData, 200, 1, slothbot, "slothbot", true ) -- makes it a bot
		setTimer ( setElementData, 200, 1, slothbot, "AllowFire", true ) -- makes it able to shoot when it wants
		setTimer ( assigncontroller, 300, 1, slothbot ) --sets the bots controller
		setTimer ( giveWeapon, 800, 1, slothbot, tonumber(weapon), 99999, true ) --gives the weapon
		setElementData(slothbot, "BotWeapon", tonumber(weapon))
		if team ~= nil then
			setElementData(slothbot, "BotTeam", team)
		end
		setTimer ( setElementInterior, 100, 1, slothbot, tonumber(interior)) --sets interior
		setTimer ( setElementDimension, 100, 1, slothbot, tonumber(dimension)) --sets dimension
		
		--sets the mode
		if mode == "waiting" then
			setTimer ( setElementData, 600, 1, slothbot, "status", "waiting")
		elseif mode == "following" then
			setTimer ( setElementData, 400, 1, slothbot, "leader", modesubject )
			setTimer ( setElementData, 600, 1, slothbot, "status", "following")
		elseif mode == "chasing" then
			setTimer ( setElementData, 400, 1, slothbot, "target", modesubject )
			setTimer ( setElementData, 600, 1, slothbot, "status", "chasing")
		elseif mode == "guarding" then
			setTimer ( setBotGuard, 400, 1, slothbot, x, y, z)
		else
			setTimer ( setElementData, 600, 1, slothbot, "status", "hunting")
		end
		if speedLevel == "sprint" then
			triggerClientEvent("setBotSprintingMode",root,slothbot)
		end
		return slothbot
	end
end

function setBotTeam(ped, team)
	if (isElement(ped)) then
		if (getElementData (ped, "slothbot") == true) and (isElement(team)) then
			setElementData(ped, "BotTeam", team)
		else
			return false
		end
	else 
		return false
	end
end

function getBotTeam(ped)
	if (isElement(ped)) then
		if (getElementData (ped, "slothbot") == true) then
			local team = (getElementData(ped, "BotTeam"))
			if team ~= false then
				return team
			else
				return false
			end
		else
			return false
		end
	else 
		return false
	end
end

function setBotWeapon(ped, weapon)
	if (isElement(ped)) and getWeaponNameFromID(tonumber(weapon)) ~= false then		
		if (getElementData (ped, "slothbot") == true) then
			setTimer ( giveWeapon, 100, 1, slothbot, tonumber(weapon), 99999, true )
			setElementData(ped, "BotWeapon", tonumber(weapon))
		else
			return false
		end
	else 
		return false
	end
end

function setBotAttackEnabled(ped, shooting)
	if (isElement(ped)) then
		if (getElementData (ped, "slothbot") == true) then
			if shooting == true then
				setElementData(ped, "AllowFire", true)
			elseif shooting == false then
				setElementData(ped, "AllowFire", false)
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end
end

function getBotAttackEnabled(ped)
	if (isElement(ped)) then
		if (getElementData (ped, "slothbot") == true) then
			if (getElementData (ped, "AllowFire") == false) then 
				return false
			elseif (getElementData (ped, "AllowFire") == true) then 
				return true
			end
		end
	end
end

function getBotMode(ped)
	if (isElement(ped)) then
		if (getElementData (ped, "slothbot") == true) then
			local mode = (getElementData (ped, "status"))
			if mode == "following" then
				local leader = (getElementData (ped, "leader"))
				return mode, leader
			elseif mode == "chasing" then	
				local target = (getElementData (ped, "target"))
				return mode, target
			else
				return mode
			end
		end
	end
end

function isPedBot(ped)
	if (isElement(ped)) then
		if (getElementData (ped, "slothbot") == true) then
			return true
		else
			return false
		end
	else
		return false
	end
end

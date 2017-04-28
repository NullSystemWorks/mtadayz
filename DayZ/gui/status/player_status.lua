--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: player_status.lua						*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: CLIENT														*----
#-----------------------------------------------------------------------------#
]]

local fading = 0
local fading2 = "up"
local screenWidth,screenHeight = guiGetScreenSize()
local playerTarget = false
local value = 0

function updateStatusIcons()
	if getElementData(localPlayer,"logedin") then
		if fading >= 0 and fading2 == "up" then
			fading = fading + 5
		elseif fading <= 255 and fading2 == "down" then
			fading = fading - 5
		end
		if fading == 0 then
			fading2 = "up"
		elseif fading == 255 then
			fading2 = "down"
		end
		-- // Normal Icons (Sound etc.) // --
		-- Sound
		--local sound = getElementData(localPlayer,"volume")
		sound,visibility = getSoundAndVisibilityLevel()
		dxDrawImage( screenWidth*0.9325 , screenHeight*0.41, screenHeight*0.075, screenHeight*0.075, ":DayZ/gui/status/misc/background.png",0,0,0)
		--dxDrawImage ( screenWidth*0.9325 , screenHeight*0.41, screenHeight*0.075, screenHeight*0.075, ":DayZ/gui/status/misc/sound.png",0,0,0,tocolor(255,255,255,(sound*2.5)+5))
		dxDrawImage ( screenWidth*0.9325 , screenHeight*0.41, screenHeight*0.075, screenHeight*0.075, ":DayZ/gui/status/misc/sound.png",0,0,0,tocolor(255,255,255,math.min(sound,255)))
		-- Visibility
		--local visibility = getElementData(localPlayer,"visibly")
		dxDrawImage ( screenWidth*0.9325 , screenHeight*0.475, screenHeight*0.075, screenHeight*0.075, ":DayZ/gui/status/misc/background.png",0,0,0)
		--dxDrawImage ( screenWidth*0.9325 , screenHeight*0.475, screenHeight*0.075, screenHeight*0.075, ":DayZ/gui/status/misc/eye.png",0,0,0,tocolor(255,255,255,(visibility*2.5)+5))
		dxDrawImage ( screenWidth*0.9325 , screenHeight*0.475, screenHeight*0.075, screenHeight*0.075, ":DayZ/gui/status/misc/eye.png",0,0,0,tocolor(255,255,255,math.min(visibility,255)))
		-- Humanity
		--[[
		local humanity = getElementData(localPlayer,"humanity")
		local humanity_icon = ":DayZ/gui/status/humanity/2500.png"
		local h_number = 0
		if humanity >= 5000 and humanity >= 3501 then
			h_number = 5
		elseif humanity <= 3500 and humanity >= 2501 then
			h_number = 4
		elseif humanity <= 2500 and humanity >= 1 then
			h_number = 3
		elseif humanity <= 0 and humanity >= -1001 then
			h_number = 2
		elseif humanity <= -1000 and humanity >= -2501 then
			h_number = 1
		elseif humanity >= -2500 then
			h_number = 0
		end
		
		dxDrawImage ( screenWidth*0.94 , screenHeight*0.63, screenHeight*0.065, screenHeight*0.065, ":DayZ/gui/status/misc/background.png",0,0,0)
		dxDrawImage ( screenWidth*0.943 , screenHeight*0.63, screenHeight*0.055, screenHeight*0.055, ":DayZ/gui/status/humanity/"..h_number..".png",0,0,0)
		]]
		-- Helmet
		if not gameplayVariables["newclothingsystem"] then
			if getElementData(localPlayer,"hasHelmet") then
				dxDrawImage ( screenWidth*0.94 , screenHeight*0.63, screenHeight*0.065, screenHeight*0.065, ":DayZ/gui/status/misc/background.png",0,0,0)
				dxDrawImage ( screenWidth*0.943 , screenHeight*0.63, screenHeight*0.055, screenHeight*0.055, ":DayZ/gui/status/misc/helmet.png",0,0,0)
			end
		end
		-- Temperature
		local temperature = math.round(getElementData(localPlayer,"temperature"),2)
		--local temperature = math.round(playerDynamicTable.playerTemperature,2)
		local status = getElementData(localPlayer,"temperature_status") or 0
		r,g,b = 0,255,0
		local t_number = 3
		if temperature <= 37 then
			value = (37-temperature)*42.5
			r,g,b = 0,255-value,value
			t_number = 2
		elseif temperature >= 37 and temperature <= 41 then
			r,g,b = 0,255,0
			t_number = 3
		elseif temperature >= 41 then
			t_number = 4
			r,g,b = 255,0,0
		end
		if value > 215 then
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.7, screenHeight*0.065, screenHeight*0.065, ":DayZ/gui/status/misc/background.png",0,0,0)
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.7, screenHeight*0.065, screenHeight*0.065, ":DayZ/gui/status/temperature/temperature_border.png",0,0,0)
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.7, screenHeight*0.065, screenHeight*0.065, ":DayZ/gui/status/temperature/"..t_number..".png",0,0,0,tocolor(r,g,b,fading))
		else
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.7, screenHeight*0.065, screenHeight*0.065, ":DayZ/gui/status/misc/background.png",0,0,0)
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.7, screenHeight*0.065, screenHeight*0.065, ":DayZ/gui/status/temperature/temperature_border.png",0,0,0)
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.7, screenHeight*0.065, screenHeight*0.065, ":DayZ/gui/status/temperature/temperature_"..status..".png",0,0,0)
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.7, screenHeight*0.065, screenHeight*0.065, ":DayZ/gui/status/temperature/"..t_number..".png",0,0,0,tocolor(r,g,b))
		end
		-- Thirst
		r,g,b = 0,255,0
		local thirst = getElementData(localPlayer,"thirst")
		--local thirst = playerDynamicTable.playerWater
		local thirst_coloring = getElementData(localPlayer,"thirst")*2.55
		r,g,b = 255-thirst_coloring,thirst_coloring,0
		local thirst_icon = ":DayZ/gui/status/thirst/100.png"
		if thirst >= 100 and thirst <= 81 then
			thirst_icon = ":DayZ/gui/status/thirst/100.png"
		elseif thirst <= 80 and thirst >= 61 then
			thirst_icon = ":DayZ/gui/status/thirst/80.png"
		elseif thirst <= 60 and thirst >= 41 then
			thirst_icon = ":DayZ/gui/status/thirst/60.png"
		elseif thirst <= 40 and thirst >= 21 then
			thirst_icon = ":DayZ/gui/status/thirst/40.png"
		elseif thirst <= 20 and thirst >= 1 then
			thirst_icon = ":DayZ/gui/status/thirst/20.png"
		elseif thirst < 1 then
			thirst_icon = ":DayZ/gui/status/thirst/0.png"
		end
		if thirst_coloring < 15 then
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.775, screenHeight*0.065, screenHeight*0.065, ":DayZ/gui/status/misc/background.png",0,0,0)
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.775, screenHeight*0.065, screenHeight*0.065, ":DayZ/gui/status/thirst/thirst_border.png",0,0,0)
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.775, screenHeight*0.065, screenHeight*0.065, thirst_icon,0,0,0,tocolor(r,g,b,fading))
		else
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.775, screenHeight*0.065, screenHeight*0.065, ":DayZ/gui/status/misc/background.png",0,0,0)
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.775, screenHeight*0.065, screenHeight*0.065, ":DayZ/gui/status/thirst/thirst_border.png",0,0,0)
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.775, screenHeight*0.065, screenHeight*0.065, thirst_icon,0,0,0,tocolor(r,g,b))
		end
		-- Blood
		r,g,b = 0,255,0
		local blood = getElementData(localPlayer,"blood")
		--local blood = playerDynamicTable.playerBlood
		local blood_coloring = getElementData(localPlayer,"blood")/47.2
		r,g,b = 255-blood_coloring,blood_coloring,0
		local blood_icon = ":DayZ/gui/status/blood/12000.png"
		if blood >= 12000 and blood >= 10001 then
			blood_icon = ":DayZ/gui/status/blood/12000.png"
		elseif blood <= 10000 and blood >= 8001 then
			blood_icon = ":DayZ/gui/status/blood/10000.png"
		elseif blood <= 8000 and blood >= 6001 then
			blood_icon = ":DayZ/gui/status/blood/8000.png"
		elseif blood <= 6000 and blood >= 4001 then
			blood_icon = ":DayZ/gui/status/blood/6000.png"
		elseif blood <= 4000 and blood >= 2001 then
			blood_icon = ":DayZ/gui/status/blood/4000.png"
		elseif blood <= 2000 then
			blood_icon = ":DayZ/gui/status/blood/2000.png"
		end	
		dxDrawImage ( screenWidth*0.94 , screenHeight*0.85, screenHeight*0.065, screenHeight*0.065, ":DayZ/gui/status/misc/background.png",0,0,0)	
		dxDrawImage ( screenWidth*0.94 , screenHeight*0.85, screenHeight*0.065, screenHeight*0.065, ":DayZ/gui/status/blood/blood_border.png",0,0,0)			
		dxDrawImage ( screenWidth*0.94 , screenHeight*0.85, screenHeight*0.065, screenHeight*0.065, blood_icon,0,0,0,tocolor(r,g,b))
		-- Food
		r,g,b = 0,255,0
		local food = getElementData(localPlayer,"food")
		--local food = playerDynamicTable.playerFood
		local food_coloring = getElementData(localPlayer,"food")*2.55
		r,g,b = 255-food_coloring,food_coloring,0
		local food_icon = ":DayZ/gui/status/hunger/100.png"
		if food >= 100 and food <= 81 then
			food_icon = ":DayZ/gui/status/hunger/100.png"
		elseif food <= 80 and food >= 61 then
			food_icon = ":DayZ/gui/status/hunger/80.png"
		elseif food <= 60 and food >= 41 then
			food_icon = ":DayZ/gui/status/hunger/60.png"
		elseif food <= 40 and food >= 21 then
			food_icon = ":DayZ/gui/status/hunger/40.png"
		elseif food <= 20 and food >= 1 then
			food_icon = ":DayZ/gui/status/hunger/20.png"
		elseif food < 1 then
			food_icon = ":DayZ/gui/status/hunger/0.png"
		end
		if food < 15 then
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.925, screenHeight*0.065, screenHeight*0.065, ":DayZ/gui/status/misc/background.png",0,0,0)
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.925, screenHeight*0.065, screenHeight*0.065, ":DayZ/gui/status/hunger/food_border.png",0,0,0)
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.925, screenHeight*0.065, screenHeight*0.065, food_icon,0,0,0,tocolor(r,g,b,fading))
		else
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.925, screenHeight*0.065, screenHeight*0.065, ":DayZ/gui/status/misc/background.png",0,0,0)
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.925, screenHeight*0.065, screenHeight*0.065, ":DayZ/gui/status/hunger/food_border.png",0,0,0)
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.925, screenHeight*0.065, screenHeight*0.065, food_icon,0,0,0,tocolor(r,g,b))
		end
		-- // Status Symbols (Broken bone, pain, bleeding, ...)
		-- Broken bone
		if getElementData(localPlayer,"brokenbone") then
		--if playerDynamicTable.playerBrokenBone then
			dxDrawImage ( screenWidth*0.9375 , screenHeight*0.55, screenHeight*0.065, screenHeight*0.065, ":DayZ/gui/status/misc/brokenbone.png",0,0,0)
		end
		if getElementData(localPlayer,"bleeding") > 0 then
		--if playerDynamicTable.playerBleeding > 0 then
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.85, screenHeight*0.065, screenHeight*0.065, ":DayZ/gui/status/misc/medic.png",0,0,0,tocolor(255,255,255,fading))
		end
		if getElementData(localPlayer,"infection") or getElementData(localPlayer,"sepsis") and getElementData(localPlayer,"sepsis") > 0 then
		--if playerDynamicTable.playerInfection or playerDynamicTable.playerSepsis and playerDynamicTable.playerSepsis > 0 then
			dxDrawImage ( screenWidth*0.94 , screenHeight*0.85, screenHeight*0.065, screenHeight*0.065, ":DayZ/gui/status/blood/infection.png",0,0,0)
		end
		local x,y,z = getElementPosition(localPlayer)
		for i,player in ipairs(getElementsByType("player")) do
			setPlayerNametagShowing ( player, false )
			if player ~= localPlayer then
				local px,py,pz = getElementPosition (player)
				local pdistance = getDistanceBetweenPoints3D ( x,y,z,px,py,pz )
				if pdistance <= 2 then
					local sx,sy = getScreenFromWorldPosition ( px, py, pz+0.95, 0.06 )
					if sx and sy then
						if getElementData(player,"bandit") then
							text = string.gsub(getPlayerName(player), '#%x%x%x%x%x%x', '' ).." (Bandit)"
						else
							text = string.gsub(getPlayerName(player), '#%x%x%x%x%x%x', '' )
						end
						local w = dxGetTextWidth(text,1.02,"default-bold")
						if gameplayVariables["difficulty"] and gameplayVariables["difficulty"] == "normal" then
							dxDrawText (text, sx-(w/2), sy, sx-(w/2), sy, tocolor ( 100, 255, 100, 200 ), 1.02, "default-bold" )
						end
					end
				end
			end		
		end
		for i,veh in ipairs(getElementsByType("vehicle")) do
			local px,py,pz = getElementPosition (veh)
			local vehID = getElementModel(veh)
			local vehicle = getPedOccupiedVehicle(localPlayer)
			if veh ~= vehicle then
				if vehID ~= 548 then
					local pdistance = getDistanceBetweenPoints3D ( x,y,z,px,py,pz )
					if pdistance <= 6 then
						local sx,sy = getScreenFromWorldPosition ( px, py, pz+0.95, 0.06 )
						if sx and sy then
							local w = dxGetTextWidth(getVehicleName(veh),1.02,"default-bold")
							local vehName = getElementData(getElementData(veh,"parent"),"vehicle_name")
							dxDrawText ( vehName, sx-(w/2), sy, sx-(w/2), sy, tocolor ( 100, 255, 100, 200 ), 1.02, "default-bold" )	
						end
					end
				end
			end
		end
		local veh = getPedOccupiedVehicle (localPlayer)
		if veh then
			local screenW, screenH = guiGetScreenSize()
			local maxfuel = getElementData(veh,"maxfuel")
			local fuel = getElementData(getElementData(veh,"parent"),"fuel")
			local needengine = getElementData(veh,"needengines")
			local needtires = getElementData(veh,"needtires")
			local needparts = getElementData(veh,"needparts")
			local needscrap = getElementData(veh,"needscrap")
			local needglass = getElementData(veh,"needglass")
			local needrotary = getElementData(veh,"needrotary")
			local vehiclename = getElementData(veh,"vehicle_name")
			local engine = getElementData(getElementData(veh,"parent"),"Engine_inVehicle") or 0
			local tires = getElementData(getElementData(veh,"parent"),"Tire_inVehicle") or 0
			local parts = getElementData(getElementData(veh,"parent"),"Parts_inVehicle") or 0
			local scrap = getElementData(getElementData(veh,"parent"),"Scrap_inVehicle") or 0
			local glass = getElementData(getElementData(veh,"parent"),"Glass_inVehicle") or 0
			local rotary = getElementData(getElementData(veh,"parent"),"Rotary_inVehicle") or 0
			local offset = dxGetFontHeight(1.02,"default-bold")
			local e_number = 0
			--local w = dxGetTextWidth(engine.."/"..needengine.." Engine",1.02,"default-bold")
			local enginetype = ""
			if needrotary == 0 then
				if engine == needengine then
					r,g,b = 0,255,0
					e_number = 1
					enginetype = "eng"
				else
					r,g,b = 255,0,0
					e_number = 0
					enginetype = "eng"
				end
			else
				if rotary == needrotary then
					r,g,b = 0,255,0
					e_number = 1
					enginetype = "mrot"
				else
					r,g,b = 255,0,0
					e_number = 0
					enginetype = "mrot"
				end
			end
			--dxDrawText (engine.."/"..needengine.." Engine" ,screenWidth*0.5-w/2 , screenHeight*0,screenWidth*0.5-w/2 , screenHeight*0,tocolor ( r,g,b, 220 ), 1.02, "default-bold" )
			dxDrawImage(screenW * 0.4562, screenH * 0.0767, screenW * 0.0488, screenH * 0.0317, ":DayZ/gui/status/vehicle/engine/"..enginetype.."_"..e_number..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			--local w = dxGetTextWidth(tires.."/"..needtires.." Tires",1.02,"default-bold")
			local tire_number = 0
			if tires == needtires then
				r,g,b = 0,255,0
				tire_number = 1
			else
				r,g,b = 255,0,0
				tire_number = 0
			end
			--dxDrawText (tires.."/"..needtires.." Tires",screenWidth*0.5-w/2 , screenHeight*0+offset,screenWidth*0.5-w/2 , screenHeight*0+offset,tocolor ( r,g,b, 220 ), 1.02, "default-bold" )
			dxDrawText(tonumber(tires).."/"..tonumber(needtires), screenW * 0.5162, screenH * 0.1083, screenW * 0.5687, screenH * 0.1333, tocolor(73, 251, 3, 255), 1.00, "default-bold", "center", "top", false, false, false, false, false)
			dxDrawImage(screenW * 0.5175, screenH * 0.0767, screenW * 0.0488, screenH * 0.0317, ":DayZ/gui/status/vehicle/whl/whl_"..tire_number..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			--local w = dxGetTextWidth(parts.."/"..needparts.." Tank Parts",1.02,"default-bold")
			local p_number = 0
			if parts == needparts then
				r,g,b = 0,255,0
				p_number = 1
			else
				r,g,b = 255,0,0
				p_number = 0
			end
			--dxDrawText (parts.."/"..needparts.." Tank Parts",screenWidth*0.5-w/2 , screenHeight*0+offset*2,screenWidth*0.5-w/2 , screenHeight*0+offset, tocolor (r,g,b, 220 ) , 1.02, "default-bold" )
			dxDrawImage(screenW * 0.5787, screenH * 0.0767, screenW * 0.0488, screenH * 0.0317, ":DayZ/gui/status/vehicle/tank/tank_"..p_number..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			--local w = dxGetTextWidth("Fuel:"..math.floor(fuel).."/"..maxfuel,1.02,"default-bold")
			--[[if fuel == maxfuel then
				r,g,b = 0,255,0
				number = 100
			elseif fuel < maxfuel/10 then
				r,g,b = 255,0,0	
			elseif fuel < maxfuel/4 then
				r,g,b = 255,50,0	
			elseif fuel < maxfuel/3 then
				r,g,b = 200,100,0
			elseif fuel < maxfuel/2 then
				r,g,b = 125,200,0		
			elseif fuel < maxfuel/1.5 then
				r,g,b = 50,200,0
			end]]
			-- a*100/b
			local fuel_number = 0
			if getElementModel(veh) ~= 509 then
				if fuel == maxfuel then
					fuel_number = 100
				elseif fuel >= (maxfuel*99)/100 then
					fuel_number = 90
				elseif fuel >= (maxfuel*90)/100 then 
					fuel_number = 90
				elseif fuel >= (maxfuel*80)/100 then
					fuel_number = 80
				elseif fuel >= (maxfuel*70)/100 then
					fuel_number = 70
				elseif fuel >= (maxfuel*60)/100 then
					fuel_number = 60
				elseif fuel >= (maxfuel*50)/100 then
					fuel_number = 50
				elseif fuel >= (maxfuel*40)/100 then
					fuel_number = 40
				elseif fuel >= (maxfuel*30)/100 then
					fuel_number = 30
				elseif fuel >= (maxfuel*20)/100 then
					fuel_number = 20
				elseif fuel >= (maxfuel*1)/100 then
					fuel_number = 10
				elseif fuel == (maxfuel*0)/100 then
					fuel_number = 0
				end
			
			--dxDrawText ("Fuel:"..math.floor(fuel).."/"..maxfuel,screenWidth*0.5-w/2 , screenHeight*0+offset*3,screenWidth*0.5-w/2 , screenHeight*0+offset*2,tocolor ( r,g,b, 220 ), 1.02, "default-bold" )
			dxDrawImage(screenW * 0.4975, screenH * -0.0983, screenW * 0.0200, screenH * 0.2750, ":DayZ/gui/status/vehicle/fuel/"..fuel_number..".png", 270, 0, 0, tocolor(255, 255, 255, 255), false)
			end
			local veh_health = getElementHealth(veh)
			local health_number = 0
			if veh_health <= 1000 and veh_health >= 510 then
				health_number = 0
			elseif veh_health <= 500 and veh_health >= 310 then
				health_number = 1
			elseif veh_health <= 300 and veh_health >= 0 then
				health_number = 2
			end
			dxDrawImage(screenW * 0.3950, screenH * 0.0767, screenW * 0.0488, screenH * 0.0317, ":DayZ/gui/status/vehicle/hull/hull_"..health_number..".png", 0, 0, 0, tocolor(255,255,255,255), false)
		end
		if not playerTarget then return end
		local x,y,z = getElementPosition(playerTarget)
		local x,y,distance = getScreenFromWorldPosition (x,y,z+0.5)
		distance = 20
		if getElementData(playerTarget,"bandit") then
			text = string.gsub(getPlayerName(playerTarget), '#%x%x%x%x%x%x', '' ).." (Bandit)"
		else
			text = string.gsub(getPlayerName(playerTarget), '#%x%x%x%x%x%x', '' )
		end
		local w = dxGetTextWidth(text,distance*0.033,"default-bold")
		if gameplayVariables["difficulty"] and gameplayVariables["difficulty"] == "normal" then
			dxDrawText (text,x-(w/2),y,x-(w/2), y, tocolor ( 100, 255, 100, 200 ), distance*0.033, "default-bold" )
		end
	end	
end
addEventHandler ("onClientRender",root,updateStatusIcons)

function targetingActivated(target)
	if ( target ) and getElementType(target) == "player" then
		playerTarget = target
	else
		playerTarget = false
	end
end
addEventHandler ( "onClientPlayerTarget", root, targetingActivated )

function dayZDeathInfo()
	fadeCamera (false, 1.0, 0, 0, 0 ) 
	setTimer(showDayZDeathScreen,50,1)
end
addEvent("onClientPlayerDeathInfo",true)
addEventHandler("onClientPlayerDeathInfo",getRootElement(),dayZDeathInfo)

function showDayZDeathScreen()
	setTimer ( fadeCamera, 1000, 1, true, 1.5 )
	deadBackground = guiCreateStaticImage(0,0,1,1,":DayZ/gui/status/misc/dead.jpg",true)
	deathText = guiCreateLabel(0,0.8,1,0.2,"You died! \nYou will respawn in 30 seconds.",true)
	guiLabelSetHorizontalAlign (deathText,"center")
	setTimer(function() guiSetVisible(deathText,false) end,30000,1)
	setTimer(function() guiSetVisible(deadBackground,false) end,30000,1)
	setTimer(destroyElement,30000,1,deathText)
	setTimer(destroyElement,30000,1,deadBackground)
	local countdown = 30
	setTimer(function() countdown = countdown-1 guiSetText(deathText,"You died!\nYou will respawn in "..countdown.." seconds.") end,1000,29)
end
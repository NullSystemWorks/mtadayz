--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: items.lua								*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]

function checkFenceOwner(element,ownerData)
	if getElementType(element) == "player" and element == client then
		local acc = getAccountName(getPlayerAccount(element))
			if acc then
				if acc ~= ownerData then
					setElementData(element,"blood",getElementData(element,"blood") - gameplayVariables["loseWire"] )
				else
				end
			else
			end
	else
	end
end
addEvent("checkFenceOwner",true)
addEventHandler("checkFenceOwner",root,checkFenceOwner)

-- Block for San Fierro Carrier and Area 69 unless player has the corresponding keycard
areaDoor_1 = createObject(8948,217.39999389648,1875.9000244141,13.89999961853,0,0,272)
areaDoor_2 = createObject(8948,210.10000610352,1875.6999511719,13.89999961853,0,0,272)
areaDoorCol = createColCuboid(210,1875,12,8,4,4)
areaSign = createObject(3927,218.10000610352,1877.1999511719,12.699999809265,0,0,264)
areaJetDoor = createObject(3095,268.39999389648,1884.5999755859,16,0,0,0)
areaVentDoor = createObject(3117,246,1862.8000488281,20.299999237061,10,0,38)
	
carrierDoor = createObject(2938,-1422.5,494.89999389648,4.6999998092651,0,0,0)
carrierDoorCol = createColCuboid(-1425,490,2,4,10,4)
carrierSign = createObject(3927,-1422.5999755859,501.5,2.5,0,0,88)
carrierUnknown1 = createObject(3115,-1456.0999755859,501.29998779297,16.89999961853,0,0,0)
carrierUnknown2 = createObject(3113,-1465,501.60000610352,3.7999999523163,0,0,0)
carrierUnknown3 = createObject(3055,-1335,487.39999389648,12.39999961853,0,0,0)
carrierUnknown4 = createObject(3055,-1324.5999755859,515.20001220703,12.39999961853,0,0,0)
carrierUnknown5 = createObject(3114,-1414.5999755859,516.40002441406,16.60000038147,0,0,0)
carrierUnknown6 = createObject(18260,-1365.3000488281,512,11.800000190735,0,0,0)
carrierUnknown7 = createObject(931,-1348,498.39999389648,18.299999237061,0,0,0)

function onPlayerActivateKeycard(itemName)
	if itemName == "San Fierro Carrier Keycard" then
		setElementData(source,"CarrierCardActive",true)
		setTimer(function()
			if source then
				setElementData(source,"CarrierCardActive",false)
			end
		end,180000,1,source)
	elseif itemName == "Area 69 Keycard" then
		setElementData(source,"AreaCardActive",true)
		setTimer(function()
			if source then
				setElementData(source,"AreaCardActive",false)
			end
		end,180000,1,source)
	end
	outputChatBox("You activated the "..itemName..". You have 3 minutes before you have to activate the keycard again!",source,255,0,0,true)
end
addEvent("onPlayerActivateKeycard",true)
addEventHandler("onPlayerActivateKeycard",root,onPlayerActivateKeycard)

function moveCarrierDoorIfKeyCard(hitElement)
	if getElementData(hitElement,"CarrierCardActive") then
		moveObject(carrierDoor,1000,-1422.5,506.89999389648,4.6999998092651)
		setTimer(function()
			setElementData(hitElement,"San Fierro Carrier Keycard",getElementData(hitElement,"San Fierro Carrier Keycard")-1)
			setElementData(hitElement,"CarrierCardActive",false)
		end,10000,1,hitElement)
	else
		outputChatBox("You need activate the 'San Fierro Carrier Keycard' to open this door! Open your inventory and click on the keycard to activate it.",hitElement,255,0,0,true)
	end
end
addEventHandler("onColShapeHit",carrierDoorCol,moveCarrierDoorIfKeyCard)

function moveAreaDoorIfKeyCard(hitElement)
	if getElementData(hitElement,"AreaCardActive") then
		moveObject(areaDoor_1,1000,217.39999389648-12,1875.9000244141,13.89999961853)
		setTimer(function()
			setElementData(hitElement,"Area 69 Keycard",getElementData(hitElement,"Area 69 Keycard")-1)
			setElementData(hitElement,"AreaCardActive",false)
		end,10000,1,hitElement)
	else
		outputChatBox("You need to activate the 'Area 69 Keycard' to open this door! Open your inventory and click on the keycard to activate it.",hitElement,255,0,0,true)
	end
end
addEventHandler("onColShapeHit",areaDoorCol,moveAreaDoorIfKeyCard)

function closeCarrierDoorAfterHit()
	moveObject(carrierDoor,1000,-1422.5,494.89999389648,4.6999998092651)
end
addEventHandler("onColShapeLeave",carrierDoorCol,closeCarrierDoorAfterHit)

function closeAreaDoorAfterHit()
	moveObject(areaDoor_1,1000,217.39999389648,1875.9000244141,13.89999961853)
end
addEventHandler("onColShapeLeave",areaDoorCol,closeAreaDoorAfterHit)

areaJumpPad = createMarker(268.6566,1880.3245,-31.3,"cylinder",1,255,0,0,255) -- To get out of the area
function teleportJumpPadForArea(hitElement)
	setElementPosition(hitElement,268,1875,18)
end
addEventHandler("onMarkerHit", areaJumpPad, teleportJumpPadForArea)
addEvent("onMapOpened",true)
addEvent("onNewMap",true)
addEvent("doAttachPathpoints",true)
addEvent("doDetachPathpoints",true)

function onStart()
	addEventHandler("onMapOpened",getRootElement(),handleMapStart)
	addEventHandler("onNewMap",getRootElement(),handleMapStart)
	addEventHandler("onElementDestroy",getRootElement(),detachRemovedPoint)
	addEventHandler("doAttachPathpoints",getRootElement(),attachPoints)
	addEventHandler("doDetachPathpoints",getRootElement(),detachPoints)
end

function onStop()
	removeEventHandler("onMapOpened",getRootElement(),handleMapStart)
	removeEventHandler("onNewMap",getRootElement(),handleMapStart)
	removeEventHandler("onElementDestroy",getRootElement(),detachRemovedPoint)
	removeEventHandler("doAttachPathpoints",getRootElement(),attachPoints)
	removeEventHandler("doDetachPathpoints",getRootElement(),detachPoints)
end

function handleMapStart()
	triggerClientEvent("sbNewMapStart",source,handleMapStart)
end

function detachRemovedPoint()
	if getElementType(source)=="pathpoint" then
		local start = getElementID(source)
		
		for index,connection in ipairs(getElementsByType("pathpoint")) do
			if connection~=source then
				local stop = getElementID(connection)
				
				if isConnected(start,stop) then
					removeConnection(start,stop)
				end
			end
		end
	end
end

function attachPoints(start,stop,oneway)
	if not isConnected(start,stop) then
		local type = oneway and "one-way" or "both ways"
		outputDebugString(getPlayerName(client).." attached point '"..start.."' to '"..stop.."' ("..type..")")
		
		addConnection(start,stop,oneway)
	end
end

function detachPoints(start,stop)
	if isConnected(start,stop) then
		outputDebugString(getPlayerName(client).." detached point '"..start.."' from '"..stop.."'")
		
		removeConnection(start,stop)
	end
end
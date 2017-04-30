function getAllConnections(start)
	start = getElementByID(start)
	
	local neighborString = getElementData(start,"neighbors")
	if neighborString then
		local neighbors = split(neighborString,44)
		if neighbors then
			return neighbors
		end
	end
	
	return false
end

function getAllConnectionElements(start)
	start = getElementByID(start)
	
	local neighborString = getElementData(start,"neighbors")
	if neighborString then
--		outputDebugString("Neighbor string: "..neighborString)
		
		local neighbors = split(neighborString,44)
		if neighbors then
			for index,neighbor in ipairs(neighbors) do
				local element=getElementByID(neighbor)
				
				if element then
					neighbors[index]=element
				else
					table.remove(neighbors,index)
				end
			end
			
			return neighbors
		end
	end
	
	return {}
end

function isConnected(start,stop)
	local startID = start
	start = getElementByID(start)
	
	local neighborString = getElementData(start,"neighbors")
	if neighborString then
		local neighbors = split(neighborString,44)
		if neighbors and #neighbors > 0 then
--			local startX,startY,startZ = exports.edf:edfGetElementPosition(start)
			
			for nIndex,neighborID in ipairs(neighbors) do
				if neighborID == stop then
					return true
				end
			end
		end
	end
	
	stop = getElementByID(stop)
	
	local neighborString = getElementData(stop,"neighbors")
	if neighborString then
		local neighbors = split(neighborString,44)
		if neighbors and #neighbors > 0 then
--			local startX,startY,startZ = exports.edf:edfGetElementPosition(stop)
			
			for nIndex,neighborID in ipairs(neighbors) do
				if neighborID == startID then
					return true
				end
			end
		end
	end
	
	return false
end

function isConnected1Way(start,stop)
	local startID = start
	
	start = getElementByID(start)
	
	local connected = false
	
	local neighborString = getElementData(start,"neighbors")
	if neighborString then
		local neighbors = split(neighborString,44)
		if neighbors and #neighbors > 0 then
			for nIndex,neighborID in ipairs(neighbors) do
				if neighborID == stop then
					connected = true
				end
			end
		end
	end
	
	if connected then
		stop = getElementByID(stop)
		
		local neighborString = getElementData(stop,"neighbors")
		if neighborString then
			local neighbors = split(neighborString,44)
			if neighbors and #neighbors > 0 then
				for nIndex,neighborID in ipairs(neighbors) do
					if neighborID == startID then
						return false
					end
				end
			end
		end
		
		return true
	end
	
	return false
end

function addConnection(start,stop,oneway)
	local startElement = getElementByID(start)
	local startString  = getElementData(startElement,"neighbors")
	
	if startString then
		startString = startString..","..stop
	else
		startString = stop
	end
	
	setElementData(startElement,"neighbors",startString)
	
	if not oneway then
		local stopElement = getElementByID(stop)
		local stopString  = getElementData(stopElement,"neighbors")
		
		if stopString then
			stopString = stopString..","..start
		else
			stopString = start
		end
		
		setElementData(stopElement,"neighbors",stopString)
	end
end

function removeConnection(start,stop)
	local startElement = getElementByID(start)
	local stopElement  = getElementByID(stop)
	
	local startString = getElementData(startElement,"neighbors")
	local stopString  = getElementData(stopElement,"neighbors")
	
	if startString then
		local neighborTable = split(startString,44)
		
		for index,neighbor in ipairs(neighborTable) do
			if neighbor == stop then
				table.remove(neighborTable,index)
				break
			end
		end
		
		startString = table.concat(neighborTable,",")
		
		setElementData(startElement,"neighbors",startString)
	end
	
	if stopString then
		local neighborTable = split(stopString,44)
		
		for index,neighbor in ipairs(neighborTable) do
			if neighbor == start then
				table.remove(neighborTable,index)
				break
			end
		end
		
		stopString = table.concat(neighborTable,",")
		
		setElementData(stopElement,"neighbors",stopString)
	end
end
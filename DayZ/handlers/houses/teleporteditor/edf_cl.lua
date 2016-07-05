addEvent("onClientElementCreate",true)
addEvent("onClientElementSelect",true)
addEvent("onClientElementDrop",true)
addEvent("onClientElementDestroyed",true)
addEvent("onClientElementPropertyChanged",true)
local isSlelcted = {}
local isDestroyed ={}
local lastSelected
local lastcreated
local text = "Do you want to set ... as a destination for last selected marker (...)"
local window = guiCreateWindow(200,100,224,154,"teleporteditor",false)
guiWindowSetSizable(window,false)
local memo = guiCreateMemo(9,21,206,83,text,false,window)
guiMemoSetReadOnly(memo,true)
local yesb = guiCreateButton(13,111,82,33,"yes (1)",false,window)
local nob = guiCreateButton(133,111,82,33,"no (2)",false,window)
guiSetVisible(window, false)
addEventHandler("onClientElementPropertyChanged",getRootElement(),function ( propertyName )
	--outputChatBox("change "..propertyName)
	if getElementType(source) == "Teleport_p" and (propertyName == "interior_") then
		--outputChatBox("teleport ok")
		--local dim = exports.edf:edfGetElementProperty(source, "dimension_")
		local int = exports.edf:edfGetElementProperty(source, "interior_")
		--exports.edf:edfSetElementDimension (source, dim)
		--exports.edf:edfSetElementInterior (source, int)
		triggerServerEvent("onchangei",getLocalPlayer(),source,int)
	elseif getElementType(source) == "destination_p" and (propertyName == "t_interior") then
		--outputChatBox("destyn ok")
		--local dim = exports.edf:edfGetElementProperty(source, "t_dimension")
		local int = exports.edf:edfGetElementProperty(source, "t_interior")
		--exports.edf:edfSetElementDimension (source, dim)
		--exports.edf:edfSetElementInterior (source, int)
		triggerServerEvent("onchangei",getLocalPlayer(),source,int)
	end
end)
addEventHandler ( "onClientElementCreate", getRootElement(),function()
	if getElementType(source) == "Teleport_p" then
		local elid = tostring(getElementID(source)) or "error"
		exports.edf:edfSetElementProperty (source, "description", elid)
	end
	if getElementType(source) == "Teleport_p" or getElementType(source) == "destination_p" then
		--local dim = getElementDimension(getLocalPlayer())
		local int = getElementInterior(getLocalPlayer())
		--exports.edf:edfSetElementDimension (source, dim)
		--exports.edf:edfSetElementInterior (source, int)
		triggerServerEvent("onchangei",getLocalPlayer(),source,int)
		if getElementType(source) == "Teleport_p" then
			--exports.edf:edfSetElementProperty (source, "dimension_", dim)
			exports.edf:edfSetElementProperty (source, "interior_", int)
		elseif getElementType(source) == "destination_p" then
			--exports.edf:edfSetElementProperty (source, "t_dimension", dim)
			exports.edf:edfSetElementProperty (source, "t_interior", int)
		end
	end
end)
addEventHandler ( "onClientElementSelect", getRootElement(),function()
	--outputChatBox(getElementType(getElementParent(source)))
	if getElementType(getElementParent(source)) == "Teleport_p" or getElementType(getElementParent(source)) == "destination_p" then
		--outputChatBox("?????")
		isSlelcted[getElementParent(source)] = true
	elseif getElementType(source) == "Teleport_p" or getElementType(source) == "destination_p" then
		isSlelcted[source] = true
	end
	if getElementType(getElementParent(source)) == "Teleport_p" then
		closewindow()
	elseif getElementType(source) == "Teleport_p" then
		closewindow()
	end
	if getElementType(getElementParent(source)) == "destination_p" then
		setTimer(asign,1000,1,getElementParent(source))
	elseif getElementType(source) == "destination_p" then
		setTimer(asign,1000,1,source)
	end
end)
function asign(element)
	if getElementType(element) == "destination_p" and lastSelected and isElement(lastSelected) then
		local targetid = exports.edf:edfGetElementProperty (lastSelected, "destynation_id")
		if not isElement(targetid) then
			lastcreated = element
			text = "Do you want to set "..tostring(getElementID(element)).." as a destination for last selected teleport ("..tostring(getElementID(lastSelected))..")?"
			guiSetText(memo,text)
			guiSetVisible(window, true)
			bindKey("1","down",yesfunc)
			bindKey("num_1","down",yesfunc)
			bindKey("2","down",nofunc)
			bindKey("num_2","down",nofunc)
		end
	end
end
function yesfunc()
	closewindow()
	exports.edf:edfSetElementProperty (lastSelected, "destynation_id", lastcreated)
end
function nofunc()
	closewindow()
end
addEventHandler ( "onClientGUIClick", yesb, yesfunc, false )
addEventHandler ( "onClientGUIClick", nob, nofunc, false )
function closewindow()
	guiSetVisible(window, false)
	unbindKey("1","down",yesfunc)
	unbindKey("num_1","down",yesfunc)
	unbindKey("2","down",nofunc)
	unbindKey("num_2","down",nofunc)
end
addEventHandler ( "onClientElementDrop", getRootElement(),function()
	if getElementType(source) == "Teleport_p" or getElementType(source) == "destination_p" then
		isSlelcted[source] = false
		if getElementType(source) == "Teleport_p" then
			lastSelected = source
		end
	end
end)
addEventHandler ( "onClientElementDestroyed", getRootElement(),function()
	if getElementType(source) == "Teleport_p" then
		isDestroyed[source] = true
	end
end)
function renderineditor()
	local destinations = getElementsByType("destination_p")
	local telepickups = getElementsByType("Teleport_p")
	for i,p in ipairs(destinations) do
		if isSlelcted[p] then
			local tx,ty,tz = exports.edf:edfGetElementPosition(p)
			local x2,y2 = getScreenFromWorldPosition(tx,ty,tz)
			if x2 then
				dxDrawImage( x2-15,y2-15,30,30,":teleporteditor/tar.png")
				--outputChatBox(":TeleportEditor/tar.png")
			end
			for j,t in ipairs(telepickups) do
				local targetid = exports.edf:edfGetElementProperty (t, "destynation_id")
				if targetid then
					if isElement(targetid) and targetid == p then
						local ax,ay,az = exports.edf:edfGetElementPosition(t)
						local x1,y1 = getScreenFromWorldPosition(ax,ay,az)
						if x1 then
							dxDrawImage( x1-15,y1-15,30,30,":teleporteditor/tele.png")
							--outputChatBox(":TeleportEditor/tele.png")
						end
					end
				end
			end
		end
	end
	for i,p in ipairs(telepickups) do
		local ax,ay,az = exports.edf:edfGetElementPosition(p)
		local px,py,pz = getElementPosition(getLocalPlayer())
		local d_text = exports.edf:edfGetElementProperty (p, "description") or "error"
		local dt_color = exports.edf:edfGetElementProperty (p, "desccolor") or "#FFFF0000"
		local x1,y1 = getScreenFromWorldPosition(ax,ay,az)
		local dist = getDistanceBetweenPoints3D(ax,ay,az,px,py,pz)
		local red, gren, blue, alpha = conwert(dt_color)
		if (dist < 100) and x1 and (not isDestroyed[p]) then
			local llen = string.len(d_text)
			llen = math.floor(llen/2)*6
			local size = 50/dist
			dxDrawText(d_text,x1-(llen)*size,y1-(40)*size,x1-(llen)*size,y1-(40)*size,tocolor(red, gren, blue, alpha),size,"arial")
		end
		if isSlelcted[p] then
			local targetid = exports.edf:edfGetElementProperty (p, "destynation_id")
			if x1 then
				dxDrawImage( x1-15,y1-15,30,30,":teleporteditor/tele.png")
				--outputChatBox(":TeleportEditor/tele.png")
			end
			if targetid then
			--outputChatBox("1")
				if isElement(targetid) then
					--outputChatBox("2")
					local tx,ty,tz = exports.edf:edfGetElementPosition(targetid)
					local x2,y2 = getScreenFromWorldPosition(tx,ty,tz)
					if x2 then
						--outputChatBox("3")
						dxDrawImage( x2-15,y2-15,30,30,":teleporteditor/tar.png")
						--outputChatBox(":TeleportEditor/tar.png")
					end
				end
			end
		end
		if exports.edf:edfGetElementProperty (p, "type") == "ring" then
			if isSlelcted[p] then
				local obrep = getRepresentation(p,"object")
				local rx,ry,rz = getElementRotation(obrep)
				local tempobject = createVehicle(594,ax,ay,az,rx,ry,rz)
					setElementRotation (tempobject,rx,ry,rz)
				local matrix = getElementMatrix ( tempobject )
				destroyElement (tempobject)
				local offX = 0 * matrix[1][1] + 50 * matrix[2][1] + 0 * matrix[3][1] + matrix[4][1]
				local offY = 0 * matrix[1][2] + 50 * matrix[2][2] + 0 * matrix[3][2] + matrix[4][2]
				local offZ = 0 * matrix[1][3] + 50 * matrix[2][3] + 0 * matrix[3][3] + matrix[4][3]
				local marker = getRepresentation(p,"marker")
				--outputChatBox(tostring(getElementType(marker))..", "..tostring(offX)..", "..tostring(offY)..", "..tostring(offZ)..", ")
				setMarkerTarget (marker, tonumber(offX), tonumber(offY), tonumber(offZ))
			end
		end
	end
end
addEventHandler ( "onClientRender", getRootElement(),renderineditor)
function getRepresentation(element,type)
	for i,elem in ipairs(getElementsByType(type,element)) do
		if elem ~= exports.edf:edfGetHandle ( elem ) then
			return elem
		end
	end
	return false
end
function conwert(color)
	local hexTodecim = {["0"]=0,["1"]=1,["2"]=2,["3"]=3,["4"]=4,["5"]=5,["6"]=6,["7"]=7,["8"]=8,["9"]=9,["a"]=10,["b"]=11,["c"]=12,["d"]=13,["e"]=14,["f"]=15}
	local red = (hexTodecim[string.lower(string.sub(color, 2, 2))]*16) + hexTodecim[string.lower(string.sub(color, 3, 3))]
	local gren = (hexTodecim[string.lower(string.sub(color, 4, 4))]*16) + hexTodecim[string.lower(string.sub(color, 5, 5))]
	local blue = (hexTodecim[string.lower(string.sub(color, 6, 6))]*16) + hexTodecim[string.lower(string.sub(color, 6, 6))]
	local alpha = (hexTodecim[string.lower(string.sub(color, 8, 8))]*16) + hexTodecim[string.lower(string.sub(color, 9, 9))]
	return red, gren, blue, alpha
end
--[[addCommandHandler("setmydim",function(com,arg)
	local dim = tonumber(arg)
	if dim and dim >= 0 then
		dim = math.floor(dim)
		setElementDimension(getLocalPlayer(),dim)
		outputChatBox("Dimension set to: "..dim)
	else
		outputChatBox("error: bad argument")
	end
end)]]
addCommandHandler("setmyint",function(com,arg)
	local dim = tonumber(arg)
	if dim and dim >= 0 then
		dim = math.floor(dim)
		setElementInterior(getLocalPlayer(),dim)
		outputChatBox("Interior set to: "..dim)
	else
		outputChatBox("error: bad argument")
	end
end)
local pretelep = getElementsByType("Teleport_p")
for i,p in ipairs(pretelep) do
	if exports.edf:edfGetElementProperty (p, "type") == "ring" then
		local ax,ay,az = exports.edf:edfGetElementPosition(p)
		local obrep = getRepresentation(p,"object")
		local rx,ry,rz = getElementRotation(obrep)
		local tempobject = createVehicle(594,ax,ay,az,rx,ry,rz)
		setElementRotation (tempobject,rx,ry,rz)
		local matrix = getElementMatrix ( tempobject )
		destroyElement (tempobject)
		local offX = 0 * matrix[1][1] + 50 * matrix[2][1] + 0 * matrix[3][1] + matrix[4][1]
		local offY = 0 * matrix[1][2] + 50 * matrix[2][2] + 0 * matrix[3][2] + matrix[4][2]
		local offZ = 0 * matrix[1][3] + 50 * matrix[2][3] + 0 * matrix[3][3] + matrix[4][3]
		local marker = getRepresentation(p,"marker")
		--outputChatBox(tostring(getElementType(marker))..", "..tostring(offX)..", "..tostring(offY)..", "..tostring(offZ)..", ")
		setMarkerTarget (marker, tonumber(offX), tonumber(offY), tonumber(offZ))
	end
	--local dim = exports.edf:edfGetElementProperty(p, "dimension_")
	local int = exports.edf:edfGetElementProperty(p, "interior_")
	--exports.edf:edfSetElementDimension (p, dim)
	--exports.edf:edfSetElementInterior (p, int)
	triggerServerEvent("onchangei",getLocalPlayer(),p,int)
end
pretelep = getElementsByType("destination_p")
for i,p in ipairs(pretelep) do
	--local dim = exports.edf:edfGetElementProperty(p, "t_dimension")
	local int = exports.edf:edfGetElementProperty(p, "t_interior")
	--exports.edf:edfSetElementDimension (p, dim)
	--exports.edf:edfSetElementInterior (p, int)
	triggerServerEvent("onchangei",getLocalPlayer(),p,int)
	--outputChatBox(int)
end





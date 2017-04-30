--[[
/***************************************************************************************************************
*
*  PROJECT:     dxGUI
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        dxState.lua
*  PURPOSE:     All state functions.
*  DEVELOPERS:  Skyline <xtremecooker@gmail.com>
*
*  dxGUI is available from http://community.mtasa.com/index.php?p=resources&s=details&id=4871
*
****************************************************************************************************************/
]]
-- // Functions
function dxRefreshStates(container)
	if not container then
		container = dxGetRootPane()
	end
	
	local absoluteX,absoluteY = getCursorAbsolute()
	local containerVisible = false
	if (dxGetVisible(container)) then
		if ( getElementType(container) ~= "dxRootPane") then
			if (getElementData(getElementParent(container),"visible")) then
				containerVisible = true
			else
				containerVisible = false
			end
		else
			containerVisible = true
		end
	end
	local elementFor = {}
	if containerVisible then
		for _,element in ipairs(getElementChildren(container)) do 
			if ( dxGetVisible(element) ) then
				local x = getElementData(container,"x")+getElementData(element,"x")
				local y = getElementData(container,"y")+getElementData(element,"y")
				local width = getElementData(element,"width")
				local height = getElementData(element,"height")
				if (isCursorShowing()) then
					setElementData(element,"pushBefore",getElementData(element,"push"))
					setElementData(element,"hoverBefore",getElementData(element,"hover"))
					setElementData(element,"hover",false)
					setElementData(element,"push",false)
					if ( intersect(x,y,x+width,y+height,absoluteX,absoluteY) ) then
						table.insert(elementFor,element)
					end
					if (getElementData(element,"container")) then
						local comp = dxRefreshStates(element)
						for _,w in ipairs(comp) do
							table.insert(elementFor,w)
						end
					end
				end
			end
		end
	end
	
	if (container == dxGetRootPane()) then
		if #elementFor <=0 then return end
		table.sort(elementFor,function(a,b)
			local parenta = getElementParent(a)
			local parentb = getElementParent(b)
			if (dxGetAlwaysOnTop(a) and not dxGetAlwaysOnTop(b)) then return true end
			if (not dxGetAlwaysOnTop(a) and dxGetAlwaysOnTop(b)) then return false end
			if (parenta == parentb) then
				return dxGetZOrder(a) > dxGetZOrder(b)
			end

			local aParentIdx,bParentIdx = a,b
			local aParents,bParents = {},{}
			while getElementParent(aParentIdx) ~= dxGetRootPane() do
				aParentIdx = getElementParent(aParentIdx)
				table.insert(aParents,aParentIdx)
			end
			while getElementParent(bParentIdx) ~= dxGetRootPane() do
				bParentIdx = getElementParent(bParentIdx)
				table.insert(bParents,bParentIdx)
			end
			aParents = table.reverse(aParents)
			bParents = table.reverse(bParents)
			--[[if (aParents[1] ~= bParents[1]) then
				return dxGetZOrder(aParents[1]) > dxGetZOrder(bParents[1])
			end]]
			for i,v in ipairs(aParents) do
				if (aParents[i] ~= bParents[i]) then
					return dxGetZOrder(aParents[i]) > dxGetZOrder(bParents[i])
				end
			end
			return false
		end)
		local tableClickers = {elementFor[1]}
		for _,w in ipairs(elementFor) do
			local parent = w
			while parent ~= dxGetRootPane() do
				parent = getElementParent(parent)
				if (parent == elementFor[1]) then
					table.insert(tableClickers,_)
				end
			end
		end
		for i,_i in ipairs(tableClickers) do
			local element = elementFor[i]
			local hover = getElementData(element,"hoverBefore")
			local push = getElementData(element,"pushBefore")
			if (getKeyState("mouse1")) and getElementData(element,"clicked") then
				setElementData(element,"push",true)
				setElementData(element,"hover",true)
			else
				setElementData(element,"hover",true)
			end
			local push1 = getElementData(element,"push")
			local hover1 = getElementData(element,"hover")
			if (not hover) and (hover1) then
				triggerEvent("onClientDXMouseEnter",element,absoluteX,absoluteY)
			end
			
			if hover and (not hover1) then
				triggerEvent("onClientDXMouseLeave",element,absoluteX,absoluteY)
			end
		end
	end
	return elementFor
end

function dxRefreshClickStates(container,button,state,absoluteX,absoluteY,doubleClick)
	if not container then
		container = dxGetRootPane()
	end
	
	if not doubleClick then
		doubleClick = false
	end

	local containerVisible = false
	if (dxGetVisible(container)) then
		if ( getElementType(container) ~= "dxRootPane") then
			if (getElementData(getElementParent(container),"visible")) then
				containerVisible = true
			else
				containerVisible = false
			end
		else
			containerVisible = true
		end
	end
	local clickedElements = {}
	if containerVisible then
		for _,element in ipairs(getElementChildren(container)) do 
			if ( dxGetVisible(element) )  then
				local x = getElementData(container,"x")+getElementData(element,"x")
				local y = getElementData(container,"y")+getElementData(element,"y")
				local width = getElementData(element,"width")
				local height = getElementData(element,"height")
				if (getElementType(element) == "dxScrollBar") then
					height = height + getElementData(dxGetElementTheme(element),"ScrollbarThumb:Height")
				end
				setElementData(element,"clicked",false)
				if ( intersect(x,y,x+width,y+height,absoluteX,absoluteY) ) then
					table.insert(clickedElements,element)
				end
				if (getElementData(element,"container")) then
					local  cont = dxRefreshClickStates(element,button,state,absoluteX,absoluteY,doubleClick)
					for _,w in ipairs(cont) do
						table.insert(clickedElements,w)
					end
				end
			end
		end
	end
	
	if (container == dxGetRootPane()) then
		if #clickedElements <=0 then return end
		if #clickedElements ==1 then setElementData(clickedElements[1],"clicked",true) 
		else
			table.sort(clickedElements,function(a,b)
				local parenta = getElementParent(a)
				local parentb = getElementParent(b)
				if (dxGetAlwaysOnTop(a) and not dxGetAlwaysOnTop(b)) then return true end
				if (not dxGetAlwaysOnTop(a) and dxGetAlwaysOnTop(b)) then return false end
				if (parenta == parentb) then
					return dxGetZOrder(a) > dxGetZOrder(b)
				end

				local aParentIdx,bParentIdx = a,b
				local aParents,bParents = {},{}
				while getElementParent(aParentIdx) ~= dxGetRootPane() do
					aParentIdx = getElementParent(aParentIdx)
					table.insert(aParents,aParentIdx)
				end
				while getElementParent(bParentIdx) ~= dxGetRootPane() do
					bParentIdx = getElementParent(bParentIdx)
					table.insert(bParents,bParentIdx)
				end
				aParents = table.reverse(aParents)
				bParents = table.reverse(bParents)
				--[[if (aParents[1] ~= bParents[1]) then
					return dxGetZOrder(aParents[1]) > dxGetZOrder(bParents[1])
				end]]
				for i,v in ipairs(aParents) do
					if (aParents[i] ~= bParents[i]) then
						return dxGetZOrder(aParents[i]) > dxGetZOrder(bParents[i])
					end
				end
				return false
			end)
		end
		local tableClickers = {clickedElements[1]}
		for _,w in ipairs(clickedElements) do
			local parent = w
			while parent ~= dxGetRootPane() do
				parent = getElementParent(parent)
				if (parent == clickedElements[1]) then
					table.insert(tableClickers,_)
				end
			end
		end
		for i,_i in ipairs(tableClickers) do
			if (doubleClick) then 
				triggerEvent("onClientDXDoubleClick",clickedElements[i],button,absoluteX,absoluteY)
				if not wasEventCancelled() then
					setElementData(clickedElements[i],"clicked",true)
				end
			end
			
			if not (doubleClick) then 
				triggerEvent("onClientDXClick",clickedElements[i],button,state,absoluteX,absoluteY)
				if not wasEventCancelled() then
					setElementData(clickedElements[i],"clicked",true)
				end
			end
		end
	end
	return clickedElements
end

-- // Events
addEventHandler("onClientClick",getRootElement(),
	function(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedWorld)
		dxRefreshClickStates(dxGetRootPane(),button,state,absoluteX,absoluteY)
	end)
addEventHandler("onClientDoubleClick",getRootElement(),
	function(button, absoluteX, absoluteY, worldX, worldY, worldZ, clickedWorld)
		dxRefreshClickStates(dxGetRootPane(),button,false,absoluteX,absoluteY,true)
	end)
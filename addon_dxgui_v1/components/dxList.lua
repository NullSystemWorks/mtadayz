--[[
/***************************************************************************************************************
*
*  PROJECT:     dxGUI
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        components/dxList.lua
*  PURPOSE:     All listbox functions.
*  DEVELOPERS:  Skyline <xtremecooker@gmail.com>
*
*  dxGUI is available from http://community.mtasa.com/index.php?p=resources&s=details&id=4871
*
****************************************************************************************************************/
]]
-- // Initializing
function dxCreateList(resource,x,y,width,height,title,parent,color,font,theme)
	if not x or not y or not width or not height then
		outputDebugString("dxCreateList gets wrong parameters (x,y,width,height[,title=\"\",parent=dxGetRootPane(),color=black,font=default,theme=dxGetDefaultTheme()])")
		return
	end
	
	if not title then
		title = ""
	end
	
	if not color then
		color = tocolor(0,0,0,255)
	end
	
	if not font then
		font = "default"
	end
	
	if not parent then
		parent = dxGetRootPane()
	end
	
	if not theme then
		theme = dxGetDefaultTheme()
	end
	
	if type(theme) == "string" then
		theme = dxGetTheme(theme)
	end
	
	if not theme then
		outputDebugString("dxCreateList didn't find the main theme.")
		return false
	end
	
	local list = createElement("dxList")
	setElementParent(list, parent)
	setElementData(list,"resource",resource)
	setElementData(list,"x",x)
	setElementData(list,"y",y)
	setElementData(list,"width",width)
	setElementData(list,"height",height)
	setElementData(list,"text",title)
	setElementData(list,"Title:show",true)
	setElementData(list,"theme",theme)
	setElementData(list,"color",color)
	setElementData(list,"font",font)
	setElementData(list,"visible",true)
	setElementData(list,"hover",false)
	setElementData(list,"parent",parent)
	setElementData(list,"container",false)
	setElementData(list,"scrollbarVert",false)
	setElementData(list,"scrollbarHorz",false)
	setElementData(list,"clicked",false)
	setElementData(list,"postGUI",false)
	setElementData(list,"ZOrder",getElementData(parent,"ZIndex")+1)
	setElementData(parent,"ZIndex",getElementData(parent,"ZIndex")+1)
	addEventHandler("onClientDXClick",list,__list,false)
	addEventHandler("onClientDXDoubleClick",list,list__,false)
	return list
end
-- // Functions
function dxListClear(dxElement)
	if not dxElement or getElementType(dxElement) ~= "dxList" then
		outputDebugString("dxListClear gets wrong parameters.(dxList)")
		return
	end
	
	for _,v in ipairs(getElementChildren(dxElement)) do
		destroyElement(v)
	end
end

function dxListGetItemCount(dxElement)
	if not dxElement or getElementType(dxElement) ~= "dxList" then
		outputDebugString("dxListClear gets wrong parameters.(dxList)")
		return
	end
	return #getElementChildren(dxElement)
end

function dxListGetSelectedItem(dxElement) 
	if not dxElement or getElementType(dxElement) ~= "dxList" then
		outputDebugString("dxListGetSelectedItem gets wrong parameters.(dxList)")
		return
	end
	
	return getElementData(dxElement,"selectedItem")
end

function dxListSetSelectedItem(dxElement,item)
	if not dxElement or getElementType(dxElement) ~= "dxList" or not item or getElementType(item)~="dxListItem" then
		outputDebugString("dxListSetSelectedItem gets wrong parameters.(dxList,dxListItem)")
		return
	end
	setElementData(dxElement,"selectedItem",item)
	for _,w in ipairs(getElementChildren(dxElement)) do
		setElementData(w,"clicked",false)
	end
	setElementData(item,"clicked",true)
end

function dxListRemoveRow(dxElement)
	if not dxElement or getElementType(dxElement) ~= "dxListItem" then
		outputDebugString("dxListRemoveRow gets wrong parameters.(dxListItem)")
		return
	end
	destroyElement(dxElement)
end

function dxListAddRow(dxElement,text,color,font,colorcoded)
	if not dxElement or getElementType(dxElement) ~= "dxList" then
		outputDebugString("dxListAddRow gets wrong parameters.(dxList[,text=\"\",color=black,font=default,colorcoded=false])")
		return
	end
	if not text then
		text = ""
	end
	if not color then
		color = tocolor(0,0,0,255)
	end
	if not font then
		font = "default"
	end
	if colorcoded == nil then
		colorcoded = false
	end
	local item = createElement("dxListItem")
	setElementParent(item,dxElement)
	dxSetText(item,text)
	setElementData(item,"color",color)
	setElementData(item,"font",font)
	dxSetColorCoded(item,colorcoded)
	return item
end

function dxListSetTitleShow(dxElement,titleShow)
	dxDeprecatedFunction("dxListSetTitleShow","dxListSetTitleVisible")
	if not dxElement or getElementType(dxElement) ~= "dxList" or titleShow==nil then
		outputDebugString("dxListSetTitleShow gets wrong parameters.(dxList,titleShow)")
		return
	end
	setElementData(dxElement,"Title:show",titleShow)
end

function dxListGetTitleShow(dxElement)
	dxDeprecatedFunction("dxListGetTitleShow","dxListGetTitleVisible")
	if not dxElement or getElementType(dxElement) ~= "dxList" then
		outputDebugString("dxListGetTitleShow gets wrong parameters.(dxList)")
		return
	end
	return getElementData(dxElement,"Title:show")
end

function dxListSetTitleVisible(dxElement,titleShow)
	if not dxElement or getElementType(dxElement) ~= "dxList" or titleShow==nil then
		outputDebugString("dxListSetTitleShow gets wrong parameters.(dxList,titleShow)")
		return
	end
	setElementData(dxElement,"Title:show",titleShow)
end

function dxListGetTitleVisible(dxElement)
	if not dxElement or getElementType(dxElement) ~= "dxList" then
		outputDebugString("dxListGetTitleShow gets wrong parameters.(dxList)")
		return
	end
	return getElementData(dxElement,"Title:show")
end

-- // Events
function __list(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedWorld)
	local list = source
	local parentX = getElementData(getElementParent(list),"x")
	local parentY = getElementData(getElementParent(list),"y")
	local x,y = 
		parentX+getElementData(list,"x"),parentY+getElementData(list,"y")
	local width = getElementData(list,"width")
	local height = getElementData(list,"height")
	local cTheme = dxGetElementTheme(list)

	local tShow = getElementData(list,"Title:show")
	local titleHeight = getElementData(cTheme,"ListBoxTitle:Height")
	local coh = height
	local cpyyy = y
	local scrollbarVert = getElementData(list,"scrollbarVert") 
	if (scrollbarVert) then
		width = width-20
	end
	if (tShow) then			
		if (intersect(x,y,x+width,y+titleHeight,absoluteX,absoluteY)) then
			return;
		end
		coh = coh-titleHeight
		cpyyy = cpyyy+titleHeight
	end
	local itemHeight = 23
	local itemMultiplyHeight = 23
	local itemMultiply = 0.9
	local itemSorter = 0
	if ( scrollbarVert ) then
		itemSorter = (dxScrollBarGetScroll(scrollbarVert)/100)*dxListGetItemCount(list)*itemMultiply*itemMultiplyHeight
	end
	itemSorter = itemSorter/2
	local itemClicked = 0
	for id,item in ipairs(getElementChildren(list)) do
		setElementData(item,"clicked",false)
		if ( id*itemMultiply*itemMultiplyHeight - itemSorter <= coh+itemHeight ) and (id*itemMultiply*itemMultiplyHeight - itemSorter >=0) and itemClicked == 0 then
			local itemMax = math.max((id-1)*itemMultiply*itemMultiplyHeight-itemSorter,0)
			local itemShow = (cpyyy+coh)-(cpyyy+itemMax-23)
			itemShow = math.min(itemShow,itemHeight)-3
			if (intersect(x+1,cpyyy+itemMax,x+1+width-2,cpyyy+itemMax+itemShow,absoluteX,absoluteY)) then
				setElementData(item,"clicked",true)
				setElementData(list,"selectedItem",item)
				triggerEvent("onClientDXClick",item,button,state,absoluteX,absoluteY)
				itemClicked = 1
			end
		end
	end
end


function list__(button, absoluteX, absoluteY, worldX, worldY, worldZ, clickedWorld)
	local list = source
	local parentX = getElementData(getElementParent(list),"x")
	local parentY = getElementData(getElementParent(list),"y")
	local x,y = 
		parentX+getElementData(list,"x"),parentY+getElementData(list,"y")
	local width = getElementData(list,"width")
	local height = getElementData(list,"height")
	local cTheme = dxGetElementTheme(list)

	local tShow = getElementData(list,"Title:show")
	local titleHeight = getElementData(cTheme,"ListBoxTitle:Height")
	local coh = height
	local cpyyy = y
	local scrollbarVert = getElementData(list,"scrollbarVert") 
	if (scrollbarVert) then
		width = width-20
	end
	if (tShow) then			
		if (intersect(x,y,x+width,y+titleHeight,absoluteX,absoluteY)) then
			return;
		end
		coh = coh-titleHeight
		cpyyy = cpyyy+titleHeight
	end
	local itemHeight = 23
	local itemMultiplyHeight = 23
	local itemMultiply = 0.9
	local itemSorter = 0
	if ( scrollbarVert ) then
		itemSorter = (dxScrollBarGetScroll(scrollbarVert)/100)*dxListGetItemCount(list)*itemMultiply*itemMultiplyHeight
	end
	itemSorter = itemSorter/2
	local itemClicked = 0
	for id,item in ipairs(getElementChildren(list)) do
		setElementData(item,"clicked",false)
		if ( id*itemMultiply*itemMultiplyHeight - itemSorter <= coh+itemHeight ) and (id*itemMultiply*itemMultiplyHeight - itemSorter >=0) and itemClicked == 0 then
			local itemMax = math.max((id-1)*itemMultiply*itemMultiplyHeight-itemSorter,0)
			local itemShow = (cpyyy+coh)-(cpyyy+itemMax-23)
			itemShow = math.min(itemShow,itemHeight)-3
			if (intersect(x+1,cpyyy+itemMax,x+1+width-2,cpyyy+itemMax+itemShow,absoluteX,absoluteY)) then
				setElementData(item,"clicked",true)
				setElementData(list,"selectedItem",item)
				triggerEvent("onClientDXDoubleClick",item,button,absoluteX,absoluteY)
				itemClicked = 1
			end
		end
	end
end

-- // Render
function dxListRender(component,cpx,cpy,cpg)
	if not cpx then cpx = 0 end
	if not cpy then cpy = 0 end
	-- // Initializing
	local cTheme = dxGetElementTheme(component)
			or dxGetElementTheme(getElementParent(component))
	
	local cx,cy = dxGetPosition(component)
	local cw,ch = dxGetSize(component)
	
	local color = getElementData(component,"color")
	local font = dxGetFont(component)
	
	if not font then
		font = "default"
	end
	
	if not color then
		color = tocolor(255,255,255,255)
	end
	local cpxx = cpx+cx
	local cpyy = cpy+cy
	local tShow = getElementData(component,"Title:show")
	local titleHeight = getElementData(cTheme,"ListBoxTitle:Height")
	local coh = ch
	local cpyyy = cpyy
	local scrollbarVert = getElementData(component,"scrollbarVert") 
	if (scrollbarVert) then
		cw = cw-20
	end
	if (tShow) then							
		dxDrawImageSection(cpxx,cpyy,cw,titleHeight,
			getElementData(cTheme,"ListBoxTitle:X"),getElementData(cTheme,"ListBoxTitle:Y"),
			getElementData(cTheme,"ListBoxTitle:Width"),getElementData(cTheme,"ListBoxTitle:Height"),
			getElementData(cTheme,"ListBoxTitle:images"),0,0,0,tocolor(255,255,255), cpg)
		local funct = dxDrawText
		if (dxGetColorCoded(component)) then
			funct = dxDrawColorText
		end
		local color_ = getElementData(component,"color")
		local font_ = dxGetFont(component)
		funct(dxGetText(component),cpxx,cpyy,cpxx+cw,cpyy+titleHeight,color_,1,font_,"center","center",true,false,cpg)
		coh = coh-titleHeight
		cpyyy = cpyyy+titleHeight
	end
	
	dxDrawImageSection(cpxx,cpyyy,cw,coh,
		getElementData(cTheme,"ListBoxBackground:X"),getElementData(cTheme,"ListBoxBackground:Y"),
		getElementData(cTheme,"ListBoxBackground:Width"),getElementData(cTheme,"ListBoxBackground:Height"),
		getElementData(cTheme,"ListBoxBackground:images"),0,0,0,tocolor(255,255,255), cpg)
	
	
	local itemHeight = 23
	local itemMultiplyHeight = 23
	local itemMultiply = 0.9
	local itemSorter = 0
	
	if ( scrollbarVert ) then
		itemSorter = (dxScrollBarGetScroll(scrollbarVert)/100)*dxListGetItemCount(component)*itemMultiply*itemMultiplyHeight
	end
	itemSorter = itemSorter/2
	if (dxListGetItemCount(component)*itemMultiply*itemHeight > coh) then
		local choc = coh
		if ( tShow ) then
			choc = choc + getElementData(cTheme,"ScrollbarThumb:Height")/2
		else
			choc = choc - getElementData(cTheme,"ScrollbarThumb:Height")/2-4
		end
		if not (scrollbarVert) then
			
			scrollbarVert = dxCreateScrollBar(getElementData(component,"resource"),cx+cw-22,cy,20,choc,element,"Vertical",0,200,cTheme)
			setElementData(component,"scrollbarVert",scrollbarVert)
		else
			dxSetPosition(scrollbarVert,cx+cw,cy)
			dxSetSize(scrollbarVert,20,choc)
			setElementData(component,"scrollbarVert",scrollbarVert)
		end
	end

	for id,item in ipairs(getElementChildren(component)) do
		if ( id*itemMultiply*itemMultiplyHeight - itemSorter <= coh+itemHeight ) and (id*itemMultiply*itemMultiplyHeight - itemSorter >=0) then
			setElementData(item,"shown",true)
			local back = "ListBox1STColor"	
			if ( (id % 2) == 0) then back ="ListBox2NDColor" end
			if ( getElementData(item,"clicked") ) then back ="ListBoxClickedColor" end
			local itemMax = math.max((id-1)*itemMultiply*itemMultiplyHeight-itemSorter,0)
			local itemShow = (cpyyy+coh)-(cpyyy+itemMax)
			itemShow = math.min(itemShow,itemHeight)-3
			dxDrawImageSection(cpxx+1,cpyyy+itemMax,cw-2,itemShow,
				getElementData(cTheme,back..":X"),getElementData(cTheme,back..":Y"),
				getElementData(cTheme,back..":Width"),getElementData(cTheme,back..":Height"),
				getElementData(cTheme,back..":images"),0,0,0,tocolor(255,255,255),cpg)
			local funct = dxDrawText
			if ( dxGetColorCoded(item) ) then
				funct = dxDrawColorText
			end
			local font__ = getElementData(item,"font")
			local color__ = getElementData(item,"color")
			if not font__ then
				font__ = "default"
			end
			if not color__ then color__ = tocolor(0,0,0) end
			arrowWidth = 0
			--[[local arrowWidth = getElementData(cTheme,"ListBoxItemArrow:Width")
			local arrowHeight = getElementData(cTheme,"ListBoxItemArrow:Height")
			local arrowCenter = (itemHeight-arrowHeight)/2
			
			local itemMax_ = math.max((id-1)*itemMultiply*arrowHeight-itemSorter,0)
			local itemShow_ = (cpyyy+coh)-(cpyyy+arrowCenter+arrowHeight)
			itemShow_ = math.min(itemShow_,arrowHeight)
			dxDrawImageSection(cpxx+1,cpyyy+itemMax+arrowCenter,arrowWidth,itemShow_,
				getElementData(cTheme,"ListBoxItemArrow:X"),getElementData(cTheme,"ListBoxItemArrow:Y"),
				arrowWidth,arrowHeight,getElementData(cTheme,"ListBoxItemArrow:images"),0,0,0,tocolor(255,255,255),cpg)]]
			-- Now is good without arrows :)
			funct(dxGetText(item),cpxx+1+arrowWidth+5,cpyyy+itemMax,cpxx+1+(cw-2),cpyyy+itemMax+itemShow,color__,1,font__,"left","center",true,false,cpg)
		else
			setElementData(item,"shown",false)
		end
	end
end
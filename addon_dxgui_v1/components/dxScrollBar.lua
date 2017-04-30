--[[
/***************************************************************************************************************
*
*  PROJECT:     dxGUI
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        components/dxButton.lua
*  PURPOSE:     All scrollbar functions.
*  DEVELOPERS:  Skyline <xtremecooker@gmail.com>
*
*  dxGUI is available from http://community.mtasa.com/index.php?p=resources&s=details&id=4871
*
****************************************************************************************************************/
]]
-- // Initializing
function dxCreateScrollBar(resource,x,y,width,height,parent,type_,progress,max_,theme)
	if not x or not y or not width or not height then
		outputDebugString("dxCreateScrollBar gets wrong parameters (x,y,width,height[,parent=dxGetRootPane(),type=Vertical,scroll=0,max=100,theme=dxGetDefaultTheme()])")
		return
	end
	
	if not parent then
		parent = dxGetRootPane()
	end
	
	if type_ == nil then
		type_ = "Vertical"
	end
	
	if type_ ~= "Vertical" and type_ ~= "Horizontal" and type_ ~= 0 and type_~= 1 then
		type_ = "Vertical"
	end
	
	if (type_ == 0) then
		type_ = "Vertical"
	end
	
	if (type_ == 1) then
		type_ = "Horizontal"
	end
	
	if not progress then
		progress = 0
	end
	
	if not max_ then
		max_ = 100
	end
	
	if max_ <= 0 then
		max_ = 100
	end
	
	if progress < 0 or progress > max_ then
		progress = 0
	end
	
	if not color then
		color = "segment"
	end
	
	if not theme then
		theme = dxGetDefaultTheme()
	end
	
	if type(theme) == "string" then
		theme = dxGetTheme(theme)
	end
	
	if not theme then
		outputDebugString("dxCreateScrollBar didn't find the main theme.")
		return false
	end
	
	local scrollBar = createElement("dxScrollBar")
	setElementParent(scrollBar,parent)
	setElementData(scrollBar,"resource",resource)
	setElementData(scrollBar,"x",x)
	setElementData(scrollBar,"y",y)
	setElementData(scrollBar,"width",width)
	setElementData(scrollBar,"height",height)
	setElementData(scrollBar,"type",type_)
	setElementData(scrollBar,"progress",progress)
	setElementData(scrollBar,"max",max_)
	setElementData(scrollBar,"theme",theme)
	setElementData(scrollBar,"visible",true)
	setElementData(scrollBar,"hover",false)
	setElementData(scrollBar,"parent",parent)
	setElementData(scrollBar,"container",false)
	setElementData(scrollBar,"period",1)
	setElementData(scrollBar,"postGUI",false)
	setElementData(scrollBar,"ZOrder",getElementData(parent,"ZIndex")+1)
	setElementData(parent,"ZIndex",getElementData(parent,"ZIndex")+1)
	addEventHandler("onClientDXClick",scrollBar,__scrollbar,false)	
	return scrollBar
end
-- // Functions
function dxScrollBarGetScroll(dxElement)
	if not dxElement then
		outputDebugString("dxScrollBarGetScroll gets wrong parameters.(dxElement)")
		return
	end
	if (getElementType(dxElement)~="dxScrollBar") then
		outputDebugString("dxScrollBarGetScroll gets wrong parameters.(dxElement must be dxScrollBar)")
		return
	end
	return getElementData(dxElement,"progress")
end

function dxScrollBarSetScroll(dxElement,progress)
	if not dxElement or not progress then
		outputDebugString("dxScrollBarSetScroll gets wrong parameters.(dxElement,progress)")
		return
	end
	if (getElementType(dxElement)~="dxScrollBar") then
		outputDebugString("dxScrollBarSetScroll gets wrong parameters.(dxElement must be dxScrollBar)")
		return
	end
	local max = getElementData(dxElement,"max")
	if type(progress)~="number" then
		outputDebugString("dxScrollBarSetScroll gets wrong parameters.(progress must be between 0-"..tostring(max))
		return
	end
	if (progress < 0) then
		progress = 0
	end
	
	if (progress > max) then
		progress = max
	end
	setElementData(dxElement,"progress",progress)
	triggerEvent("onClientDXPropertyChanged",dxElement,"scroll",progress)
	triggerEvent("onClientDXScroll",dxElement,progress)
end

function dxScrollBarGetScrollPercent(dxElement)
	if not dxElement then
		outputDebugString("dxScrollBarGetScrollPercent gets wrong parameters.(dxElement)")
		return
	end
	if (getElementType(dxElement)~="dxScrollBar") then
		outputDebugString("dxScrollBarGetScrollPercent gets wrong parameters.(dxElement must be dxScrollBar)")
		return
	end
	-- max progress
	-- 100 x
	return (100*getElementData(dxElement,"progress")) / getElementData(dxElement,"max")
end

function dxScrollBarSetScrollPercent(dxElement,progress)
	if not dxElement or not progress then
		outputDebugString("dxScrollBarSetScrollPercent gets wrong parameters.(dxElement,percent)")
		return
	end
	if (getElementType(dxElement)~="dxScrollBar") then
		outputDebugString("dxScrollBarSetScrollPercent gets wrong parameters.(dxElement must be dxScrollBar)")
		return
	end
	if type(progress)~="number" then
		outputDebugString("dxScrollBarSetScrollPercent gets wrong parameters.(percent must be number)")
		return
	end
	if (progress > 100) then
		progress = 100
	end
	if (progress < 0) then
		progress = 0
	end
	-- 100 percent
	-- max x
	setElementData(dxElement,"progress",(getElementData(dxElement,"max")*progress)/100)
	triggerEvent("onClientDXPropertyChanged",dxElement,"scrollPercent",progress,(getElementData(dxElement,"max")*progress)/100)
	triggerEvent("onClientDXScroll",dxElement,(getElementData(dxElement,"max")*progress)/100)
end

function dxScrollBarGetMaxScroll(dxElement)
	if not dxElement then
		outputDebugString("dxScrollBarGetMaxScroll gets wrong parameters.(dxElement)")
		return
	end
	if (getElementType(dxElement)~="dxScrollBar") then
		outputDebugString("dxScrollBarGetMaxScroll gets wrong parameters.(dxElement must be dxScrollBar)")
		return
	end
	return getElementData(dxElement,"max")
end

function dxScrollBarSetMaxScroll(dxElement,progress)
	if not dxElement or not progress then
		outputDebugString("dxScrollBarSetMaxScroll gets wrong parameters.(dxElement,maxProgress)")
		return
	end
	if (getElementType(dxElement)~="dxScrollBar") then
		outputDebugString("dxScrollBarSetMaxScroll gets wrong parameters.(dxElement must be dxScrollBar)")
		return
	end
	setElementData(dxElement,"max",progress)
	triggerEvent("onClientDXPropertyChanged",dxElement,"maxScroll",progress)
	if (getElementData(dxElement,"progress") > progress ) then
		dxScrollBarSetProgress(dxElement,progress)
	end
end
function dxScrollBarRefresh(element) 
	if (getElementData(element,"GiveUp")) then
		local scroll = dxScrollBarGetScroll(element)
		if scroll >0 then				
			dxScrollBarSetScroll(element,scroll-getElementData(element,"period"))
		end
	end
	
	if (getElementData(element,"GiveDown")) then
		local scroll = dxScrollBarGetScroll(element)
		if scroll < dxScrollBarGetMaxScroll(element) then
			dxScrollBarSetScroll(element,scroll+getElementData(element,"period"))
		end
	end
	
	if ( getElementData(element,"isMoving") ) then
		if (getElementData(element,"type") == "Vertical") then
			local cTheme = dxGetElementTheme(element)
			local absoluteX,absoluteY = getCursorAbsolute()
			local upArrowH=getElementData(cTheme,"ScrollUpArrow:Height")
			local downArrowH=getElementData(cTheme,"ScrollDownArrow:Height")
			local thumb = getElementData(cTheme,"ScrollbarThumb:Height")
			local _,ry = dxGetPosition(element)
			ry = ry + getElementData(getElementParent(element),"y")
			local ay = absoluteY-ry-upArrowH-(thumb/2)
			-- %100'da h ise
			-- y'de	ay'dır
			local y50 = ((ay*100) / (getElementData(element,"height")-upArrowH-downArrowH))
			dxScrollBarSetScrollPercent(element,y50)
		else
			local cTheme = dxGetElementTheme(element)
			local upArrowW=getElementData(cTheme,"ScrollLeftArrow:Width")
			local downArrowW=getElementData(cTheme,"ScrollRightArrow:Width")
			local thumb = getElementData(cTheme,"ScrollbarThumb:Width")
			local absoluteX,absoluteY = getCursorAbsolute()
			local rx,_ = dxGetPosition(element)
			rx = rx + getElementData(getElementParent(element),"x")
			local ax = absoluteX-rx-upArrowW-(thumb/2)
			-- %100'da w ise
			-- y'de	ax'dır
			local y50 = ((ax*100) / getElementData(element,"width"))
			dxScrollBarSetScrollPercent(element,y50)
		end
	end
end
function dxScrollBarsRefresh()
	for _,element in ipairs(getElementsByType("dxScrollBar")) do
		dxScrollBarRefresh(element)
	end
end

-- // Events

function __scrollbar(button,state,absoluteX,absoluteY,worldX,worldY,worldZ,clickedWorld)
	local scrollbar = source
	if (button == "left" and state == "down") then
		setElementData(scrollbar,"clicked",false)
		setElementData(scrollbar,"isMoving",false)
		setElementData(scrollbar,"GiveUp",false)
		setElementData(scrollbar,"GiveDown",false)
		local x,y = dxGetPosition(scrollbar)
		local parent = getElementParent(scrollbar)
		local px,py = getElementData(parent,"x"),getElementData(parent,"y")
		local rx,ry = px+x,py+y
		local w,h = dxGetSize(scrollbar)
		local cTheme = dxGetElementTheme(scrollbar)
		local type_ = getElementData(scrollbar,"type")
		if ( type_ == "Vertical") then
			local upArrowH=getElementData(cTheme,"ScrollUpArrow:Height")
			local downArrowH=getElementData(cTheme,"ScrollDownArrow:Height")
			local thumb = getElementData(cTheme,"ScrollbarThumb:Height")
			local click,up,down = false
			if (intersect(rx,ry,rx+w,ry+h+thumb,absoluteX,absoluteY)) then
				setElementData(scrollbar,"clicked",true)
				click = true
			end
			
			local ratio = dxScrollBarGetScrollPercent(scrollbar)/50
			local yScroll = ry+upArrowH+((h-downArrowH-upArrowH)/2)*ratio
			local c = (w-getElementData(cTheme,"ScrollbarThumb:Width"))/2
			
			if (intersect(rx+c,yScroll,rx+c+getElementData(cTheme,"ScrollbarThumb:Width"),yScroll+thumb,absoluteX,absoluteY)) then
				setElementData(scrollbar,"isMoving",true)
			end
			
			if (intersect(rx,ry,rx+w,ry+upArrowH,absoluteX,absoluteY)) then
				setElementData(scrollbar,"GiveUp",true)
				up = true
			end
			
			if (intersect(rx,ry+upArrowH+(h-downArrowH-upArrowH)+thumb,rx+w,ry+upArrowH+(h-downArrowH-upArrowH)+thumb+downArrowH,absoluteX,absoluteY)) then
				setElementData(scrollbar,"GiveDown",true)
				down = true
			end
			
			if (click) and (not up) and (not down) then
				local ay = absoluteY-ry-upArrowH-(thumb/2)
				-- %100'da h ise
				-- y'de	ay'dır
				local y50 = ((ay*100) / (h-upArrowH-downArrowH))
				dxScrollBarSetScrollPercent(scrollbar,y50)
			end
		else
			local upArrowW=getElementData(cTheme,"ScrollLeftArrow:Width")
			local downArrowW=getElementData(cTheme,"ScrollRightArrow:Width")
			local thumb = getElementData(cTheme,"ScrollbarThumb:Width")
			local click,up,down = false
			if (intersect(rx,ry,rx+w+thumb,ry+h,absoluteX,absoluteY)) then
				setElementData(scrollbar,"clicked",true)			
				click = true
			end
			
			local ratio = dxScrollBarGetScrollPercent(scrollbar)/50
			local xScroll = rx+upArrowW+((w-downArrowW-upArrowW)/2)*ratio
			local c = (h-getElementData(cTheme,"ScrollbarThumb:Height"))/2
			
			
			if (intersect(xScroll,ry+c,xScroll+getElementData(cTheme,"ScrollbarThumb:Width"),ry+c+getElementData(cTheme,"ScrollbarThumb:Height"),absoluteX,absoluteY)) then
				setElementData(scrollbar,"isMoving",true)
			end
			
			if (intersect(rx,ry,rx+upArrowW,ry+h,absoluteX,absoluteY)) then
				setElementData(scrollbar,"GiveUp",true)
				up = true
			end
			
			if (intersect(rx+upArrowW+(w-downArrowW-upArrowW)+thumb,ry,rx+upArrowW+(w-downArrowW-upArrowW)+thumb+downArrowW,ry+h,absoluteX,absoluteY)) then
				setElementData(scrollbar,"GiveDown",true)
				down = true
			end
			if (click) and (not up) and (not down) then
				local ax = absoluteX-rx-upArrowW-(thumb/2)
				-- %100'da w ise
				-- y'de	ax'dır
				local y50 = ((ax*100) / (w-upArrowW-downArrowW))
				dxScrollBarSetScrollPercent(scrollbar,y50)
			end
		end
	end
	
end

addEventHandler("onClientClick",getRootElement(),function(button,state,absoluteX,absoluteY,worldX,worldY,worldZ,clickedWorld)
	if (button=="left" and state=="up") then
		for _,scrollbar in ipairs(getElementsByType("dxScrollBar")) do
			setElementData(scrollbar,"isMoving",false)
			setElementData(scrollbar,"GiveUp",false)
			setElementData(scrollbar,"GiveDown",false)
		end
	end
end)

addEventHandler( "onClientKey", getRootElement(),function(button, press)
	if (button == "mouse_wheel_up") then
		for _,element in ipairs(getElementsByType("dxScrollBar")) do
			if (getElementData(element,"clicked")) then
				local scroll = dxScrollBarGetScroll(element)
				if (scroll > 0) then
					dxScrollBarSetScroll(element,scroll-getElementData(element,"period"))
				end
			end
		end
	elseif (button == "mouse_wheel_down") then
		for _,element in ipairs(getElementsByType("dxScrollBar")) do
			if (getElementData(element,"clicked")) then
				local scroll = dxScrollBarGetScroll(element)
				if (scroll < dxScrollBarGetMaxScroll(element)) then
					dxScrollBarSetScroll(element,scroll+getElementData(element,"period"))
				end
			end
		end
	end
end)

-- // Render
function dxScrollBarRender(component,cpx,cpy,cpg)
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
	local type_ = getElementData(component,"type")
	if (type_ == "Vertical") then
		local upArrowH=getElementData(cTheme,"ScrollUpArrow:Height")
		local downArrowH=getElementData(cTheme,"ScrollDownArrow:Height")
		dxDrawImageSection(cpxx,cpyy,cw,upArrowH,
			getElementData(cTheme,"ScrollUpArrow:X"),getElementData(cTheme,"ScrollUpArrow:Y"),
			getElementData(cTheme,"ScrollUpArrow:Width"),getElementData(cTheme,"ScrollUpArrow:Height"),
			getElementData(cTheme,"ScrollUpArrow:images"),0,0,0,color,cpg)
			
		dxDrawImageSection(cpxx,cpyy+upArrowH,cw,ch+getElementData(cTheme,"ScrollbarThumb:Height")-upArrowH-downArrowH,
			getElementData(cTheme,"VertScrollContainer:X"),getElementData(cTheme,"VertScrollContainer:Y"),
			getElementData(cTheme,"VertScrollContainer:Width"),getElementData(cTheme,"VertScrollContainer:Height"),
			getElementData(cTheme,"VertScrollContainer:images"),0,0,0,color,cpg)
		
		dxDrawImageSection(cpxx,cpyy+upArrowH+ch+getElementData(cTheme,"ScrollbarThumb:Height")-upArrowH-downArrowH,cw,downArrowH,
			getElementData(cTheme,"ScrollDownArrow:X"),getElementData(cTheme,"ScrollDownArrow:Y"),
			getElementData(cTheme,"ScrollDownArrow:Width"),getElementData(cTheme,"ScrollDownArrow:Height"),
			getElementData(cTheme,"ScrollDownArrow:images"),0,0,0,color,cpg)
		
		local ratio = dxScrollBarGetScrollPercent(component)/50
		local yScroll = cpyy+upArrowH+((ch-upArrowH-downArrowH)/2)*ratio
		local c = (cw-getElementData(cTheme,"ScrollbarThumb:Width"))/2
		dxDrawImageSection(cpxx+c,yScroll,getElementData(cTheme,"ScrollbarThumb:Width"),getElementData(cTheme,"ScrollbarThumb:Height"),
			getElementData(cTheme,"ScrollbarThumb:X"),getElementData(cTheme,"ScrollbarThumb:Y"),
			getElementData(cTheme,"ScrollbarThumb:Width"),getElementData(cTheme,"ScrollbarThumb:Height"),
			getElementData(cTheme,"ScrollbarThumb:images"),0,0,0,color,cpg)	
	else
		local upArrowW=getElementData(cTheme,"ScrollLeftArrow:Width")
		local downArrowW=getElementData(cTheme,"ScrollRightArrow:Height")
		dxDrawImageSection(cpxx,cpyy,upArrowW,ch,
			getElementData(cTheme,"ScrollLeftArrow:X"),getElementData(cTheme,"ScrollLeftArrow:Y"),
			getElementData(cTheme,"ScrollLeftArrow:Width"),getElementData(cTheme,"ScrollLeftArrow:Height"),
			getElementData(cTheme,"ScrollLeftArrow:images"),0,0,0,color,cpg)
		dxDrawImageSection(cpxx+upArrowW,cpyy,cw+getElementData(cTheme,"ScrollbarThumb:Width")-upArrowW-downArrowW,ch,
			getElementData(cTheme,"HorzScrollContainer:X"),getElementData(cTheme,"HorzScrollContainer:Y"),
			getElementData(cTheme,"HorzScrollContainer:Width"),getElementData(cTheme,"HorzScrollContainer:Height"),
			getElementData(cTheme,"HorzScrollContainer:images"),0,0,0,color,cpg)
		
		dxDrawImageSection(cpxx+upArrowW+cw+getElementData(cTheme,"ScrollbarThumb:Width")-upArrowW-downArrowW,cpyy,downArrowW,ch,
			getElementData(cTheme,"ScrollRightArrow:X"),getElementData(cTheme,"ScrollRightArrow:Y"),
			getElementData(cTheme,"ScrollRightArrow:Width"),getElementData(cTheme,"ScrollRightArrow:Height"),
			getElementData(cTheme,"ScrollRightArrow:images"),0,0,0,color,cpg)
		
		local ratio = dxScrollBarGetScrollPercent(component)/50
		local xScroll = cpxx+upArrowW+((cw-downArrowW-upArrowW)/2)*ratio
		local c = (ch-getElementData(cTheme,"ScrollbarThumb:Height"))/2
		dxDrawImageSection(xScroll,cpyy+c,getElementData(cTheme,"ScrollbarThumb:Width"),getElementData(cTheme,"ScrollbarThumb:Height"),
			getElementData(cTheme,"ScrollbarThumb:X"),getElementData(cTheme,"ScrollbarThumb:Y"),
			getElementData(cTheme,"ScrollbarThumb:Width"),getElementData(cTheme,"ScrollbarThumb:Height"),
			getElementData(cTheme,"ScrollbarThumb:images"),0,0,0,color,cpg)
	end
end
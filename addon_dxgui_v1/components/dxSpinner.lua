--[[
/***************************************************************************************************************
*
*  PROJECT:     dxGUI
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        components/dxButton.lua
*  PURPOSE:     All spinner functions.
*  DEVELOPERS:  Skyline <xtremecooker@gmail.com>
*
*  dxGUI is available from http://community.mtasa.com/index.php?p=resources&s=details&id=4871
*
****************************************************************************************************************/
]]
-- // Initializing
function dxCreateSpinner(resource,x,y,width,height,parent,color,defaultPos,min_,max_,theme)
	if not x or not y or not width or not height then
		outputDebugString("dxCreateSpinner gets wrong parameters (x,y,width,height[parent=dxGetRootPane(),color=black,defaultPos=0,min=0,max=100,font=default,theme=dxGetDefaultTheme()])")
		return
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
	
	if not defaultPos then
		defaultPos = 0
	end
	
	if not min_ then
		min_ = 0
	end
	
	if not max_ then
		max_ = 100
	end
	
	if not theme then
		theme = dxGetDefaultTheme()
	end
	
	if type(theme) == "string" then
		theme = dxGetTheme(theme)
	end
	
	if not theme then
		outputDebugString("dxCreateSpinner didn't find the main theme.")
		return false
	end
	
	local spinner = createElement("dxSpinner")
	setElementParent(spinner,parent)
	setElementData(spinner,"resource",resource)
	setElementData(spinner,"x",x)
	setElementData(spinner,"y",y)
	setElementData(spinner,"width",width)
	setElementData(spinner,"height",height)
	setElementData(spinner,"max",max_)
	setElementData(spinner,"position",defaultPos)
	setElementData(spinner,"min",min_)
	setElementData(spinner,"theme",theme)
	setElementData(spinner,"color",color)
	setElementData(spinner,"font",font)
	setElementData(spinner,"visible",true)
	setElementData(spinner,"hover",false)
	setElementData(spinner,"parent",parent)
	setElementData(spinner,"container",false)
	setElementData(spinner,"postGUI",false)
	setElementData(spinner,"ZOrder",getElementData(parent,"ZIndex")+1)
	setElementData(parent,"ZIndex",getElementData(parent,"ZIndex")+1)
	return spinner
end
-- // Functions
function dxSpinnerGetPosition(dxElement)
	if not dxElement then
		outputDebugString("dxSpinnerGetPosition gets wrong parameters.(dxElement)")
		return
	end
	if (getElementType(dxElement)~="dxSpinner") then
		outputDebugString("dxSpinnerGetPosition gets wrong parameters.(dxElement must be dxSpinner)")
		return
	end
	return getElementData(dxElement,"position")
end

function dxSpinnerSetPosition(dxElement,pos)
	if not dxElement or not pos then
		outputDebugString("dxSpinnerSetMax gets wrong parameters.(dxElement,pos)")
		return
	end
	if (getElementType(dxElement)~="dxSpinner") then
		outputDebugString("dxSpinnerSetMax gets wrong parameters.(dxElement must be dxSpinner)")
		return
	end
	if (pos <= getElementData(dxElement,"max") and pos >= getElementData(dxElement,"min")) then
		setElementData(dxElement,"position",pos)
		triggerEvent("onClientDXSpin",dxElement,pos)
		return true
	end
	return false
end

function dxSpinnerGetMax(dxElement)
	if not dxElement then
		outputDebugString("dxSpinnerGetMax gets wrong parameters.(dxElement)")
		return
	end
	if (getElementType(dxElement)~="dxSpinner") then
		outputDebugString("dxSpinnerGetMax gets wrong parameters.(dxElement must be dxSpinner)")
		return
	end
	return getElementData(dxElement,"max")
end

function dxSpinnerSetMax(dxElement,max_)
	if not dxElement or not max_ then
		outputDebugString("dxSpinnerSetMax gets wrong parameters.(dxElement,max)")
		return
	end
	if (getElementType(dxElement)~="dxSpinner") then
		outputDebugString("dxSpinnerSetMax gets wrong parameters.(dxElement must be dxSpinner)")
		return
	end
	setElementData(dxElement,"max",max_)
	if ( dxSpinnerGetPosition(dxElement) > max_ ) then
		dxSpinnerSetPosition(dxElement,max_)
	end
	return true
end

function dxSpinnerGetMin(dxElement)
	if not dxElement then
		outputDebugString("dxSpinnerGetMin gets wrong parameters.(dxElement)")
		return
	end
	if (getElementType(dxElement)~="dxSpinner") then
		outputDebugString("dxSpinnerGetMin gets wrong parameters.(dxElement must be dxSpinner)")
		return
	end
	return getElementData(dxElement,"min")
end

function dxSpinnerSetMin(dxElement,min_)
	if not dxElement or not min_ then
		outputDebugString("dxSpinnerSetMin gets wrong parameters.(dxElement,min)")
		return
	end
	if (getElementType(dxElement)~="dxSpinner") then
		outputDebugString("dxSpinnerSetMin gets wrong parameters.(dxElement must be dxSpinner)")
		return
	end
	setElementData(dxElement,"min",min_)
	if ( dxSpinnerGetPosition(dxElement) < min_ ) then
		dxSpinnerSetPosition(dxElement,min_)
	end
	return true
end

function dxSpinnerRefresh(element)
	if (getElementData(element,"clicked")) then
		if (getElementData(element,"increasing")) then
			dxSpinnerSetPosition(element,dxSpinnerGetPosition(element)+1)
			setElementData(element,"increasing",false)
			setElementData(element,"increasing",false)
			setElementData(element,"increaseRender",true)
			incControl = function(elm)
				if (getElementData(elm,"increaseRender")) then
					setElementData(elm,"increasing",true)
				end
			end
			setTimer(incControl,100,1,element)
		end
		
		if (getElementData(element,"reducing")) then
			dxSpinnerSetPosition(element,dxSpinnerGetPosition(element)-1)
			setElementData(element,"reducing",false)
			setElementData(element,"reduceRender",true)
			reduceControl = function(elm)
				if (getElementData(elm,"reduceRender")) then
					setElementData(elm,"reducing",true)
				end
			end
			setTimer(reduceControl,100,1,element)
		end
	end
end

function dxSpinnersRefresh()
	for _,element in ipairs(getElementsByType("dxSpinner")) do
		dxSpinnerRefresh(element)
	end
end

-- // Events
addEventHandler("onClientDXClick",getRootElement(),function(button,state,absoluteX,absoluteY,worldX,worldY,worldZ,clickedWorld)
	local spinner = source
	if (button == "left" and state=="down") then
		setElementData(spinner,"clicked",false)
		setElementData(spinner,"increasing",false)
		setElementData(spinner,"increaseRender",false)
		setElementData(spinner,"reducing",false)
		setElementData(spinner,"reduceRender",false)
			
		local x,y = dxGetPosition(spinner)
		local parent = getElementParent(spinner)
		local px,py = getElementData(parent,"x"),getElementData(parent,"y")
		local rx,ry = px+x,py+y
		local w,h = dxGetSize(spinner)
		local cTheme = dxGetElementTheme(spinner)
		local optWidth = getElementData(cTheme,"SpinnerIncBackground:Width")	
		if (intersect(rx,ry,rx+w,ry+h,absoluteX,absoluteY)) then
			setElementData(spinner,"clicked",true)
		end
		
		if (intersect(rx+w-optWidth,ry,rx+w,ry+(h/2),absoluteX,absoluteY)) then
			setElementData(spinner,"increasing",true)
		end
		
		if (intersect(rx+w-optWidth,ry+(h/2),rx+w,ry+h,absoluteX,absoluteY)) then
			setElementData(spinner,"reducing",true)
		end
	end
end)

addEventHandler("onClientClick",getRootElement(),function(button,state,absoluteX,absoluteY,worldX,worldY,worldZ,clickedWorld)
	if (button=="left" and state=="up") then
		for _,spinner in ipairs(getElementsByType("dxSpinner")) do
			setElementData(spinner,"increasing",false)
			setElementData(spinner,"increaseRender",false)
			setElementData(spinner,"reducing",false)
			setElementData(spinner,"reduceRender",false)
		end
	end
end)

-- // Render

function dxSpinnerRender(component,cpx,cpy,cpg)
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
	local optWidth = getElementData(cTheme,"SpinnerIncBackground:Width")	
	
	dxDrawImageSection(cpxx,cpyy,cw-optWidth,ch,
		getElementData(cTheme,"SpinnerBackground:X"),getElementData(cTheme,"SpinnerBackground:Y"),
		getElementData(cTheme,"SpinnerBackground:Width"),getElementData(cTheme,"SpinnerBackground:Height"),
		getElementData(cTheme,"SpinnerBackground:images"),0,0,0,tocolor(255,255,255), cpg)
		
	dxDrawImageSection(cpxx+cw-optWidth,cpyy,optWidth,ch,
		getElementData(cTheme,"SpinnerIncBackground:X"),getElementData(cTheme,"SpinnerIncBackground:Y"),
		getElementData(cTheme,"SpinnerIncBackground:Width"),getElementData(cTheme,"SpinnerIncBackground:Height"),
		getElementData(cTheme,"SpinnerIncBackground:images"),0,0,0,tocolor(255,255,255), cpg)
	local str = tostring(dxSpinnerGetPosition(component))
	if ( dxSpinnerGetPosition(component) == dxSpinnerGetMin(component) ) then
		str = "#FF0000"..str
	elseif ( dxSpinnerGetPosition(component) == dxSpinnerGetMax(component) ) then
		str = "#FF0000"..str
	end
	dxDrawColorText(tostring(str),cpxx,cpyy,cpxx+(cw-optWidth),cpyy+ch,color,1,font,"right","center",true,false,cpg)
end

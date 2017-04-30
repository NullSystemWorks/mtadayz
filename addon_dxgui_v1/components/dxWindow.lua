--[[
/***************************************************************************************************************
*
*  PROJECT:     dxGUI
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        components/dxButton.lua
*  PURPOSE:     All window functions.
*  DEVELOPERS:  Skyline <xtremecooker@gmail.com>
*
*  dxGUI is available from http://community.mtasa.com/index.php?p=resources&s=details&id=4871
*
****************************************************************************************************************/
]]
-- // Initializing
function dxCreateWindow(resource,x,y,width,height,title,color,font,theme)
	if not x or not y or not width or not height or not title then
		outputDebugString("dxCreateWindow gets wrong parameters. (x,y,width,height,title,[color=white,font=default,theme=dxGetDefaultTheme()]")
		return false
	end
	
	if not color then
		color = tocolor(255,255,255,255)
	end
	
	if not font then
		font = "default"
	end
	
	if not theme then
		theme = dxGetDefaultTheme()
	end
	
	if type(theme) == "string" then
		theme = dxGetTheme(theme)
	end
	
	if not theme then
		outputDebugString("dxCreateWindow didn't find the main theme.")
		return false
	end
	local parent = dxGetRootPane()
	local window = createElement("dxWindow")
	setElementParent(window,dxGetRootPane())
	setElementData(window,"resource",resource)
	setElementData(window,"x",x)
	setElementData(window,"y",y)
	setElementData(window,"Title:visible",true)
	setElementData(window,"Title:x",x)
	setElementData(window,"Title:y",y)
	setElementData(window,"colorcoded",false)
	setElementData(window,"width",width)
	setElementData(window,"height",height)
	setElementData(window,"text",title)
	setElementData(window,"color",color)
	setElementData(window,"font",font)
	setElementData(window,"theme",theme)
	setElementData(window,"visible",true)
	setElementData(window,"clicked",false)
	setElementData(window,"movable",true)
	setElementData(window,"isMoving",false)
	setElementData(window,"container",true)
	setElementData(window,"postGUI",false)
	setElementData(window,"ZIndex",0)
	setElementData(window,"ZOrder",getElementData(parent,"ZIndex")+1)
	setElementData(parent,"ZIndex",getElementData(parent,"ZIndex")+1)
	return window
end

-- // Functions
function dxWindowGetTitlePosition(dxElement,relative)
	if not dxElement then
		outputDebugString("dxWindowGetTitlePosition gets wrong parameters (dxElement[,relative=false])")
		return
	end
	if (getElementType(dxElement)~="dxWindow") then
		outputDebugString("dxWindowGetTitlePosition gets wrong parameters (dxElement must be dxWindow)")
		return
	end

	local tx,ty = getElementData(dxElement,"Title:x"),getElementData(dxElement,"Title:y")
	local px,py = getElementData(getElementParent(dxElement),"width"),getElementData(getElementParent(dxElement),"height")
	if relative then
		return tx/px,ty/py
	else
		return tx,ty
	end
end

function dxWindowSetTitlePosition(dxElement,x,y,relative)
	if not dxElement or not x or not y then
		outputDebugString("dxGetPosition gets wrong parameters (dxElement,x,y[,relative=false])")
		return
	end
	if (getElementType(dxElement)~="dxWindow") then
		outputDebugString("dxGetPosition gets wrong parameters (dxElement must be dxWindow)")
		return
	end

	local px,py = getElementData(getElementParent(dxElement),"width"),getElementData(getElementParent(dxElement),"height")
	if relative then
		setElementData(dxElement,"Title:x",x*px)
		setElementData(dxElement,"Title:y",y*py)
	else
		setElementData(dxElement,"Title:x",x)
		setElementData(dxElement,"Title:y",y)
	end
	triggerEvent("onClientDXPropertyChanged",dxElement,"titleposition",x,y,relative)
end

function dxWindowGetMovable(dxWindow)
	if not dxWindow  then
		outputDebugString("dxGetMovable gets wrong parameters (dxWindow)")
		return
	end
	if (getElementType(dxWindow) ~= "dxWindow") then
		outputDebugString("dxWindowSetMovable gets wrong parameters (dxElement must be dxWindow)")
		return
	end
	return getElementData(dxWindow,"movable")
end

function dxWindowIsMoving(dxWindow)
	if not dxWindow  then
		outputDebugString("dxIsMoving gets wrong parameters (dxWindow)")
		return
	end
	if (getElementType(dxWindow) ~= "dxWindow") then
		outputDebugString("dxWindowSetMovable gets wrong parameters (dxElement must be dxWindow)")
		return
	end
	return getElementData(dxWindow,"isMoving")
end

function dxWindowSetMovable(dxWindow,movable)
	if not dxWindow or movable == nil then
		outputDebugString("dxWindowSetMovable gets wrong parameters (dxWindow,movable)")
		return
	end
	if (getElementType(dxWindow) ~= "dxWindow") then
		outputDebugString("dxWindowSetMovable gets wrong parameters (dxElement must be dxWindow)")
		return
	end
	setElementData(dxWindow,"movable",movable)
	triggerEvent("onClientDXPropertyChanged",dxElement,"movable",movable)
end

function dxWindowSetTitleVisible(dxElement,visible)
	if not dxElement or visible == nil  then
		outputDebugString("dxWindowSetTitleVisible gets wrong parameters (dxElement,visible)")
		return
	end
	setElementData(dxElement,"Title:visible",visible)
	triggerEvent("onClientDXPropertyChanged",dxElement,"titlevisible",visible)
end

function dxWindowGetTitleVisible(dxElement)
	if not dxElement then
		outputDebugString("dxWindowGetTitleVisible gets wrong parameters (dxElement)")
		return
	end
	return getElementData(dxElement,"Title:visible")
end

-- // Deprecated Functions
function dxWindowSetPostGUI(dxElement,postGUI)
	dxDeprecatedFunction("dxWindowSetPostGUI","dxSetAlwaysOnTop")
	if not dxElement or getElementType(dxElement) ~= "dxWindow" or postGUI==nil then
		outputDebugString("dxWindowSetPostGUI gets wrong parameters.(dxWindow,postGUI)")
		return
	end
	setElementData(dxElement,"postGUI",postGUI)
end

function dxWindowGetPostGUI(dxElement)
	dxDeprecatedFunction("dxWindowGetPostGUI","dxGetAlwaysOnTop")
	if not dxElement or getElementType(dxElement) ~= "dxWindow" then
		outputDebugString("dxWindowSetPostGUI gets wrong parameters.(dxWindow)")
		return
	end
	local postgui = getElementData(dxElement,"postGUI")
	if (postgui == nil) then return false end
	return postgui
end

-- // Events 
addEventHandler("onClientClick",getRootElement(),
	function(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedWorld)
		if (button == "left" and state=="down") then
			for _,wnd in ipairs(getElementsByType("dxWindow")) do
				if dxGetVisible(wnd) and getElementData(getElementParent(wnd),"visible") then
					setElementData(wnd,"isMoving",false)
					local x,y = getElementData(wnd,"x"),getElementData(wnd,"y")
					local tx,ty = getElementData(wnd,"Title:x"),getElementData(wnd,"Title:y")
					local width = getElementData(wnd,"width")
					local theme = getElementData(wnd,"theme")
					local height = getElementData(theme,"TitleBarTopRight:Height")
					if getElementData(wnd,"clicked") and (intersect(tx,ty,tx+width,ty+height,absoluteX,absoluteY)) then
						if getElementData(wnd,"movable") then
							setElementData(wnd,"isMoving",true)
							setElementData(wnd,"Move:x",absoluteX-getElementData(wnd,"Title:x"))
							setElementData(wnd,"Move:y",absoluteY-getElementData(wnd,"Title:y"))
						end
					end
				end
			end
		end
		
		if (button == "left" and state=="up") then
			for _,wnd in ipairs(getElementsByType("dxWindow")) do
				if (getElementData(wnd,"isMoving")) then
					local x,y,tx,ty = dxGetPosition(wnd)
					triggerEvent('onClientDXMove',wnd,x,y,tx,ty)
				end
				setElementData(wnd,"isMoving",false)
				setElementData(wnd,"Move:x",false)
				setElementData(wnd,"Move:y",false)
			end
		end
	end)

-- // Render Functions
function dxWindowMoveControl(element)
	if (isCursorShowing()) and getElementData(element,"movable") and getElementData(element,"isMoving") then
		local x,y = getCursorAbsolute()
		setElementData(element,"Title:x",x-getElementData(element,"Move:x"))
		setElementData(element,"Title:y",y-getElementData(element,"Move:y"))
		setElementData(element,"x",x-getElementData(element,"Move:x"))
		setElementData(element,"y",y-getElementData(element,"Move:y"))
	end
end
function dxWindowRender(element)
	dxWindowMoveControl(element)
	
	-- // Property initializing
	local w,h = dxGetSize(element)
	local x,y,titlex,titley = dxGetPosition(element)
	local title,color = dxGetText(element),getElementData(element,"color")
	local theme,font = getElementData(element,"theme"),getElementData(element,"font")
	local cpg = dxGetAlwaysOnTop(element)
	if (getElementData(element,"Title:visible")) then
		local clickedset = ""
		if ( getElementData(element,"clicked") ) then clickedset = "Selected" end 
		local titleHeight = getElementData(theme,"TitleBarBackground:Height")
		titleHeight = math.max(titleHeight,22)
		dxDrawImageSection(titlex,titley,
			getElementData(theme,"TitleBarTopLeft"..clickedset..":Width"),getElementData(theme,"TitleBarTopLeft"..clickedset..":Height"),
			getElementData(theme,"TitleBarTopLeft"..clickedset..":X"),getElementData(theme,"TitleBarTopLeft"..clickedset..":Y"),
			getElementData(theme,"TitleBarTopLeft"..clickedset..":Width"),getElementData(theme,"TitleBarTopLeft"..clickedset..":Height"),
			getElementData(theme,"TitleBarTopLeft"..clickedset..":images"),0,0,0,color,cpg)
			
		dxDrawImageSection(titlex+getElementData(theme,"TitleBarTopLeft"..clickedset..":Width"),titley,
			w-getElementData(theme,"TitleBarTopLeft"..clickedset..":Width")-getElementData(theme,"TitleBarTopRight"..clickedset..":Width"),
			getElementData(theme,"TitleBarTopLeft"..clickedset..":Height"),
			getElementData(theme,"TitleBarBackground"..clickedset..":X"),getElementData(theme,"TitleBarBackground"..clickedset..":Y"),
			getElementData(theme,"TitleBarBackground"..clickedset..":Width"),getElementData(theme,"TitleBarBackground"..clickedset..":Height"),
			getElementData(theme,"TitleBarBackground"..clickedset..":images"),0,0,0,color,cpg)
		
		dxDrawImageSection(titlex+w-getElementData(theme,"TitleBarTopRight"..clickedset..":Width"),titley,
			getElementData(theme,"TitleBarTopRight"..clickedset..":Width"),getElementData(theme,"TitleBarTopRight"..clickedset..":Height"),
			getElementData(theme,"TitleBarTopRight"..clickedset..":X"),getElementData(theme,"TitleBarTopRight"..clickedset..":Y"),
			getElementData(theme,"TitleBarTopRight"..clickedset..":Width"),getElementData(theme,"TitleBarTopRight"..clickedset..":Height"),
			getElementData(theme,"TitleBarTopRight"..clickedset..":images"),0,0,0,color,cpg)
		local funct = dxDrawText
		if (dxGetColorCoded(element)) then funct = dxDrawColorText end
		local textWidth = 0
		if (dxGetColorCoded(element)) then
			textWidth = dxGetTextWidth(title:gsub("#%x%x%x%x%x%x", ""),1,font)
		else
			textWidth = dxGetTextWidth(title,1,font)
		end
		if textWidth > w-50 then
			while textWidth>w-50 do
				title = title:sub(1,title:len()-6).."..."
				if (dxGetColorCoded(element)) then
					textWidth = dxGetTextWidth(title:gsub("#%x%x%x%x%x%x", ""),1,font)
				else
					textWidth = dxGetTextWidth(title,1,font)
				end
			end
		end
		funct(title,titlex+25,titley,titlex+25+w-50,titley+titleHeight,color,1,font,"center","center",true,false,cpg)
	end
	-- // Drawing Component Pane
	local hex = tostring(toHex(color))
	hex = hex:gsub("(..)(......)","%2%1")
	local r,g,b,a = getColorFromString("#"..hex)
	if (a > 20) then
		a = a-20
	end

	local leftw = getElementData(theme,"Frame2Left:Width")
	local rightw = getElementData(theme,"Frame2Right:Width")
	dxDrawImageSection(x+leftw,y+getElementData(theme,"TitleBarTopLeft:Height")-1,w-leftw-rightw,getElementData(theme,"Frame2Top:Height"),
			getElementData(theme,"Frame2Top:X"),getElementData(theme,"Frame2Top:Y"),
			getElementData(theme,"Frame2Top:Width"),getElementData(theme,"Frame2Top:Height"),
			getElementData(theme,"Frame2Top:images"),0,0,0,tocolor(r,g,b,a),cpg)
	dxDrawImageSection(x,y+getElementData(theme,"TitleBarTopLeft:Height")-1,leftw,h+getElementData(theme,"Frame2Top:Height"),
			getElementData(theme,"Frame2Left:X"),getElementData(theme,"Frame2Left:Y"),
			getElementData(theme,"Frame2Left:Width"),getElementData(theme,"Frame2Left:Height"),
			getElementData(theme,"Frame2Left:images"),0,0,0,tocolor(r,g,b,a),cpg)
	dxDrawImageSection(x+leftw,y+getElementData(theme,"TitleBarTopLeft:Height")-1+getElementData(theme,"Frame2Top:Height"),w-leftw-rightw,h,
			getElementData(theme,"Frame2Background:X"),getElementData(theme,"Frame2Background:Y"),
			getElementData(theme,"Frame2Background:Width"),getElementData(theme,"Frame2Background:Height"),
			getElementData(theme,"Frame2Background:images"),0,0,0,tocolor(r,g,b,a),cpg)
	dxDrawImageSection(x+(w-leftw),y+getElementData(theme,"TitleBarTopLeft:Height")-1,rightw,h+getElementData(theme,"Frame2Top:Height"),
			getElementData(theme,"Frame2Right:X"),getElementData(theme,"Frame2Right:Y"),
			getElementData(theme,"Frame2Right:Width"),getElementData(theme,"Frame2Right:Height"),
			getElementData(theme,"Frame2Right:images"),0,0,0,tocolor(r,g,b,a),cpg)
	dxDrawImageSection(x,y+getElementData(theme,"TitleBarTopLeft:Height")-1+h+getElementData(theme,"Frame2Top:Height"),getElementData(theme,"Frame2BottomLeft:Width"),getElementData(theme,"Frame2BottomLeft:Height"),
			getElementData(theme,"Frame2BottomLeft:X"),getElementData(theme,"Frame2BottomLeft:Y"),
			getElementData(theme,"Frame2BottomLeft:Width"),getElementData(theme,"Frame2BottomLeft:Height"),
			getElementData(theme,"Frame2BottomLeft:images"),0,0,0,tocolor(r,g,b,a),cpg)
	dxDrawImageSection(x+getElementData(theme,"Frame2BottomLeft:Width"),y+getElementData(theme,"Frame2Top:Height")+getElementData(theme,"TitleBarTopLeft:Height")-1+h,w-getElementData(theme,"Frame2BottomLeft:Width")-getElementData(theme,"Frame2BottomRight:Width"),getElementData(theme,"Frame2Bottom:Height"),
			getElementData(theme,"Frame2Bottom:X"),getElementData(theme,"Frame2Bottom:Y"),
			getElementData(theme,"Frame2Bottom:Width"),getElementData(theme,"Frame2Bottom:Height"),
			getElementData(theme,"Frame2Bottom:images"),0,0,0,tocolor(r,g,b,a),cpg)
	dxDrawImageSection(x+(w-leftw),y+getElementData(theme,"TitleBarTopLeft:Height")-1+h+getElementData(theme,"Frame2Top:Height"),getElementData(theme,"Frame2BottomRight:Width"),getElementData(theme,"Frame2BottomRight:Height"),
			getElementData(theme,"Frame2BottomRight:X"),getElementData(theme,"Frame2BottomRight:Y"),
			getElementData(theme,"Frame2BottomRight:Width"),getElementData(theme,"Frame2BottomRight:Height"),
			getElementData(theme,"Frame2BottomRight:images"),0,0,0,tocolor(r,g,b,a),cpg)
			
	dxWindowComponentRender(element)
end

function dxWindowComponentRender(element)
	local w,h = dxGetSize(element)
	local x,y,titlex,titley = dxGetPosition(element)
	local title,color = dxGetText(element),getElementData(element,"color")
	local theme,font = getElementData(element,"theme"),getElementData(element,"font")
	local cpg = dxGetAlwaysOnTop(element)
	for _,aElements in ipairs(attachedElements) do
		if ( aElements[1] == element ) then
			guiSetPosition(aElements[2],x+aElements[3],y+aElements[4],false)
		end
	end
	local comps = getElementChildren(element)
	table.sort(comps,function(a,b)
		return (dxGetZOrder(a) < dxGetZOrder(b))
	end)
	for _,component in ipairs(comps) do
		if (dxGetVisible(component)) then
			for _,aElements in ipairs(attachedElements) do
				if ( aElements[1] == component ) then
					guiSetPosition(aElements[2],cpx+cx+aElements[3],cpy+cy+aElements[4],false)
				end
			end
			
			-- Type renderer
			local eType = getElementType(component)
			
			if ( eType == "dxButton" ) then
				dxButtonRender(component,x,y,cpg)
			elseif (eType == "dxCheckBox") then
				dxCheckBoxRender(component,x,y,cpg)
			elseif (eType == "dxRadioButton") then
				dxRadioButtonRender(component,x,y,cpg)
			elseif (eType == "dxLabel") then
				dxLabelRender(component,x,y,cpg)
			elseif (eType == "dxStaticImage") then
				dxStaticImageRender(component,x,y,cpg)
			elseif (eType == "dxProgressBar") then
				dxProgressBarRender(component,x,y,cpg)
			elseif (eType == "dxScrollBar") then
				dxScrollBarRender(component,x,y,cpg)
			elseif (eType == "dxSpinner") then
				dxSpinnerRender(component,x,y,cpg)
			elseif (eType == "dxList") then
				dxListRender(component,x,y,cpg)
			end
		end
	end
end
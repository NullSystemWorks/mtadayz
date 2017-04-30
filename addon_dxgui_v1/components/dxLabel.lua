--[[
/***************************************************************************************************************
*
*  PROJECT:     dxGUI
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        components/dxLabel.lua
*  PURPOSE:     All label functions.
*  DEVELOPERS:  Skyline <xtremecooker@gmail.com>
*
*  dxGUI is available from http://community.mtasa.com/index.php?p=resources&s=details&id=4871
*
****************************************************************************************************************/
]]
-- // Initializing
function dxCreateLabel(resource,x,y,width,height,text,parent,color,font,scale,alignX,alignY,colorCoded)
	if not x or not y or not width or not height or not text then
		outputDebugString("dxCreateLabel gets wrong parameters (dxElement,x,y,width,height[,parent=dxGetRootPane(),color=white,font=default,scale=1,alignX=left,alignY=top,colorCoded=false])")
		return
	end
	
	if not parent then
		parent = dxGetRootPane()
	end
	
	if not color then
		color = tocolor(255,255,255,255)
	end
	
	if not font then
		font = "default"
	end
	
	if not colorCoded then
		colorCoded = false
	end
	
	if not scale then
		scale = 1
	end
	
	if not alignX then
		alignX = "left"
	end
	
	if not alignY then
		alignY = "top"
	end
	
	local label = createElement("dxLabel")
	setElementParent(label,parent)
	setElementData(label,"resource",resource)
	setElementData(label,"x",x)
	setElementData(label,"y",y)
	setElementData(label,"width",width)
	setElementData(label,"height",height)
	setElementData(label,"text",text)
	setElementData(label,"visible",true)
	setElementData(label,"colorcoded",colorCoded)
	setElementData(label,"hover",false)
	setElementData(label,"scale",scale)
	setElementData(label,"font",font)
	setElementData(label,"alignX",alignX)
	setElementData(label,"alignY",alignY)
	setElementData(label,"parent",parent)
	setElementData(label,"container",false)
	setElementData(label,"postGUI",false)
	setElementData(label,"ZOrder",getElementData(parent,"ZIndex")+1)
	setElementData(parent,"ZIndex",getElementData(parent,"ZIndex")+1)
	return label
end
-- // Functions
function dxLabelGetScale(dxElement) 
	if not dxElement then
		outputDebugString("dxLabelGetScale gets wrong parameters.(dxElement)")
		return
	end
	if (getElementType(dxElement)~="dxLabel") then
		outputDebugString("dxLabelGetScale gets wrong parameters.(dxElement must be dxLabel)")
		return
	end
	return getElementData(dxElement,"scale")
end

function dxLabelGetHorizontalAlign(dxElement) 
	if not dxElement then
		outputDebugString("dxLabelGetHorizontalAlign gets wrong parameters.(dxElement)")
		return
	end
	if (getElementType(dxElement)~="dxLabel") then
		outputDebugString("dxLabelGetHorizontalAlign gets wrong parameters.(dxElement must be dxLabel)")
		return
	end
	return getElementData(dxElement,"alignX")
end

function dxLabelGetVerticalAlign(dxElement) 
	if not dxElement then
		outputDebugString("dxLabelGetVerticalAlign gets wrong parameters.(dxElement)")
		return
	end
	if (getElementType(dxElement)~="dxLabel") then
		outputDebugString("dxLabelGetVerticalAlign gets wrong parameters.(dxElement must be dxLabel)")
		return
	end
	return getElementData(dxElement,"alignY")
end

function dxLabelSetScale(dxElement,scale) 
	if not dxElement or not scale then
		outputDebugString("dxLabelGetScale gets wrong parameters.(dxElement,scale)")
		return
	end
	if (getElementType(dxElement)~="dxLabel") then
		outputDebugString("dxLabelGetScale gets wrong parameters.(dxElement must be dxLabel)")
		return
	end
	setElementData(dxElement,"scale",scale)
	triggerEvent("onClientDXPropertyChanged",dxElement,"scale",scale)
end

function dxLabelSetHorizontalAlign(dxElement,alignX) 
	if not dxElement or not alignX then
		outputDebugString("dxLabelGetHorizontalAlign gets wrong parameters.(dxElement,alignX)")
		return
	end
	if (getElementType(dxElement)~="dxLabel") then
		outputDebugString("dxLabelGetHorizontalAlign gets wrong parameters.(dxElement must be dxLabel)")
		return
	end
	setElementData(dxElement,"alignX",alignX)
	triggerEvent("onClientDXPropertyChanged",dxElement,"alignX",alignX)
end

function dxLabelSetVerticalAlign(dxElement,alignY) 
	if not dxElement or not alignY then
		outputDebugString("dxLabelGetVerticalAlign gets wrong parameters.(dxElement,alignY)")
		return
	end
	if (getElementType(dxElement)~="dxLabel") then
		outputDebugString("dxLabelGetVerticalAlign gets wrong parameters.(dxElement must be dxLabel)")
		return
	end
	setElementData(dxElement,"alignY",alignY)
	triggerEvent("onClientDXPropertyChanged",dxElement,"alignY",alignY)
end

-- // Render
function dxLabelRender(component,cpx,cpy,cpg)
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
	local title,font = dxGetText(component),dxGetFont(component)
	local tx = cx
	local th = ch					
	local textX = cpx+cx
	local textY = cpy+cy
	local tw = getElementData(getElementParent(component),"width")-(textX-getElementData(getElementParent(component),"x"))
	local scale = dxLabelGetScale(component)
	local textWidth = dxGetTextWidth(title,scale,font)
	if (dxGetColorCoded(component)) then
		textWidth = dxGetTextWidth(title:gsub("#%x%x%x%x%x%x",""),scale,font)
	else
		textWidth = dxGetTextWidth(title,scale,font)
	end
	if textWidth > tw then
		while textWidth>tw do
			title = title:sub(1,title:len()-1)
			if (dxGetColorCoded(component)) then
				textWidth = dxGetTextWidth(title:gsub("#%x%x%x%x%x%x",""),scale,font)
			else
				textWidth = dxGetTextWidth(title,scale,font)
			end
		end
	end
	local alignX,alignY = dxLabelGetHorizontalAlign(component),
		dxLabelGetVerticalAlign(component)
	
	if (dxGetColorCoded(component)) then
		dxDrawColorText(title,textX,textY,textX+textWidth,textY+ch,color,scale,font,alignX,alignY,true,true,cpg)
	else
		dxDrawText(title,textX,textY,textX+textWidth,textY+ch,color,scale,font,alignX,alignY,true,true,cpg)
	end
end

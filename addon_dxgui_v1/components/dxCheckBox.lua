--[[
/***************************************************************************************************************
*
*  PROJECT:     dxGUI
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        components/dxCheckBox.lua
*  PURPOSE:     All checkbox functions.
*  DEVELOPERS:  Skyline <xtremecooker@gmail.com>
*
*  dxGUI is available from http://community.mtasa.com/index.php?p=resources&s=details&id=4871
*
****************************************************************************************************************/
]]
-- // Initializing
function dxCreateCheckBox(resource,x,y,width,height,text,parent,selected,color,font,theme)
	if not x or not y or not width or not height or not text then
		outputDebugString("dxCreateCheckBox gets wrong parameters (dxElement,x,y,width,height[,parent=dxGetRootPane(),selected=false,color=white,font=default,theme=dxGetDefaultTheme()])")
		return
	end
	
	if not selected then
		selected = false
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
	
	if not theme then
		theme = dxGetDefaultTheme()
	end
	
	if type(theme) == "string" then
		theme = dxGetTheme(theme)
	end
	
	if not theme then
		outputDebugString("dxCreateCheckBox didn't find the main theme.")
		return false
	end
	
	local checkbox = createElement("dxCheckBox")
	setElementParent(checkbox,parent)
	setElementData(checkbox,"resource",resource)
	setElementData(checkbox,"x",x)
	setElementData(checkbox,"y",y)
	setElementData(checkbox,"width",width)
	setElementData(checkbox,"height",height)
	setElementData(checkbox,"text",text)
	setElementData(checkbox,"visible",true)
	setElementData(checkbox,"colorcoded",false)
	setElementData(checkbox,"hover",false)
	setElementData(checkbox,"selected",selected)
	setElementData(checkbox,"font",font)
	setElementData(checkbox,"theme",theme)	
	setElementData(checkbox,"parent",parent)
	setElementData(checkbox,"container",false)
	setElementData(checkbox,"postGUI",false)
	setElementData(checkbox,"ZOrder",getElementData(parent,"ZIndex")+1)
	setElementData(parent,"ZIndex",getElementData(parent,"ZIndex")+1)
	return checkbox
end

-- // Functions
function dxCheckBoxGetSelected(dxElement)
	if not dxElement then
		outputDebugString("dxCheckBoxGetSelected gets wrong parameters (dxCheckBox)")
		return
	end
	if (getElementType(dxElement)) ~= "dxCheckBox" then
		outputDebugString("dxCheckBoxGetSelected gets wrong parameters (dxElement must be dxCheckBox)")
		return false
	end
	return getElementData(dxElement,"selected")
end

function dxCheckBoxSetSelected(dxElement,selected)
	if not dxElement or selected == nil then
		outputDebugString("dxCheckBoxSetSelected gets wrong parameters (dxCheckBox)")
		return
	end
	if (getElementType(dxElement)) ~= "dxCheckBox" then
		outputDebugString("dxCheckBoxSetSelected gets wrong parameters (dxElement must be dxCheckBox)")
		return
	end
	setElementData(dxElement,"selected",selected)
	triggerEvent("onClientDXPropertyChanged",dxElement,"selected",selected)
end

-- // Events
addEventHandler("onClientDXClick",getRootElement(),
	function(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedWorld)
		if (button=="left" and state=="up") and (source and getElementType(source) == "dxCheckBox") then
			local checked = not dxCheckBoxGetSelected(source)					
			triggerEvent("onClientDXChanged",source,checked)
			if not wasEventCancelled() then
				dxCheckBoxSetSelected(source,checked)
			end
		end
	end)

-- // Render
function dxCheckBoxRender(component,cpx,cpy,cpg)
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
	local checked = dxCheckBoxGetSelected(component)
	local imageset  = "CheckboxNormal"
	if not checked then
		if (getElementData(component,"hover")) then
			imageset = "CheckboxHover"--
		else
			imageset = "CheckboxMark"
		end
	else
		if (getElementData(component,"hover")) then
			imageset = "CheckboxMarkHover" -- 
		else
			imageset = "CheckboxNormal" -- 
		end
	end
	
	dxDrawImageSection(cpx+cx,cpy+cy,cw,ch,
			getElementData(cTheme,imageset..":X"),getElementData(cTheme,imageset..":Y"),
			getElementData(cTheme,imageset..":Width"),getElementData(cTheme,imageset..":Height"),
			getElementData(cTheme,imageset..":images"),0,0,0,color,cpg)
	
	local title,font = dxGetText(component),dxGetFont(component)
		
	local tx = cx
	local th = ch					
	local textHeight = dxGetFontHeight(1,font)
	local textX = cpx+cx+cw+5
	local textY = cpy+cy+((th-textHeight)/2)
	if (dxGetColorCoded(component)) then
		dxDrawColorText(title,textX,textY,textX,textY,color,1,font,"left","top",false,false,cpg)
	else
		dxDrawText(title,textX,textY,textX,textY,color,1,font,"left","top",false,false,cpg)
	end
end
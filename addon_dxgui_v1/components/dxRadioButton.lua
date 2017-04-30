--[[
/***************************************************************************************************************
*
*  PROJECT:     dxGUI
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        components/dxButton.lua
*  PURPOSE:     All radiobutton functions.
*  DEVELOPERS:  Skyline <xtremecooker@gmail.com>
*
*  dxGUI is available from http://community.mtasa.com/index.php?p=resources&s=details&id=4871
*
****************************************************************************************************************/
]]
-- // Initializing
function dxCreateRadioButton(resource,x,y,width,height,text,parent,selected,groupName,color,font,theme)
	if not x or not y or not width or not height or not text then
		outputDebugString("dxCreateRadioButton gets wrong parameters (dxElement,x,y,width,height[,parent=dxGetRootPane(),selected=false,groupName=default,color=white,font=default,theme=dxGetDefaultTheme()])")
		return
	end
	
	if not groupName then
		groupName="default"
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
	
	local radioButton = createElement("dxRadioButton")
	setElementParent(radioButton,parent)
	setElementData(radioButton,"resource",resource)
	setElementData(radioButton,"x",x)
	setElementData(radioButton,"y",y)
	setElementData(radioButton,"width",width)
	setElementData(radioButton,"height",height)
	setElementData(radioButton,"text",text)
	setElementData(radioButton,"visible",true)
	setElementData(radioButton,"colorcoded",false)
	setElementData(radioButton,"hover",false)
	setElementData(radioButton,"group",groupName)
	setElementData(radioButton,"font",font)
	setElementData(radioButton,"theme",theme)	
	setElementData(radioButton,"parent",parent)
	setElementData(radioButton,"container",false)
	setElementData(radioButton,"postGUI",false)
	setElementData(radioButton,"ZOrder",getElementData(parent,"ZIndex")+1)
	setElementData(parent,"ZIndex",getElementData(parent,"ZIndex")+1)
	dxRadioButtonSetSelected(radioButton,selected)
	return radioButton
end

-- // Functions
function dxRadioButtonGetGroup(dxElement)
	if not dxElement then
		outputDebugString("dxRadioButtonGetGroup gets wrong parameters (dxRadioButton)")
		return
	end
	if (getElementType(dxElement)) ~= "dxRadioButton" then
		outputDebugString("dxRadioButtonGetGroup gets wrong parameters (dxElement must be dxRadioButton)")
		return false
	end
	return getElementData(dxElement,"group")
end

function dxRadioButtonSetGroup(dxElement,groupName)
	if not dxElement or not groupName then
		outputDebugString("dxRadioButtonSetGroup gets wrong parameters (dxRadioButton,groupName)")
		return
	end
	if (getElementType(dxElement)) ~= "dxRadioButton" then
		outputDebugString("dxRadioButtonSetGroup gets wrong parameters (dxElement must be dxRadioButton)")
		return false
	end
	setElementData(dxElement,"group",groupName)
	triggerEvent("onClientDXPropertyChanged",dxElement,"group",group)
end

function dxRadioButtonGetSelected(dxElement)
	if not dxElement then
		outputDebugString("dxRadioButtonGetSelected gets wrong parameters (dxRadioButton)")
		return
	end
	if (getElementType(dxElement)) ~= "dxRadioButton" then
		outputDebugString("dxRadioButtonGetSelected gets wrong parameters (dxElement must be dxRadioButton)")
		return false
	end
	return getElementData(dxElement,"selected")
end

function dxRadioButtonSetSelected(dxElement,selected)
	if not dxElement or selected == nil then
		outputDebugString("dxRadioButtonSetSelected gets wrong parameters (dxRadioButton)")
		return
	end
	if (getElementType(dxElement)) ~= "dxRadioButton" then
		outputDebugString("dxRadioButtonSetSelected gets wrong parameters (dxElement must be dxRadioButton)")
		return
	end

	if selected then
		for _,element in ipairs(getElementChildren(getElementParent(dxElement))) do
			if (getElementType(element)=="dxRadioButton" and dxRadioButtonGetGroup(element) == dxRadioButtonGetGroup(dxElement)) then
				setElementData(element,"selected",false)
			end
		end
	end
	setElementData(dxElement,"selected",selected)
	triggerEvent("onClientDXPropertyChanged",dxElement,"selected",selected)
end

-- // Events
addEventHandler("onClientDXClick",getRootElement(),
	function(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedWorld)
		if (button=="left" and state=="up") and (source and getElementType(source) == "dxRadioButton") then
			triggerEvent("onClientDXChanged",source,getElementData(source,"group"))
			if not wasEventCancelled() then
				dxRadioButtonSetSelected(source,true)
			end
		end
	end)

-- // Render
function dxRadioButtonRender(component,cpx,cpy,cpg)
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
	local checked = dxRadioButtonGetSelected(component)
	local imageset  = "RadioButtonNormal"
	if not checked then
		if (getElementData(component,"hover")) then
			imageset = "RadioButtonHover"
		else
			imageset = "RadioButtonNormal"
		end
	else
		if (getElementData(component,"hover")) then
			imageset = "RadioButtonMarkHover"
		else
			imageset = "RadioButtonMark"
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
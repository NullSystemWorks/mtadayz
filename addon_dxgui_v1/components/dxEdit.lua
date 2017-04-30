--[[
/***************************************************************************************************************
*
*  PROJECT:     dxGUI
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        components/dxEdit.lua
*  PURPOSE:     All edit functions.
*  DEVELOPERS:  Skyline <xtremecooker@gmail.com>
*
*  dxGUI is available from http://community.mtasa.com/index.php?p=resources&s=details&id=4871
*
****************************************************************************************************************/
]]
-- It won't work.Because It doesn't add to the render.
function dxCreateEdit(x,y,width,height,text,placeholder,parent,color,font,theme)
	if not x or not y or not width or not height or not text then
		outputDebugString("dxCreateEdit gets wrong parameters (x,y,width,height,text[,placeholder=none,parent=dxGetRootPane(),color=white,font=default,theme=dxGetDefaultTheme()])")
		return
	end
	
	if not parent then
		parent = dxGetRootPane()
	end
	
	if not font then
		font = "default"
	end
	
	if not placeholder then
		placeholder = ""
	end
	
	if not color then
		color = tocolor(255,255,255,255)
	end
	
	if not theme then
		theme = dxGetDefaultTheme()
	end
	
	if type(theme) == "string" then
		theme = dxGetTheme(theme)
	end
	
	if not theme then
		outputDebugString("dxCreateEdit didn't find the main theme.")
		return false
	end
	
	local edit = createElement("dxEdit")
	setElementParent(edit,parent)
	setElementData(edit,"x",x)
	setElementData(edit,"y",y)
	setElementData(edit,"width",width)
	setElementData(edit,"height",height)
	setElementData(edit,"color",color)
	setElementData(edit,"font",font)
	setElementData(edit,"placeholder",placeholder)
	setElementData(edit,"theme",theme)
	setElementData(edit,"visible",true)
	setElementData(edit,"text",text)
	setElementData(edit,"hover",false)
	setElementData(edit,"parent",parent)
	setElementData(edit,"readonly",false)
	setElementData(edit,"caret",-1)
	setElementData(edit,"masked",false)
	setElementData(edit,"maxlength",-1)
	setElementData(edit,"postGUI",false)
	setElementData(edit,"ZOrder",getElementData(parent,"ZIndex")+1)
	setElementData(parent,"ZIndex",getElementData(parent,"ZIndex")+1)
	return edit
end

function dxEditGetPlaceholder(dxElement)
	if not dxElement then
		outputChatBox("dxEditGetPlaceholder gets wrong parameters(dxElement)")
		return
	end
	if getElementType(dxElement) ~= "dxEdit" then
		outputChatBox("dxEditGetPlaceholder gets wrong parameters(dxElement must be dxLabel)")
		return
	end
	return getElementData(dxElement,"placeholder")
end

function dxEditGetCaret(dxElement)
	if not dxElement then
		outputChatBox("dxEditGetCaret gets wrong parameters(dxElement)")
		return
	end
	if getElementType(dxElement) ~= "dxEdit" then
		outputChatBox("dxEditGetCaret gets wrong parameters(dxElement must be dxLabel)")
		return
	end
	return getElementData(dxElement,"caret")
end

function dxEditIsReadOnly(dxElement)
	if not dxElement then
		outputChatBox("dxEditIsReadOnly gets wrong parameters(dxElement)")
		return
	end
	if getElementType(dxElement) ~= "dxEdit" then
		outputChatBox("dxEditIsReadOnly gets wrong parameters(dxElement must be dxLabel)")
		return
	end
	return getElementData(dxElement,"readonly")
end

function dxEditIsMasked(dxElement)
	if not dxElement then
		outputChatBox("dxEditIsMasked gets wrong parameters(dxElement)")
		return
	end
	if getElementType(dxElement) ~= "dxEdit" then
		outputChatBox("dxEditIsMasked gets wrong parameters(dxElement must be dxLabel)")
		return
	end
	return getElementData(dxElement,"masked")
end

function dxEditGetMaxLength(dxElement)
	if not dxElement then
		outputChatBox("dxEditGetMaxLength gets wrong parameters(dxElement)")
		return
	end
	if getElementType(dxElement) ~= "dxEdit" then
		outputChatBox("dxEditGetMaxLength gets wrong parameters(dxElement must be dxLabel)")
		return
	end
	return getElementData(dxElement,"maxlength")
end

--
function dxEditSetPlaceholder(dxElement,placeholder)
	if not dxElement or not placeholder then
		outputChatBox("dxEditSetPlaceholder gets wrong parameters(dxElement,placeholder)")
		return
	end
	if getElementType(dxElement) ~= "dxEdit" then
		outputChatBox("dxEditSetPlaceholder gets wrong parameters(dxElement must be dxLabel)")
		return
	end
	setElementData(dxElement,"placeholder",placeholder)
end

function dxEditSetCaret(dxElement,caret)
	if not dxElement or not caret then
		outputChatBox("dxEditSetCaret gets wrong parameters(dxElement,caret)")
		return
	end
	if getElementType(dxElement) ~= "dxEdit" then
		outputChatBox("dxEditSetCaret gets wrong parameters(dxElement must be dxLabel)")
		return
	end
	setElementData(dxElement,"caret",caret)
end

function dxEditSetReadOnly(dxElement,readonly)
	if not dxElement or readonly == nil then
		outputChatBox("dxEditSetReadOnly gets wrong parameters(dxElement,readonly)")
		return
	end
	if getElementType(dxElement) ~= "dxEdit" then
		outputChatBox("dxEditSetReadOnly gets wrong parameters(dxElement must be dxLabel)")
		return
	end
	setElementData(dxElement,"readonly",readonly)
end

function dxEditSetMasked(dxElement,masked)
	if not dxElement or masked == nil then
		outputChatBox("dxEditSetMasked gets wrong parameters(dxElement)")
		return
	end
	if getElementType(dxElement) ~= "dxEdit" then
		outputChatBox("dxEditSetMasked gets wrong parameters(dxElement must be dxLabel)")
		return
	end
	setElementData(dxElement,"masked",masked)
end

function dxEditSetMaxLength(dxElement,maxlen)
	if not dxElement or not maxlen then
		outputChatBox("dxEditSetMaxLength gets wrong parameters(dxElement,maxlength)")
		return
	end
	if getElementType(dxElement) ~= "dxEdit" then
		outputChatBox("dxEditSetMaxLength gets wrong parameters(dxElement must be dxLabel)")
		return
	end
	setElementData(dxElement,"maxlength",maxlength)
end
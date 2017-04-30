--[[
/***************************************************************************************************************
*
*  PROJECT:     dxGUI
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        dxGetter.lua
*  PURPOSE:     All shared getter functions.
*  DEVELOPERS:  Skyline <xtremecooker@gmail.com>
*
*  dxGUI is available from http://community.mtasa.com/index.php?p=resources&s=details&id=4871
*
****************************************************************************************************************/
]]
function dxGetPosition(dxElement,relative)
	if not dxElement then
		outputDebugString("dxGetPosition gets wrong parameters (dxElement[,relative=false]")
		return
	end
	local x,y = getElementData(dxElement,"x"),getElementData(dxElement,"y")
	local tx,ty = getElementData(dxElement,"Title:x"),getElementData(dxElement,"Title:y")
	local px,py = getElementData(getElementParent(dxElement),"width"),getElementData(getElementParent(dxElement),"height")
	if tx and ty then
		if relative then
			return x/px,y/py,tx/px,ty/py
		else
			return x,y,tx,ty
		end
	else
		if relative then
			return x/px,y/py
		else
			return x,y
		end
	end
end

function dxGetSize(dxElement,relative)
	if not dxElement then
		outputDebugString("dxGetSize gets wrong parameters (dxElement[,relative=false]")
		return
	end
	local w,h = getElementData(dxElement,"width"),getElementData(dxElement,"height")
	local px,py = getElementData(getElementParent(dxElement),"width"),getElementData(getElementParent(dxElement),"height")
	if relative then
		return w/px,h/py
	else
		return w,h
	end
end

function dxGetVisible(dxElement)
	if not dxElement  then
		outputDebugString("dxGetVisible gets wrong parameters (dxElement)")
		return
	end
	return getElementData(dxElement,"visible")
end

function dxGetElementTheme(dxElement)
	if not dxElement  then
		outputDebugString("dxGetElementTheme gets wrong parameters (dxElement)")
		return
	end
	return getElementData(dxElement,"theme")
end

function dxGetFont(dxElement)
	if not dxElement  then
		outputDebugString("dxGetFont gets wrong parameters (dxElement)")
		return
	end
	return getElementData(dxElement,"font")
end

function dxGetColor(dxElement)
	if not dxElement  then
		outputDebugString("dxGetColor gets wrong parameters (dxElement)")
		return
	end
	local hex = tostring(toHex(getElementData(dxElement,"color")))
	hex = hex:gsub("(..)(......)","%2%1")
	local r,g,b,a = getColorFromString("#"..hex)
	return r,g,b,a
end

function dxGetColorCoded(dxElement)
	if not dxElement  then
		outputDebugString("dxGetColorCoded gets wrong parameters (dxElement)")
		return
	end
	return getElementData(dxElement,"colorcoded")
end

function dxGetText(dxElement)
	if not dxElement  then
		outputDebugString("dxGetText gets wrong parameters (dxElement)")
		return
	end
	return getElementData(dxElement,"text")
end

function dxGetAlpha(dxElement)
	if not dxElement  then
		outputDebugString("dxGetAlpha gets wrong parameters (dxElement)")
		return
	end
	local hex = tostring(toHex(getElementData(dxElement,"color")))
	hex = hex:gsub("(..)(......)","%2%1")
	local r,g,b,a = getColorFromString("#"..hex)
	return a
end

function dxGetAlwaysOnTop(dxElement)
	if not dxElement then
		outputDebugString("dxGetAlwaysOnTop gets wrong parameters.(dxElement)")
		return
	end
	local postgui = getElementData(dxElement,"postGUI")
	if (postgui == nil) then return false end
	return postgui
end

function dxGetZOrder(dxElement)
	if not dxElement then
		outputDebugString("dxGetZOrder gets wrong parameters.(dxElement)")
		return
	end
	local zOrder = getElementData(dxElement,"ZOrder")
	return zOrder
end
--[[
/***************************************************************************************************************
*
*  PROJECT:     dxGUI
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        dxSetter.lua
*  PURPOSE:     All shared setter functions
*  DEVELOPERS:  Skyline <xtremecooker@gmail.com>
*
*  dxGUI is available from http://community.mtasa.com/index.php?p=resources&s=details&id=4871
*
****************************************************************************************************************/
]]
function dxSetPosition(dxElement,x,y,relative,setTitle)
	if not dxElement or not x or not y then
		outputDebugString("dxSetPosition gets wrong parameters (dxElement,x,y[,relative=false,setTitle=true]")
		return
	end
	if relative == nil then
		relative = false
	end
	if setTitle == nil then
		setTitle = true
	end
	local dxType = getElementType(dxElement)
	local px,py = getElementData(getElementParent(dxElement),"width"),getElementData(getElementParent(dxElement),"height")
	if (dxType == "dxWindow") and (setTitle) then
		if relative then
			setElementData(dxElement,"x",x*px)
			setElementData(dxElement,"y",y*py)
			setElementData(dxElement,"Title:x",x*px)
			setElementData(dxElement,"Title:y",y*py)
		else
			setElementData(dxElement,"x",x)
			setElementData(dxElement,"y",y)
			setElementData(dxElement,"Title:x",x)
			setElementData(dxElement,"Title:y",y)
		end
		triggerEvent("onClientDXPropertyChanged",dxElement,"position",x,y,relative,px,py)
	else
		if relative then
			setElementData(dxElement,"x",x*px)
			setElementData(dxElement,"y",y*py)
		else
			setElementData(dxElement,"x",x)
			setElementData(dxElement,"y",y)
		end
		triggerEvent("onClientDXPropertyChanged",dxElement,"position",x,y,relative)
	end
end

function dxSetSize(dxElement,w,h,relative)
	if not dxElement or not w or not h then
		outputDebugString("dxSetSize gets wrong parameters (dxElement,width,height[,relative=false]")
		return
	end
	
	local px,py = getElementData(getElementParent(dxElement),"width"),getElementData(getElementParent(dxElement),"height")
	if relative then
		setElementData(dxElement,"width",w*px)
		setElementData(dxElement,"height",h*py)
	else
		setElementData(dxElement,"width",w)
		setElementData(dxElement,"height",h)
	end
	triggerEvent("onClientDXPropertyChanged",dxElement,"size",w,h,relative)
end

function dxSetVisible(dxElement,visible)
	if not dxElement or visible == nil  then
		outputDebugString("dxSetVisible gets wrong parameters (dxElement,visible)")
		return
	end
	setElementData(dxElement,"visible",visible)
	triggerEvent("onClientDXPropertyChanged",dxElement,"visible",visible)
end

function dxSetElementTheme(dxElement,theme)
	if not dxElement or not theme  then
		outputDebugString("dxSetElementTheme gets wrong parameters (dxElement,theme)")
		return
	end
	setElementData(dxElement,"theme",theme)
	triggerEvent("onClientDXPropertyChanged",dxElement,"theme",theme)
end

function dxSetFont(dxElement,font)
	if not dxElement or not font  then
		outputDebugString("dxSetFont gets wrong parameters (dxElement,font)")
		return
	end
	setElementData(dxElement,"font",font)
	triggerEvent("onClientDXPropertyChanged",dxElement,"font",font)
end

function dxSetColor(dxElement,color)
	if not dxElement or not color  then
		outputDebugString("dxSetFont gets wrong parameters (dxElement,color)")
		return
	end
	setElementData(dxElement,"color",color)
	triggerEvent("onClientDXPropertyChanged",dxElement,"color",color)
end

function dxSetColorCoded(dxElement,colorcoded)
	if not dxElement or colorcoded == nil  then
		outputDebugString("dxSetColorCoded gets wrong parameters (dxElement,colorcoded)")
		return
	end
	setElementData(dxElement,"colorcoded",colorcoded)
	triggerEvent("onClientDXPropertyChanged",dxElement,"colorcoded",colorcoded)
end

function dxSetText(dxElement,text)
	if not dxElement or not text  then
		outputDebugString("dxSetText gets wrong parameters (dxElement,text)")
		return
	end
	setElementData(dxElement,"text",text)
	triggerEvent("onClientDXPropertyChanged",dxElement,"text",text)
end

function dxSetAlpha(dxElement,alpha)
	if not dxElement or not alpha then
		outputDebugString("dxSetAlpha gets wrong parameters (dxElement,alpha)")
		return
	end
	local hex = tostring(toHex(getElementData(dxElement,"color")))
	hex = hex:gsub("(..)(......)","%2%1")
	local r,g,b,a = getColorFromString("#"..hex)
	setElementData(dxElement,"color",tocolor(r,g,b,alpha))
	triggerEvent("onClientDXPropertyChanged",dxElement,"alpha",alpha)
end

function dxSetAlwaysOnTop(dxElement,postGUI)
	if not dxElement or postGUI==nil then
		outputDebugString("dxSetAlwaysOnTop gets wrong parameters.(dxElement,alwaysOnTop)")
		return
	end
	setElementData(dxElement,"postGUI",postGUI)
end

function dxSetZOrder(dxElement,ZOrder)
	if not dxElement or ZOrder==nil then
		outputDebugString("dxSetZOrder gets wrong parameters.(dxElement,ZOrder)")
		return
	end
	setElementData(dxElement,"ZOrder",ZOrder)
end

function dxBringToFront(dxElement)
	if not dxElement  then
		outputDebugString("dxBringToFront gets wrong parameters.(dxElement)")
		return
	end
	local parentChilds = getElementChildren(getElementParent(dxElement))
	local bringOne = dxGetZOrder(dxElement)
	for _,w in ipairs(parentChilds) do
		if (bringOne < dxGetZOrder(w)) and (dxElement ~= w) then
			bringOne = dxGetZOrder(w)
		end
	end
	dxSetZOrder(dxElement,bringOne+1)
end

function dxMoveToBack(dxElement)
	if not dxElement  then
		outputDebugString("dxMoveToBack gets wrong parameters.(dxElement)")
		return
	end
	local parentChilds = getElementChildren(getElementParent(dxElement))
	local bringOne = dxGetZOrder(dxElement)
	local willMove = {}
	for _,w in ipairs(parentChilds) do
		if (bringOne >= dxGetZOrder(w)) and (dxElement~=w) then
			table.insert(willMove,w)
		end
	end
	for _,w in ipairs(willMove) do
		dxSetZOrder(w,dxGetZOrder(w)+1)
	end
	dxSetZOrder(dxElement,0)
end
--[[
/***************************************************************************************************************
*
*  PROJECT:     dxGUI
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        components/dxImage.lua
*  PURPOSE:     All static image functions.
*  DEVELOPERS:  Skyline <xtremecooker@gmail.com>
*
*  dxGUI is available from http://community.mtasa.com/index.php?p=resources&s=details&id=4871
*
****************************************************************************************************************/
]]
-- // Initializing
function dxCreateStaticImage(resource,x,y,width,height,path,rotation,parent)
	if not x or not y or not width or not height or not path then
		outputDebugString("dxCreateStaticImage gets wrong parameters (dxElement,x,y,width,height,path[,rotation=0,parent=dxGetRootPane()])")
		return
	end
	
	if not parent then
		parent = dxGetRootPane()
	end
	
	if not rotation then
		rotation = 0
	end
	if not fileExists(path) then
		return false
	end
	
	local image = createElement("dxStaticImage")
	setElementParent(image,parent)
	setElementData(image,"resource",resource)
	setElementData(image,"x",x)
	setElementData(image,"y",y)
	setElementData(image,"width",width)
	setElementData(image,"height",height)
	setElementData(image,"rotation",rotation)
	setElementData(image,"Section",false)
	setElementData(image,"Section:x",false)
	setElementData(image,"Section:y",false)
	setElementData(image,"Section:width",false)
	setElementData(image,"Section:height",false)
	setElementData(image,"image",path)
	setElementData(image,"visible",true)
	setElementData(image,"hover",false)
	setElementData(image,"parent",parent)
	setElementData(image,"container",false)
	setElementData(image,"postGUI",false)
	setElementData(image,"ZOrder",getElementData(parent,"ZIndex")+1)
	setElementData(parent,"ZIndex",getElementData(parent,"ZIndex")+1)
	return image
end

function dxCreateStaticImageSection(resource,x,y,width,height,sectionX,sectionY,sectionWidth,sectionHeight,path,rotation,parent)
	if not x or not y or not width or not height or not path or not sectionX or not sectionY or not sectionWidth or not sectionHeight then
		outputDebugString("dxCreateStaticImageSection gets wrong parameters (dxElement,x,y,width,height,sectionX,sectionY,sectionWidth,sectionHeight,path[,rotation=0,parent=dxGetRootPane()])")
		return
	end
	
	if not parent then
		parent = dxGetRootPane()
	end
	if not rotation then
		rotation = 0
	end
	if not fileExists(path) then
		return false
	end
	
	local image = createElement("dxStaticImage")
	setElementParent(image,parent)
	setElementData(image,"resource",resource)
	setElementData(image,"x",x)
	setElementData(image,"y",y)
	setElementData(image,"width",width)
	setElementData(image,"height",height)
	setElementData(image,"rotation",rotation)
	setElementData(image,"Section",true)
	setElementData(image,"Section:x",sectionX)
	setElementData(image,"Section:y",sectionY)
	setElementData(image,"Section:width",sectionWidth)
	setElementData(image,"Section:height",sectionHeight)
	setElementData(image,"image",path)
	setElementData(image,"visible",true)
	setElementData(image,"hover",false)
	setElementData(image,"parent",parent)
	setElementData(image,"container",false)
	return image
end
-- // Functions
function dxStaticImageGetLoadedImage(dxElement)
	if not dxElement then
		outputDebugString("dxStaticImageGetLoadedImage gets wrong parameters.(dxElement)")
		return
	end
	if (getElementType(dxElement)~="dxStaticImage") then
		outputDebugString("dxStaticImageGetLoadedImage gets wrong parameters.(dxElement must be dxStaticImage)")
		return
	end
	return getElementData(dxElement,"image")
end

function dxStaticImageLoadImage(dxElement,path)
	if not dxElement or not path then
		outputDebugString("dxStaticImageLoadImage gets wrong parameters.(dxElement,path)")
		return
	end
	if (getElementType(dxElement)~="dxStaticImage") then
		outputDebugString("dxStaticImageLoadImage gets wrong parameters.(dxElement must be dxStaticImage)")
		return
	end
	if not fileExists(path) then
		return false
	end
	setElementData(dxElement,"image",path)
	triggerEvent("onClientDXPropertyChanged",dxElement,"image",path)
	return true
end

function dxStaticImageGetSection(dxElement)
	if not dxElement then
		outputDebugString("dxStaticImageGetSection gets wrong parameters.(dxElement)")
		return
	end
	if (getElementType(dxElement)~="dxStaticImage") then
		outputDebugString("dxStaticImageGetSection gets wrong parameters.(dxElement must be dxStaticImage)")
		return
	end
	if not (getElementData(dxElement,"Section")) then
		return false
	end
	return getElementData(dxElement,"Section:x"),getElementData(dxElement,"Section:y"),
		getElementData(dxElement,"Section:width"),getElementData(dxElement,"Section:height")
end

function dxStaticImageSetSection(dxElement,sectionX,sectionY,sectionW,sectionH)
	if not dxElement then
		outputDebugString("dxStaticImageSetSection gets wrong parameters.(dxElement,[(sectionX,sectionY,sectionW,sectionH=false)])")
		return
	end
	if (getElementType(dxElement)~="dxStaticImage") then
		outputDebugString("dxStaticImageSetSection gets wrong parameters.(dxElement must be dxStaticImage)")
		return
	end
	if not sectionX then
		setElementData(dxElement,"Section",false)
		setElementData(dxElement,"Section:x",false)
		setElementData(dxElement,"Section:y",false)
		setElementData(dxElement,"Section:width",false)
		setElementData(dxElement,"Section:height",false)
		triggerEvent("onClientDXPropertyChanged",dxElement,"section",false)
		return true
	end
	setElementData(dxElement,"Section",true)
	setElementData(dxElement,"Section:x",sectionX)
	setElementData(dxElement,"Section:y",sectionY)
	setElementData(dxElement,"Section:width",sectionW)
	setElementData(dxElement,"Section:height",sectionH)
	triggerEvent("onClientDXPropertyChanged",dxElement,"section",true,sectionX,sectionY,sectionW,sectionH)
	return true
end

function dxStaticImageGetRotation(dxElement)
	if not dxElement then
		outputDebugString("dxStaticImageGetRotation gets wrong parameters.(dxElement)")
		return
	end
	if (getElementType(dxElement)~="dxStaticImage") then
		outputDebugString("dxStaticImageGetRotation gets wrong parameters.(dxElement must be dxStaticImage)")
		return
	end
	return getElementData(dxElement,"rotation")
end

function dxStaticImageSetRotation(dxElement,rot)
	if not dxElement or not rot then
		outputDebugString("dxStaticImageSetRotation gets wrong parameters.(dxElement,path)")
		return
	end
	if (getElementType(dxElement)~="dxStaticImage") then
		outputDebugString("dxStaticImageSetRotation gets wrong parameters.(dxElement must be dxStaticImage)")
		return
	end
	setElementData(dxElement,"rotation",rot)
	triggerEvent("onClientDXPropertyChanged",dxElement,"rotation",rot)
end

-- // Render
function dxStaticImageRender(component,cpx,cpy,cpg)
	local path = getElementData(component,"image")
	local rotation = getElementData(component,"rotation")
	if (getElementData(component,"Section")) then
		local sx,sy,sw,sh = getElementData(component,"Section:x"),getElementData(component,"Section:y"),getElementData(component,"Section:width"),getElementData(component,"Section:height")
		dxDrawImageSection(cpx+cx,cpx+cy,cw,ch,sx,sy,sw,sh,path,rotation,0,0,tocolor(255,255,255),cpg)
	else
		dxDrawImage(cpx+cx,cpx+cy,cw,ch,path,rotation,0,0,tocolor(255,255,255),cpg)
	end
end

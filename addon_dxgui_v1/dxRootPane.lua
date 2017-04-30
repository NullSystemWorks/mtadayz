--[[
/***************************************************************************************************************
*
*  PROJECT:     dxGUI
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        dxRootPane.lua
*  PURPOSE:     Rootpane Functions.
*  DEVELOPERS:  Skyline <xtremecooker@gmail.com>
*
*  dxGUI is available from http://community.mtasa.com/index.php?p=resources&s=details&id=4871
*
****************************************************************************************************************/
]]
function dxCreateRootPane()
	local element = createElement("dxRootPane")
	local screenX,screenY = guiGetScreenSize()
	setElementData(element,"x",0)
	setElementData(element,"y",0)
	setElementData(element,"width",screenX)
	setElementData(element,"height",screenY)
	setElementData(element,"theme",dxGetDefaultTheme())
	setElementData(element,"visible",true)
	setElementData(element,"container",true)
	setElementData(element,"ZIndex",0)
	return element
end

function dxGetRootPane()
	for _,root in ipairs(getElementsByType("dxRootPane")) do
		return root
	end
	return dxCreateRootPane()
end

addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),
	function(resource)
		if resource == getThisResource() then
			dxCreateRootPane()
		end
	end
)
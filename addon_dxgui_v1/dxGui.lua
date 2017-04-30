--[[
/***************************************************************************************************************
*
*  PROJECT:     dxGUI
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        dxGUI.lua
*  PURPOSE:     Main dxGUI File
*  DEVELOPERS:  Skyline <xtremecooker@gmail.com>
*
*  dxGUI is available from http://community.mtasa.com/index.php?p=resources&s=details&id=4871
*
****************************************************************************************************************/
]]
attachedElements = {}

function guiAttachToDirectX(to,element,x,y)
	table.insert(attachedElements,{to,element,x,y})
end

function dxDeprecatedFunction(old,new)
	triggerServerEvent("deprecatedFunction",getRootElement(),old,new)
end

function dxDestroyElement(dxElement)
	if (isElement(dxElement)) then
		triggerEvent("onClientDXDestroy",dxElement)
		if not (wasEventCanceled()) then
			destroyElement(dxElement)
			return true;
		end
	end
	return false;
end

function dxDestroyElements(resource)
	for _,v in ipairs(getElementChildren(dxGetRootPane())) do
		if ( getElementData(v,"resource") == resource ) then
			destroyElement(v)
		end
	end
	triggerEvent("onClientDXDestroyAll",getRootElement(),resource)
end

addEventHandler("onClientResourceStop",getRootElement(),function(resource)
	dxDestroyElements(resource)
end)

addEventHandler("onClientRender",getRootElement(),
	function()
		dxRefreshStates()
		dxScrollBarsRefresh()
		dxSpinnersRefresh()
		local comps = getElementChildren(dxGetRootPane())
		table.sort(comps,function(a,b)
			return (dxGetZOrder(a) < dxGetZOrder(b))
		end)
		for _,component in ipairs(comps) do
			if dxGetVisible(component) and (dxGetVisible(dxGetRootPane())) then
				for _,aElements in ipairs(attachedElements) do
					if ( aElements[1] == component ) then
						guiSetPosition(aElements[2],cpx+cx+aElements[3],cpy+cy+aElements[4],false)
					end
				end
				
				-- Type renderer
				local eType = getElementType(component)
				local x,y,cpg = 0,0,dxGetAlwaysOnTop(component)
				if ( eType == "dxWindow") then
					dxWindowRender(component)
				elseif ( eType == "dxButton" ) then
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
)

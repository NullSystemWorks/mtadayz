--[[
/***************************************************************************************************************
*
*  PROJECT:     dxGUI
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        dxTheme.lua
*  PURPOSE:     All theme functions.
*  DEVELOPERS:  Skyline <xtremecooker@gmail.com>
*
*  dxGUI is available from http://community.mtasa.com/index.php?p=resources&s=details&id=4871
*
****************************************************************************************************************/
]]
function dxRefreshThemes()
	for _,theme in ipairs(getElementsByType("dxTheme")) do
		destroyElement(theme)
	end
	
	local xml = xmlLoadFile("themes.xml")
	local defaultsel = false
	local i = 0
	while (xmlFindChild(xml,"theme",i)) do
		local theme_c = xmlFindChild(xml,"theme",i)
		local theme = createElement("dxTheme")
		if (xmlNodeGetAttribute(theme_c,"default")) then
			setElementData(theme,"default",true)
		else
			setElementData(theme,"default",false)
		end
		setElementData(theme,"name",xmlNodeGetAttribute(theme_c,"name"))
		
		local theme_im = xmlFindChild(theme_c,"images",0)
		local theme_ims = xmlFindChild(theme_c,"imagesets",0)
		
		setElementData(theme,"images","themes/"..xmlNodeGetAttribute(theme_c,"name").."/"..xmlNodeGetAttribute(theme_im,"src"))
		setElementData(theme,"imagesets","themes/"..xmlNodeGetAttribute(theme_c,"name").."/"..xmlNodeGetAttribute(theme_ims,"src"))
		
		local xml2 = xmlLoadFile("themes/"..xmlNodeGetAttribute(theme_c,"name").."/"..xmlNodeGetAttribute(theme_ims,"src"))
		local i_ = 0
		while (xmlFindChild(xml2,"Image",i_)) do
			local image_c = (xmlFindChild(xml2,"Image",i_))
			local name = xmlNodeGetAttribute(image_c,"Name")
			setElementData(theme,name..":Height",tonumber(xmlNodeGetAttribute(image_c,"Height")))
			setElementData(theme,name..":Width",tonumber(xmlNodeGetAttribute(image_c,"Width")))
			setElementData(theme,name..":X",tonumber(xmlNodeGetAttribute(image_c,"XPos")))
			setElementData(theme,name..":Y",tonumber(xmlNodeGetAttribute(image_c,"YPos")))
			if xmlNodeGetAttribute(image_c,"Image") then
				setElementData(theme,name..":images","themes/"..xmlNodeGetAttribute(theme_c,"name").."/"..xmlNodeGetAttribute(image_c,"Image"))
			else
				setElementData(theme,name..":images",getElementData(theme,"images"))
			end
			i_ = i_+1
		end
		i=i+1
	end
end

function dxGetTheme(themeName)
	for _,theme in ipairs(getElementsByType("dxTheme")) do
		if getElementData(theme,"name") == themeName then
			return theme
		end
	end
	return false
end

function dxGetDefaultTheme()
	theme = false
	for _,themes in ipairs(getElementsByType("dxTheme")) do
		if (getElementData(themes,"default")) then
			theme = themes
			break
		end
	end
	return theme
end

addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),
	function(resource)
		if resource == getThisResource() then
			dxRefreshThemes()
		end
	end
)
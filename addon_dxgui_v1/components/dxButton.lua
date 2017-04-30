--[[
/***************************************************************************************************************
*
*  PROJECT:     dxGUI
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        components/dxButton.lua
*  PURPOSE:     All button functions.
*  DEVELOPERS:  Skyline <xtremecooker@gmail.com>
*
*  dxGUI is available from http://community.mtasa.com/index.php?p=resources&s=details&id=4871
*
****************************************************************************************************************/
]]
-- // Initializing
function dxCreateButton(resource,x,y,width,height,text,parent,color,font,theme)
	if not x or not y or not width or not height or not text then
		outputDebugString("dxCreateButton gets wrong parameters (resource,x,y,width,height,text[,parent=dxGetRootPane(),color=white,font=default,theme=dxGetDefaultTheme()])")
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
	
	if not theme then
		theme = dxGetDefaultTheme()
	end
	
	if type(theme) == "string" then
		theme = dxGetTheme(theme)
	end
	
	if not theme then
		outputDebugString("dxCreateButton didn't find the main theme.")
		return false
	end
	
	local button = createElement("dxButton")
	setElementParent(button,parent)
	setElementData(button,"resource",resource)
	setElementData(button,"x",x)
	setElementData(button,"y",y)
	setElementData(button,"width",width)
	setElementData(button,"height",height)
	setElementData(button,"text",text)
	setElementData(button,"visible",true)
	setElementData(button,"colorcoded",false)
	setElementData(button,"hover",false)
	setElementData(button,"font",font)
	setElementData(button,"theme",theme)
	setElementData(button,"parent",parent)
	setElementData(button,"container",false)
	setElementData(button,"postGUI",false)
	setElementData(button,"ZOrder",getElementData(parent,"ZIndex")+1)
	setElementData(parent,"ZIndex",getElementData(parent,"ZIndex")+1)
	return button
end

-- // Functions
function dxButtonRender(component,cpx,cpy,cpg)
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
	
	local cpxx = cpx+cx
	local cpyy = cpy+cy
	-- Button drawings
	local imageset = "S"
	if ( getElementData(component,"push") ) then
		imageset = "S"
	elseif ( getElementData(component,"hover") ) then
		imageset = ""
	end
	
	local leftw,rightw = getElementData(cTheme,imageset.."ButtonLeft:Width"),getElementData(cTheme,imageset.."ButtonRight:Width")
	local toplefth,botlefth = getElementData(cTheme,imageset.."ButtonTopLeft:Height"),getElementData(cTheme,imageset.."ButtonBottomLeft:Height")
	local toprigth,botright = getElementData(cTheme,imageset.."ButtonTopRight:Height"),getElementData(cTheme,imageset.."ButtonBottomRight:Height")
	local toph,both = getElementData(cTheme,imageset.."ButtonTop:Height"), getElementData(cTheme,imageset.."ButtonBottom:Height")
	dxDrawImageSection(cpxx,cpyy,getElementData(cTheme,imageset.."ButtonTopLeft:Width"),getElementData(cTheme,imageset.."ButtonTopLeft:Height"),
		getElementData(cTheme,imageset.."ButtonTopLeft:X"),getElementData(cTheme,imageset.."ButtonTopLeft:Y"),
		getElementData(cTheme,imageset.."ButtonTopLeft:Width"),getElementData(cTheme,imageset.."ButtonTopLeft:Height"),
		getElementData(cTheme,imageset.."ButtonTopLeft:images"),0,0,0,color,cpg)
	dxDrawImageSection(cpxx,cpyy+toplefth,getElementData(cTheme,imageset.."ButtonLeft:Width"),ch-toplefth-botlefth,
		getElementData(cTheme,imageset.."ButtonLeft:X"),getElementData(cTheme,imageset.."ButtonLeft:Y"),
		getElementData(cTheme,imageset.."ButtonLeft:Width"),getElementData(cTheme,imageset.."ButtonLeft:Height"),
		getElementData(cTheme,imageset.."ButtonLeft:images"),0,0,0,color,cpg)
	dxDrawImageSection(cpxx,cpyy+toplefth+(ch-toplefth-botlefth),getElementData(cTheme,imageset.."ButtonBottomLeft:Width"),botlefth,
		getElementData(cTheme,imageset.."ButtonBottomLeft:X"),getElementData(cTheme,imageset.."ButtonBottomLeft:Y"),
		getElementData(cTheme,imageset.."ButtonBottomLeft:Width"),getElementData(cTheme,imageset.."ButtonBottomLeft:Height"),
		getElementData(cTheme,imageset.."ButtonBottomLeft:images"),0,0,0,color,cpg)
	dxDrawImageSection(cpxx+leftw,cpyy,cw-leftw-rightw,toph,
		getElementData(cTheme,imageset.."ButtonTop:X"),getElementData(cTheme,imageset.."ButtonTop:Y"),
		getElementData(cTheme,imageset.."ButtonTop:Width"),getElementData(cTheme,imageset.."ButtonTop:Height"),
		getElementData(cTheme,imageset.."ButtonTop:images"),0,0,0,color,cpg)
	dxDrawImageSection(cpxx+leftw,cpyy+toplefth+(ch-toplefth-botlefth),cw-leftw-rightw,both,
		getElementData(cTheme,imageset.."ButtonBottom:X"),getElementData(cTheme,imageset.."ButtonBottom:Y"),
		getElementData(cTheme,imageset.."ButtonBottom:Width"),getElementData(cTheme,imageset.."ButtonBottom:Height"),
		getElementData(cTheme,imageset.."ButtonBottom:images"),0,0,0,color,cpg)
	dxDrawImageSection(cpxx+leftw+(cw-leftw-rightw),cpyy+toplefth+(ch-toplefth-botlefth),getElementData(cTheme,imageset.."ButtonBottomRight:Width"),botright,
		getElementData(cTheme,imageset.."ButtonBottomRight:X"),getElementData(cTheme,imageset.."ButtonBottomRight:Y"),
		getElementData(cTheme,imageset.."ButtonBottomRight:Width"),getElementData(cTheme,imageset.."ButtonBottomRight:Height"),
		getElementData(cTheme,imageset.."ButtonBottomRight:images"),0,0,0,color,cpg)
	dxDrawImageSection(cpxx+leftw+(cw-leftw-rightw),cpyy,getElementData(cTheme,imageset.."ButtonTopRight:Width"),getElementData(cTheme,imageset.."ButtonTopRight:Height"),
		getElementData(cTheme,imageset.."ButtonTopRight:X"),getElementData(cTheme,imageset.."ButtonTopRight:Y"),
		getElementData(cTheme,imageset.."ButtonTopRight:Width"),getElementData(cTheme,imageset.."ButtonTopRight:Height"),
		getElementData(cTheme,imageset.."ButtonTopRight:images"),0,0,0,color,cpg)
	dxDrawImageSection(cpxx+leftw+(cw-leftw-rightw),cpyy+toplefth,getElementData(cTheme,imageset.."ButtonRight:Width"),ch-toplefth-botlefth,
		getElementData(cTheme,imageset.."ButtonRight:X"),getElementData(cTheme,imageset.."ButtonRight:Y"),
		getElementData(cTheme,imageset.."ButtonRight:Width"),getElementData(cTheme,imageset.."ButtonRight:Height"),
		getElementData(cTheme,imageset.."ButtonRight:images"),0,0,0,color,cpg)
	dxDrawImageSection(cpxx+leftw,cpyy+toplefth,cw-leftw-rightw,ch-toplefth-botlefth,
		getElementData(cTheme,imageset.."ButtonCenter:X"),getElementData(cTheme,imageset.."ButtonCenter:Y"),
		getElementData(cTheme,imageset.."ButtonCenter:Width"),getElementData(cTheme,imageset.."ButtonCenter:Height"),
		getElementData(cTheme,imageset.."ButtonCenter:images"),0,0,0,color,cpg)
	local title,font = dxGetText(component),dxGetFont(component)
	local tw = cw-leftw-rightw
	local th = ch-toplefth-botlefth
	
	local textWidth
	if (dxGetColorCoded(component)) then
		textWidth = dxGetTextWidth(title:gsub("#%x%x%x%x%x%x", ""),1,font)
	else
		textWidth = dxGetTextWidth(title,1,font)
	end
	if textWidth > tw-10 then
		while textWidth>tw-10 do
			title = title:sub(1,title:len()-6).."..."
			if (dxGetColorCoded(component)) then
				textWidth = dxGetTextWidth(title:gsub("#%x%x%x%x%x%x", ""),1,font)
			else
				textWidth = dxGetTextWidth(title,1,font)
			end
		end
	end
	
	local textHeight = dxGetFontHeight(1,font)
	local textX = cpxx+leftw
	local textY = cpyy+toplefth
	local textXX = cpxx+cw-leftw-rightw
	local textYY = cpyy+ch-toplefth
	if (dxGetColorCoded(component)) then
		dxDrawColorText(title,textX,textY,textXX,textYY,color,1,font,"center","center",true,true,cpg)
	else
		dxDrawText(title,textX,textY,textXX,textYY,color,1,font,"center","center",true,true,cpg)
	end
	--
end
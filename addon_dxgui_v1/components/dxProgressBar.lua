--[[
/***************************************************************************************************************
*
*  PROJECT:     dxGUI
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        components/dxProgressBar.lua
*  PURPOSE:     All progressbar functions.
*  DEVELOPERS:  Skyline <xtremecooker@gmail.com>
*
*  dxGUI is available from http://community.mtasa.com/index.php?p=resources&s=details&id=4871
*
****************************************************************************************************************/
]]
-- // Initalizing
function dxCreateProgressBar(resource,x,y,width,height,parent,progress,color,max_,theme)
	if not x or not y or not width or not height then
		outputDebugString("dxCreateProgressBar gets wrong parameters (x,y,width,height[,parent=dxGetRootPane(),progress=0,color=segment,max=100,theme=dxGetDefaultTheme()])")
		return
	end
	
	if not parent then
		parent = dxGetRootPane()
	end
	
	if not progress then
		progress = 0
	end
	
	if not max_ then
		max_ = 100
	end
	
	if max_ <= 0 then
		max_ = 100
	end
	
	if progress < 0 or progress > max_ then
		progress = 0
	end
	
	if not color then
		color = "segment"
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
	
	local progressBar = createElement("dxProgressBar")
	setElementParent(progressBar,parent)
	setElementData(progressBar,"resource",resource)
	setElementData(progressBar,"x",x)
	setElementData(progressBar,"y",y)
	setElementData(progressBar,"width",width)
	setElementData(progressBar,"height",height)
	setElementData(progressBar,"progress",progress)
	setElementData(progressBar,"max",max_)
	setElementData(progressBar,"theme",theme)
	setElementData(progressBar,"visible",true)
	setElementData(progressBar,"progressColor",color)
	setElementData(progressBar,"hover",false)
	setElementData(progressBar,"parent",parent)
	setElementData(progressBar,"container",false)
	setElementData(progressBar,"postGUI",false)
	setElementData(progressBar,"ZOrder",getElementData(parent,"ZIndex")+1)
	setElementData(parent,"ZIndex",getElementData(parent,"ZIndex")+1)
	return progressBar
end
-- // Functions
function dxProgressBarGetProgress(dxElement)
	if not dxElement then
		outputDebugString("dxProgressBarGetProgress gets wrong parameters.(dxElement)")
		return
	end
	if (getElementType(dxElement)~="dxProgressBar") then
		outputDebugString("dxProgressBarGetProgress gets wrong parameters.(dxElement must be dxProgressBar)")
		return
	end
	return getElementData(dxElement,"progress")
end

function dxProgressBarSetProgress(dxElement,progress)
	if not dxElement or not progress then
		outputDebugString("dxProgressBarSetProgress gets wrong parameters.(dxElement,progress)")
		return
	end
	if (getElementType(dxElement)~="dxProgressBar") then
		outputDebugString("dxProgressBarSetProgress gets wrong parameters.(dxElement must be dxProgressBar)")
		return
	end
	local max = getElementData(dxElement,"max")
	if type(progress)~="number" or progress < 0 or progress > max then
		outputDebugString("dxProgressBarSetProgress gets wrong parameters.(progress must be between 0-"..tostring(max))
		return
	end
	setElementData(dxElement,"progress",progress)
	triggerEvent("onClientDXPropertyChanged",dxElement,"progress",progress)
end

function dxProgressBarGetProgressPercent(dxElement)
	if not dxElement then
		outputDebugString("dxProgressBarGetProgressPercent gets wrong parameters.(dxElement)")
		return
	end
	if (getElementType(dxElement)~="dxProgressBar") then
		outputDebugString("dxProgressBarGetProgressPercent gets wrong parameters.(dxElement must be dxProgressBar)")
		return
	end
	-- max progress
	-- 100 x
	return (100*getElementData(dxElement,"progress")) / getElementData(dxElement,"max")
end

function dxProgressBarSetProgressPercent(dxElement,progress)
	if not dxElement or not progress then
		outputDebugString("dxProgressBarSetProgressPercent gets wrong parameters.(dxElement,percent)")
		return
	end
	if (getElementType(dxElement)~="dxProgressBar") then
		outputDebugString("dxProgressBarSetProgressPercent gets wrong parameters.(dxElement must be dxProgressBar)")
		return
	end
	if type(progress)~="number" or progress < 0 or progress > 100 then
		outputDebugString("dxProgressBarSetProgressPercent gets wrong parameters.(percent must be between 0-100)")
		return
	end
	-- 100 percent
	-- max x
	setElementData(dxElement,"progress",(getElementData(dxElement,"max")*progress)/100)
	triggerEvent("onClientDXPropertyChanged",dxElement,"progressPercent",progress,(getElementData(dxElement,"max")*progress)/100)
end

function dxProgressBarGetMaxProgress(dxElement)
	if not dxElement then
		outputDebugString("dxProgressBarGetMaxProgress gets wrong parameters.(dxElement)")
		return
	end
	if (getElementType(dxElement)~="dxProgressBar") then
		outputDebugString("dxProgressBarGetMaxProgress gets wrong parameters.(dxElement must be dxProgressBar)")
		return
	end
	return getElementData(dxElement,"max")
end

function dxProgressBarSetMaxProgress(dxElement,progress)
	if not dxElement or not progress then
		outputDebugString("dxProgressBarSetMaxProgress gets wrong parameters.(dxElement,maxProgress)")
		return
	end
	if (getElementType(dxElement)~="dxProgressBar") then
		outputDebugString("dxProgressBarSetMaxProgress gets wrong parameters.(dxElement must be dxProgressBar)")
		return
	end
	setElementData(dxElement,"max",progress)
	triggerEvent("onClientDXPropertyChanged",dxElement,"maxProgress",progress)
	if (getElementData(dxElement,"progress") > progress ) then
		dxProgressBarSetProgress(dxElement,progress)
	end
end

-- // Render
function dxProgressBarRender(component,cpx,cpy,cpg)
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
	
	local leftw,rightw = getElementData(cTheme,"ProgressLeft:Width"),getElementData(cTheme,"ProgressRight:Width")
	local toplefth,botlefth = getElementData(cTheme,"ProgressTopLeft:Height"),getElementData(cTheme,"ProgressBottomLeft:Height")
	local toprigth,botrigth = getElementData(cTheme,"ProgressTopRight:Height"),getElementData(cTheme,"ProgressBottomRight:Height")
	local toph,both = getElementData(cTheme,"ProgressTop:Height"),getElementData(cTheme,"ProgressBottom:Height")
	
	dxDrawImageSection(cpxx,cpyy,getElementData(cTheme,"ProgressTopLeft:Width"),toplefth,
		getElementData(cTheme,"ProgressTopLeft:X"),getElementData(cTheme,"ProgressTopLeft:Y"),
		getElementData(cTheme,"ProgressTopLeft:Width"),getElementData(cTheme,"ProgressTopLeft:Height"),
		getElementData(cTheme,"ProgressTopLeft:images"),0,0,0,color,cpg)
	dxDrawImageSection(cpxx,cpyy+toplefth,getElementData(cTheme,"ProgressLeft:Width"),ch-toplefth-botlefth,
		getElementData(cTheme,"ProgressLeft:X"),getElementData(cTheme,"ProgressLeft:Y"),
		getElementData(cTheme,"ProgressLeft:Width"),getElementData(cTheme,"ProgressLeft:Height"),
		getElementData(cTheme,"ProgressLeft:images"),0,0,0,color,cpg)
	dxDrawImageSection(cpxx,cpyy+toplefth+(ch-toplefth-botlefth),getElementData(cTheme,"ProgressBottomLeft:Width"),botlefth,
		getElementData(cTheme,"ProgressBottomLeft:X"),getElementData(cTheme,"ProgressBottomLeft:Y"),
		getElementData(cTheme,"ProgressBottomLeft:Width"),getElementData(cTheme,"ProgressBottomLeft:Height"),
		getElementData(cTheme,"ProgressBottomLeft:images"),0,0,0,color,cpg)
	dxDrawImageSection(cpxx+getElementData(cTheme,"ProgressTopLeft:Width"),cpyy,cw-leftw-rightw,toph,
		getElementData(cTheme,"ProgressTop:X"),getElementData(cTheme,"ProgressTop:Y"),
		getElementData(cTheme,"ProgressTop:Width"),getElementData(cTheme,"ProgressTop:Height"),
		getElementData(cTheme,"ProgressTop:images"),0,0,0,color,cpg)
	dxDrawImageSection(cpxx+getElementData(cTheme,"ProgressTopLeft:Width"),cpyy+toplefth+(ch-toplefth-botlefth),cw-leftw-rightw,both,
		getElementData(cTheme,"ProgressBottom:X"),getElementData(cTheme,"ProgressBottom:Y"),
		getElementData(cTheme,"ProgressBottom:Width"),getElementData(cTheme,"ProgressBottom:Height"),
		getElementData(cTheme,"ProgressBottom:images"),0,0,0,color,cpg)
	dxDrawImageSection(cpxx+leftw+(cw-leftw-rightw),cpyy+toplefth+(ch-toplefth-botlefth),getElementData(cTheme,"ProgressBottomRight:Width"),botrigth,
		getElementData(cTheme,"ProgressBottomRight:X"),getElementData(cTheme,"ProgressBottomRight:Y"),
		getElementData(cTheme,"ProgressBottomRight:Width"),getElementData(cTheme,"ProgressBottomRight:Height"),
		getElementData(cTheme,"ProgressBottomRight:images"),0,0,0,color,cpg)
	dxDrawImageSection(cpxx+leftw+(cw-leftw-rightw),cpyy+toprigth,getElementData(cTheme,"ProgressRight:Width"),ch-toplefth-botlefth,
		getElementData(cTheme,"ProgressRight:X"),getElementData(cTheme,"ProgressRight:Y"),
		getElementData(cTheme,"ProgressRight:Width"),getElementData(cTheme,"ProgressRight:Height"),
		getElementData(cTheme,"ProgressRight:images"),0,0,0,color,cpg)
	dxDrawImageSection(cpxx+leftw+(cw-leftw-rightw),cpyy,getElementData(cTheme,"ProgressTopRight:Width"),toprigth,
		getElementData(cTheme,"ProgressTopRight:X"),getElementData(cTheme,"ProgressTopRight:Y"),
		getElementData(cTheme,"ProgressTopRight:Width"),getElementData(cTheme,"ProgressTopRight:Height"),
		getElementData(cTheme,"ProgressTopRight:images"),0,0,0,color,cpg)
	dxDrawImageSection(cpxx+leftw,cpyy+toplefth,cw-leftw-rightw,ch-toplefth-botlefth,
		getElementData(cTheme,"ProgressBackground:X"),getElementData(cTheme,"ProgressBackground:Y"),
		getElementData(cTheme,"ProgressBackground:Width"),getElementData(cTheme,"ProgressBackground:Height"),
		getElementData(cTheme,"ProgressBackground:images"),0,0,0,color,cpg)
	local prog = dxProgressBarGetProgress(component)
	local max = dxProgressBarGetMaxProgress(component)
	local width__ = cw-leftw-rightw
	-- max width__
	-- prog x
	local width_ = (prog*width__) / max
	local progressColor = getElementData(component,"progressColor")
	if type(progressColor) ~= "string" then
		dxDrawRectangle(cpxx+leftw,cpyy,width_,ch,progressColor,cpg)
	else
		dxDrawImageSection(cpxx+leftw,cpyy,width_,ch,
			getElementData(cTheme,"ProgressBarLitSegment:X"),getElementData(cTheme,"ProgressBarLitSegment:Y"),
			getElementData(cTheme,"ProgressBarLitSegment:Width"),getElementData(cTheme,"ProgressBarLitSegment:Height"),
			getElementData(cTheme,"ProgressBarLitSegment:images"),0,0,0,tocolor(255,255,255),cpg)
	end
end
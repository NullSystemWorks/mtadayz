dxSharedFunctions = {}
dxSharedFunctions.__index = dxSharedFunctions
local dx = exports.dxGUI
function dxSharedFunctions:Position(x,y,relative,title)
	if (type(self) ~= "table") then
		outputDebugString("calling method incorrectly ( object.method() )! use object:method()")
	end
	
	if x and y then
		return dx:dxSetPosition(self.gui,x,y,relative,title)
	else
		return dx:dxGetPosition(self.gui,x)
	end
end

function dxSharedFunctions:Size(w,h,relative)
	if (type(self) ~= "table") then
		outputDebugString("calling method incorrectly ( object.method() )! use object:method()")
	end
	
	if type(w) == "number" then
		return dx:dxSetSize(self.gui,w,h,relative)
	else
		return dx:dxGetSize(self.gui,x)
	end
end

function dxSharedFunctions:Visible(visible)
	if (type(self) ~= "table") then
		outputDebugString("calling method incorrectly ( object.method() )! use object:method()")
	end
	
	if type(visible) == "boolean" then
		return dx:dxSetVisible(self.gui,visible)
	else
		return dx:dxGetVisible(self.gui)
	end
end

function dxSharedFunctions:Theme(theme)
	if (type(self) ~= "table") then
		outputDebugString("calling method incorrectly ( object.method() )! use object:method()")
	end
	
	if type(theme) == "dxTheme" then
		return dxSetTheme(self.gui,theme)
	else
		return dxGetTheme(self.gui)
	end
end

function dxSharedFunctions:Font(font)
	if (type(self) ~= "table") then
		outputDebugString("calling method incorrectly ( object.method() )! use object:method()")
	end
	
	if type(font)~="nil" then
		return dxSetFont(self.gui,font)
	else
		return dxGetFont(self.gui)
	end
end

function dxSharedFunctions:Color(color)
	if (type(self) ~= "table") then
		outputDebugString("calling method incorrectly ( object.method() )! use object:method()")
	end
	
	if type(color)~="nil" then
		return dxSetColor(self.gui,color)
	else
		return dxGetColor(self.gui)
	end
end

function dxSharedFunctions:ColorCoded(colorcoded)
	if (type(self) ~= "table") then
		outputDebugString("calling method incorrectly ( object.method() )! use object:method()")
	end
	
	if type(colorcoded)~="nil" then
		return dxSetColorCoded(self.gui,colorcoded)
	else
		return dxGetColorCoded(self.gui)
	end
end

function dxSharedFunctions:Text(text)
	if (type(self) ~= "table") then
		outputDebugString("calling method incorrectly ( object.method() )! use object:method()")
	end
	
	if type(text)~="nil" then
		return dxSetText(self.gui,text)
	else
		return dxGetText(self.gui)
	end
end

function dxSharedFunctions:Alpha(alpha)
	if (type(self) ~= "table") then
		outputDebugString("calling method incorrectly ( object.method() )! use object:method()")
	end
	
	if type(alpha)~="nil" then
		return dxSetAlpha(self.gui,alpha)
	else
		return dxGetAlpha(self.gui)
	end
end
-- Events
---------------------------------------------------- 

function dxSharedFunctions:AddOnClick(func) -- now available in button only.
	if (type(self) ~= "table") then
		outputDebugString("calling method incorrectly ( object.method() )! use object:method()")
	end
	
	if ( type(func) ~= "function" ) then
		return false
	end
	table.insert(self._click,func)
	return table.getn(self._click)
end

function dxSharedFunctions:RemoveOnClick(func) -- now available in button only.
	if (type(self) ~= "table") then
		outputDebugString("calling method incorrectly ( object.method() )! use object:method()")
	end
	
	if ( type(func) ~= "function" ) and (type(func) ~= "number") then
		return false
	end
	local _i = table.getn(self._click)
	if (type(func) == "number") then
		table.remove(self._click,func)
	else
		for i,f in ipairs(self._click) do 
			if ( f == func ) then 
				table.remove(self._click,i)
				break 
			end
		end
	end
	local __i = table.getn(self._click)
	if (_i == __i) then
		return false
	end
	return true
end

----------------------------------------------------
function dxSharedFunctions:AddOnMouseEnter(func)
	if (type(self) ~= "table") then
		outputDebugString("calling method incorrectly ( object.method() )! use object:method()")
	end
	
	if ( type(func) ~= "function" ) then
		return false
	end
	table.insert(self._mouseenter,func)
	return table.getn(self._mouseenter)
end

function dxSharedFunctions:RemoveOnMouseEnter(func)
	if (type(self) ~= "table") then
		outputDebugString("calling method incorrectly ( object.method() )! use object:method()")
	end
	
	if ( type(func) ~= "function" ) and (type(func) ~= "number") then
		return false
	end
	local _i = table.getn(self._mouseenter)
	if (type(func) == "number") then
		table.remove(self._mouseenter,func)
	else
		for i,f in ipairs(self._mouseenter) do 
			if ( f == func ) then 
				table.remove(self._mouseenter,i)
				break 
			end
		end
	end
	local __i = table.getn(self._mouseenter)
	if (_i == __i) then
		return false
	end
	return true
end

----------------------------------------------------
function dxSharedFunctions:AddOnMouseLeave(func)
	if (type(self) ~= "table") then
		outputDebugString("calling method incorrectly ( object.method() )! use object:method()")
	end
	
	if ( type(func) ~= "function" ) then
		return false
	end
	table.insert(self._mouseleave,func)
	return table.getn(self._mouseleave)
end

function dxSharedFunctions:RemoveOnMouseLeave(func)
	if (type(self) ~= "table") then
		outputDebugString("calling method incorrectly ( object.method() )! use object:method()")
	end
	
	if ( type(func) ~= "function" ) and (type(func) ~= "number") then
		return false
	end
	local _i = table.getn(self._mouseleave)
	if (type(func) == "number") then
		table.remove(self._mouseleave,func)
	else
		for i,f in ipairs(self._mouseleave) do 
			if ( f == func ) then 
				table.remove(self._mouseleave,i)
				break 
			end
		end
	end
	local __i = table.getn(self._mouseleave)
	if (_i == __i) then
		return false
	end
	return true
end

----------------------------------------------------

function dxSharedFunctions:AddOnChange(func)
	if (type(self) ~= "table") then
		outputDebugString("calling method incorrectly ( object.method() )! use object:method()")
	end
	
	if ( type(func) ~= "function" ) then
		return false
	end
	table.insert(self._change,func)
	return table.getn(self._change)
end

function dxSharedFunctions:RemoveOnChange(func)
	if (type(self) ~= "table") then
		outputDebugString("calling method incorrectly ( object.method() )! use object:method()")
	end
	
	if ( type(func) ~= "function" ) and (type(func) ~= "number") then
		return false
	end
	local _i = table.getn(self._change)
	if (type(func) == "number") then
		table.remove(self._change,func)
	else
		for i,f in ipairs(self._change) do 
			if ( f == func ) then 
				table.remove(self._change,i)
				break 
			end
		end
	end
	local __i = table.getn(self._change)
	if (_i == __i) then
		return false
	end
	return true
end

----------------------------------------------------

function dxSharedFunctions:AddOnPropertyChange(func)
	if (type(self) ~= "table") then
		outputDebugString("calling method incorrectly ( object.method() )! use object:method()")
	end
	
	if ( type(func) ~= "function" ) then
		return false
	end
	table.insert(self._propchange,func)
	return table.getn(self._propchange)
end

function dxSharedFunctions:RemoveOnPropertyChange(func)
	if (type(self) ~= "table") then
		outputDebugString("calling method incorrectly ( object.method() )! use object:method()")
	end
	
	if ( type(func) ~= "function" ) and (type(func) ~= "number") then
		return false
	end
	local _i = table.getn(self._propchange)
	if (type(func) == "number") then
		table.remove(self._propchange,func)
	else
		for i,f in ipairs(self._propchange) do 
			if ( f == func ) then 
				table.remove(self._propchange,i)
				break 
			end
		end
	end
	local __i = table.getn(self._propchange)
	if (_i == __i) then
		return false
	end
	return true
end
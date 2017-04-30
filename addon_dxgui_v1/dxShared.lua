--[[
/***************************************************************************************************************
*
*  PROJECT:     dxGUI
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        dxShared.lua
*  PURPOSE:     All shared functions.
*  DEVELOPERS:  Skyline <xtremecooker@gmail.com>
*
*  dxGUI is available from http://community.mtasa.com/index.php?p=resources&s=details&id=4871
*
****************************************************************************************************************/
]]
-- dxDrawColorText : by Aiboforcen from mtasa.com
-- Edited: Someone
-- Skyline's add: clip,wordBreak,postGUI options.And added maxWidth compatible
function dxDrawColorText(str, ax, ay, bx, by, color, scale, font, alignX, alignY,clip,wordBreak,postGUI)
	--local maxWidth = bx-ax

	local strAdded = 0
	if str:sub(1,1) ~= " " then
		str = " "..str
		strAdded = 1
	end
		if alignX then
		if alignX == "center" then
		  local w = dxGetTextWidth(str:gsub("#%x%x%x%x%x%x",""), scale, font)
		  ax = ax + (bx-ax)/2 - w/2
		 -- maxWidth = bx-ax
		elseif alignX == "right" then
		  local w = dxGetTextWidth(str:gsub("#%x%x%x%x%x%x",""), scale, font)
		  ax = bx - w
		-- maxWidth = bx-ax
		end
	  end
	 
	  if alignY then
		if alignY == "center" then
		  local h = dxGetFontHeight(scale, font)
		  ay = ay + (by-ay)/2 - h/2
		elseif alignY == "bottom" then
		  local h = dxGetFontHeight(scale, font)
		  ay = by - h
		end
	  end
		local f = 1
	  local pat = "(.-)#(%x%x%x%x%x%x)"
	  local s, e, cap, col = str:find(pat, 1)
	  local last = 1
		while s do
		if cap == "" and col then color = tocolor(tonumber("0x"..col:sub(1, 2)), tonumber("0x"..col:sub(3, 4)), tonumber("0x"..col:sub(5, 6)), 255) end
		if s ~= 1 or cap ~= "" then
		  local w = dxGetTextWidth(cap, scale, font)
		 --[[ if (w > maxWidth) then
			w = maxWidth
		  end

		  maxWidth = maxWidth-w]]
		  if (f == 1) and strAdded == 1 then
			cap = cap:sub(2)
			f = f+1
		  end
			if not clip then
			clip = false
			end
			if not wordBreak then
				wordBreak = false
			end
			if not postGUI then
				postGUI = false
			end
		  dxDrawText(cap, ax, ay, ax + w, by, color, scale, font,"left","top",clip,wordBreak,postGUI)
		  ax = ax + w
		  color = tocolor(tonumber("0x"..col:sub(1, 2)), tonumber("0x"..col:sub(3, 4)), tonumber("0x"..col:sub(5, 6)), 255)
		end
		last = e + 1
		s, e, cap, col = str:find(pat, last)
	  end
	  if last <= #str then
		cap = str:sub(last)
		local w = dxGetTextWidth(cap, scale, font)
		--[[if (w > maxWidth) then
			w = maxWidth
		  end

		  maxWidth = maxWidth-w
		]]
		if not clip then
			clip = false
		end
		if not wordBreak then
			wordBreak = false
		end
		if not postGUI then
			postGUI = false
		end
		if ( f == 1) and strAdded==1 then
			cap = cap:sub(2)
		end
		f = f+1
		dxDrawText(cap, ax, ay, ax + w, by, color, scale, font,"left","top",clip,wordBreak,postGUI)
	end
end

function toHex(x)
	return string.format("%x",x)
end

function intersect(x,y,x2,y2,posx,posy)
	if (posx >= x and posx<=x2) and (posy >= y and posy<=y2) then
		return true
	end
	return false
end

function string:tobool()
	if self == "true" then
		return true
	else
		return false
	end
end

function relativeToAbsolute(xcoord,ycoord)
	local x,y = guiGetScreenSize()
	local rx = x*xcoord
	local ry = y*ycoord
	return rx,ry
end

function getCursorAbsolute()
	if (not isCursorShowing()) then
		return false
	end
	local scx,scy,wx,wy,wh = getCursorPosition()
	local x,y = relativeToAbsolute(scx,scy)
	return x,y
end

function table.reverse ( tab )
    local size = #tab
    local newTable = {}
 
    for i,v in ipairs ( tab ) do
        newTable[size-i] = v
    end
 
    return newTable
end
--[[
/***************************************************************************************************************
*
*  PROJECT:     dxGUI
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        dxAnimation.lua
*  PURPOSE:     Animation Functions
*  DEVELOPERS:  Skyline <xtremecooker@gmail.com>
*
*  dxGUI is available from http://community.mtasa.com/index.php?p=resources&s=details&id=4871
*
****************************************************************************************************************/
]]
function dxMove(dxElement,xMove,yMove,titleMove)
	if not dxElement or not xMove or not yMove then
		outputDebugString("dxMove gets wrong parameters (dxElement,xMove,yMove[,titleMove=true])")
		return
	end

	if titleMove == nil then
		titleMove = true
	end
	local x,y,tx,ty = dxGetPosition(dxElement)
	move = function()
		local movex,movey,movetx,movety = false,false,false,false
		local xx,yy,txx,tyy = dxGetPosition(dxElement)
		if ( xx ~= x+xMove ) then
			if (xx > x+xMove ) then
				xx = xx - 1
			else
				xx = xx + 1
			end
		else
			movex = true
		end
		
		if (yy ~= y+yMove) then
			if (yy > y+yMove) then
				yy = yy -1
			else
				yy = yy +1
			end
		else
			movey = true
		end
		
		if (tx) then
			if ( txx ~= tx+xMove ) then
				if (txx > tx+xMove ) then
					txx = txx - 1
				else
					txx = txx + 1
				end
			else
				movetx = true
			end
		else
			movetx = true
		end
		
		if (ty) then
			if ( tyy ~= ty+yMove ) then
				if (tyy > ty+yMove ) then
					tyy = tyy - 1
				else
					tyy = tyy + 1
				end
			else
				movety = true
			end
		else
			movety = true
		end
		
		dxSetPosition(dxElement,xx,yy,false,false)
		if (titleMove and getElementType(dxElement) == "dxWindow") then
			dxWindowSetTitlePosition(dxElement,txx,tyy)
		end
		if movex and movey and movetx and movety then
			removeEventHandler('onClientRender',getRootElement(),move)
			triggerEventHandler('onClientDXMove',dxElement,xx,yy,txx,tyy)
		end
	end
	addEventHandler('onClientRender',getRootElement(),move)
end

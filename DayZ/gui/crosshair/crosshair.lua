local sx, sy = guiGetScreenSize()
local size = 64
local cursorX, cursorY = 0, 0
local clicked = false
local crosshair = ""
local isFiring = 0

setPlayerHudComponentVisible("crosshair", false)

local crosshairTable = {

{0,"dot"},
{2,"dot"},
{4,"dot"},
{5,"dot"},
{6,"dot"},
{8,"dot"},
{22,"pistol"},
{23,"pistol"},
{24,"pistol"},
{25,"shotgun"},
{26,"shotgun"},
{27,"shotgun"},
{28,"mp"},
{29,"mp"},
{30,"rifle"},
{31,"rifle"},
{33,"hunting"},
{34,"none"},
{43,"none"},
{16,"dot"},
{17,"dot"},
}

function setCrossHairSize(weapon)
	if isFiring < 48 then
		isFiring = isFiring+2.4
	end
end
addEventHandler("onClientPlayerWeaponFire",localPlayer,setCrossHairSize)

function drawCrosshair()
	if getElementData(localPlayer,"fracturedArms") then return end
    local hX,hY,hZ = getPedTargetEnd ( getLocalPlayer() )
    local screenX1, screenY1 = getScreenFromWorldPosition ( hX,hY,hZ )
	if screenX1 then
		for i, cross in ipairs(crosshairTable) do
			if getPedWeapon(localPlayer) == cross[1] then
				crosshair = cross[2]
			end
		end
		if not getControlState("fire") then
			isFiring = isFiring-1.2
			if isFiring < 0 then
				isFiring = 0
			end
		end
		if getPedWeapon(localPlayer) == 34 then
			setPlayerHudComponentVisible("crosshair", true)
		else
			setPlayerHudComponentVisible("crosshair", false)
		end
		if getPedWeapon(localPlayer) == 22 and getElementData(localPlayer,"currentweapon_2") == "Flashlight" then
			crosshair = "none"
		end
		dxDrawImage(screenX1-((size+isFiring)/2)+1, screenY1-((size+isFiring)/2)-1, size+isFiring, size+isFiring, ":DayZ/gui/crosshair/"..crosshair..".png", 0,0,0, tocolor(0,0,0,255))
		dxDrawImage(screenX1-((size+isFiring)/2)-1, screenY1-((size+isFiring)/2)+1, size+isFiring, size+isFiring, ":DayZ/gui/crosshair/"..crosshair..".png", 0,0,0, tocolor(0,0,0,255))
		dxDrawImage(screenX1-((size+isFiring)/2)-1, screenY1-((size+isFiring)/2)-1, size+isFiring, size+isFiring, ":DayZ/gui/crosshair/"..crosshair..".png", 0,0,0, tocolor(0,0,0,255))
		dxDrawImage(screenX1-((size+isFiring)/2)+1, screenY1-((size+isFiring)/2)+1, size+isFiring, size+isFiring, ":DayZ/gui/crosshair/"..crosshair..".png", 0,0,0, tocolor(0,0,0,255))
		dxDrawImage(screenX1-((size+isFiring)/2), screenY1-((size+isFiring)/2), size+isFiring, size+isFiring, ":DayZ/gui/crosshair/"..crosshair..".png", 0,0,0, tocolor(123,247,96,255))
	end
end 

bindKey("aim_weapon", "both", function(key, state)       
    local weapon = getPedWeapon(getLocalPlayer())
	if gameplayVariables["difficulty"] and gameplayVariables["difficulty"] == "hardcore" then return end
	if weapon ~= 0 and weapon ~=1 then
        if state == "down" then 
            addEventHandler("onClientRender", root, drawCrosshair)
        else
            removeEventHandler("onClientRender", root, drawCrosshair)
			isFiring = 0
        end 
    end
end)
local x, y = 200, 200
local recx, recy = 200, 200
local recw, rech = 560, 200
local eastype = "OutElastic"
 
local totallines = 10
local nbToSkip = 0
 
local playersTable = getElementsByType("player")
setTimer(function()
    playersTable = getElementsByType("player")
end, 3000, 0)
 
local selectedPlayer = playersTable[1]

 

function performRender()
    local tick = getTickCount()
    local endTime = tickk + 3000
    local laufzeit = tick - tickk
    local dauer = endTime - tickk
    local progress = laufzeit/dauer
    local recintw, recinth, _ = interpolateBetween(x, y, 0, recw, rech, 0, progress, eastype)
    local recintx, recinty, _ = interpolateBetween(0, 0, 0, recx, recy, 0, progress, eastype)
    dxDrawRectangle(recintx, recinty, recintw, recinth, tocolor(101, 101, 101, 100), false)
    dxDrawRectangle(recintx+10, recinty+10, 180, 180, tocolor(50, 50, 50, 200), false)
 
    local line = 0
    for k, player in ipairs (playersTable) do
        if k > nbToSkip and line < totallines-1 then
            local nameplayer = getPlayerName(player)
            if player == selectedPlayer or line == 0 then
                dxDrawRectangle(recintx+10, recinty+10+line*20, 180, 20, tocolor(0, 192, 252, 80), false)
				--dxDrawRectangle(recintx+10, recinty+10+line+1*20, 180, 20, tocolor(0, 192, 252, 80), false)
            end
            dxDrawText(nameplayer, recintx+15, recinty+10+line*20, recintx+15+180, recinty+12+line*20+20, tocolor(255,255,255,255), 1, "default-bold", "left", "center", false, false, true, true)
            --dxDrawText("Bot~1", recintx+15, recinty+10+line+1*20, recintx+15+180, recinty+12+line+1*20+20, tocolor(255,255,255,255), 1, "default-bold", "left", "center", false, false, true, true)
			line = line + 1
        end
    end
 
    -- Drawing details only
	local ping = getPlayerPing(selectedPlayer)
    local nameplayer = getPlayerName(selectedPlayer) or "Undefined"
	local level = getElementData(selectedPlayer,"lvl")or 0
    local money = getPlayerMoney(selectedPlayer) or 0
    local country = getElementData(selectedPlayer, "country") or "N/A"
    local playerX, playerY, playerZ = getElementPosition( selectedPlayer )
    local zone = getZoneName( playerX, playerY, playerZ )
    if getElementData(selectedPlayer,"rank") then
        local rank = getElementData(selectedPlayer,"rank")
        cadena = "ranks/"..rank..".png"
    else
        --cadena = "ranks/1.png"
    end
	local rR,gG,bB = math.random(0,255), math.random(0,255), math.random(0,255)
	local pl = getElementsByType("player")
    dxDrawImage( recintx+400, recinty+30, 150, 150, cadena)
    dxDrawText("DayZ Scoreboard 1.0", recintx+435, (recinty+180), x, y, tocolor(255,255,255, 150), 1, "default", "left", "top", false, false, true, true)
    dxDrawText(nameplayer, recintx+300, (recinty+10), x, y, tocolor(255, 255, 255, 255), 2, "default", "left", "top", false, false, true, true)
	dxDrawText("( "..tostring(#pl).."/100 )", recintx+490, (recinty+10), x, y, tocolor(255, 255, 255, 255), 1.2, "default", "left", "top", false, false, true, true)
    dxDrawText("Level: "..level, recintx+200, (recinty+40), x, y, tocolor(255, 255, 255, 255), 1, "default-bold", "left", "top", false, false, true, false)
    dxDrawText("Money: "..money,recintx+200, (recinty+60), x, y, tocolor(255, 255, 255, 255), 1, "default-bold", "left", "top", false, false, true, false)
    dxDrawText("City: "..zone, recintx+200, (recinty+80), x, y, tocolor(255, 255, 255, 255), 1, "default-bold", "left", "top", false, false, true, false)
    dxDrawText("Ping: "..ping, recintx+200, (recinty+120), x, y, tocolor(255, 255, 255, 255), 1, "default-bold", "left", "top", false, false, true, false)
    dxDrawText("Country: "..country, recintx+200, (recinty+100), x, y, tocolor(255, 255, 255, 255), 1, "default-bold", "left", "top", false, false, true, false)
	dxDrawText("DayZ 0.9.0a", recintx+250, (recinty+173), x, y, tocolor(255, 255, 255, 255), 1.3, "default-bold", "left", "top", false, false, false, false)
end
es = false
function tabular(key, keyState, arguments)
if es == false then
tickk = getTickCount()
addEventHandler("onClientRender",root,performRender)
--showCursor(true)
es = true
elseif es == true then
removeEventHandler("onClientRender",root,performRender)
--showCursor(false)
es = false
end
end

--addEventHandler("onClientRender",root, render)
addCommandHandler("toggle",tabular)
bindKey("tab","down","toggle","1")
 
function scrolling( _, _, side)
    outputChatBox(side)
    if side == "down" then
        nbToSkip = nbToSkip + 1
    elseif side == "up" then
        nbToSkip = nbToSkip - 1
    end
    if nbToSkip < 0 then nbToSkip = 0 end
    if nbToSkip >= #playersTable then nbToSkip = #playersTable-1 end
    selectedPlayer = playersTable[nbToSkip+1]
end


function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end


bindKey("mouse_wheel_up", "down", scrolling, "up")
bindKey("mouse_wheel_down", "down", scrolling, "down")
function onJoin()
	local cn = exports.admin:getPlayerCountry(source)
	setElementData(source,"country",cn)
end
addEventHandler("onPlayerJoin",root,onJoin)

function changeR(me,cmd,player,rank)
local acc = getPlayerAccount(me)
local accN = getAccountName(acc)
local rank = tonumber(rank)
local player = findPlayer(player)
local pAcc = getPlayerAccount(player)
if not isGuestAccount(acc) and not isGuestAccount(pAcc) and isObjectInACLGroup( "user."..accN, aclGetGroup( "Admin" ) ) then
	setElementData(player,"rank",rank)
	setAccountData( pAcc, "rank", rank )
	outputChatBox("[RANK] The player "..getPlayerName(me).." #0000ffchanged your rank to "..tostring(rank),player,0,0,255,true)
	outputChatBox("[RANK] You changed "..getPlayerName(player).." #0000ffrank to "..tostring(rank),me,0,0,255,true)
else
	outputChatBox("[RANK] Parameter error. Use /rank PLAYERNAME N°RANK",me,255,0,0,true)
end
end
addCommandHandler("rank",changeR)
function onLogin(_,acc)
	local rank = getAccountData(acc,"rank")
	if rank then
	setElementData(source,"rank",rank)
end
end
addEventHandler("onPlayerLogin",root,onLogin)

--[[Utiles]]--

function findPlayer(name)
    local name = name and name:gsub("#%x%x%x%x%x%x", ""):lower() or nil
    if name then
        for _, player in ipairs(getElementsByType("player")) do
            local name_ = getPlayerName(player):gsub("#%x%x%x%x%x%x", ""):lower()
            if name_:find(name, 1, true) then
                return player
            end
        end
    end
end
function onJoin()
	local cn = exports.admin:getPlayerCountry(source)
	setElementData(source,"country",cn)
end
addEventHandler("onPlayerJoin",root,onJoin)

function getServerDetails()
	serverName = getServerName()
	triggerClientEvent("getTheServerName",root,serverName)
end
setTimer(getServerDetails,1000,1)

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
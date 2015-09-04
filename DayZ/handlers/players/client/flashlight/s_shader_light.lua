--
--s_shader_light.lua
--


local isFlon = {}
local isFlen = {}

function remotePlayerJoin()
isFlon[source]=false
isFlen[source]=false
for _,playa in ipairs(getElementsByType("player")) do		
	triggerClientEvent (source,"flashOnPlayerEnable",getRootElement(),isFlen[playa],playa)
	triggerClientEvent (source,"flashOnPlayerSwitch",getRootElement(),isFlon[playa],playa)
	end		
end

function remotePlayerQuit()
if getElementType ( source ) == "player" then
	isFlon[source]=false
	isFlen[source]=false
	triggerClientEvent ("flashOnPlayerQuit",getRootElement(),source)
	end
end

function remoteSwitch(isON)
	isFlon[source]=isON 
	triggerClientEvent ("flashOnPlayerSwitch",getRootElement(),isFlon[source],source)
 end

function remoteEnable(isEN)
	isFlen[source]=isEN 
	triggerClientEvent ("flashOnPlayerEnable",getRootElement(),isFlen[source],source)
end
 

addEventHandler("onPlayerQuit", getRootElement(), remotePlayerQuit)

addEvent("onPlayerStartRes",true)
addEventHandler("onPlayerStartRes", getRootElement(), remotePlayerJoin)

addEvent("onSwitchLight",true)
addEventHandler("onSwitchLight", getRootElement(), remoteSwitch)

addEvent("onSwitchEffect",true)
addEventHandler("onSwitchEffect", getRootElement(), remoteEnable)
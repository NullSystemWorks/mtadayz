--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: skins_player.lua						*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]

function getSkinIDFromName(name)
	for i,skin in ipairs(skinTable) do
		if name == skin[1] then
			return skin[2]
		end
	end
end

function getSkinNameFromID(id)
	for i,skin in ipairs(skinTable) do
		if id == skin[2] then
			return skin[1]
		end
	end
end

function addPlayerSkin(skin)
	local current = getElementData(source,"skin")
	local name = getSkinNameFromID(current)
	local id = getSkinIDFromName(skin)
	local gender = getElementData(source,"gender")
	if gender == "female" then
		if id == 172 or id == 192 or id == 285 then
			setElementData(source,skin,getElementData(source,skin)-1)
			setElementData(source,"skin",id)
			setElementModel(source,id)
			triggerClientEvent(source,"refreshInventoryManual",source)
		else
			outputChatBox("You can't wear this!",source,255,0,0,true)
		end
	else
		if id == 172 or id == 192 then
			outputChatBox("You can't wear this!",source,255,0,0,true)
		else
			setElementData(source,skin,getElementData(source,skin)-1)
			setElementData(source,"skin",id)
			setElementModel(source,id)
			triggerClientEvent(source,"refreshInventoryManual",source)
		end
	end
end
addEvent("onPlayerChangeSkin",true)
addEventHandler("onPlayerChangeSkin",getRootElement(),addPlayerSkin)

function checkBandit ()
	for i, player in ipairs(getElementsByType("player")) do
		if getElementData(player,"logedin") then
			local current = getElementData(player,"skin")
			if getElementData(player,"bandit") then
				if getElementData(player,"gender") == "male" then
					if current == 179 or current == 287 then
						setElementModel(player,288)
					elseif current == 73 then
						setElementModel(player,180)
					end
				elseif getElementData(player,"gender") == "female" then
					if current == 192 then
						setElementModel(player,191)
					elseif current == 172 then
						setElementModel(player,211)
					end
				end
			elseif getElementData(player,"humanity") == 5000 then
				if current == 73 or current == 179 or current == 287 or current == 172 or current == 192 then
					setElementModel(player,210)
				end
			else
				setElementModel(player,current)
			end
		end
	end
end
setTimer(checkBandit,20000,0)
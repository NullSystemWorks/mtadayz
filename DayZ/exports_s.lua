--[[

	Author: CiBeR
	Version: 0.1
	Copyright: DayZ Gamemode. Al rights reserved to Developers
	Current Devs: Lawliet, CiBeR
	
]]--
function setPlayerBlood(player,blood)
	if isElement(player) and ( getElementType(player) == "player" ) and blood then
		setElementData(player,"blood",blood)
	end
end
function setPlayerMurders(player,murders)
	if isElement(player) and ( getElementType(player) == "player" ) and murders then
		setElementData(player,"murders",murders)
	end
end
function setPlayerZombies(player,zkill)
	if isElement(player) and ( getElementType(player) == "player" ) and zkill then
		setElementData(player,"zombieskilled",zkill)
	end
end
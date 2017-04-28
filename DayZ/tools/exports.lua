--[[

	Author: CiBeR
	Version: 0.2
	Copyright: DayZ Gamemode. All rights reserved to Developers
	Current Devs: Lawliet, CiBeR, Jboy

	
]]--

-- [[ Exported functions ]] --
--[[ 
getPlayerBlood - Arguments: element player. Returns: Amount of blood the player has (int)
setPlayerBlood - Arguments: element player, int amount. Effect: sets player's blood to specified amount
getPlayerZombiesKilled - Arguments: element player. Returns: Amount of zombies player has killed (int)
setPlayerZombiesKilled - Arguments: element player, int amount. Effect: sets amount of killed zombies for player to specified value

getPlayerHeadshots - Arguments: element player. Returns: Amount of head shots player has delivered (int)
setPlayerHeadshots - Arguments: element player, int amount. Effect: sets amount of head shots player has delivered to specified value
getPlayerMurders - Arguments: element player. Returns: Amount of murders player has committed (int)
setPlayerMurders - Arguments: element player, int amount. Effect: sets amount of murders to specified value

getPlayerBanditsKilled - Arguments: element player. Returns: Amount of bandits player has killed
setPlayerBanditsKilled - Arguments: element player, int amount. Effect: sets amount of killed bandits to specified value
getPlayerTemperature - Arguments: element player. Returns: Temperature of player (int)
setPlayerTemperature - Arguments: element player, int amount. Effect: sets temperature to specified value

getPlayerHumanity - Arguments: element player. Returns: Humanity of player (int)
setPlayerHumanity - Arguments: element player, int amount. Effect: sets humanity to specified value
getActualTime - No Arguments. Returns Actual Real Time, Format: HH:MM:SS
getDayZVersion - No Arguments. Returns running DayZ version

setGameplayVariablesClient - Arguments: variable name, variable value. Effect: Create or set a GameplayVariable [CLIENT Only]
setGameplayVariablesServer - Arguments: variable name, variable value. Effect: Create or set a GameplayVariable [SERVER Only]

getGameplayVariablesClient - Arguments: variable name. Returns: Value of the variable [CLIENT Only]
getGameplayVariablesServer - Arguments: variable name. Returns: Value of the variable [SERVER Only]
setGameplayVariable - Arguments: variable name, variable value. Effect: Create or set a GameplayVariable [SHARED]
getGameplayVariable - Arguments: variable name. Returns: Value of the variable [SHARED]
]]

-- [[ VERSION HANDLER ]]
function getDayZVersion()
	return "0.9.9a"
end

-- [[ Player Blood Functions ]] --
function setPlayerBlood(player,blood)
	if isElement(player) and ( getElementType(player) == "player" ) and blood then
		setElementData(player,"blood",blood)
	end
end

function getPlayerBlood(player)
	if isElement(player) and (getElementType(player) == "player") then
		local blood = getElementData(player,"blood")
		return blood
	end
end

-- [[ Player Zombies Functions ]] --
function setPlayerZombiesKilled(player,zkill)
	if isElement(player) and ( getElementType(player) == "player" ) and zkill then
		setElementData(player,"zombieskilled",zkill)
	end
end

function getPlayerZombiesKilled(player)
	if isElement(player) and (getElementType(player) == "player") then
		local murders = getElementData(player,"zombieskilled")
		return murders
	end
end


-- [[ Player Headshots Function ]] --
function setPlayerHeadshots(player,headshots)
	if isElement(player) and ( getElementType(player) == "player" ) and headshots then
		setElementData(player,"headshots",headshots)
	end
end

function getPlayerHeadshots(player)
	if isElement(player) and (getElementType(player) == "player") then
		local headshots = getElementData(player,"headshots")
		return headshots
	end
end

-- [[ Player Murders Function ]] --
function setPlayerMurders(player,murders)
	if isElement(player) and ( getElementType(player) == "player" ) and murders then
		setElementData(player,"murders",murders)
	end
end

function getPlayerMurders(player)
	if isElement(player) and (getElementType(player) == "player") then
		local murders = getElementData(player,"murders")
		return murders
	end
end


-- [[ Player Bandits Killed Function ]] --
function setPlayerBanditsKilled(player,bkill)
	if isElement(player) and ( getElementType(player) == "player" ) and bkill then
		setElementData(player,"banditskilled",bkill)
	end
end

function getPlayerBanditsKilled(player)
	if isElement(player) and (getElementType(player) == "player") then
		local bkill = getElementData(player,"banditskilled")
		return bkill
	end
end


-- [[ Player Temperature Function ]] --
function setPlayerTemperature(player,temperature)
	if isElement(player) and ( getElementType(player) == "player" ) and temperature then
		setElementData(player,"temperature",temperature)
	end
end

function getPlayerTemperature(player)
	if isElement(player) and (getElementType(player) == "player") then
		local temperature = getElementData(player,"temperature")
		return temperature
	end
end


-- [[ Player Humanity Function ]] --
function setPlayerHumanity(player,humanity)
	if isElement(player) and ( getElementType(player) == "player" ) and humanity then
		setElementData(player,"humanity",humanity)
	end
end

function getPlayerHumanity(player)
	if isElement(player) and (getElementType(player) == "player") then
		local humanity = getElementData(player,"humanity")
		return humanity
	end
end

function getActualTime()
		local theTime = getRealTime()
		local hour = theTime.hour
		local minute = theTime.minute
		local seconds = theTime.second
		if hour < 10 then
			hour = "0"..hour
		else
			hour = theTime.hour
		end
		if minute < 10 then
			minute  = "0"..minute
		else
			minute = theTime.minute
		end
		if seconds < 10 then
			minute = "0"..seconds
		else
			seconds = theTime.second
		end
		return hour, minute, seconds
end

function getGameplayVariablesServer()
local variablesTable = {}
	for key, var in pairs(gameplayVariables) do
		table.insert(variablesTable,{key,var})
	end
	return variablesTable
end

function getGameplayVariablesServerPairs() -- Proposed format
local variablesTable = {}
	for key, var in pairs(gameplayVariables) do
		-- OLD: table.insert(variablesTable,{key,var})
		variablesTable[key] = var -- UPDATE: Made it easy to get variable: getGameplayVariablesServer()["var"] instead of a loop to get info
	end
	return variablesTable
end

function getGameplayVariablesClient()
local variablesTable = {}
	for key, var in pairs(gameplayVariables) do
		table.insert(variablesTable,{key,var})
	end
	return variablesTable
end


function setGameplayVariable(var,value)
	if gameplayVariables[var] ~= nil then
		gameplayVariables[var] = value
	end
end

function getGameplayVariable(var)
	return gameplayVariables[var]
end




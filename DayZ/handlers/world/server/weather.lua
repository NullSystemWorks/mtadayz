--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: weather.lua							*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]

DaysPassed = 0
Season = false
local timeTimer = 10000
local realtime = getRealTime()
setTime(realtime.hour, realtime.minute)
setFarClipDistance(1000)

function checkSetTime()
	if gameplayVariables["realtime"] then
		local realtime = getRealTime()
		setTime(realtime.hour, realtime.minute)
		setMinuteDuration(60000)
		timeTimer = 60000
	else
		local hours,minute = getTime()
		setTime(hours,minute)
		setMinuteDuration(gameplayVariables["customtime"])
		timeTimer = gameplayVariables["customtime"]
	end
end
setTimer(checkSetTime,timeTimer,0)

function addDaysPassed()
local hours,minute = getTime()
	if hours == 0 and minute == 1 then
		DaysPassed = DaysPassed+1
	end
end
setTimer(addDaysPassed,10000,0)

function resetDaysPassed()
	if DaysPassed == 364 then
		DaysPassed = 0
	end
end
setTimer(resetDaysPassed,10000,0)

function setSeason()
	if DaysPassed == 0 then
		Season = "Winter"
	elseif DaysPassed == 91 then
		Season = "Spring"
	elseif DaysPassed == 182 then
		Season = "Summer"
	elseif DaysPassed == 273 then
		Season = "Autumn"
	end
end
setTimer(setSeason,10000,0)

WeatherTable = {

["Winter"] = {
	{15}, -- Snow
	{1},
	{4},
},

["Spring"] = {
	{2},
	{16},
	{5},
},
	
["Summer"] = {
	{0},
	{16},
	{18},
},
	
["Autumn"] = {
	{7},
	{9},
	{15}, -- Snow
	
},
}
--[[
function setTheWeather()
local number = math.random(1,3)
	if Season == "Winter" then
		if number == 1 then
			setWeather(15)
		elseif number == 2 then
			setWeather(1)
		elseif number == 3 then
			setWeather(4)
		end
	elseif Season == "Spring" then
		if number == 1 then
			setWeather(1)
		elseif number == 2 then
			setWeather(16)
		elseif  number == 3 then
			setWeather(5)
		end
	elseif Season == "Summer" then
		if number == 1 then
			setWeather(0)
		elseif number == 2 then
			setWeather(16)
		elseif number == 3 then
			setWeather(18)
		end
	elseif Season == "Autumn" then
		if number == 1 then
			setWeather(4)
		elseif number == 2 then
			setWeather(9)
		elseif number == 3 then
			setWeather(15)
		end
	end
end
setTimer(setTheWeather,math.random(1800000,3600000),0)
]]

local initializeWeather = false
local weatherRandomizer = 1800000

if not initializeWeather then
	setWeather(math.random(14,16))
	initializeWeather = true
end

function setTheWeather()
	local number = math.random(0,18)
	weatherRandomizer = math.random(600000,1800000)
	setWeatherBlended(number)
	
	if number == 8 then
		setFarClipDistance(400)
	elseif number == 9 then
		setFarClipDistance(200)
	else
		setFarClipDistance(900)
	end
end
setTimer(setTheWeather,weatherRandomizer,0)
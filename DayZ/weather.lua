--[[
#---------------------------------------------------------------#
----*			DayZ MTA Script weather.lua				    *----
----* This Script is owned by Marwin, you are not allowed to use or own it.
----* Owner: Marwin W., Germany, Lower Saxony, Otterndorf
----* Skype: xxmavxx96
----* Developers: L, CiBeR,	Jboy							*----
#---------------------------------------------------------------#
]]

DaysPassed = 0
Season = false
local realtime = getRealTime()
setTime(realtime.hour, realtime.minute)
setMinuteDuration(2000)
setFarClipDistance(1000)
setFogDistance(100)

function checkSetTime()
	local hours,minute = getTime()
    setTime(hours, minute)
    setMinuteDuration(10000)
end
setTimer(checkSetTime,10000,0)

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

function setNight (hour,minutes)
	if gameplayVariables["enablenight"] then
		if hour == 21 then
			setSkyGradient(0, 100/minutes, 196/minutes, 136/minutes, 170/minutes, 212/minutes)
			setFarClipDistance(120+(880-minutes*14.6))
			setFogDistance(-150+(250-minutes*4.16))
		elseif hour == 7 then
			setSkyGradient( 0, 1.6*minutes, 196*3.26, 136*2.26, 170*2.83, 212*3.53 )
			setFarClipDistance(120+(minutes*14.6))
			setFogDistance(-150+(minutes*4.16))
		elseif hour == 22 or hour == 23 then
			setSkyGradient( 0, 0, 0, 0, 0, 0 )
			setFarClipDistance(120)
			setFogDistance(-150)
		elseif hour >= 0 and hour <= 7 then
			setSkyGradient( 0, 0, 0, 0, 0, 0 )
			setFarClipDistance(120)
			setFogDistance(-150)
		else
			setSkyGradient(0, 100, 196, 136, 170, 212)
			setFarClipDistance(1000)
			setFogDistance(100)
		end
	end
end

function setNightTime()
	if not true then return end
	local hour, minutes = getTime()
	setNight (hour,minutes)
end
--setTimer(setNightTime,60000,0)
--setNightTime()

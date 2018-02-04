--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: weather.lua							*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]

local timeTimer = 10000
local realtime = getRealTime()
setTime(realtime.hour, realtime.minute)

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

local initializeWeather = false
local weatherRandomizer = 1800000

if not initializeWeather then
	setWeather(math.random(0,18))
	local x,y,z = math.random(0,15),math.random(0,15),math.random(0,15)
	setWindVelocity(x,y,z)
	initializeWeather = true
end

function setTheWeather()
	local number = math.random(0,18)
	weatherRandomizer = math.random(600000,1800000)
	setWeatherBlended(number)
end
setTimer(setTheWeather,weatherRandomizer,0)

function setRainOnCloudyWeather()
local weather = getWeather()
	if weather == 4 or weather == 7 or weather == 12 or weather == 15 then
		local shouldItRain = math.random(0,100)
		if shouldItRain > 74 then
			setRainLevel(math.random())
		else
			if getRainLevel() and getRainLevel() > 0 then
				setRainLevel(0)
			end
		end
	end
end
setTimer(setRainOnCloudyWeather,1200000,0)

function setRandomWindVelocity()
	local x,y,z = math.random(0,15),math.random(0,15),math.random(0,15)
	setWindVelocity(x,y,z)
end
setTimer(setRandomWindVelocity,300000,0)
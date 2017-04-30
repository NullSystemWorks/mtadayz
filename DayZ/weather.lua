
local realtime = getRealTime()
setTime(realtime.hour, realtime.minute)
setMinuteDuration(60000)
setSkyGradient(0, 100, 196, 136, 170, 212)
setFarClipDistance(1000)
setFogDistance(100)

function checkSetTime()
    local realtime = getRealTime()
    setTime(realtime.hour, realtime.minute)
    setMinuteDuration(60000)
end
setTimer(checkSetTime,60000,0)



function setWeather2()
	local number = math.random(1,6)
	if number == 2 then
		setWeather ( 7 )
	elseif number == 3 then
		setWeather ( 12 )
	elseif number == 4 then
		setWeather ( 7 )
	elseif number == 5 then
		setWeather ( 4 )	
	end
end
setTimer(setWeather2,3600000,0)
setWeather2()


function setNight (hour,minutes)
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

function setNightTime()
	if not gameplayVariables["enablenight"] then return end
	local hour, minutes = getTime()
	setNight (hour,minutes)
end
setTimer(setNightTime,60000,0)
setNightTime()

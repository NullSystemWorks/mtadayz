--
-- c_helper_functions.lua
-- 

---------------------------------------------------------------------------------------
-- original code from faza3 delphi command line application
-- cybermoon.w.interia.pl
---------------------------------------------------------------------------------------
function toint(n)
    local s = tostring(n)
    local i = s:find('%.')
    if i then
        return tonumber(s:sub(1, i-1))
    else
        return n
    end
end

function rang(x)
    local b = x / 360
    local a = 360 * ( b - toint( b ))
    if ( a < 0 ) then 
		a = a + 360 
	end
    return a
end

function faza(Rok, Miesiac, Dzien, godzina, minuta, sekunda)
local A, b, phi1, phi2, jdp, tzd, elm, ams, aml, asd
    if (Miesiac > 2) then
        Miesiac = Miesiac
        Rok = Rok
	end
	if Miesiac <= 2 then
		Miesiac = Miesiac + 12
		Rok = Rok - 1
	end

	local A = toint(Rok / 100)
	local b = 2 - A + toint(A / 4)

	jdp = toint(365.25 * (Rok + 4716)) + toint(30.6001 * (Miesiac + 1)) + Dzien + b + ((godzina + minuta / 60 + sekunda / 3600) / 24) - 1524.5
	jdp = jdp
	tzd = (jdp - 2451545) / 36525
	elm = rang(297.8502042 + 445267.1115168 * tzd - (0.00163 * tzd * tzd) + tzd * tzd * tzd / 545868 - (tzd * tzd * tzd * tzd) / 113065000);
	ams = rang(357.5291092 + 35999.0502909 * tzd - 0.0001536 * tzd * tzd + tzd * tzd * tzd / 24490000)
	aml = rang(134.9634114 + 477198.8676313 * tzd - 0.008997 * tzd * tzd + tzd * tzd * tzd / 69699 - (tzd * tzd * tzd * tzd) / 14712000);
	asd = 180 - elm -   (6.289 * math.sin((3.1415926535 / 180) * aml)) +
                    (2.1 * math.sin((3.1415926535 / 180) * ((ams)))) -
                    (1.274 * math.sin((3.1415926535 / 180) * ((2 * elm) - aml))) -
                    (0.658 * math.sin((3.1415926535 / 180) * (2 * elm))) -
                    (0.214 * math.sin((3.1415926535 / 180) * (2 * aml))) -
                    (0.11 * math.sin((3.1415926535 / 180) * elm))
	phi1 = ((1 + math.cos((3.1415926535 / 180) * (asd))) / 2)


	tzd = (jdp + (0.5 / 24) - 2451545) / 36525
	elm = rang(297.8502042 + 445267.1115168 * tzd - (0.00163 * tzd * tzd) + (tzd * tzd * tzd) / 545868 - (tzd * tzd * tzd * tzd) / 113065000)
	ams = rang(357.5291092 + 35999.0502909 * tzd - (0.0001536 * tzd * tzd) + (tzd * tzd * tzd) / 24490000)
	aml = rang(134.9634114 + 477198.8676313 * tzd - (0.008997 * tzd * tzd) + (tzd * tzd * tzd) / 69699 - (tzd * tzd * tzd * tzd) / 14712000)
	asd= 180 - elm -   (6.289 * math.sin((3.1415926535 / 180) * ((aml)))) +
                    (2.1 * math.sin((3.1415926535 / 180) * ams)) -
                    (1.274 * math.sin((3.1415926535 / 180) * ((2 * elm) - aml))) -
                    (0.658 * math.sin((3.1415926535 / 180) * (2 * elm))) -
                    (0.214 * math.sin((3.1415926535 / 180) * (2 * aml))) -
                    (0.11 * math.sin((3.1415926535 / 180) * elm))
	phi2 = ((1 + math.cos((3.1415926535 / 180) * (asd))) / 2)

	if ( phi2 - phi1 ) < 0 then 
		phi1 = -phi1 
	end
	return phi1
end

function getCurrentMoonPhase()
	local getTime = getRealTime()
	local faze = faza( getTime.year + 1900, getTime.month + 1, getTime.monthday, getTime.hour, getTime.minute, getTime.second )
	if faze >= 0 then 
		return 1 - ( faze / 2  )
	else
		if faze < 0 then 
			return 1 - (( 2 + faze ) / 2 )
		end 
	end
end

function eulerToVectorXY(rotX, rotY, rotZ)
	local sinX = math.sin(rotX) local cosX = math.cos(rotX)
	local sinY = math.sin(-rotY) local cosY = math.cos(-rotY)	
	return cosX*sinY,sinX,cosX*cosY
end

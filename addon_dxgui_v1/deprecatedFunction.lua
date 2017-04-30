--[[
/***************************************************************************************************************
*
*  PROJECT:     dxGUI
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        deprecatedFunction.lua
*  PURPOSE:     Output Deprecated Functions
*  DEVELOPERS:  Skyline <xtremecooker@gmail.com>
*
*  dxGUI is available from http://community.mtasa.com/index.php?p=resources&s=details&id=4871
*
****************************************************************************************************************/
]]
CRT_SECURE_NO_DEPRECATE = 1
addEvent("deprecatedFunction",true)
addEventHandler("deprecatedFunction",getRootElement(),function(old,new)
	if _CRT_SECURE_NO_DEPRECATE == 1 then
		return;
	end
	local temp = "'"..old.."' was declared deprecated.This function may be unsafe.Consider using '"..new.."'. To disable deprecation, use _CRT_SECURE_NO_DEPRECATE."
	outputDebugString(temp,2)
end)

--[[
	Variable: _CRT_SECURE_NO_DEPRECATE
	What's for: For show deprecate warnings.
	Description: If you don't want to see warnings, set this variable to 1.
]]
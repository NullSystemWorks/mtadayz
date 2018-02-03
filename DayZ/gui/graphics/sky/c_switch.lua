--
-- c_switch.lua
--

----------------------------------------------------------------
----------------------------------------------------------------
-- Effect switching on and off
--
--	To switch on:
--			triggerEvent( "switchDynamicSky", root, true )
--
--	To switch off:
--			triggerEvent( "switchDynamicSky", root, false )
--
----------------------------------------------------------------
----------------------------------------------------------------

--------------------------------
-- Switch effect on or off
--------------------------------
function toggleSkyDetail( dsOn )
	outputDebugString( "switchDynamicSky: " .. tostring(dsOn) )
	if dsOn then
		startDynamicSky()
	else
		stopDynamicSky()
	end
end

addEvent( "switchDynamicSky", true )
addEventHandler( "switchDynamicSky", resourceRoot, toggleSkyDetail )

--------------------------------
-- onClientResourceStop
-- Stop the resource
--------------------------------
addEventHandler( "onClientResourceStop", getResourceRootElement( getThisResource()),stopDynamicSky)

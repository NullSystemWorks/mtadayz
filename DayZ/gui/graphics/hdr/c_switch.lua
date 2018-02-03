--
-- c_switch.lua
--

----------------------------------------------------------------
----------------------------------------------------------------
-- Effect switching on and off
----------------------------------------------------------------
----------------------------------------------------------------

--------------------------------
-- Switch effect on or off
--------------------------------
function toggleHDR( bOn )
	if bOn then
		enableContrast()
	else
		disableContrast()
	end
end
addEvent( "switchContrast", true )
addEventHandler( "switchContrast", resourceRoot, toggleHDR )



--
-- c_switch.lua
--

----------------------------------------------------------------
----------------------------------------------------------------
-- Effect switching on and off
--
--	To switch on:
--			triggerEvent( "onClientSwitchDetail", root, true )
--
--	To switch off:
--			triggerEvent( "onClientSwitchDetail", root, false )
--
----------------------------------------------------------------
----------------------------------------------------------------

--------------------------------
-- Switch effect on or off
--------------------------------
function toggleTextureDetail(bOn)
	outputDebugString( "switchDetail: " .. tostring(bOn) )
	if bOn then
		enableDetail()
	else
		disableDetail()
	end
end

addEvent( "onClientSwitchDetail", true )
addEventHandler( "onClientSwitchDetail", resourceRoot, toggleTextureDetail)

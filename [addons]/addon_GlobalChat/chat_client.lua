--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
-- GlobalChat MTA:DayZ addon 1.0
-- Made by -ffs-Sniper
-- You are free to edit this addon
--///////////////////////////////////

--Define your desired chat key
GlobalChatKey = "x"

addEventHandler( "onClientResourceStart", getResourceRootElement ( ),
	function ( )
		bindKey ( GlobalChatKey, "down", "chatbox", "globalchat" )
		outputChatBox ( "Press " .. string.upper ( GlobalChatKey ) .. " to use the global chat." , 255, 255, 255, true )
	end
)
local root = getRootElement()
 
addEventHandler("onPlayerLogin", root,
	function()
		triggerClientEvent ( "onRollMessageStart", getRootElement(), getPlayerName(source).." #FFFFFFhas logged in!",255,255,255, "join")
	end
)
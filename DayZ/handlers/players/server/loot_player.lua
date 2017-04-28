--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: loot_player.lua						*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]

function onPlayerTakeItemFromGround (itemName,col)
	itemPlus = 1
	if itemName == "11.43x23mm Cartridge" then
		itemPlus = 7
	elseif itemName == "9x18mm Cartridge" then
		itemPlus = 8
	elseif itemName == "9x19mm Cartridge" then
		itemPlus = 17
	elseif itemName == ".303 British Cartridge" then
		itemPlus = 10
	elseif itemName == "5.45x39mm Cartridge" then
		itemPlus = 30
	elseif itemName == "7.62x39mm Cartridge" then
		itemPlus = 30
	elseif itemName == "7.62x51mm Cartridge" then
		itemPlus = 20
	elseif itemName == "5.56x45mm Cartridge" then
		itemPlus = 20
	elseif itemName == "7.62x54mm Cartridge" then
		itemPlus = 10
	elseif itemName == "1866 Slug" then
		itemPlus = 15
	elseif itemName == "12 Gauge Pellet" then
		itemPlus = 7
	elseif itemName == "M136 Rocket" then
		itemPlus = 0
	elseif itemName == "Bolt" then
		itemPlus = 7
	elseif itemName == "Bizon PP-19 SD" or itemName == "Lee Enfield" or itemName == "AK-74" or itemName == "AKS-74U" or itemName == "RPK" or itemName == "AKM" or itemName == "Sa58V CCO" or itemName == "Sa58V RCO" or itemName == "FN FAL" or itemName == "M24" or itemName == "DMR" or itemName == "M40A3" or itemName == "G36A CAMO" or itemName == "G36C" or itemName == "G36C CAMO" or itemName == "G36K CAMO" or itemName == "L85A2 RIS Holo" or itemName == "M16A2" or itemName == "M16A2 M203" or itemName == "M4A1" or itemName == "M16A4" or itemName == "CZ 550" or itemName == "SVD Dragunov" or itemName == "Mosin-Nagant" or itemName == "Winchester 1866" or itemName == "Double-barreled Shotgun" or itemName == "M1014" or itemName == "Remington 870" or itemName == "Compound Crossbow" or itemName == "Hatchet" then
		removeBackWeaponOnDrop()	
	end
	local x,y,z = getElementPosition(source)
	local id,ItemType = getItemTablePosition (itemName)
	destroyElement(getElementData(col,"parent"))
	destroyElement(col)
	setElementData(client,itemName,(getElementData(client,itemName) or 0)+itemPlus)
	local theTime = getRealTime()
	local hour = theTime.hour
	local minute = theTime.minute
	local seconds = theTime.second
	local theAccount = getPlayerAccount(client)
	if hour < 10 then
		hour = "0"..hour
	else
		hour = theTime.hour
	end
	if minute < 10 then
		minute  = "0"..minute
	else
		minute = theTime.minute
	end
	if seconds < 10 then
		minute = "0"..seconds
	else
		seconds = theTime.second
	end
	exports.DayZ:saveLog("[DayZ] ["..hour..":"..minute..":"..seconds.."] "..getAccountName(theAccount).." picked up from ground: "..itemName.."\n","game")
	outputDebugString("[DayZ] ["..hour..":"..minute..":"..seconds.."] "..getAccountName(theAccount).." picked up from ground: "..itemName,0,0,255,0)
end
addEvent( "onPlayerTakeItemFromGround", true )
addEventHandler( "onPlayerTakeItemFromGround", getRootElement(), onPlayerTakeItemFromGround )

function onPlayerChangeLoot(loot)
local players = getElementsWithinColShape (loot,"player")
	for theKey,player in ipairs(players) do 
		triggerClientEvent(player,"refreshLootManual",player,loot)
	end	
end
addEvent( "onPlayerChangeLoot", true )
addEventHandler( "onPlayerChangeLoot", getRootElement(), onPlayerChangeLoot )

function getItemTablePosition (itema)
	for id, item in ipairs(buildingClasses[tostring("other")]) do
		if itema == item[1] then
			return id,"other"
		end
	end

	return item,itemString
end

function playerDropAItem(itemName)
	local x,y,z = getElementPosition(source)
	local item,itemString = getItemTablePosition(itemName)
	local itemPickup = createItemPickup(item,x+math.random(-1.25,1.25),y+math.random(-1.25,1.25),z,itemString)
	local theTime = getRealTime()
	local hour = theTime.hour
	local minute = theTime.minute
	local seconds = theTime.second
	local theAccount = getPlayerAccount(client)
	if hour < 10 then
		hour = "0"..hour
	else
		hour = theTime.hour
	end
	if minute < 10 then
		minute  = "0"..minute
	else
		minute = theTime.minute
	end
	if seconds < 10 then
		minute = "0"..seconds
	else
		seconds = theTime.second
	end

	exports.DayZ:saveLog("[DayZ] ["..hour..":"..minute..":"..seconds.."] "..getAccountName(theAccount).." dropped to ground: "..itemName.."\r\n","game")
	outputDebugString("[DayZ] ["..hour..":"..minute..":"..seconds.."] "..getAccountName(theAccount).." dropped to ground: "..itemName,0,0,255,0)
end
addEvent("playerDropAItem", true)
addEventHandler( "playerDropAItem", getRootElement(), playerDropAItem)

function checkPlayerClothes(itemName)
	if itemName == "Military collar" then
	  removePedClothes(source, 13, "dogtag", "neck")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "dogtag", "neck", 13)
	  end
	end

	if itemName == "Africa collar" then
	  removePedClothes(source, 13, "neckafrica", "neck")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "neckafrica", "neck", 13)
	  end
	end

	if itemName == "LS collar" then
	  removePedClothes(source, 13, "neckls", "neck")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "neckls", "neck", 13)
	  end
	end

	if itemName == "Gold collar" then
	  removePedClothes(source, 13, "neckropeg", "neck2")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "neckropeg", "neck2", 13)
	  end
	end

	if itemName == "Silver collar" then
	  removePedClothes(source, 13, "neckropes", "neck2")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "neckropes", "neck2", 13)
	  end
	end

	if itemName == "Black Bandana (M)" then
	  removePedClothes(source, 15, "bandblack3", "bandmask")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "bandblack3", "bandmask", 15)
	  end
	end

	if itemName == "Blue Bandana (M)" then
	  removePedClothes(source, 15, "bandblue3", "bandmask")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "bandblue3", "bandmask", 15)
	  end
	end

	if itemName == "Green Bandana (M)" then
	  removePedClothes(source, 15, "bandgang3", "bandmask")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "bandgang3", "bandmask", 15)
	  end
	end

	if itemName == "Red Bandana (M)" then
	  removePedClothes(source, 15, "bandred3", "bandmask")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "bandred3", "bandmask", 15)
	  end
	end

	if itemName == "Dark Glasses" then
	  removePedClothes(source, 15, "glasses01dark", "glasses01")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "glasses01dark", "glasses01", 15)
	  end
	end

	if itemName == "Red Glasses" then
	  removePedClothes(source, 15, "glasses03red", "glasses03")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "glasses03red", "glasses03", 15)
	  end
	end

	if itemName == "Square Glasses" then
	  removePedClothes(source, 15, "glasses04dark", "glasses04")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "glasses04dark", "glasses04", 15)
	  end
	end

	if itemName == "Black Bandana (H)" then
	  removePedClothes(source, 16, "bandblack", "bandana")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "bandblack", "bandana", 16)
	  end
	end

	if itemName == "Blue Bandana (H)" then
	  removePedClothes(source, 16, "bandblue", "bandana")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "bandblue", "bandana", 16)
	  end
	end

	if itemName == "Green Bandana (H)" then
	  removePedClothes(source, 16, "bandgang", "bandana")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "bandgang", "bandana", 16)
	  end
	end

	if itemName == "Red Bandana (H)" then
	  removePedClothes(source, 16, "bandred", "bandana")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "bandred", "bandana", 16)
	  end
	end

	if itemName == "Black Beret" then
	  removePedClothes(source, 16, "beretblk", "beret")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "beretblk", "beret", 16)
	  end
	end

	if itemName == "Red Beret" then
	  removePedClothes(source, 16, "beretred", "beret")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "beretred", "beret", 16)
	  end
	end

	if itemName == "Old Hat" then
	  removePedClothes(source, 16, "boater", "boater")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "boater", "boater", 16)
	  end
	end

	if itemName == "Black Hat" then
	  removePedClothes(source, 16, "bowler", "bowler")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "bowler", "bowler", 16)
	  end
	end

	if itemName == "Yellow Hat" then
	  removePedClothes(source, 16, "bowleryellow", "bowler")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "bowleryellow", "bowler", 16)
	  end
	end

	if itemName == "Black Trucker" then
	  removePedClothes(source, 16, "capblk", "cap")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "capblk", "cap", 16)
	  end
	end

	if itemName == "Blue Trucker" then
	  removePedClothes(source, 16, "capblue", "cap")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "capblue", "cap", 16)
	  end
	end

	if itemName == "Green Trucker" then
	  removePedClothes(source, 16, "capgang", "cap")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "capgang", "cap", 16)
	  end
	end

	if itemName == "Red Trucker" then
	  removePedClothes(source, 16, "capred", "cap")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "capred", "cap", 16)
	  end
	end

	if itemName == "Yellow Trucker" then
	  removePedClothes(source, 16, "capzip", "cap")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "capzip", "cap", 16)
	  end
	end

	if itemName == "Cow-Boy Hat" then
	  removePedClothes(source, 16, "cowboy", "cowboy")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "cowboy", "cowboy", 16)
	  end
	end

	if itemName == "White Hat" then
	  removePedClothes(source, 16, "hatmancplaid", "hatmanc")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "hatmancplaid", "hatmanc", 16)
	  end
	end

	if itemName == "Hockey Mask" then
	  removePedClothes(source, 16, "hockey", "hockeymask")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "hockey", "hockeymask", 16)
	  end
	end

	if itemName == "Black Shoe" then
	  removePedClothes(source, 3, "bask1problk", "bask1")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "bask1problk", "bask1", 3)
	  end
	end

	if itemName == "Sport Shoe" then
	  removePedClothes(source, 3, "bask1prowht", "bask1")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "bask1prowht", "bask1", 3)
	  end
	end

	if itemName == "Brown Shoe" then
	  removePedClothes(source, 3, "timberfawn", "bask1")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "timberfawn", "bask1", 3)
	  end
	end

	if itemName == "Biker Shoe" then
	  removePedClothes(source, 3, "boxingshoe", "biker")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "boxingshoe", "biker", 3)
	  end
	end

	if itemName == "Blue Shoe" then
	  removePedClothes(source, 3, "convproblu", "conv")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "convproblu", "conv", 3)
	  end
	end

	if itemName == "Red Shoe" then
	  removePedClothes(source, 3, "sneakerprored", "sneaker")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "sneakerprored", "sneaker", 3)
	  end
	end

	if itemName == "Beach Shoe" then
	  removePedClothes(source, 3, "sandal", "flipflop")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "sandal", "flipflop", 3)
	  end
	end

	if itemName == "Black Pants" then
	  removePedClothes(source, 2, "chinosblack", "chinosb")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "chinosblack", "chinosb", 2)
	  end
	end

	if itemName == "Beige Pants" then
	  removePedClothes(source, 2, "chinosbiege", "chinosb")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "chinosbiege", "chinosb", 2)
	  end
	end

	if itemName == "Gray Shorts" then
	  removePedClothes(source, 2, "chongergrey", "chonger")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "chongergrey", "chonger", 2)
	  end
	end

	if itemName == "Blue Shorts" then
	  removePedClothes(source, 2, "chongerblue", "chonger")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "chongerblue", "chonger", 2)
	  end
	end

	if itemName == "Blue Jeans" then
	  removePedClothes(source, 2, "jeansdenim", "jeans")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "jeansdenim", "jeans", 2)
	  end
	end

	if itemName == "Green Jeans" then
	  removePedClothes(source, 2, "denimsgang", "jeans")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "denimsgang", "jeans", 2)
	  end
	end

	if itemName == "Gray Pants" then
	  removePedClothes(source, 2, "suit1trgreen", "suit1tr")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "suit1trgreen", "suit1tr", 2)
	  end
	end

	if itemName == "Yellow Pants" then
	  removePedClothes(source, 2, "suit1tryellow", "suit1tr")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "suit1tryellow", "suit1tr", 2)
	  end
	end

	if itemName == "Blue Jogging" then
	  removePedClothes(source, 2, "tracktrblue", "tracktr")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "tracktrblue", "tracktr", 2)
	  end
	end

	if itemName == "Gray Jogging" then
	  removePedClothes(source, 2, "tracktrwhstr", "tracktr")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "tracktrwhstr", "tracktr", 2)
	  end
	end

	if itemName == "Military Pants" then
	  removePedClothes(source, 2, "worktrcamogrn", "worktr")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "worktrcamogrn", "worktr", 2)
	  end
	end

	if itemName == "Beige Vest" then
	  removePedClothes(source, 0, "hoodjackbeige", "hoodjack")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "hoodjackbeige", "hoodjack", 0)
	  end
	end

	if itemName == "Baseball Shirt" then
	  removePedClothes(source, 0, "bandits", "baseball")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "bandits", "baseball", 0)
	  end
	end

	if itemName == "Baseball 2 Shirt" then
	  removePedClothes(source, 0, "baskballdrib", "baskball")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "baskballdrib", "baskball", 0)
	  end
	end

	if itemName == "Red Vest" then
	  removePedClothes(source, 0, "bballjackrstar", "bbjack")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "bballjackrstar", "bbjack", 0)
	  end
	end

	if itemName == "Grey Shirt" then
	  removePedClothes(source, 0, "coachsemi", "coach")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "coachsemi", "coach", 0)
	  end
	end

	if itemName == "Green Vest" then
	  removePedClothes(source, 0, "field", "field")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "field", "field", 0)
	  end
	end

	if itemName == "Hawai Shirt" then
	  removePedClothes(source, 0, "hawaiiwht", "hawaii")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "hawaiiwht", "hawaii", 0)
	  end
	end

	if itemName == "Black Vest" then
	  removePedClothes(source, 0, "hoodyAblack", "hoodyA")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "hoodyAblack", "hoodyA", 0)
	  end
	end

	if itemName == "Brown Vest" then
	  removePedClothes(source, 0, "hoodyabase5", "hoodya")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "hoodyabase5", "hoodya", 0)
	  end
	end

	if itemName == "Biker Vest" then
	  removePedClothes(source, 0, "leather", "leather")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "leather", "leather", 0)
	  end
	end

	if itemName == "Blue Shirt" then
	  removePedClothes(source, 0, "shirtbcheck", "shirtb")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "shirtbcheck", "shirtb", 0)
	  end
	end

	if itemName == "Green 2 Vest" then
	  removePedClothes(source, 0, "suit1gang", "suit1")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "suit1gang", "suit1", 0)
	  end
	end

	if itemName == "Number 5 Shirt" then
	  removePedClothes(source, 0, "tshirtbase5", "tshirt")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "tshirtbase5", "tshirt", 0)
	  end
	end

	if itemName == "Monk Shirt" then
	  removePedClothes(source, 0, "tshirtbobomonk", "tshirt")
	  if getElementData(source, itemName) >= 2 then
	  	addPedClothes(source, "tshirtbobomonk", "tshirt", 0)
	  end
	end
	if itemName == "Helmet" then
		removePedClothes(source,16,"helmet","helmet")
		if getElementData(source, itemName) >= 2 then
			addPedClothes(source,"helmet","helmet",16)
		end	
	end
	if itemName == "MX Helmet" then
		removePedClothes(source,16,"moto","moto")
		if getElementData(source, itemName) >= 2 then
			addPedClothes(source,"moto","moto",16)
		end	
	end
end
addEvent("checkPlayerClothes", true)
addEventHandler( "checkPlayerClothes", getRootElement(), checkPlayerClothes)
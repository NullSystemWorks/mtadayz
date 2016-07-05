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

	if itemName == "Military collar" then
	  removePedClothes(source, 13, "dogtag", "neck")
	end

	if itemName == "Africa collar" then
	  removePedClothes(source, 13, "neckafrica", "neck")
	end
	if itemName == "LS collar" then
	  removePedClothes(source, 13, "neckls", "neck")
	end

	if itemName == "Gold collar" then
	  removePedClothes(source, 13, "neckropeg", "neck2")
	end

	if itemName == "Silver collar" then
	  removePedClothes(source, 13, "neckropes", "neck2")
	end

	if itemName == "Black Bandana (M)" then
	  removePedClothes(source, 15, "bandblack3", "bandmask")
	end

	if itemName == "Blue Bandana (M)" then
	  removePedClothes(source, 15, "bandblue3", "bandmask")
	end

	if itemName == "Green Bandana (M)" then
	  removePedClothes(source, 15, "bandgang3", "bandmask")
	end

	if itemName == "Red Bandana (M)" then
	  removePedClothes(source, 15, "bandgang3", "bandmask")
	end

	if itemName == "Dark Glasses" then
	  removePedClothes(source, 15, "glasses01dark", "glasses01")
	end

	if itemName == "Red Glasses" then
	  removePedClothes(source, 15, "glasses03red", "glasses03")
	end

	if itemName == "Square Glasses" then
	  removePedClothes(source, 15, "glasses04dark", "glasses04")
	end

	if itemName == "Black Bandana (H)" then
	  removePedClothes(source, 16, "bandblack", "bandana")
	end

	if itemName == "Blue Bandana (H)" then
	  removePedClothes(source, 16, "bandblue", "bandana")
	end

	if itemName == "Green Bandana (H)" then
	  removePedClothes(source, 16, "bandgang", "bandana")
	end

	if itemName == "Red Bandana (H)" then
	  removePedClothes(source, 16, "bandred", "bandana")
	end

	if itemName == "Black Beret" then
	  removePedClothes(source, 16, "beretblk", "beret")
	end

	if itemName == "Red Beret" then
	  removePedClothes(source, 16, "beretred", "beret")
	end

	if itemName == "Old Hat" then
	  removePedClothes(source, 16, "boater", "boater")
	end

	if itemName == "Black Hat" then
	  removePedClothes(source, 16, "bowler", "bowler")
	end

	if itemName == "Yellow Hat" then
	  removePedClothes(source, 16, "bowleryellow", "bowler")
	end

	if itemName == "Black Trucker" then
	  removePedClothes(source, 16, "capblk", "cap")
	end

	if itemName == "Blue Trucker" then
	  removePedClothes(source, 16, "capblue", "cap")
	end

	if itemName == "Green Trucker" then
	  removePedClothes(source, 16, "capgang", "cap")
	end

	if itemName == "Red Trucker" then
	  removePedClothes(source, 16, "capred", "cap")
	end

	if itemName == "Yellow Trucker" then
	  removePedClothes(source, 16, "capzip", "cap")
	end

	if itemName == "Cow-Boy Hat" then
	  removePedClothes(source, 16, "cowboy", "cowboy")
	end

	if itemName == "White Hat" then
	  removePedClothes(source, 16, "hatmancplaid", "hatmanc")
	end

	if itemName == "Hockey Mask" then
	  removePedClothes(source, 16, "hockey", "hockeymask")
	end

	if itemName == "Black Shoe" then
	  removePedClothes(source, 3, "bask1problk", "bask1")
	end

	if itemName == "Sport Shoe" then
	  removePedClothes(source, 3, "bask1prowht", "bask1")
	end

	if itemName == "Brown Shoe" then
	  removePedClothes(source, 3, "timberfawn", "bask1")
	end

	if itemName == "Biker Shoe" then
	  removePedClothes(source, 3, "boxingshoe", "biker")
	end

	if itemName == "Blue Shoe" then
	  removePedClothes(source, 3, "convproblu", "conv")
	end

	if itemName == "Red Shoe" then
	  removePedClothes(source, 3, "sneakerprored", "sneaker")
	end

	if itemName == "Beach Shoe" then
	  removePedClothes(source, 3, "sandal", "flipflop")
	end

	if itemName == "Black Pants" then
	  removePedClothes(source, 2, "chinosblack", "chinosb")
	end

	if itemName == "Beige Pants" then
	  removePedClothes(source, 2, "chinosbiege", "chinosb")
	end

	if itemName == "Gray Shorts" then
	  removePedClothes(source, 2, "chongergrey", "chonger")
	end

	if itemName == "Blue Shorts" then
	  removePedClothes(source, 2, "chongerblue", "chonger")
	end

	if itemName == "Blue Jeans" then
	  removePedClothes(source, 2, "jeansdenim", "jeans")
	end

	if itemName == "Green Jeans" then
	  removePedClothes(source, 2, "denimsgang", "jeans")
	end

	if itemName == "Gray Pants" then
	  removePedClothes(source, 2, "suit1trgreen", "suit1tr")
	end

	if itemName == "Yellow Pants" then
	  removePedClothes(source, 2, "suit1tryellow", "suit1tr")
	end

	if itemName == "Blue Jogging" then
	  removePedClothes(source, 2, "tracktrblue", "tracktr")
	end

	if itemName == "Gray Jogging" then
	  removePedClothes(source, 2, "tracktrwhstr", "tracktr")
	end

	if itemName == "Military Pants" then
	  removePedClothes(source, 2, "worktrcamogrn", "worktr")
	end

	if itemName == "Beige Vest" then
	  removePedClothes(source, 0, "hoodjackbeige", "hoodjack")
	end

	if itemName == "Baseball Shirt" then
	  removePedClothes(source, 0, "bandits", "baseball")
	end

	if itemName == "Baseball 2 Shirt" then
	  removePedClothes(source, 0, "baskballdrib", "baskball")
	end

	if itemName == "Red Vest" then
	  removePedClothes(source, 0, "bballjackrstar", "bbjack")
	end

	if itemName == "Grey Shirt" then
	  removePedClothes(source, 0, "coachsemi", "coach")
	end

	if itemName == "Green Vest" then
	  removePedClothes(source, 0, "field", "field")
	end

	if itemName == "Hawai Shirt" then
	  removePedClothes(source, 0, "hawaiiwht", "hawaii")
	end

	if itemName == "Black Vest" then
	  removePedClothes(source, 0, "hoodyAblack", "hoodyA")
	end

	if itemName == "Brown Vest" then
	  removePedClothes(source, 0, "hoodyabase5", "hoodya")
	end

	if itemName == "Biker Vest" then
	  removePedClothes(source, 0, "leather", "leather")
	end

	if itemName == "Blue Shirt" then
	  removePedClothes(source, 0, "shirtbcheck", "shirtb")
	end

	if itemName == "Green 2 Vest" then
	  removePedClothes(source, 0, "suit1gang", "suit1")
	end

	if itemName == "Number 5 Shirt" then
	  removePedClothes(source, 0, "tshirtbase5", "tshirt")
	end

	if itemName == "Monk Shirt" then
	  removePedClothes(source, 0, "tshirtbobomonk", "tshirt")
	end

	exports.DayZ:saveLog("[DayZ] ["..hour..":"..minute..":"..seconds.."] "..getAccountName(theAccount).." dropped to ground: "..itemName.."\r\n","game")
	outputDebugString("[DayZ] ["..hour..":"..minute..":"..seconds.."] "..getAccountName(theAccount).." dropped to ground: "..itemName,0,0,255,0)
end
addEvent( "playerDropAItem", true )
addEventHandler( "playerDropAItem", getRootElement(), playerDropAItem )

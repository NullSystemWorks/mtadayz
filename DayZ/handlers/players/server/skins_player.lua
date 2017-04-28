--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: skins_player.lua						*----
----* Original Author: PicardRemi                               		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y, PicardRemi	*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]

function checkClothes()
	local skin1 = getElementData(source, "Military collar")
	if skin1 >= 1 then
	  addPedClothes(source, "dogtag", "neck", 13)
	else
	  removePedClothes(source, 13, "dogtag", "neck")
	end

	local skin2 = getElementData(source, "Africa collar")
	if skin2 >= 1 then
	  addPedClothes(source, "neckafrica", "neck", 13 )
	else
	  removePedClothes(source, 13, "neckafrica", "neck")
	end

	local skin3 = getElementData(source, "LS collar")
	if skin3 >= 1 then
	  addPedClothes(source, "neckls", "neck", 13 )
	else
	  removePedClothes(source, 13, "neckls", "neck")
	end

	local skin4 = getElementData(source, "Gold collar")
	if skin4 >= 1 then
	  addPedClothes(source, "neckropeg", "neck2", 13 )
	else
	  removePedClothes(source, 13, "neckropeg", "neck2")
	end

	local skin5 = getElementData(source, "Silver collar")
	if skin5 >= 1 then
	  addPedClothes(source, "neckropes", "neck2", 13 )
	else
	  removePedClothes(source, 13, "neckropes", "neck2")
	end

	local skin6 = getElementData(source, "Black Bandana (M)")
	if skin6 >= 1 then
	  addPedClothes(source, "bandblack3", "bandmask", 15 )
	else
	  removePedClothes(source, 15, "bandblack3", "bandmask")
	end

	local skin7 = getElementData(source, "Blue Bandana (M)")
	if skin7 >= 1 then
	  addPedClothes(source, "bandblue3", "bandmask", 15 )
	else
	  removePedClothes(source, 15, "bandblue3", "bandmask")
	end

	local skin8 = getElementData(source, "Green Bandana (M)")
	if skin8 >= 1 then
	  addPedClothes(source, "bandgang3", "bandmask", 15 )
	else
	  removePedClothes(source, 15, "bandgang3", "bandmask")
	end

	local skin9 = getElementData(source, "Red Bandana (M)")
	if skin9 >= 1 then
	  addPedClothes(source, "bandred3", "bandmask", 15 )
	else
	  removePedClothes(source, 15, "bandred3", "bandmask")
	end

	local skin10 = getElementData(source, "Dark Glasses")
	if skin10 >= 1 then
	  addPedClothes(source, "glasses01dark", "glasses01", 15 )
	else
	  removePedClothes(source, 15, "glasses01dark", "glasses01")
	end

	local skin11 = getElementData(source, "Red Glasses")
	if skin11 >= 1 then
	  addPedClothes(source, "glasses03red", "glasses03", 15 )
	else
	  removePedClothes(source, 15, "glasses03red", "glasses03")
	end

	local skin12 = getElementData(source, "Square Glasses")
	if skin12 >= 1 then
	  addPedClothes(source, "glasses04dark", "glasses04", 15 )
	else
	  removePedClothes(source, 15, "glasses04dark", "glasses04")
	end

	local skin13 = getElementData(source, "Black Bandana (H)")
	if skin13 >= 1 then
	  addPedClothes(source, "bandblack", "bandana", 16 )
	else
	  removePedClothes(source, 16, "bandblack", "bandana")
	end

	local skin14 = getElementData(source, "Blue Bandana (H)")
	if skin14 >= 1 then
	  addPedClothes(source, "bandblue", "bandana", 16 )
	else
	  removePedClothes(source, 16, "bandblue", "bandana")
	end

	local skin15 = getElementData(source, "Green Bandana (H)")
	if skin15 >= 1 then
	  addPedClothes(source, "bandgang", "bandana", 16 )
	else
	  removePedClothes(source, 16, "bandgang", "bandana")
	end

	local skin16 = getElementData(source, "Red Bandana (H)")
	if skin16 >= 1 then
	  addPedClothes(source, "bandred", "bandana", 16 )
	else
	  removePedClothes(source, 16, "bandred", "bandana")
	end

	-- Chapeau etc
	local skin16 = getElementData(source, "Black Beret")
	if skin16 >= 1 then
	  addPedClothes(source, "beretblk", "beret", 16 )
	else
	  removePedClothes(source, 16, "beretblk", "beret")
	end

	local skin17 = getElementData(source, "Red Beret")
	if skin17 >= 1 then
	  addPedClothes(source, "beretred", "beret", 16 )
	else
	  removePedClothes(source, 16, "beretred", "beret")
	end

	local skin18 = getElementData(source, "Old Hat")
	if skin18 >= 1 then
	  addPedClothes(source, "boater", "boater", 16 )
	else
	  removePedClothes(source, 16, "boater", "boater")
	end

	local skin18 = getElementData(source, "Black Hat")
	if skin18 >= 1 then
	  addPedClothes(source, "bowler", "bowler", 16 )
	else
	  removePedClothes(source, 16, "bowler", "bowler")
	end

	local skin19 = getElementData(source, "Yellow Hat")
	if skin19 >= 1 then
	  addPedClothes(source, "bowleryellow", "bowler", 16 )
	else
	  removePedClothes(source, 16, "bowleryellow", "bowler")
	end

	local skin20 = getElementData(source, "Black Trucker")
	if skin20 >= 1 then
	  addPedClothes(source, "capblk", "cap", 16 )
	else
	  removePedClothes(source, 16, "capblk", "cap")
	end

	 --test
	local skin21 = getElementData(source, "Blue Trucker")
	if skin21 >= 1 then
	  addPedClothes(source, "capblue", "cap", 16 )
	else
	  removePedClothes(source, 16, "capblue", "cap")
	end

	local skin22 = getElementData(source, "Green Trucker")
	if skin22 >= 1 then
	  addPedClothes(source, "capgang", "cap", 16 )
	else
	  removePedClothes(source, 16, "capgang", "cap")
	end

	local skin23 = getElementData(source, "Red Trucker")
	if skin23 >= 1 then
	  addPedClothes(source, "capred", "cap", 16 )
	else
	  removePedClothes(source, 16, "capred", "cap")
	end

	local skin24 = getElementData(source, "Yellow Trucker")
	if skin24 >= 1 then
	  addPedClothes(source, "capzip", "cap", 16 )
	else
	  removePedClothes(source, 16, "capzip", "cap")
	end

	local skin25 = getElementData(source, "Cow-Boy Hat")
	if skin25 >= 1 then
	  addPedClothes(source, "cowboy", "cowboy", 16 )
	else
	  removePedClothes(source, 16, "cowboy", "cowboy")
	end

	local skin26 = getElementData(source, "White Hat")
	if skin26 >= 1 then
	  addPedClothes(source, "hatmancplaid", "hatmanc", 16 )
	else
	  removePedClothes(source, 16, "hatmancplaid", "hatmanc")
	end

	local skin27 = getElementData(source, "Hockey Mask")
	if skin27 >= 1 then
	  addPedClothes(source, "hockey", "hockeymask", 16 )
	else
	  removePedClothes(source, 16, "hockey", "hockeymask")
	end

	local skin28 = getElementData(source, "Black Shoe")
	if skin28 >= 1 then
	  addPedClothes(source, "bask1problk", "bask1", 3 )
	else
	  removePedClothes(source, 3, "bask1problk", "bask1")
	end

	local skin29 = getElementData(source, "Sport Shoe")
	if skin29 >= 1 then
	  addPedClothes(source, "bask1prowht", "bask1", 3 )
	else
	  removePedClothes(source, 3, "bask1prowht", "bask1")
	end

	local skin30 = getElementData(source, "Brown Shoe")
	if skin30 >= 1 then
	  addPedClothes(source, "timberfawn", "bask1", 3 )
	else
	  removePedClothes(source, 3, "timberfawn", "bask1")
	end

	local skin31 = getElementData(source, "Biker Shoe")
	if skin31 >= 1 then
	  addPedClothes(source, "boxingshoe", "biker", 3 )
	else
	  removePedClothes(source, 3, "boxingshoe", "biker")
	end

	local skin32 = getElementData(source, "Blue Shoe")
	if skin32 >= 1 then
	  addPedClothes(source, "convproblu", "conv", 3 )
	else
	  removePedClothes(source, 3, "convproblu", "conv")
	end

	local skin33 = getElementData(source, "Red Shoe")
	if skin33 >= 1 then
	  addPedClothes(source, "sneakerprored", "sneaker", 3 )
	else
	  removePedClothes(source, 3, "sneakerprored", "sneaker")
	end

	local skin34 = getElementData(source, "Beach Shoe")
	if skin34 >= 1 then
	  addPedClothes(source, "sandal", "flipflop", 3 )
	else
	  removePedClothes(source, 3, "sandal", "flipflop")
	end

	-- Pantalon
	local skin35 = getElementData(source, "Black Pants")
	if skin35 >= 1 then
	  addPedClothes(source, "chinosblack", "chinosb", 2 )
	else
	  removePedClothes(source, 2, "chinosblack", "chinosb")
	end

	local skin36 = getElementData(source, "Beige Pants")
	if skin36 >= 1 then
	  addPedClothes(source, "chinosbiege", "chinosb", 2 )
	else
	  removePedClothes(source, 2, "chinosbiege", "chinosb")
	end

	local skin37 = getElementData(source, "Gray Shorts")
	if skin37 >= 1 then
	  addPedClothes(source, "chongergrey", "chonger", 2 )
	else
	  removePedClothes(source, 2, "chongergrey", "chonger")
	end

	local skin39 = getElementData(source, "Blue Shorts")
	if skin39 >= 1 then
	  addPedClothes(source, "chongerblue", "chonger", 2 )
	else
	  removePedClothes(source, 2, "chongerblue", "chonger")
	end

	local skin40 = getElementData(source, "Blue Jeans")
	if skin40 >= 1 then
	  addPedClothes(source, "jeansdenim", "jeans", 2 )
	else
	  removePedClothes(source, 2, "jeansdenim", "jeans")
	end

	local skin41 = getElementData(source, "Green Jeans")
	if skin41 >= 1 then
	  addPedClothes(source, "denimsgang", "jeans", 2 )
	else
	  removePedClothes(source, 2, "denimsgang", "jeans")
	end

	local skin42 = getElementData(source, "Gray Pants")
	if skin42 >= 1 then
	  addPedClothes(source, "suit1trgreen", "suit1tr", 2 )
	else
	  removePedClothes(source, 2, "suit1trgreen", "suit1tr")
	end

	local skin43 = getElementData(source, "Yellow Pants")
	if skin43 >= 1 then
	  addPedClothes(source, "suit1tryellow", "suit1tr", 2 )
	else
	  removePedClothes(source, 2, "suit1tryellow", "suit1tr")
	end

	local skin44 = getElementData(source, "Blue Jogging")
	if skin44 >= 1 then
	  addPedClothes(source, "tracktrblue", "tracktr", 2 )
	else
	  removePedClothes(source, 2, "tracktrblue", "tracktr")
	end

	local skin45 = getElementData(source, "Gray Jogging")
	if skin45 >= 1 then
	  addPedClothes(source, "tracktrwhstr", "tracktr", 2 )
	else
	  removePedClothes(source, 2, "tracktrwhstr", "tracktr")
	end

	local skin46 = getElementData(source, "Military Pants")
	if skin46 >= 1 then
	  addPedClothes(source, "worktrcamogrn", "worktr", 2 )
	else
	  removePedClothes(source, 2, "worktrcamogrn", "worktr")
	end

	local skin47 = getElementData(source, "Beige Vest")
	if skin47 >= 1 then
	  addPedClothes(source, "hoodjackbeige", "hoodjack", 0 )
	else
	  removePedClothes(source, 0, "hoodjackbeige", "hoodjack")
	end

	local skin48 = getElementData(source, "Baseball Shirt")
	if skin48 >= 1 then
	  addPedClothes(source, "bandits", "baseball", 0 )
	else
	  removePedClothes(source, 0, "bandits", "baseball")
	end

	local skin49 = getElementData(source, "Baseball 2 Shirt")
	if skin49 >= 1 then
	  addPedClothes(source, "baskballdrib", "baskball", 0 )
	else
	  removePedClothes(source, 0, "baskballdrib", "baskball")
	end

	local skin50 = getElementData(source, "Red Vest")
	if skin50 >= 1 then
	  addPedClothes(source, "bballjackrstar", "bbjack", 0 )
	else
	  removePedClothes(source, 0, "bballjackrstar", "bbjack")
	end

	local skin51 = getElementData(source, "Grey Shirt")
	if skin51 >= 1 then
	  addPedClothes(source, "coachsemi", "coach", 0 )
	else
	  removePedClothes(source, 0, "coachsemi", "coach")
	end

	local skin52 = getElementData(source, "Green Vest")
	if skin52 >= 1 then
	  addPedClothes(source, "field", "field", 0 )
	else
	  removePedClothes(source, 0, "field", "field")
	end

	local skin53 = getElementData(source, "Hawai Shirt")
	if skin53 >= 1 then
	  addPedClothes(source, "hawaiiwht", "hawaii", 0 )
	else
	  removePedClothes(source, 0, "hawaiiwht", "hawaii")
	end

	local skin54 = getElementData(source, "Black Vest")
	if skin54 >= 1 then
	  addPedClothes(source, "hoodyAblack", "hoodyA", 0 )
	else
	  removePedClothes(source, 0, "hoodyAblack", "hoodyA")
	end

	local skin55 = getElementData(source, "Brown Vest")
	if skin55 >= 1 then
	  addPedClothes(source, "hoodyabase5", "hoodya", 0 )
	else
	  removePedClothes(source, 0, "hoodyabase5", "hoodya")
	end

	local skin56 = getElementData(source, "Biker Vest")
	if skin56 >= 1 then
	  addPedClothes(source, "leather", "leather", 0 )
	else
	  removePedClothes(source, 0, "leather", "leather")
	end

	local skin57 = getElementData(source, "Blue Shirt")
	if skin57 >= 1 then
	  addPedClothes(source, "shirtbcheck", "shirtb", 0 )
	else
	  removePedClothes(source, 0, "shirtbcheck", "shirtb")
	end
	  
	local skin58 = getElementData(source, "Green 2 Vest")
	if skin58 >= 1 then
	  addPedClothes(source, "suit1gang", "suit1", 0 )
	else
	  removePedClothes(source, 0, "suit1gang", "suit1")
	end

	local skin59 = getElementData(source, "Number 5 Shirt")
	if skin59 >= 1 then
	  addPedClothes(source, "tshirtbase5", "tshirt", 0 )
	else
	  removePedClothes(source, 0, "tshirtbase5", "tshirt")
	end

	local skin60 = getElementData(source, "Monk Shirt")
	if skin60 >= 1 then
	  addPedClothes(source, "tshirtbobomonk", "tshirt", 0 )
	else
	  removePedClothes(source, 0, "tshirtbobomonk", "tshirt")
	end
	
	--helmets
	local skin61 = getElementData(source,"Helmet")
	if skin61 >= 1 then
		addPedClothes(source,"helmet","helmet",16)
	else
		removePedClothes(source,16,"helmet","helmet")
	end
	
	local skin62 = getElementData(source,"MX Helmet")
	if skin62 >= 1 then
		addPedClothes(source,"moto","moto",16)
	else
		removePedClothes(source,16,"moto","moto")
	end
end
addEvent("onPlayerChangeClothes",true)
addEventHandler("onPlayerChangeClothes",getRootElement(),checkClothes)

-- OLD CLOTHING/SKIN SYSTEM
function getSkinIDFromName(name)
	for i,skin in ipairs(skinTable) do
		if name == skin[1] then
			return skin[2]
		end
	end
end

function getSkinNameFromID(id)
	for i,skin in ipairs(skinTable) do
		if id == skin[2] then
			return skin[1]
		end
	end
end

function addPlayerSkin(skin)
	if skin == "MX Helmet" or skin == "Helmet" then
		setElementData(source,"hasHelmet",true)
		setElementData(source,skin,getElementData(source,skin)-1)
		return
	end
	local current = getElementData(source,"skin")
	local name = getSkinNameFromID(current)
	local id = getSkinIDFromName(skin)
	local gender = getElementData(source,"gender")
	if gender == "female" then
		if id == 172 or id == 192 or id == 285 then
			setElementData(source,skin,getElementData(source,skin)-1)
			setElementData(source,"skin",id)
			setElementModel(source,id)
			triggerClientEvent(source,"refreshInventoryManual",source)
		else
			outputChatBox("You can't wear this!",source,255,0,0,true)
		end
	else
		if id == 172 or id == 192 then
			outputChatBox("You can't wear this!",source,255,0,0,true)
		else
			setElementData(source,skin,getElementData(source,skin)-1)
			setElementData(source,"skin",id)
			setElementModel(source,id)
			triggerClientEvent(source,"refreshInventoryManual",source)
		end
	end
end
addEvent("onPlayerChangeSkin",true)
addEventHandler("onPlayerChangeSkin",getRootElement(),addPlayerSkin)

function checkBandit ()
	if gameplayVariables["newclothingsystem"] then return end
	for i, player in ipairs(getElementsByType("player")) do
		if getElementData(player,"logedin") then
			local current = getElementData(player,"skin")
			if getElementData(player,"bandit") then
				if getElementData(player,"gender") == "male" then
					if current == 179 or current == 287 then
						setElementModel(player,288)
					elseif current == 73 then
						setElementModel(player,180)
					end
				elseif getElementData(player,"gender") == "female" then
					if current == 192 then
						setElementModel(player,191)
					elseif current == 172 then
						setElementModel(player,211)
					end
				end
			elseif getElementData(player,"humanity") == 5000 then
				if current == 73 or current == 179 or current == 287 or current == 172 or current == 192 then
					setElementModel(player,210)
				end
			else
				setElementModel(player,current)
			end
		end
	end
end
setTimer(checkBandit,20000,0)
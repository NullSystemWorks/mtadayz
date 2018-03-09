--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: DayZ_c.lua								*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: CLIENT														*----
#-----------------------------------------------------------------------------#
]]


--[[
TO DO



]]

playerSkillsTable = {}

Skills = {
    label = {},
    staticimage = {},
	font = {},
	description = {},
	chance = {},
}

Skills.font[1] = guiCreateFont(":DayZ/fonts/needhelp.ttf",40)
Skills.font[2] = guiCreateFont(":DayZ/fonts/needhelp.ttf",20)
Skills.font[3] = guiCreateFont(":DayZ/fonts/needhelp.ttf",25)
Skills.font[4] = guiCreateFont(":DayZ/fonts/needhelp.ttf",18)

Skills.staticimage[1] = guiCreateStaticImage(0.00, 0.06, 1.00, 0.90, ":DayZ/gui/journal/images/journal_page1.png", true)

Skills.label[1] = guiCreateLabel(0.17, 0.10, 0.22, 0.07, "Skills", true, Skills.staticimage[1])
guiLabelSetColor(Skills.label[1], 0, 0, 0)
guiLabelSetHorizontalAlign(Skills.label[1], "center", false)
guiSetFont(Skills.label[1],Skills.font[1])


Skills.label[2] = guiCreateLabel(0.52, 0.15, 0.22, 0.04, "Soldier", true, Skills.staticimage[1])
guiLabelSetColor(Skills.label[2], 0, 0, 0)
guiLabelSetVerticalAlign(Skills.label[2], "center")
guiSetFont(Skills.label[2],Skills.font[4])
Skills.staticimage[2] = guiCreateStaticImage(0.52, 0.19, 0.06, 0.09, ":DayZ/gui/rpg/icons/sold_icon.png", true, Skills.staticimage[1])
guiSetProperty(Skills.staticimage[2], "ImageColours", "tl:FF737373 tr:FF737373 bl:FF737373 br:FF737373")
Skills.staticimage[3] = guiCreateStaticImage(0.66, 0.19, 0.06, 0.09, ":DayZ/gui/rpg/icons/sold_dodge.png", true, Skills.staticimage[1])
guiSetProperty(Skills.staticimage[3], "ImageColours", "tl:FF737373 tr:FF737373 bl:FF737373 br:FF737373")
Skills.staticimage[4] = guiCreateStaticImage(0.74, 0.19, 0.06, 0.09, ":DayZ/gui/rpg/icons/sold_tough.png", true, Skills.staticimage[1])
guiSetProperty(Skills.staticimage[4], "ImageColours", "tl:FF737373 tr:FF737373 bl:FF737373 br:FF737373")
Skills.staticimage[5] = guiCreateStaticImage(0.82, 0.19, 0.06, 0.09, ":DayZ/gui/rpg/icons/sold_crit.png", true, Skills.staticimage[1])
guiSetProperty(Skills.staticimage[5], "ImageColours", "tl:FF737373 tr:FF737373 bl:FF737373 br:FF737373")

Skills.label[3] = guiCreateLabel(0.52, 0.34, 0.22, 0.04, "Medic", true, Skills.staticimage[1])
guiLabelSetColor(Skills.label[3], 0, 0, 0)
guiLabelSetVerticalAlign(Skills.label[3], "center")
guiSetFont(Skills.label[3],Skills.font[4])
Skills.staticimage[6] = guiCreateStaticImage(0.52, 0.38, 0.06, 0.09, ":DayZ/gui/rpg/icons/med_icon.png", true, Skills.staticimage[1])
guiSetProperty(Skills.staticimage[6], "ImageColours", "tl:FF737373 tr:FF737373 bl:FF737373 br:FF737373")
Skills.staticimage[7] = guiCreateStaticImage(0.66, 0.38, 0.06, 0.09, ":DayZ/gui/rpg/icons/med_scndchance.png", true, Skills.staticimage[1])
guiSetProperty(Skills.staticimage[7], "ImageColours", "tl:FF737373 tr:FF737373 bl:FF737373 br:FF737373")
Skills.staticimage[8] = guiCreateStaticImage(0.74, 0.38, 0.06, 0.09, ":DayZ/gui/rpg/icons/med_prof.png", true, Skills.staticimage[1])
guiSetProperty(Skills.staticimage[8], "ImageColours", "tl:FF737373 tr:FF737373 bl:FF737373 br:FF737373")
Skills.staticimage[9] = guiCreateStaticImage(0.82, 0.38, 0.06, 0.09, ":DayZ/gui/rpg/icons/med_wbor.png", true, Skills.staticimage[1])
guiSetProperty(Skills.staticimage[9], "ImageColours", "tl:FF737373 tr:FF737373 bl:FF737373 br:FF737373")

Skills.label[4] = guiCreateLabel(0.52, 0.53, 0.22, 0.04, "Scavenger", true, Skills.staticimage[1])
guiLabelSetColor(Skills.label[4], 0, 0, 0)
guiLabelSetVerticalAlign(Skills.label[4], "center")
guiSetFont(Skills.label[4],Skills.font[4])
Skills.staticimage[10] = guiCreateStaticImage(0.52, 0.57, 0.06, 0.09, ":DayZ/gui/rpg/icons/scav_icon.png", true, Skills.staticimage[1])
guiSetProperty(Skills.staticimage[10], "ImageColours", "tl:FF737373 tr:FF737373 bl:FF737373 br:FF737373")
Skills.staticimage[11] = guiCreateStaticImage(0.66, 0.57, 0.06, 0.09, ":DayZ/gui/rpg/icons/scav_good.png", true, Skills.staticimage[1])
guiSetProperty(Skills.staticimage[11], "ImageColours", "tl:FF737373 tr:FF737373 bl:FF737373 br:FF737373")
Skills.staticimage[12] = guiCreateStaticImage(0.74, 0.57, 0.06, 0.09, ":DayZ/gui/rpg/icons/scav_camouflage.png", true, Skills.staticimage[1])
guiSetProperty(Skills.staticimage[12], "ImageColours", "tl:FF737373 tr:FF737373 bl:FF737373 br:FF737373")
Skills.staticimage[13] = guiCreateStaticImage(0.82, 0.57, 0.06, 0.09, ":DayZ/gui/rpg/icons/scav_shadow.png", true, Skills.staticimage[1])
guiSetProperty(Skills.staticimage[13], "ImageColours", "tl:FF737373 tr:FF737373 bl:FF737373 br:FF737373")

Skills.label[5] = guiCreateLabel(0.52, 0.72, 0.22, 0.04, "Engineer", true, Skills.staticimage[1])
guiLabelSetColor(Skills.label[5], 0, 0, 0)
guiLabelSetVerticalAlign(Skills.label[5], "center")
guiSetFont(Skills.label[5],Skills.font[4])
Skills.staticimage[14] = guiCreateStaticImage(0.52, 0.76, 0.06, 0.09, ":DayZ/gui/rpg/icons/eng_icon.png", true, Skills.staticimage[1])
guiSetProperty(Skills.staticimage[14], "ImageColours", "tl:FF737373 tr:FF737373 bl:FF737373 br:FF737373")
Skills.staticimage[15] = guiCreateStaticImage(0.66, 0.76, 0.06, 0.09, ":DayZ/gui/rpg/icons/eng_ammo.png", true, Skills.staticimage[1])
guiSetProperty(Skills.staticimage[15], "ImageColours", "tl:FF737373 tr:FF737373 bl:FF737373 br:FF737373")
Skills.staticimage[16] = guiCreateStaticImage(0.74, 0.76, 0.06, 0.09, ":DayZ/gui/rpg/icons/eng_duct.png", true, Skills.staticimage[1])
guiSetProperty(Skills.staticimage[16], "ImageColours", "tl:FF737373 tr:FF737373 bl:FF737373 br:FF737373")
Skills.staticimage[17] = guiCreateStaticImage(0.82, 0.76, 0.06, 0.09, ":DayZ/gui/rpg/icons/eng_analysis.png", true, Skills.staticimage[1])
guiSetProperty(Skills.staticimage[17], "ImageColours", "tl:FF737373 tr:FF737373 bl:FF737373 br:FF737373")

Skills.label[6] = guiCreateLabel(0.10, 0.19, 0.37, 0.40, "Skills are a necessary prerequisite for every survivalist out there. However, in order to learn these particular skills, I need to find out how to properly use them...and if I cannot find someone to teach me, I will have to learn it by myself.\n\nOnce I have enough experience in a particular field, I will be able to put that into use.", true, Skills.staticimage[1])
guiLabelSetColor(Skills.label[6], 0, 0, 0)
guiLabelSetHorizontalAlign(Skills.label[6], "left", true)
guiSetFont(Skills.label[6],Skills.font[2])


Skills.label[7] = guiCreateLabel(0.10, 0.68, 0.36, 0.04, "Current XP: 0", true, Skills.staticimage[1])
guiLabelSetColor(Skills.label[7], 0, 0, 0)
guiSetFont(Skills.label[7],Skills.font[2])

Skills.label[8] = guiCreateLabel(0.10, 0.72, 0.36, 0.04, "Current SP: 0", true, Skills.staticimage[1])
guiLabelSetColor(Skills.label[8], 0, 0, 0)
guiSetFont(Skills.label[8],Skills.font[2])

Skills.label[9] = guiCreateLabel(0.10, 0.76, 0.36, 0.04, "Conversion Rate: 20 XP for 1 SP", true, Skills.staticimage[1])
guiLabelSetColor(Skills.label[9], 0, 0, 0)
guiSetFont(Skills.label[9],Skills.font[2])

Skills.label[10] = guiCreateLabel(0.33, 0.87, 0.17, 0.04, "Convert XP to SP", true, Skills.staticimage[1])
guiLabelSetColor(Skills.label[10], 0, 0, 0)
guiSetFont(Skills.label[10],Skills.font[3])

Skills.label["SoldierDodge"] = guiCreateLabel(0.66, 0.28, 0.06, 0.04, "Level: 0", true, Skills.staticimage[1])
guiLabelSetColor(Skills.label["SoldierDodge"], 0, 0, 0)
guiSetFont(Skills.label["SoldierDodge"],Skills.font[4])

Skills.label["SoldierTough"] = guiCreateLabel(0.74, 0.28, 0.06, 0.04, "Level: 0", true, Skills.staticimage[1])
guiLabelSetColor(Skills.label["SoldierTough"], 0, 0, 0)
guiSetFont(Skills.label["SoldierTough"],Skills.font[4])

Skills.label["SoldierCrit"] = guiCreateLabel(0.81, 0.28, 0.06, 0.04, "Level: 0", true, Skills.staticimage[1])
guiLabelSetColor(Skills.label["SoldierCrit"], 0, 0, 0)
guiSetFont(Skills.label["SoldierCrit"],Skills.font[4])

Skills.label["MedicChance"] = guiCreateLabel(0.66, 0.47, 0.06, 0.04, "Level: 0", true, Skills.staticimage[1])
guiLabelSetColor(Skills.label["MedicChance"], 0, 0, 0)
guiSetFont(Skills.label["MedicChance"],Skills.font[4])

Skills.label["MedicProf"] = guiCreateLabel(0.74, 0.47, 0.06, 0.04, "Level: 0", true, Skills.staticimage[1])
guiLabelSetColor(Skills.label["MedicProf"], 0, 0, 0)
guiSetFont(Skills.label["MedicProf"],Skills.font[4])

Skills.label["MedicBorders"] = guiCreateLabel(0.81, 0.47, 0.06, 0.04, "Level: 0", true, Skills.staticimage[1])
guiLabelSetColor(Skills.label["MedicBorders"], 0, 0, 0)
guiSetFont(Skills.label["MedicBorders"],Skills.font[4])

Skills.label["ScavengerGood"] = guiCreateLabel(0.66, 0.66, 0.06, 0.04, "Level: 0", true, Skills.staticimage[1])
guiLabelSetColor(Skills.label["ScavengerGood"], 0, 0, 0)
guiSetFont(Skills.label["ScavengerGood"],Skills.font[4])

Skills.label["ScavengerCamouflage"] = guiCreateLabel(0.74, 0.66, 0.06, 0.04, "Level: 0", true, Skills.staticimage[1])
guiLabelSetColor(Skills.label["ScavengerCamouflage"], 0, 0, 0)
guiSetFont(Skills.label["ScavengerCamouflage"],Skills.font[4])

Skills.label["ScavengerShadow"] = guiCreateLabel(0.81, 0.66, 0.06, 0.04, "Level: 0", true, Skills.staticimage[1])
guiLabelSetColor(Skills.label["ScavengerShadow"], 0, 0, 0)
guiSetFont(Skills.label["ScavengerShadow"],Skills.font[4])

Skills.label["EngineerAmmo"] = guiCreateLabel(0.66, 0.85, 0.06, 0.04, "Level: 0", true, Skills.staticimage[1])
guiLabelSetColor(Skills.label["EngineerAmmo"], 0, 0, 0)
guiSetFont(Skills.label["EngineerAmmo"],Skills.font[4])

Skills.label["EngineerDuct"] = guiCreateLabel(0.74, 0.85, 0.06, 0.04, "Level: 0", true, Skills.staticimage[1])
guiLabelSetColor(Skills.label["EngineerDuct"], 0, 0, 0)
guiSetFont(Skills.label["EngineerDuct"],Skills.font[4])

Skills.label["EngineerAnalysis"] = guiCreateLabel(0.81, 0.85, 0.06, 0.04, "Level: 0", true, Skills.staticimage[1])
guiLabelSetColor(Skills.label["EngineerAnalysis"], 0, 0, 0)
guiSetFont(Skills.label["EngineerAnalysis"],Skills.font[4])

-- Description Label
Skills.label[23] = guiCreateLabel(0.10, 0.49, 0.37, 0.20, "", true, Skills.staticimage[1])
guiLabelSetColor(Skills.label[23], 0, 0, 0)
guiLabelSetHorizontalAlign(Skills.label[23], "left", true)
guiSetFont(Skills.label[23],Skills.font[2])

-- Error Label
Skills.label[24] = guiCreateLabel(0.52, 0.10, 0.36, 0.05, "", true, Skills.staticimage[1])
guiLabelSetColor(Skills.label[24], 255,0,0)
guiLabelSetHorizontalAlign(Skills.label[24], "left", true)
guiSetFont(Skills.label[24],Skills.font[4])


-- Max breaks (\n) allowed: 4
Skills.description[2] = "I am going the path of the soldier.\nActivates Soldier Skills"
Skills.description[3] = "Allows me to dodge hits from zombies.\nEach level increases the chance.\nChance: "
Skills.description[4] = "I am tough enough to withstand some serious blows.\nDamage Reduction: -"
Skills.description[5] = "I perfected my marksmanship to the point I could even hit a fly between its eyes.\nChance to deal critical damage: "
Skills.description[6] = "I am going the path of the medic.\nActivates Medic Skills"
Skills.description[7] = "I am capable of surviving fatal blows, but only through sheer luck.\nChance to survive deadly hit: "
Skills.description[8] = "I have seen enough of the human anatomy to know what I'm doing.\nHealing Power: "
Skills.description[9] = "People around me feel safer because they know I can help them.\nHealing Power other people: "
Skills.description[10] = "I am going the path of the scavenger.\nActivates Scavenger Skills"
Skills.description[11] = "My good luck allows me to find more stuff.\nChance to loot +1 more item: "
Skills.description[12] = "I am blending in with my environment whenever I'm not moving.\nBlend Level: "
Skills.description[13] = "Zombies have a harder time detecting me.\nDetection Chance: -"
Skills.description[14] = "I am going the path of the engineer.\nActivates Engineer Skills"
Skills.description[15] = "I know every detail and inner workings of my weapon.\nChance to not consume ammo: "
Skills.description[16] = "I have created a prototype for duct tape which is superior to any currently existing tape.\nRepair Rate: "
Skills.description[17] = "I have honed my ability to analyze all kinds of situations and can react appropriately.\nIncreased XP Gain: +"

guiSetVisible(Skills.staticimage[1],false)

function guiClickConvertXPToSP()
	triggerServerEvent("onPlayerConvertXPToSP",localPlayer)
end
addEventHandler("onClientGUIClick",Skills.label[10],guiClickConvertXPToSP,false)

function onPlayerGUISkillError(message)
	guiSetText(Skills.label[24],message)
	setTimer(guiSetText,3000,1,Skills.label[24],"")
end
addEvent("onPlayerGUISkillError",true)
addEventHandler("onPlayerGUISkillError",root,onPlayerGUISkillError)

function onPlayerGUIUpdateXP(xp,sp,conversionxp)
	guiSetText(Skills.label[7],"Current XP: "..tostring(math.floor(xp)))
	guiSetText(Skills.label[8],"Current SP: "..tostring(sp))
	guiSetText(Skills.label[9],"Conversion Rate: "..tostring(math.ceil(conversionxp)).." XP for 1 SP")
end
addEvent("onPlayerGUIUpdateXP",true)
addEventHandler("onPlayerGUIUpdateXP",root,onPlayerGUIUpdateXP)

function setConversionLabelRed()
	if source == Skills.label[10] then
		guiLabelSetColor(Skills.label[10],255,0,0)
	end
end
addEventHandler("onClientMouseEnter",Skills.label[10],setConversionLabelRed)

function setConversionLabelBlack()
	if source == Skills.label[10] then
		guiLabelSetColor(Skills.label[10],0,0,0)
	end
end
addEventHandler("onClientMouseLeave",Skills.label[10],setConversionLabelBlack)

function setSkillDescription()
	if source == Skills.staticimage[2] then
		guiSetText(Skills.label[23],Skills.description[2])
	elseif source == Skills.staticimage[3] then
		guiSetText(Skills.label[23],Skills.description[3]..""..tostring(playerSkillsTable[localPlayer]["SoldierDodgeChance"]).."%")
	elseif source == Skills.staticimage[4] then
		guiSetText(Skills.label[23],Skills.description[4]..""..tostring(playerSkillsTable[localPlayer]["SoldierToughChance"]).."%")
	elseif source == Skills.staticimage[5] then
		guiSetText(Skills.label[23],Skills.description[5]..""..tostring(playerSkillsTable[localPlayer]["SoldierCritChance"]).."%")
	elseif source == Skills.staticimage[6] then
		guiSetText(Skills.label[23],Skills.description[6])
	elseif source == Skills.staticimage[7] then
		guiSetText(Skills.label[23],Skills.description[7]..""..tostring(playerSkillsTable[localPlayer]["MedicChanceChance"]).."%")
	elseif source == Skills.staticimage[8] then
		guiSetText(Skills.label[23],Skills.description[8]..""..tostring(playerSkillsTable[localPlayer]["MedicProfChance"]).."%")
	elseif source == Skills.staticimage[9] then
		guiSetText(Skills.label[23],Skills.description[9]..""..tostring(playerSkillsTable[localPlayer]["MedicBordersChance"]).."%")
	elseif source == Skills.staticimage[10] then
		guiSetText(Skills.label[23],Skills.description[10])
	elseif source == Skills.staticimage[11] then
		guiSetText(Skills.label[23],Skills.description[11]..""..tostring(playerSkillsTable[localPlayer]["ScavengerGoodChance"]).."%")
	elseif source == Skills.staticimage[12] then
		guiSetText(Skills.label[23],Skills.description[12]..""..tostring(playerSkillsTable[localPlayer]["ScavengerCamouflageChance"]).."%")
	elseif source == Skills.staticimage[13] then
		guiSetText(Skills.label[23],Skills.description[13]..""..tostring(playerSkillsTable[localPlayer]["ScavengerShadowChance"]).."%")
	elseif source == Skills.staticimage[14] then
		guiSetText(Skills.label[23],Skills.description[14])
	elseif source == Skills.staticimage[15] then
		guiSetText(Skills.label[23],Skills.description[15]..""..tostring(playerSkillsTable[localPlayer]["EngineerAmmoChance"]).."%")
	elseif source == Skills.staticimage[16] then
		guiSetText(Skills.label[23],Skills.description[16]..""..tostring(playerSkillsTable[localPlayer]["EngineerDuctChance"]).."%")
	elseif source == Skills.staticimage[17] then
		guiSetText(Skills.label[23],Skills.description[17]..""..tostring(playerSkillsTable[localPlayer]["EngineerAnalysisChance"]).." %")
	end
end
addEventHandler("onClientMouseEnter",resourceRoot,setSkillDescription)

function highlightActiveSkills()
	if playerSkillsTable[localPlayer]["SoldierActive"] then 
		guiSetProperty(Skills.staticimage[2], "ImageColours", "tl:ffffffff tr:ffffffff bl:ffffffff br:ffffffff")
	end
	if playerSkillsTable[localPlayer]["SoldierDodge"] > 0 then  
		guiSetProperty(Skills.staticimage[3], "ImageColours", "tl:ffffffff tr:ffffffff bl:ffffffff br:ffffffff")
	end
	if playerSkillsTable[localPlayer]["SoldierTough"] > 0 then 
		guiSetProperty(Skills.staticimage[4], "ImageColours", "tl:ffffffff tr:ffffffff bl:ffffffff br:ffffffff")
	end
	if playerSkillsTable[localPlayer]["SoldierCrit"] > 0 then  
		guiSetProperty(Skills.staticimage[5], "ImageColours", "tl:ffffffff tr:ffffffff bl:ffffffff br:ffffffff")
	end
	
	if playerSkillsTable[localPlayer]["MedicActive"] then
		guiSetProperty(Skills.staticimage[6], "ImageColours", "tl:ffffffff tr:ffffffff bl:ffffffff br:ffffffff")
	end
	if playerSkillsTable[localPlayer]["MedicChance"] > 0 then
		guiSetProperty(Skills.staticimage[7], "ImageColours", "tl:ffffffff tr:ffffffff bl:ffffffff br:ffffffff")
	end
	if playerSkillsTable[localPlayer]["MedicProf"] > 0 then
		guiSetProperty(Skills.staticimage[8], "ImageColours", "tl:ffffffff tr:ffffffff bl:ffffffff br:ffffffff")
	end
	if playerSkillsTable[localPlayer]["MedicBorders"] > 0 then
		guiSetProperty(Skills.staticimage[9], "ImageColours", "tl:ffffffff tr:ffffffff bl:ffffffff br:ffffffff")
	end

	if playerSkillsTable[localPlayer]["ScavengerActive"] then 
		guiSetProperty(Skills.staticimage[10], "ImageColours", "tl:ffffffff tr:ffffffff bl:ffffffff br:ffffffff")
	end
	if playerSkillsTable[localPlayer]["ScavengerGood"] > 0 then
		guiSetProperty(Skills.staticimage[11], "ImageColours", "tl:ffffffff tr:ffffffff bl:ffffffff br:ffffffff")
	end
	if playerSkillsTable[localPlayer]["ScavengerCamouflage"] > 0 then 
		guiSetProperty(Skills.staticimage[12], "ImageColours", "tl:ffffffff tr:ffffffff bl:ffffffff br:ffffffff")
	end
	if playerSkillsTable[localPlayer]["ScavengerShadow"] > 0 then 
		guiSetProperty(Skills.staticimage[13], "ImageColours", "tl:ffffffff tr:ffffffff bl:ffffffff br:ffffffff")
	end
		
	if playerSkillsTable[localPlayer]["EngineerActive"] then 
		guiSetProperty(Skills.staticimage[14], "ImageColours", "tl:ffffffff tr:ffffffff bl:ffffffff br:ffffffff")
	end
	if playerSkillsTable[localPlayer]["EngineerAmmo"] > 0 then 
		guiSetProperty(Skills.staticimage[15], "ImageColours", "tl:ffffffff tr:ffffffff bl:ffffffff br:ffffffff")
	end
	if playerSkillsTable[localPlayer]["EngineerDuct"] > 0 then 
		guiSetProperty(Skills.staticimage[16], "ImageColours", "tl:ffffffff tr:ffffffff bl:ffffffff br:ffffffff")
	end
	if playerSkillsTable[localPlayer]["EngineerAnalysis"] > 0 then 
		guiSetProperty(Skills.staticimage[17], "ImageColours", "tl:ffffffff tr:ffffffff bl:ffffffff br:ffffffff")
	end
end

function highlightSelectedSkill()
	-- Soldier
	if source == Skills.staticimage[2] then
		if playerSkillsTable[localPlayer]["SoldierActive"] then return end
	elseif source == Skills.staticimage[3] then
		if playerSkillsTable[localPlayer]["SoldierDodge"] > 0 then return end
	elseif source == Skills.staticimage[4] then
		if playerSkillsTable[localPlayer]["SoldierTough"] > 0 then return end
	elseif source == Skills.staticimage[5] then
		if playerSkillsTable[localPlayer]["SoldierCrit"] > 0 then return end
	end
	-- Medic
	if source == Skills.staticimage[6] then
		if playerSkillsTable[localPlayer]["MedicActive"] then return end
	elseif source == Skills.staticimage[7] then
		if playerSkillsTable[localPlayer]["MedicChance"] > 0 then return end
	elseif source == Skills.staticimage[8] then
		if playerSkillsTable[localPlayer]["MedicProf"] > 0 then return end
	elseif source == Skills.staticimage[9] then	
		if playerSkillsTable[localPlayer]["MedicBorders"] > 0 then return end
	end
	-- Scavenger
	if source == Skills.staticimage[10] then
		if playerSkillsTable[localPlayer]["ScavengerActive"] then return end
	elseif source == Skills.staticimage[11] then 
		if playerSkillsTable[localPlayer]["ScavengerGood"] > 0 then return end
	elseif source == Skills.staticimage[12] then
		if playerSkillsTable[localPlayer]["ScavengerCamouflage"] > 0 then return end
	elseif source == Skills.staticimage[13] then	
		if playerSkillsTable[localPlayer]["ScavengerShadow"] > 0 then return end
	end
	-- Engineer
	if source == Skills.staticimage[14] then
		if playerSkillsTable[localPlayer]["EngineerActive"] then return end
	elseif source == Skills.staticimage[15] then
		if playerSkillsTable[localPlayer]["EngineerAmmo"] > 0 then return end
	elseif source == Skills.staticimage[16] then
		if playerSkillsTable[localPlayer]["EngineerDuct"] > 0 then return end
	elseif source == Skills.staticimage[17] then	
		if playerSkillsTable[localPlayer]["EngineerAnalysis"] > 0 then return end
	end
	
	for i=2, 17 do
		if source == Skills.staticimage[i] then
			guiSetProperty(source, "ImageColours", "tl:ffffffff tr:ffffffff bl:ffffffff br:ffffffff")
		end
	end
end
addEventHandler("onClientMouseEnter",resourceRoot,highlightSelectedSkill)

function highlightSelectedSkill()
	-- Soldier
	if source == Skills.staticimage[2] then
		if playerSkillsTable[localPlayer]["SoldierActive"] then return end
	elseif source == Skills.staticimage[3] then
		if playerSkillsTable[localPlayer]["SoldierDodge"] > 0 then return end
	elseif source == Skills.staticimage[4] then
		if playerSkillsTable[localPlayer]["SoldierTough"] > 0 then return end
	elseif source == Skills.staticimage[5] then
		if playerSkillsTable[localPlayer]["SoldierCrit"] > 0 then return end
	end
	-- Medic
	if source == Skills.staticimage[6] then
		if playerSkillsTable[localPlayer]["MedicActive"] then return end
	elseif source == Skills.staticimage[7] then
		if playerSkillsTable[localPlayer]["MedicChance"] > 0 then return end
	elseif source == Skills.staticimage[8] then
		if playerSkillsTable[localPlayer]["MedicProf"] > 0 then return end
	elseif source == Skills.staticimage[9] then	
		if playerSkillsTable[localPlayer]["MedicBorders"] > 0 then return end
	end
	-- Scavenger
	if source == Skills.staticimage[10] then
		if playerSkillsTable[localPlayer]["ScavengerActive"] then return end
	elseif source == Skills.staticimage[11] then 
		if playerSkillsTable[localPlayer]["ScavengerGood"] > 0 then return end
	elseif source == Skills.staticimage[12] then
		if playerSkillsTable[localPlayer]["ScavengerCamouflage"] > 0 then return end
	elseif source == Skills.staticimage[13] then	
		if playerSkillsTable[localPlayer]["ScavengerShadow"] > 0 then return end
	end
	-- Engineer
	if source == Skills.staticimage[14] then
		if playerSkillsTable[localPlayer]["EngineerActive"] then return end
	elseif source == Skills.staticimage[15] then
		if playerSkillsTable[localPlayer]["EngineerAmmo"] > 0 then return end
	elseif source == Skills.staticimage[16] then
		if playerSkillsTable[localPlayer]["EngineerDuct"] > 0 then return end
	elseif source == Skills.staticimage[17] then	
		if playerSkillsTable[localPlayer]["EngineerAnalysis"] > 0 then return end
	end
	
	for i=2, 17 do
		if source == Skills.staticimage[i] then
			guiSetProperty(source, "ImageColours", "tl:FF737373 tr:FF737373 bl:FF737373 br:FF737373")
		end
	end
	
	guiSetText(Skills.label[23],"")
end
addEventHandler("onClientMouseLeave",resourceRoot,highlightSelectedSkill)

function activateSkillOnClick()
	for i=2, 17 do
		if source == Skills.staticimage[i] then
			triggerServerEvent("onPlayerActivateSkill",localPlayer,i)
		end
	end
end
addEventHandler("onClientGUIClick",resourceRoot,activateSkillOnClick)

function onPlayerGUIUpdateSkillLevel(skillName,skillValue,imageNumber,chanceName,skillChance)
	if skillName then
		guiSetProperty(Skills.staticimage[imageNumber], "ImageColours", "tl:ffffffff tr:ffffffff bl:ffffffff br:ffffffff")
		playerSkillsTable[localPlayer][skillName] = skillValue
		if chanceName then
			playerSkillsTable[localPlayer][chanceName] = skillChance
			guiSetText(Skills.label[23],Skills.description[imageNumber]..""..playerSkillsTable[localPlayer][chanceName].."%")
		end
		if tonumber(skillValue) then
			guiSetText(Skills.label[skillName],"Level: "..playerSkillsTable[localPlayer][skillName])
		end
	end
end
addEvent("onPlayerGUIUpdateSkillLevel",true)
addEventHandler("onPlayerGUIUpdateSkillLevel",root,onPlayerGUIUpdateSkillLevel)

function onPlayerUpdateSkillsToJournal(skillTable)
	if skillTable then
		playerSkillsTable[localPlayer] = {}
		for k, data in pairs(skillTable) do
			playerSkillsTable[localPlayer][k] = data
			if Skills.label[k] then
				guiSetText(Skills.label[k],"Level: "..playerSkillsTable[localPlayer][k])
			end
		end
	end
	highlightActiveSkills()
	guiSetText(Skills.label[7],"Current XP: "..tostring(math.floor(playerSkillsTable[localPlayer]["XP"])))
	guiSetText(Skills.label[8],"Current SP: "..tostring(playerSkillsTable[localPlayer]["SP"]))
	guiSetText(Skills.label[9],"Conversion Rate: "..tostring(playerSkillsTable[localPlayer]["conversionXP"]).." XP for 1 SP")
end
addEvent("onPlayerUpdateSkillsToJournal",true)
addEventHandler("onPlayerUpdateSkillsToJournal",root,onPlayerUpdateSkillsToJournal)

-- NPCs & Settlement Code

npcTextTable = {
	font = {},
    conversationLabel = {},
    conversationImage = {},
	jobdetailsLabel = {},
	jobdetailsImage = {},
	startJobLabel = {},
}

--[[
Determines what NPC has what job (the NPC name must correspond to the name given in jobsSpawnPosTable, found serverside
{"npcName","npcJobRole"},
]]
local npcSpeechBubbleData = {
{"Wilkins","- Extermination Jobs -"},
{"Dr Lovestrange","- Science Jobs -"},
}

-- Extermination Jobs
--[[
This table contains the actual extermination jobs given to the player

Location: Rough location of the job (i.e San Fierro) (string)
requiredKills: Number of kills required in order to complete job
x,y,z: Exact coordinates, player must be within 25m of these in order to trigger job (int,int,int)
xpReward: XP rewarded once job has been completeds  (int)
spReward: SP rewarded once job has been completed (int)
"itemsReward": Item rewarded upon job completion, leave as "itemsReward" if you do want to give an item (string)
itemsRewardNumber: Number of item rewarded from itemsReward, set to 0 if you do want to give an item (int)
]]
local npcExterminationJobData = {
-- {"Location",requiredKills,x,y,z, xpReward, spReward, "itemsReward", itemsRewardNumber}
{"San Fierro",30,-2466.9118652344, 647.05883789063, 33.018211364746,30,1,"itemsReward",0},
{"Missionary Hill",30,-2405, -598, 132.6484375,30,0,"itemsReward",0},
{"Easter Bay Airport",40,-1336.3970947266, -189.33824157715, 14.1484375,40,0,"itemsReward",0},
{"Los Santos International",40,1733.4559326172, -2459.5588378906, 13.5546875,40,0,"itemsReward",0},
{"Las Venturas Airport",25,1362.6160888672, 1564.2092285156, 10.8203125,25,0,"itemsReward",0},
{"Verdant Meadows",25,235.29411315918, 2430.1469726563, 16.844324111938,25,0,"itemsReward",0},
{"Ganton",35,2493.1552734375, -1670.9654541016, 13.335947036743,35,0,"itemsReward",0},
{"Blueberry",28,180.14706420898, -106.61764526367, 2.0234375,28,0,"itemsReward",0},
{"Flint Range",10,-377.5393371582, -1439.3898925781, 25.7265625,10,0,"itemsReward",0},
}

--[[
This table tells the extermination NPC what to say to the player when a conversation has been initiated

GreetingsText: How the player should be greeted by the NPC, leave as GreetingsText if you do want the NPC to greet the player (string)
DescriptionText: A text describing the job (string)
LocationText: Rough description of the location (string)
]]
local npcExterminationTextModules = {
-- {"GreetingsText","DescriptionText","LocationText"},
{"What's up,","Got a job for you, if you're interested. I need you to exterminate a few zombies that are causing quite the ruckus. If you manage to kill them before they get you, I'll reward you with something nice. What do you say, hm?","They are currently near"},
{"Hello there,","Yet another job for you. This time, some zombies managed to get some of my men. Go avenge them. Make it back in one piece, and you'll be in for quite a reward.","My men were last seen in the vicinity of"},
{"How're you doing,","Some zeds are trying to breach through a survivor camp nearby. They could use some help, so go and provide some. Suffice to say, you'll be rewarded for your generous help.","The survivor camp is in"},
{"GreetingsText","Job's plain and simple: Go outside and kill some zombies. Bring the fight to them!","Looks like they're in"},
}

-- Determines what NPCs could say when a player has successfully completed an extermination job
local npcExterminationSuccessModules = {
{"Word has it you've sent some of these bastards back to hell. Here, allow me to gift you a token of my appreciation. You deserve it."},
{"I need more people going out there and help wipe every last zed off this planet. You're doing god's work. Here you go, a reward."},
{"Keep doing what you're doing, the world's better off without zombies."},
{"Trust me, one day, there won't be a single zombie left to take on. And we shall realize that truth, and that truth shall set us free. But for now, thanks for helping out. Enjoy this reward."},
}

-- Science Jobs
--[[
This table contains the actual science jobs given to the player

ItemNeeded: Name of the item needed to complete job
itemsNumberRequired: Number of items required in order to complete job
xpReward: XP rewarded once job has been completeds  (int)
spReward: SP rewarded once job has been completed (int)
"itemsReward": Item rewarded upon job completion, leave as "itemsReward" if you don't want to give an item (string)
itemsRewardNumber: Number of item rewarded from itemsReward, set to 0 if you don't want to give an item (int)
]]
local npcScienceJobData = {
-- {"ItemNeeded",requiredItemNumber, xpReward, spReward, "itemsReward", itemsRewardNumber}
{"Frank & Beans",1,30,1,"itemsReward",0},
{"Blood Bag (Empty)",1,30,1,"itemsReward",0},
{"Can (Corn)",1,30,1,"itemsReward",0},
{"Hunting Knife",1,60,1,"itemsReward",0},
{"Can (Milk)",1,30,1,"itemsReward",0},
{"Trail Mix",1,30,1,"itemsReward",0},
{"Bandage",1,30,1,"itemsReward",0},
{"Painkiller",1,30,1,"itemsReward",0},
{"Morphine",1,30,1,"itemsReward",0},
{"Road Flare",1,30,1,"itemsReward",0},
{"Heat Pack",1,30,1,"itemsReward",0},

}

--[[
This table tells the science NPC what to say to the player when a conversation has been initiated

GreetingsText: How the player should be greeted by the NPC, leave as GreetingsText if you do want the NPC to greet the player (string)
DescriptionText: A text describing the job (string)
NeededText: Transition to what item is needed (string)
]]
local npcScienceTextModules = {
-- {"GreetingsText","DescriptionText","NeededText"},
{"Greetings,","I'm running very, very low on a certain ingredient I need for my experiments. Mind if you go and fetch some for me? Don't worry, you'll get a reward. If a zombie doesn't get you first. In which case you'll end up as my personal guinea pig.","The item I'm looking for is a"},
{"My dear,","My experiments are going quite smoothly, thank you for asking. However, unless you volunteer to participate in a less than ethical project, you should go get an object for me.","That object happens to be a"},
{"Please do not disturb me,","Those zombies are really quite an interesting subject...I need more data, though.","Go get me a"},
}

-- Determines what a NPC could say once a science job has been completed
local npcScienceSuccessModules = {
{"Oh, looks like you've managed to find the object I desired! Here, as promised, your reward."},
{"And if I were to relate the NP-complete problem to this matr- oh, it's you. You were able to find the item I requested? Funny, thought I'd given you an impossible job...anyway, here's your reward."},
{"My my, who do we have here? Wait, should I know you? ...A job from me? Can't recall ever having given one to you, but since you were nice enough to find me that item, I might as well give you something in return."},
{"Dr Lovestrange likes it a lot whenever people of lesser intellect do his bidding. However, talking in third person is less royal sounding than he thought it would. Here's your reward."}, 
}

-- Speech Bubble Code
local screenWidth, screenHeight = guiGetScreenSize()
local showingSpeechBubble = false
local textSpeechBubble = "-"
local positionSpeechBubble = false
local colshapeNPC = {}

function setSpeechBubble(show,name,text,element)
	showingSpeechBubble = show
	textSpeechBubble = name.."\n"..text.."\n".."<Press E to start conversation>"
	positionSpeechBubble = element
	return
end

local speechBubbleFont = dxCreateFont("fonts/tahomab.ttf",9)
addEventHandler("onClientRender", getRootElement(), 
function()
	if not showingSpeechBubble then return end
	if isElement(positionSpeechBubble) then
		local x,y,z = getElementPosition(positionSpeechBubble)
		local x,y = getScreenFromWorldPosition(x,y,z)
		local length = dxGetTextWidth(textSpeechBubble,1,speechBubbleFont)
		if tonumber(x) and tonumber(y) then
			dxDrawRectangle ( x-length/2-screenWidth*0.01,y*0.5, screenWidth*0.02+length, screenHeight*0.07, tocolor (0,0,0,255) )
			dxDrawText(textSpeechBubble,x-length/2-screenWidth*0.01,y*0.06, x+length/2+screenWidth*0.01, y+screenHeight*0.03, tocolor(255,255,255,255),1, speechBubbleFont, "center", "center")
		end
	end
end)

function createSpeechBubble(theElement)
	if getElementData(source,"npcCol") then
		if theElement == localPlayer then
			local npc = getElementData(source,"npcCol")
			local npcName = getElementData(source,"npcName")
			local npcJobRole = ""
			for i, npcData in ipairs(npcSpeechBubbleData) do
				if npcData[1] == npcName then
					npcJobRole = npcData[2]
				end
			end
			setSpeechBubble(true,npcName,npcJobRole,npc)
			guiSetText(npcTextTable.conversationLabel[2],npcName)
			bindKey("E","down","Start Conversation")
			colshapeNPC[localPlayer] = npc
		end
	end
end
addEventHandler("onClientColShapeHit",resourceRoot,createSpeechBubble)

function destroySpeechBubble(theElement)
	if getElementData(source,"npcCol") then
		if theElement == localPlayer then
			setSpeechBubble(false,"","")
			guiSetVisible(npcTextTable.conversationImage[1],false)
			unbindKey("E","down","Start Conversation")
			colshapeNPC[localPlayer] = {}
			conversationStarted = false
		end
	end
end
addEventHandler("onClientColShapeLeave",resourceRoot,destroySpeechBubble)

-- Job GUI Code

-- Fonts
npcTextTable.font[1] = guiCreateFont(":DayZ/fonts/tahomab.ttf",12)
npcTextTable.font[2] = guiCreateFont(":DayZ/fonts/tahomab.ttf",9)
npcTextTable.font[3] = guiCreateFont(":DayZ/fonts/tahomab.ttf",40)

-- Conversation Code
npcTextTable.conversationImage[1] = guiCreateStaticImage(0.05, 0.74, 0.90, 0.20, ":DayZ/gui/rpg/icons/line.png", true)
guiSetProperty(npcTextTable.conversationImage[1], "ImageColours", "tl:A2000000 tr:A2000000 bl:A2000000 br:A2000000")
npcTextTable.conversationLabel[1] = guiCreateLabel(0.16, 0.24, 0.79, 0.51, "", true, npcTextTable.conversationImage[1]) -- NPC Conversation
guiLabelSetHorizontalAlign(npcTextTable.conversationLabel[1], "left", true)
guiSetFont(npcTextTable.conversationLabel[1],npcTextTable.font[1])
npcTextTable.conversationLabel[2] = guiCreateLabel(0.16, 0.06, 0.26, 0.15, "", true, npcTextTable.conversationImage[1]) -- NPC Name
guiLabelSetHorizontalAlign(npcTextTable.conversationLabel[2], "left", true)
guiSetFont(npcTextTable.conversationLabel[2],npcTextTable.font[1])
npcTextTable.conversationLabel[3] = guiCreateLabel(0.75, 0.80, 0.12, 0.16, "Next", true, npcTextTable.conversationImage[1])
guiLabelSetHorizontalAlign(npcTextTable.conversationLabel[3], "center", false)
guiSetFont(npcTextTable.conversationLabel[3],npcTextTable.font[2])
npcTextTable.conversationLabel[4] = guiCreateLabel(0.85, 0.80, 0.12, 0.16, "End Conversation", true, npcTextTable.conversationImage[1])
guiSetFont(npcTextTable.conversationLabel[4],npcTextTable.font[2])
npcTextTable.conversationImage[2] = guiCreateStaticImage(0.015, 0.13, 0.13, 0.73, ":DayZ/gui/rpg/icons/line.png", true, npcTextTable.conversationImage[1])

-- Job Details Code
npcTextTable.jobdetailsImage[1] = guiCreateStaticImage(0.05, 0.25, 0.25, 0.45, ":DayZ/gui/rpg/icons/line.png", true)
guiSetProperty(npcTextTable.jobdetailsImage[1], "ImageColours", "tl:9F000000 tr:9F000000 bl:9F000000 br:9F000000")

npcTextTable.jobdetailsLabel[1] = guiCreateLabel(0.00, 0.00, 1.00, 0.06, "Job Details", true, npcTextTable.jobdetailsImage[1])
guiLabelSetHorizontalAlign(npcTextTable.jobdetailsLabel[1], "center", false)
guiLabelSetVerticalAlign(npcTextTable.jobdetailsLabel[1], "center")
guiSetFont(npcTextTable.jobdetailsLabel[1],npcTextTable.font[1])
npcTextTable.jobdetailsLabel[2] = guiCreateLabel(0.02, 0.20, 0.28, 0.07, "Location:", true, npcTextTable.jobdetailsImage[1])
guiLabelSetVerticalAlign(npcTextTable.jobdetailsLabel[2], "center")
guiSetFont(npcTextTable.jobdetailsLabel[2],npcTextTable.font[2])
npcTextTable.jobdetailsLabel[3] = guiCreateLabel(0.02, 0.26, 0.28, 0.07, "Job Type:", true, npcTextTable.jobdetailsImage[1])
guiLabelSetVerticalAlign(npcTextTable.jobdetailsLabel[3], "center")
guiSetFont(npcTextTable.jobdetailsLabel[3],npcTextTable.font[2])
npcTextTable.jobdetailsLabel[4] = guiCreateLabel(0.02, 0.33, 0.28, 0.07, "Rewards:", true, npcTextTable.jobdetailsImage[1])
guiLabelSetVerticalAlign(npcTextTable.jobdetailsLabel[4], "center")
guiSetFont(npcTextTable.jobdetailsLabel[4],npcTextTable.font[2])
npcTextTable.jobdetailsLabel[5] = guiCreateLabel(0.29, 0.20, 0.67, 0.07, "LOCATION", true, npcTextTable.jobdetailsImage[1])
guiLabelSetVerticalAlign(npcTextTable.jobdetailsLabel[5], "center")
guiSetFont(npcTextTable.jobdetailsLabel[5],npcTextTable.font[2])
npcTextTable.jobdetailsLabel[6] = guiCreateLabel(0.29, 0.26, 0.67, 0.07, "EXTERMINATION", true, npcTextTable.jobdetailsImage[1])
guiLabelSetVerticalAlign(npcTextTable.jobdetailsLabel[6], "center")
guiSetFont(npcTextTable.jobdetailsLabel[6],npcTextTable.font[2])
npcTextTable.jobdetailsLabel[7] = guiCreateLabel(0.29, 0.33, 0.67, 0.07, "XPREWARD", true, npcTextTable.jobdetailsImage[1])
guiLabelSetVerticalAlign(npcTextTable.jobdetailsLabel[7], "center")
guiSetFont(npcTextTable.jobdetailsLabel[7],npcTextTable.font[2])
npcTextTable.jobdetailsLabel[8] = guiCreateLabel(0.29, 0.40, 0.67, 0.07, "SPREWARD", true, npcTextTable.jobdetailsImage[1])
guiLabelSetVerticalAlign(npcTextTable.jobdetailsLabel[8], "center")
guiSetFont(npcTextTable.jobdetailsLabel[8],npcTextTable.font[2])
npcTextTable.jobdetailsLabel[9] = guiCreateLabel(0.29, 0.46, 0.67, 0.07, "ITEMSREWARD", true, npcTextTable.jobdetailsImage[1])
guiLabelSetVerticalAlign(npcTextTable.jobdetailsLabel[9], "center")
guiSetFont(npcTextTable.jobdetailsLabel[9],npcTextTable.font[2])
npcTextTable.jobdetailsLabel[10] = guiCreateLabel(0.13, 0.93, 0.28, 0.07, "Accept", true, npcTextTable.jobdetailsImage[1])
guiLabelSetHorizontalAlign(npcTextTable.jobdetailsLabel[10], "center", false)
guiSetFont(npcTextTable.jobdetailsLabel[10],npcTextTable.font[2])
npcTextTable.jobdetailsLabel[11] = guiCreateLabel(0.60, 0.93, 0.28, 0.07, "Decline", true, npcTextTable.jobdetailsImage[1])
guiLabelSetHorizontalAlign(npcTextTable.jobdetailsLabel[11], "center", false)
guiSetFont(npcTextTable.jobdetailsLabel[11],npcTextTable.font[2])

-- Start Job Code
npcTextTable.startJobLabel[1] = guiCreateLabel(0.09, 0.27, 0.82, 0.14, "JOB: ", true) -- Job Type
guiLabelSetHorizontalAlign(npcTextTable.startJobLabel[1], "center", false)
guiLabelSetVerticalAlign(npcTextTable.startJobLabel[1], "center")
guiSetFont(npcTextTable.startJobLabel[1],npcTextTable.font[3])
guiSetAlpha(npcTextTable.startJobLabel[1],0)

npcTextTable.startJobLabel[2] = guiCreateLabel(0.09, 0.42, 0.82, 0.14, "", true) -- Job
guiLabelSetHorizontalAlign(npcTextTable.startJobLabel[2], "center", false)
guiSetFont(npcTextTable.startJobLabel[2],npcTextTable.font[2])
guiSetAlpha(npcTextTable.startJobLabel[2],0)

guiSetVisible(npcTextTable.conversationImage[1],false)
guiSetVisible(npcTextTable.jobdetailsImage[1],false)
guiSetVisible(npcTextTable.startJobLabel[1],false)
guiSetVisible(npcTextTable.startJobLabel[2],false)


-- General variables
local conversationStarted = false
local playerStartedJob = false
local greetingsText = ""
local descriptionText = ""
local xpReward = 0
local spReward = 0
local itemsReward = ""
local itemsRewardNumber = ""
local jobType = ""
local jobBlip = {}

-- Extermination variables
local locationText = ""
local location = ""
local requiredKills = 0
local x,y,z = 0,0,0
local playerCompletedExterminationJob = false
local successExterminationText = ""

-- Science variables
local neededText = ""
local itemNeeded = ""
local requiredItemNumber = 0
local playerCompletedScienceJob = false
local successScienceText = ""

function startConversation()
	if conversationStarted then return end
		
	showCursor(true)
		
	if getElementModel(colshapeNPC[localPlayer]) == 24 then -- Extermination Jobs
		
		if playerStartedJob then
			local youHaveAJob = "Sorry, I can't give you a job until you've completed your current one"
			guiSetText(npcTextTable.conversationLabel[1],youHaveAJob..", "..getPlayerName(localPlayer)..".")
			guiSetText(npcTextTable.conversationLabel[3],"Cancel Job")
			guiSetVisible(npcTextTable.conversationLabel[3],true)
			guiSetVisible(npcTextTable.conversationImage[1],true)
			return
		end
		
		if playerCompletedExterminationJob then
			local randomText = math.random(1,#npcExterminationSuccessModules)
			for i, textData in ipairs(npcExterminationSuccessModules) do
				if i == randomText then
					successExterminationText = textData[1]
				end
			end
			guiSetText(npcTextTable.conversationLabel[1],successExterminationText)
			guiSetText(npcTextTable.conversationLabel[3],"")
			guiSetVisible(npcTextTable.conversationLabel[3],false)
			guiSetVisible(npcTextTable.conversationImage[1],true)
			triggerServerEvent("onPlayerRewardForCompletedJob",localPlayer,xpReward,spReward,itemsReward,itemsRewardNumber)
			destroyElement(jobBlip[jobType])
			playerCompletedExterminationJob = false
			playerStartedJob = false
			return
		end
		
		local randomText = math.random(1,#npcExterminationTextModules)
		for i, textData in ipairs(npcExterminationTextModules) do
			if i == randomText then -- Select a random text module
				if textData[1] ~= "GreetingsText" then
					greetingsText = textData[1]
				end
				if textData[2] ~= "DescriptionText" then
					descriptionText = textData[2]
				end
				if textData[3] ~= "LocationText" then
					locationText = textData[3]
				end
			end
			local randomJob = math.random(1,#npcExterminationJobData)
			for i, jobData in ipairs(npcExterminationJobData) do
				if i == randomJob then
					if jobData[1] ~= "Location" then
						location = jobData[1]
					end
					if tonumber(jobData[2]) then
						requiredKills = jobData[2]
					end
					if tonumber(jobData[3]) and tonumber(jobData[4]) and tonumber(jobData[5]) then
						x,y,z = jobData[3],jobData[4],jobData[5]
					end
					if tonumber(jobData[6]) then
						xpReward = jobData[6]
					end
					if tonumber(jobData[7]) then
						spReward = jobData[7] 
					end
					if jobData[8] ~= "itemsReward" then
						itemsReward = jobData[8]
					end
					if tonumber(jobData[9]) and jobData[9] > 0 then
						itemsRewardNumber = jobData[9]
					end	
				end
			end
		end
		guiSetText(npcTextTable.conversationLabel[1],greetingsText.." "..getPlayerName(localPlayer)..". "..descriptionText.." "..locationText.." "..location..".")
		guiSetText(npcTextTable.conversationLabel[3],"Next")
		guiSetVisible(npcTextTable.conversationLabel[3],true)
		guiSetVisible(npcTextTable.conversationImage[1],true)
		conversationStarted = true
		jobType = "Extermination"
		
	elseif getElementModel(colshapeNPC[localPlayer]) == 70 then -- Science Jobs
		
		if playerStartedJob then
			local youHaveAJob = "Sorry, I can't give you a job until you've completed your current one"
			guiSetText(npcTextTable.conversationLabel[1],youHaveAJob..", "..getPlayerName(localPlayer)..".")
			guiSetText(npcTextTable.conversationLabel[3],"Cancel Job")
			guiSetVisible(npcTextTable.conversationLabel[3],true)
			guiSetVisible(npcTextTable.conversationImage[1],true)
			return
		end
		
		if playerCompletedScienceJob then
			local randomText = math.random(1,#npcScienceSuccessModules)
			for i, textData in ipairs(npcScienceSuccessModules) do
				if i == randomText then
					successScienceText = textData[1]
				end
			end
			guiSetText(npcTextTable.conversationLabel[1],successScienceText)
			guiSetText(npcTextTable.conversationLabel[3],"")
			guiSetVisible(npcTextTable.conversationLabel[3],false)
			guiSetVisible(npcTextTable.conversationImage[1],true)
			triggerServerEvent("onPlayerRewardForCompletedJob",localPlayer,xpReward,spReward,itemsReward,itemsRewardNumber)
			triggerServerEvent("onJobTakeRequiredItem",localPlayer,itemNeeded,requiredItemNumber)
			
			playerCompletedScienceJob = false
			playerStartedJob = false
			return
		end
		
		local randomText = math.random(1,#npcScienceTextModules)
		for i, textData in ipairs(npcScienceTextModules) do
			if i == randomText then -- Select a random text module
				if textData[1] ~= "GreetingsText" then
					greetingsText = textData[1]
				end
				if textData[2] ~= "DescriptionText" then
					descriptionText = textData[2]
				end
				if textData[3] ~= "NeededText" then
					neededText = textData[3]
				end
			end
			local randomJob = math.random(1,#npcScienceJobData)
			for i, jobData in ipairs(npcScienceJobData) do
				if i == randomJob then
					if jobData[1] ~= "ItemNeeded" then
						itemNeeded = jobData[1]
					end
					if tonumber(jobData[2]) then
						requiredItemNumber = jobData[2]
					end
					if tonumber(jobData[3]) then
						xpReward = jobData[3]
					end
					if tonumber(jobData[4]) then
						spReward = jobData[4] 
					end
					if jobData[5] ~= "itemsReward" then
						itemsReward = jobData[5]
					end
					if tonumber(jobData[6]) and jobData[6] > 0 then
						itemsRewardNumber = jobData[6]
					end	
				end
			end
		end
		guiSetText(npcTextTable.conversationLabel[1],greetingsText.." "..getPlayerName(localPlayer)..". "..descriptionText.." "..neededText.." "..itemNeeded..".")
		guiSetText(npcTextTable.conversationLabel[3],"Next")
		guiSetVisible(npcTextTable.conversationLabel[3],true)
		guiSetVisible(npcTextTable.conversationImage[1],true)
		conversationStarted = true
		jobType = "Science"
	end
end
addCommandHandler("Start Conversation",startConversation)

function displayJobDetails()
	if playerStartedJob then -- Cancel Job
		triggerServerEvent("onPlayerRewardForCompletedJob",localPlayer,0,0,"",0) -- Player gets nothing for cancelling job
		guiSetVisible(npcTextTable.conversationImage[1],false)
		showCursor(false)
		playerStartedJob = false
		conversationStarted = false
		playerInJobDetails = false
		if jobBlip[jobType] then
			destroyElement(jobBlip[jobType])
		end
		return
	end
	if jobType == "Extermination" then
		guiSetText(npcTextTable.jobdetailsLabel[2],"Location: ")
		guiSetText(npcTextTable.jobdetailsLabel[5],location)
		guiSetText(npcTextTable.jobdetailsLabel[6],jobType)
		guiSetText(npcTextTable.jobdetailsLabel[7],"XP: "..xpReward)
		guiSetText(npcTextTable.jobdetailsLabel[8],"SP: "..spReward)
		if itemsReward ~= "" then
			guiSetText(npcTextTable.jobdetailsLabel[9],"Items: "..itemsReward.." x"..itemsRewardNumber)
		else
			guiSetText(npcTextTable.jobdetailsLabel[9],"Items: None")
		end
	elseif jobType == "Science" then
		guiSetText(npcTextTable.jobdetailsLabel[2],"Item: ")
		guiSetText(npcTextTable.jobdetailsLabel[5],itemNeeded.." x"..requiredItemNumber)
		guiSetText(npcTextTable.jobdetailsLabel[6],jobType)
		guiSetText(npcTextTable.jobdetailsLabel[7],"XP: "..xpReward)
		guiSetText(npcTextTable.jobdetailsLabel[8],"SP: "..spReward)
		if itemsReward ~= "" or itemsReward ~= "itemsReward" then
			guiSetText(npcTextTable.jobdetailsLabel[9],"Items: "..itemsReward.." x"..itemsRewardNumber)
		else
			guiSetText(npcTextTable.jobdetailsLabel[9],"Items: None")
		end
	end
	guiSetVisible(npcTextTable.jobdetailsImage[1],true)
	guiSetVisible(npcTextTable.jobdetailsLabel[10],true)
	guiSetVisible(npcTextTable.jobdetailsLabel[11],true)
	playerInJobDetails = true
end
addEventHandler("onClientGUIClick",npcTextTable.conversationLabel[3],displayJobDetails,false)

local toggleAcceptedJobState = false
function toggleAcceptedJobDetails()
	if playerStartedJob then
		toggleAcceptedJobState = not toggleAcceptedJobState
		guiSetVisible(npcTextTable.jobdetailsImage[1],toggleAcceptedJobState)
		guiSetVisible(npcTextTable.jobdetailsLabel[10],false)
		guiSetVisible(npcTextTable.jobdetailsLabel[11],false)
	end
end
addCommandHandler("togglejob",toggleAcceptedJobDetails)
bindKey("B","down","togglejob")

function endConversation()
	guiSetVisible(npcTextTable.conversationImage[1],false)
	guiSetVisible(npcTextTable.jobdetailsImage[1],false)
	showCursor(false)
	conversationStarted = false
	playerInJobDetails = false
end
addEventHandler("onClientGUIClick",npcTextTable.conversationLabel[4],endConversation,false)

function acceptJob()
	local job = ""
	if jobType == "Extermination" then
		job = "Kill "..requiredKills.." zombies in "..location.."!\n<Check the map for the exact location>"
		jobBlip[jobType] = createBlip(x,y,z,19,1)
		setAllJobDetails()
		triggerServerEvent("onJobSetExterminationToPlayer",localPlayer,jobType,location,x,y,z,requiredKills,xpReward,spReward,itemsReward,itemsRewardNumber)
	elseif jobType == "Science" then
		job = "Find "..requiredItemNumber.."x "..itemNeeded.."!\n<Press B for job details>"
		setAllJobDetails()
		triggerServerEvent("onJobSetScienceToPlayer",localPlayer,jobType,itemNeeded,requiredItemNumber,xpReward,spReward,itemsReward,itemsRewardNumber)
	end
	guiSetVisible(npcTextTable.conversationImage[1],false)
	guiSetVisible(npcTextTable.jobdetailsImage[1],false)
	guiSetVisible(npcTextTable.startJobLabel[1],true)
	guiSetVisible(npcTextTable.startJobLabel[2],true)
	guiBringToFront(npcTextTable.startJobLabel[1])
	guiBringToFront(npcTextTable.startJobLabel[2])
	guiSetText(npcTextTable.startJobLabel[1],"Job: "..jobType)
	guiSetText(npcTextTable.startJobLabel[2],job)
	addEventHandler("onClientRender",root,fadeStartJobIn)
	showCursor(false)
	conversationStarted = false
	playerStartedJob = true
	playerInJobDetails = false
end
addEventHandler("onClientGUIClick",npcTextTable.jobdetailsLabel[10],acceptJob,false)

function declineJob()
	guiSetVisible(npcTextTable.conversationImage[1],false)
	guiSetVisible(npcTextTable.jobdetailsImage[1],false)
	showCursor(false)
	conversationStarted = false
	playerStartedJob = false
	playerInJobDetails = false
end
addEventHandler("onClientGUIClick",npcTextTable.jobdetailsLabel[11],declineJob,false)


function setAllJobDetails()
	playerJobTable[localPlayer] = {}
	if jobType == "Extermination" then
		playerJobTable[localPlayer]["jobType"] = jobType
		playerJobTable[localPlayer]["location"] = location
		playerJobTable[localPlayer]["x"],playerJobTable[localPlayer]["y"],playerJobTable[localPlayer]["z"] = x,y,z
		playerJobTable[localPlayer]["killsRequired"] = killsRequired
		playerJobTable[localPlayer]["xpReward"] = xpReward
		playerJobTable[localPlayer]["spReward"] = spReward
		playerJobTable[localPlayer]["itemsReward"] = itemsReward
		playerJobTable[localPlayer]["itemsRewardNumber"] = itemsRewardNumber
	elseif jobType == "Science" then
		playerJobTable[localPlayer]["jobType"] = jobType
		playerJobTable[localPlayer]["itemNeeded"] = itemNeeded
		playerJobTable[localPlayer]["requiredItemNumber"] = requiredItemNumber
		playerJobTable[localPlayer]["xpReward"] = xpReward
		playerJobTable[localPlayer]["spReward"] = spReward
		playerJobTable[localPlayer]["itemsReward"] = itemsReward
		playerJobTable[localPlayer]["itemsRewardNumber"] = itemsRewardNumber
	end
end

local jobStartAlpha = 0
local isFadingIn = false
local isFadingOut = false
local fadingStarted = false
function fadeStartJobIn()
	if not isFadingIn then
		jobStartAlpha = math.min(jobStartAlpha+0.005,1)
		guiSetAlpha(npcTextTable.startJobLabel[1],jobStartAlpha)
		guiSetAlpha(npcTextTable.startJobLabel[2],jobStartAlpha)
		if jobStartAlpha >= 1 then
			addEventHandler("onClientRender",root,fadeStartJobOut)
			removeEventHandler("onClientRender",root,fadeStartJobIn)
			isFadingIn = true
			isFadingOut = false
		end
	end
end

function fadeStartJobOut()
	if not isFadingOut then
		jobStartAlpha = jobStartAlpha-0.005
		guiSetAlpha(npcTextTable.startJobLabel[1],jobStartAlpha)
		guiSetAlpha(npcTextTable.startJobLabel[2],jobStartAlpha)
		if jobStartAlpha <= 0 then
			removeEventHandler("onClientRender",root,fadeStartJobOut)
			isFadingOut = true
			isFadingIn = false
			fadingStarted = false
			jobStartAlpha = 0
			guiSetVisible(npcTextTable.startJobLabel[1],false)
			guiSetVisible(npcTextTable.startJobLabel[2],false)
		end
	end
end

function setTextColorOnMouseOver()
	if source == npcTextTable.conversationLabel[3] or source == npcTextTable.conversationLabel[4] or source == npcTextTable.jobdetailsLabel[10] or source == npcTextTable.jobdetailsLabel[11] then
		if source == npcTextTable.conversationLabel[3] or source == npcTextTable.conversationLabel[4] then
			if playerInJobDetails then return end
		end
		guiLabelSetColor(source,255,0,0)
		playSoundFrontEnd(38)
	end
end
addEventHandler("onClientMouseEnter",resourceRoot,setTextColorOnMouseOver)

function setTextColorOnMouseLeave()
	if source == npcTextTable.conversationLabel[3] or source == npcTextTable.conversationLabel[4] or source == npcTextTable.jobdetailsLabel[10] or source == npcTextTable.jobdetailsLabel[11] then
		guiLabelSetColor(source,255,255,255)
	end
end
addEventHandler("onClientMouseLeave",resourceRoot,setTextColorOnMouseLeave)

function onClientJobCompletedByPlayer(job)
	if job == "Extermination" then
		playerCompletedExterminationJob = true
		playerStartedJob = false
		guiSetText(npcTextTable.startJobLabel[1],"Job: "..jobType)
		guiSetText(npcTextTable.startJobLabel[2],"You exterminated all zombies!")
		guiSetVisible(npcTextTable.startJobLabel[1],true)
		guiSetVisible(npcTextTable.startJobLabel[2],true)
		if not fadingStarted then
			addEventHandler("onClientRender",root,fadeStartJobIn)
			fadingStarted = true
		end
	elseif job == "Science" then
		playerCompletedScienceJob = true
		playerStartedJob = false
	end
end
addEvent("onClientJobCompletedByPlayer",true)
addEventHandler("onClientJobCompletedByPlayer",root,onClientJobCompletedByPlayer)

function onClientJobNotCompletedByPlayer()
	playerCompletedExterminationJob = false
	playerCompletedScienceJob = false
	playerStartedJob = true
end
addEvent("onClientJobNotCompletedByPlayer",true)
addEventHandler("onClientJobNotCompletedByPlayer",root,onClientJobNotCompletedByPlayer)

function onClientJobCheckIfItemInInventory()
	if not playerStartedJob then return end
	if playerJobTable[localPlayer] then
		if playerJobTable[localPlayer]["jobType"] == "Science" then
			if getElementData(localPlayer, playerJobTable[localPlayer]["itemNeeded"]) >= playerJobTable[localPlayer]["requiredItemNumber"] then
				onClientJobCompletedByPlayer(playerJobTable[localPlayer]["jobType"])
			else
				onClientJobNotCompletedByPlayer()
			end
		end
	end
end

function onClientJobLoad(jobTable)
	if jobTable then
		playerJobTable = {}
		playerJobTable[localPlayer] = {}
		for i, job in pairs(jobTable) do
			playerJobTable[localPlayer][i] = job
		end
		jobType = playerJobTable[localPlayer]["jobType"]
		if jobType == "Extermination" then
			location = playerJobTable[localPlayer]["location"]
			x,y,z = playerJobTable[localPlayer]["x"],playerJobTable[localPlayer]["y"],playerJobTable[localPlayer]["z"]
			killsRequired = playerJobTable[localPlayer]["killsRequired"]
			xpReward = playerJobTable[localPlayer]["xpReward"]
			spReward = playerJobTable[localPlayer]["spReward"]
			itemsReward = playerJobTable[localPlayer]["itemsReward"]
			itemsRewardNumber = playerJobTable[localPlayer]["itemsRewardNumber"]
			jobBlip[jobType] = createBlip(x,y,z,19,1)
			if killsRequired <= 0 then
				onClientJobCompletedByPlayer(jobType)
			end
			playerStartedJob = true
		elseif jobType == "Science" then
			itemNeeded = playerJobTable[localPlayer]["itemNeeded"]
			requiredItemNumber = playerJobTable[localPlayer]["requiredItemNumber"]
			xpReward = playerJobTable[localPlayer]["xpReward"]
			spReward = playerJobTable[localPlayer]["spReward"]
			itemsReward = playerJobTable[localPlayer]["itemsReward"]
			itemsRewardNumber = playerJobTable[localPlayer]["itemsRewardNumber"]
			playerStartedJob = true
		end
	end
end
addEvent("onClientJobLoad",true)
addEventHandler("onClientJobLoad",root,onClientJobLoad)

isPlayerInsideSafeZone = false
function toggleWeaponsInSafeZone(state)
	toggleControl("fire",state)
	toggleControl("aim_weapon",state)
	toggleControl("vehicle_fire",state)
	toggleControl("vehicle_secondary_fire",state)
	isPlayerInsideSafeZone = not state
end
addEvent("onPlayerToggleWeaponsInSafeZone",true)
addEventHandler("onPlayerToggleWeaponsInSafeZone",root,toggleWeaponsInSafeZone)


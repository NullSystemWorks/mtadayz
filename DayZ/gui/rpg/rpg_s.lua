--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: rpg_s.lua								*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]

function onPlayerConvertXPToSP()
	if client then
		local player = client
		local message = ""
		if playerSkillsTable[player]["XP"] > 0 then
			if playerSkillsTable[player]["XP"] > playerSkillsTable[player]["conversionXP"] then
				playerSkillsTable[player]["SP"] = playerSkillsTable[player]["SP"]+1
				playerSkillsTable[player]["XP"] = playerSkillsTable[player]["XP"]-playerSkillsTable[player]["conversionXP"]
				calculateConversionRate(player) -- Calculates both conversion rate + XP needed for next SP conversion
				calculateSkillsPointDistribution(player)
				triggerClientEvent(player,"onPlayerGUIUpdateXP",player,playerSkillsTable[player]["XP"],playerSkillsTable[player]["SP"],playerSkillsTable[player]["conversionXP"])
			else
				message = "Can't do that, I need more XP"
				triggerClientEvent(player,"onPlayerGUISkillError",player,message)
				return
			end
		else
			message = "Can't do that, I don't have enough XP"
			triggerClientEvent(player,"onPlayerGUISkillError",player,message)
			return
		end
	end
end
addEvent("onPlayerConvertXPToSP",true)
addEventHandler("onPlayerConvertXPToSP",root,onPlayerConvertXPToSP)

function calculateConversionRate(thePlayer)
	if thePlayer then
		playerSkillsTable[thePlayer]["conversionRate"] = playerSkillsTable[thePlayer]["conversionRate"]+0.1
		playerSkillsTable[thePlayer]["conversionXP"] = math.ceil(playerSkillsTable[thePlayer]["conversionXP"]*playerSkillsTable[thePlayer]["conversionRate"])
	end
end

function calculateSkillsPointDistribution(thePlayer)
	-- Soldier
	if playerSkillsTable[thePlayer]["SoldierActive"] then
		playerSkillsTable[thePlayer]["SoldierDodgeChance"] = 2.5*playerSkillsTable[thePlayer]["SoldierDodge"]
		playerSkillsTable[thePlayer]["SoldierToughChance"] = 5*playerSkillsTable[thePlayer]["SoldierTough"]
		playerSkillsTable[thePlayer]["SoldierCritChance"] = 3*playerSkillsTable[thePlayer]["SoldierCrit"]
	end
	-- Medic
	if playerSkillsTable[thePlayer]["MedicActive"] then
		playerSkillsTable[thePlayer]["MedicChanceChance"] = 1*playerSkillsTable[thePlayer]["MedicChance"]
		playerSkillsTable[thePlayer]["MedicProfChance"] = 10*playerSkillsTable[thePlayer]["MedicProf"]
		playerSkillsTable[thePlayer]["MedicBordersChance"] = 20*playerSkillsTable[thePlayer]["MedicBorders"]
	end
	-- Scavenger
	if playerSkillsTable[thePlayer]["ScavengerActive"] then
		playerSkillsTable[thePlayer]["ScavengerGoodChance"] = 2*playerSkillsTable[thePlayer]["ScavengerGood"]
		playerSkillsTable[thePlayer]["ScavengerCamouflageChance"] = 7.5*playerSkillsTable[thePlayer]["ScavengerCamouflage"]
			playerSkillsTable[thePlayer]["ScavengerShadowChance"] = 6*playerSkillsTable[thePlayer]["ScavengerShadow"]
	end
	-- Engineer
	if playerSkillsTable[thePlayer]["EngineerActive"] then
		playerSkillsTable[thePlayer]["EngineerAmmoChance"] = 0.1*playerSkillsTable[thePlayer]["EngineerAmmo"]
		playerSkillsTable[thePlayer]["EngineerDuctChance"] = 10*playerSkillsTable[thePlayer]["EngineerDuct"]
		playerSkillsTable[thePlayer]["EngineerAnalysisChance"] = 10*playerSkillsTable[thePlayer]["EngineerAnalysis"]
	end
end

function activateSkill(skill)
	if client then
		if skill then
			if playerSkillsTable[client]["usedSP"] < 31 then -- Max SP possible
				if playerSkillsTable[client]["SP"] > 0 then
					-- Soldier
					if skill == 2 then -- Activate path
						if playerSkillsTable[client]["SoldierActive"] then return end
						playerSkillsTable[client]["SoldierActive"] = true
						playerSkillsTable[client]["SP"] = playerSkillsTable[client]["SP"]-1
						playerSkillsTable[client]["usedSP"] = playerSkillsTable[client]["usedSP"]+1
						calculateSkillsPointDistribution(client)
						triggerClientEvent(client,"onPlayerGUIUpdateXP",client,playerSkillsTable[client]["XP"],playerSkillsTable[client]["SP"],playerSkillsTable[client]["conversionXP"])
						triggerClientEvent(client,"onPlayerGUIUpdateSkillLevel",client,"SoldierActive",playerSkillsTable[client]["SoldierActive"],skill,false,false)
						outputDebugString("Used SP for Soldier!")
					elseif skill == 3 then -- SoldierDodge
						if not playerSkillsTable[client]["SoldierActive"] then
							message = "I have to activate the Path of the Soldier first!"
							triggerClientEvent(client,"onPlayerGUISkillError",client,message)
							return
						else
							if playerSkillsTable[client]["SoldierDodge"] < 10 then -- Max Skill Level
								playerSkillsTable[client]["SoldierDodge"] = playerSkillsTable[client]["SoldierDodge"]+1
								playerSkillsTable[client]["SP"] = playerSkillsTable[client]["SP"]-1
								playerSkillsTable[client]["usedSP"] = playerSkillsTable[client]["usedSP"]+1
								calculateSkillsPointDistribution(client)
								triggerClientEvent(client,"onPlayerGUIUpdateXP",client,playerSkillsTable[client]["XP"],playerSkillsTable[client]["SP"],playerSkillsTable[client]["conversionXP"])
								triggerClientEvent(client,"onPlayerGUIUpdateSkillLevel",client,"SoldierDodge",playerSkillsTable[client]["SoldierDodge"],skill,"SoldierDodgeChance",playerSkillsTable[client]["SoldierDodgeChance"])
							else
								message = "There is not anything left to learn here."
							triggerClientEvent(client,"onPlayerGUISkillError",client,message)
								return
							end
						end
					elseif skill == 4 then -- SoldierTough
						if not playerSkillsTable[client]["SoldierActive"] then
							message = "I have to activate the Path of the Soldier first!"
							triggerClientEvent(client,"onPlayerGUISkillError",client,message)
							return
						else
							if playerSkillsTable[client]["SoldierTough"] < 10 then -- Max Skill Level
								playerSkillsTable[client]["SoldierTough"] = playerSkillsTable[client]["SoldierTough"]+1
								playerSkillsTable[client]["SP"] = playerSkillsTable[client]["SP"]-1
								playerSkillsTable[client]["usedSP"] = playerSkillsTable[client]["usedSP"]+1
								calculateSkillsPointDistribution(client)
								triggerClientEvent(client,"onPlayerGUIUpdateXP",client,playerSkillsTable[client]["XP"],playerSkillsTable[client]["SP"],playerSkillsTable[client]["conversionXP"])
								triggerClientEvent(client,"onPlayerGUIUpdateSkillLevel",client,"SoldierTough",playerSkillsTable[client]["SoldierTough"],skill,"SoldierToughChance",playerSkillsTable[client]["SoldierToughChance"])
							else
								message = "There is not anything left to learn here."
								triggerClientEvent(client,"onPlayerGUISkillError",client,message)
								return
							end
						end
					elseif skill == 5 then -- SoldierCrit
						if not playerSkillsTable[client]["SoldierActive"] then
							message = "I have to activate the Path of the Soldier first!"
							triggerClientEvent(client,"onPlayerGUISkillError",client,message)
							return
						else
							if playerSkillsTable[client]["SoldierCrit"] < 10 then -- Max Skill Level
								playerSkillsTable[client]["SoldierCrit"] = playerSkillsTable[client]["SoldierCrit"]+1
								playerSkillsTable[client]["SP"] = playerSkillsTable[client]["SP"]-1
								playerSkillsTable[client]["usedSP"] = playerSkillsTable[client]["usedSP"]+1
								calculateSkillsPointDistribution(client)
								triggerClientEvent(client,"onPlayerGUIUpdateXP",client,playerSkillsTable[client]["XP"],playerSkillsTable[client]["SP"],playerSkillsTable[client]["conversionXP"])
								triggerClientEvent(client,"onPlayerGUIUpdateSkillLevel",client,"SoldierCrit",playerSkillsTable[client]["SoldierCrit"],skill,"SoldierCritChance",playerSkillsTable[client]["SoldierCritChance"])
							else
								message = "There is not anything left to learn here."
								triggerClientEvent(client,"onPlayerGUISkillError",client,message)
								return
							end
						end
					-- Medic
					elseif skill == 6 then -- Medic Path
						if playerSkillsTable[client]["MedicActive"] then return end
						playerSkillsTable[client]["MedicActive"] = true
						playerSkillsTable[client]["SP"] = playerSkillsTable[client]["SP"]-1
						playerSkillsTable[client]["usedSP"] = playerSkillsTable[client]["usedSP"]+1
						calculateSkillsPointDistribution(client)
						triggerClientEvent(client,"onPlayerGUIUpdateXP",client,playerSkillsTable[client]["XP"],playerSkillsTable[client]["SP"],playerSkillsTable[client]["conversionXP"])
						triggerClientEvent(client,"onPlayerGUIUpdateSkillLevel",client,"MedicActive",playerSkillsTable[client]["MedicActive"],skill,false,false)
						outputDebugString("Used SP for Medic!")
					elseif skill == 7 then -- MedicChance
						if not playerSkillsTable[client]["MedicActive"] then
							message = "I have to activate the Path of the Medic first!"
							triggerClientEvent(client,"onPlayerGUISkillError",client,message)
							return
						else
							if playerSkillsTable[client]["MedicChance"] < 10 then -- Max Skill Level
								playerSkillsTable[client]["MedicChance"] = playerSkillsTable[client]["MedicChance"]+1
								playerSkillsTable[client]["SP"] = playerSkillsTable[client]["SP"]-1
								playerSkillsTable[client]["usedSP"] = playerSkillsTable[client]["usedSP"]+1
								calculateSkillsPointDistribution(client)
								triggerClientEvent(client,"onPlayerGUIUpdateXP",client,playerSkillsTable[client]["XP"],playerSkillsTable[client]["SP"],playerSkillsTable[client]["conversionXP"])
								triggerClientEvent(client,"onPlayerGUIUpdateSkillLevel",client,"MedicChance",playerSkillsTable[client]["MedicChance"],skill,"MedicChanceChance",playerSkillsTable[client]["MedicChanceChance"])
							else
								message = "There is not anything left to learn here."
								triggerClientEvent(client,"onPlayerGUISkillError",client,message)
								return
							end
						end
					elseif skill == 8 then -- MedicProf
						if not playerSkillsTable[client]["MedicActive"] then
							message = "I have to activate the Path of the Medic first!"
							triggerClientEvent(client,"onPlayerGUISkillError",client,message)
							return
						else
							if playerSkillsTable[client]["MedicProf"] < 10 then -- Max Skill Level
								playerSkillsTable[client]["MedicProf"] = playerSkillsTable[client]["MedicProf"]+1
								playerSkillsTable[client]["SP"] = playerSkillsTable[client]["SP"]-1
								playerSkillsTable[client]["usedSP"] = playerSkillsTable[client]["usedSP"]+1
								calculateSkillsPointDistribution(client)
								triggerClientEvent(client,"onPlayerGUIUpdateXP",client,playerSkillsTable[client]["XP"],playerSkillsTable[client]["SP"],playerSkillsTable[client]["conversionXP"])
								triggerClientEvent(client,"onPlayerGUIUpdateSkillLevel",client,"MedicProf",playerSkillsTable[client]["MedicProf"],skill,"MedicProfChance",playerSkillsTable[client]["MedicProfChance"])
							else
								message = "There is not anything left to learn here."
								triggerClientEvent(client,"onPlayerGUISkillError",client,message)
								return
							end
						end
					elseif skill == 9 then -- MedicBorders
						if not playerSkillsTable[client]["MedicActive"] then
							message = "I have to activate the Path of the Medic first!"
							triggerClientEvent(client,"onPlayerGUISkillError",client,message)
							return
						else
							if playerSkillsTable[client]["MedicBorders"] < 10 then -- Max Skill Level
								playerSkillsTable[client]["MedicBorders"] = playerSkillsTable[client]["MedicBorders"]+1
								playerSkillsTable[client]["SP"] = playerSkillsTable[client]["SP"]-1
								playerSkillsTable[client]["usedSP"] = playerSkillsTable[client]["usedSP"]+1
								calculateSkillsPointDistribution(client)
								triggerClientEvent(client,"onPlayerGUIUpdateXP",client,playerSkillsTable[client]["XP"],playerSkillsTable[client]["SP"],playerSkillsTable[client]["conversionXP"])
								triggerClientEvent(client,"onPlayerGUIUpdateSkillLevel",client,"MedicBorders",playerSkillsTable[client]["MedicBorders"],skill,"MedicBordersChance",playerSkillsTable[client]["MedicBordersChance"])
							else
								message = "There is not anything left to learn here."
								triggerClientEvent(client,"onPlayerGUISkillError",client,message)
								return
							end
						end
					-- Scavenger
					elseif skill == 10 then -- Scavenger Path
						if playerSkillsTable[client]["ScavengerActive"] then return end
						playerSkillsTable[client]["ScavengerActive"] = true
						playerSkillsTable[client]["SP"] = playerSkillsTable[client]["SP"]-1
						playerSkillsTable[client]["usedSP"] = playerSkillsTable[client]["usedSP"]+1
						calculateSkillsPointDistribution(client)
						triggerClientEvent(client,"onPlayerGUIUpdateXP",client,playerSkillsTable[client]["XP"],playerSkillsTable[client]["SP"],playerSkillsTable[client]["conversionXP"])
						triggerClientEvent(client,"onPlayerGUIUpdateSkillLevel",client,"ScavengerActive",playerSkillsTable[client]["ScavengerActive"],skill,false,false)
						outputDebugString("Used SP for Scavenger!")
					elseif skill == 11 then -- ScavengerGood
						if not playerSkillsTable[client]["ScavengerActive"] then
							message = "I have to activate the Path of the Scavenger first!"
							triggerClientEvent(client,"onPlayerGUISkillError",client,message)
							return
						else
							if playerSkillsTable[client]["ScavengerGood"] < 10 then -- Max Skill Level
								playerSkillsTable[client]["ScavengerGood"] = playerSkillsTable[client]["ScavengerGood"]+1
								playerSkillsTable[client]["SP"] = playerSkillsTable[client]["SP"]-1
								playerSkillsTable[client]["usedSP"] = playerSkillsTable[client]["usedSP"]+1
								calculateSkillsPointDistribution(client)
								triggerClientEvent(client,"onPlayerGUIUpdateXP",client,playerSkillsTable[client]["XP"],playerSkillsTable[client]["SP"],playerSkillsTable[client]["conversionXP"])
								triggerClientEvent(client,"onPlayerGUIUpdateSkillLevel",client,"ScavengerGood",playerSkillsTable[client]["ScavengerGood"],skill,"ScavengerGoodChance",playerSkillsTable[client]["ScavengerGoodChance"])
							else
								message = "There is not anything left to learn here."
								triggerClientEvent(client,"onPlayerGUISkillError",client,message)
								return
							end
						end
					elseif skill == 12 then -- ScavengerCamouflage
						if not playerSkillsTable[client]["ScavengerActive"] then
							message = "I have to activate the Path of the Scavenger first!"
							triggerClientEvent(client,"onPlayerGUISkillError",client,message)
							return
						else
							if playerSkillsTable[client]["ScavengerCamouflage"] < 10 then -- Max Skill Level
								playerSkillsTable[client]["ScavengerCamouflage"] = playerSkillsTable[client]["ScavengerCamouflage"]+1
								playerSkillsTable[client]["SP"] = playerSkillsTable[client]["SP"]-1
								playerSkillsTable[client]["usedSP"] = playerSkillsTable[client]["usedSP"]+1
								calculateSkillsPointDistribution(client)
								triggerClientEvent(client,"onPlayerGUIUpdateXP",client,playerSkillsTable[client]["XP"],playerSkillsTable[client]["SP"],playerSkillsTable[client]["conversionXP"])
								triggerClientEvent(client,"onPlayerGUIUpdateSkillLevel",client,"ScavengerCamouflage",playerSkillsTable[client]["ScavengerCamouflage"],skill,"ScavengerCamouflageChance",playerSkillsTable[client]["ScavengerCamouflageChance"])
							else
								message = "There is not anything left to learn here."
								triggerClientEvent(client,"onPlayerGUISkillError",client,message)
								return
							end
						end
					elseif skill == 13 then -- ScavengerShadow
						if not playerSkillsTable[client]["ScavengerActive"] then
							message = "I have to activate the Path of the Scavenger first!"
							triggerClientEvent(client,"onPlayerGUISkillError",client,message)
							return
						else
							if playerSkillsTable[client]["ScavengerShadow"] < 10 then -- Max Skill Level
								playerSkillsTable[client]["ScavengerShadow"] = playerSkillsTable[client]["ScavengerShadow"]+1
								playerSkillsTable[client]["SP"] = playerSkillsTable[client]["SP"]-1
								playerSkillsTable[client]["usedSP"] = playerSkillsTable[client]["usedSP"]+1
								calculateSkillsPointDistribution(client)
								triggerClientEvent(client,"onPlayerGUIUpdateXP",client,playerSkillsTable[client]["XP"],playerSkillsTable[client]["SP"],playerSkillsTable[client]["conversionXP"])
								triggerClientEvent(client,"onPlayerGUIUpdateSkillLevel",client,"ScavengerShadow",playerSkillsTable[client]["ScavengerShadow"],skill,"ScavengerShadowChance",playerSkillsTable[client]["ScavengerShadowChance"])
							else
								message = "There is not anything left to learn here."
								triggerClientEvent(client,"onPlayerGUISkillError",client,message)
								return
							end
						end
					-- Engineer
					elseif skill == 14 then -- Engineer Path
						if playerSkillsTable[client]["EngineerActive"] then return end
						playerSkillsTable[client]["EngineerActive"] = true
						playerSkillsTable[client]["SP"] = playerSkillsTable[client]["SP"]-1
						playerSkillsTable[client]["usedSP"] = playerSkillsTable[client]["usedSP"]+1
						calculateSkillsPointDistribution(client)
						triggerClientEvent(client,"onPlayerGUIUpdateXP",client,playerSkillsTable[client]["XP"],playerSkillsTable[client]["SP"],playerSkillsTable[client]["conversionXP"])
						triggerClientEvent(client,"onPlayerGUIUpdateSkillLevel",client,"EngineerActive",playerSkillsTable[client]["EngineerActive"],skill,false,false)
						outputDebugString("Used SP for Engineer!")
					elseif skill == 15 then -- EngineerAmmo
						if not playerSkillsTable[client]["EngineerActive"] then
							message = "I have to activate the Path of the Engineer first!"
							triggerClientEvent(client,"onPlayerGUISkillError",client,message)
							return
						else
							if playerSkillsTable[client]["EngineerAmmo"] < 10 then -- Max Skill Level
								playerSkillsTable[client]["EngineerAmmo"] = playerSkillsTable[client]["EngineerAmmo"]+1
								playerSkillsTable[client]["SP"] = playerSkillsTable[client]["SP"]-1
								playerSkillsTable[client]["usedSP"] = playerSkillsTable[client]["usedSP"]+1
								calculateSkillsPointDistribution(client)
								triggerClientEvent(client,"onPlayerGUIUpdateXP",client,playerSkillsTable[client]["XP"],playerSkillsTable[client]["SP"],playerSkillsTable[client]["conversionXP"])
								triggerClientEvent(client,"onPlayerGUIUpdateSkillLevel",client,"EngineerAmmo",playerSkillsTable[client]["EngineerAmmo"],skill,"EngineerAmmoChance",playerSkillsTable[client]["EngineerAmmoChance"])
							else
								message = "There is not anything left to learn here."
								triggerClientEvent(client,"onPlayerGUISkillError",client,message)
								return
							end
						end
					elseif skill == 16 then -- EngineerDuct
						if not playerSkillsTable[client]["EngineerActive"] then
							message = "I have to activate the Path of the Engineer first!"
							triggerClientEvent(client,"onPlayerGUISkillError",client,message)
							return
						else
							if playerSkillsTable[client]["EngineerDuct"] < 10 then -- Max Skill Level
								playerSkillsTable[client]["EngineerDuct"] = playerSkillsTable[client]["EngineerDuct"]+1
								playerSkillsTable[client]["SP"] = playerSkillsTable[client]["SP"]-1
								playerSkillsTable[client]["usedSP"] = playerSkillsTable[client]["usedSP"]+1
								calculateSkillsPointDistribution(client)
								triggerClientEvent(client,"onPlayerGUIUpdateXP",client,playerSkillsTable[client]["XP"],playerSkillsTable[client]["SP"],playerSkillsTable[client]["conversionXP"])
								triggerClientEvent(client,"onPlayerGUIUpdateSkillLevel",client,"EngineerDuct",playerSkillsTable[client]["EngineerDuct"],skill,"EngineerDuctChance",playerSkillsTable[client]["EngineerDuctChance"])
							else
								message = "There is not anything left to learn here."
								triggerClientEvent(client,"onPlayerGUISkillError",client,message)
								return
							end
						end
					elseif skill == 17 then -- EngineerAnalysis
						if not playerSkillsTable[client]["EngineerActive"] then
							message = "I have to activate the Path of the Engineer first!"
							triggerClientEvent(client,"onPlayerGUISkillError",client,message)
							return
						else
							if playerSkillsTable[client]["EngineerAnalysis"] < 10 then -- Max Skill Level
								playerSkillsTable[client]["EngineerAnalysis"] = playerSkillsTable[client]["EngineerAnalysis"]+1
								playerSkillsTable[client]["SP"] = playerSkillsTable[client]["SP"]-1
								playerSkillsTable[client]["usedSP"] = playerSkillsTable[client]["usedSP"]+1
								calculateSkillsPointDistribution(client)
								triggerClientEvent(client,"onPlayerGUIUpdateXP",client,playerSkillsTable[client]["XP"],playerSkillsTable[client]["SP"],playerSkillsTable[client]["conversionXP"])
								triggerClientEvent(client,"onPlayerGUIUpdateSkillLevel",client,"EngineerAnalysis",playerSkillsTable[client]["EngineerAnalysis"],skill,"EngineerAnalysisChance",playerSkillsTable[client]["EngineerAnalysisChance"])
							else
								message = "There is not anything left to learn here."
								triggerClientEvent(client,"onPlayerGUISkillError",client,message)
								return
							end
						end
						
					end
				else
					message = "I don't have enough SP!"
					triggerClientEvent(client,"onPlayerGUISkillError",client,message)
					return
				end
			else
				message = "There is nothing left to learn."
				triggerClientEvent(client,"onPlayerGUISkillError",client,message)
				return
			end
		end
	end
end
addEvent("onPlayerActivateSkill",true)
addEventHandler("onPlayerActivateSkill",root,activateSkill)

function medicWithoutBorders()

end

function scavengerCamouflage()
	for i, players in ipairs(getElementsByType("player")) do
		if getElementData(players,"logedin") then
			if playerSkillsTable[players] then
				if playerSkillsTable[players]["ScavengerCamouflageChance"] > 0 then
					if isPedDucked(players) then
						local alpha = 255*(playerSkillsTable[players]["ScavengerCamouflageChance"]/100)
						setElementAlpha(players,255-alpha)
						if elementBackpack[players] then
							setElementAlpha(elementBackpack[players],255-alpha)
						end
						if elementWeaponBack[players] then
							setElementAlpha(elementWeaponBack[players],255-alpha)
						end
					else
						setElementAlpha(players,255)
						if elementBackpack[players] then
							setElementAlpha(elementBackpack[players],255)
						end
						if elementWeaponBack[players] then
							setElementAlpha(elementWeaponBack[players],255)
						end
					end
				end
			end
		end
	end
end
setTimer(scavengerCamouflage,1000,0)

function onPlayerOpenJournalGetSkills()
	triggerClientEvent(client,"onPlayerUpdateSkillsToJournal",client,playerSkillsTable[client])
end
addEvent("onPlayerOpenJournalGetSkills",true)
addEventHandler("onPlayerOpenJournalGetSkills",root,onPlayerOpenJournalGetSkills)

-- NPC & Settlement Code

-- Soldiers/Police/Militia Coordinates
-- IDS: 281, 282, 285, 284, 312, 191, 157, 31
local soldierSpawnPosTable = {
-- {PositionX,PositionY,PositionZ,RotationX,RotationY,RotationZ},
-- Skins are randomized
{-1960.1374511719, -2544.2236328125, 54.528125762939, 0, 0, 244.63558959961},
{-1960.5028076172, -2543.115234375, 46.128196716309, 0, 0, 341.73059082031},
{-1978.6135253906, -2552.2248535156, 45.328197479248, 0, 0, 70.013763427734},
{-1977.0773925781, -2554.4399414063, 53.728126525879, 0, 0, 203.9494934082},
{-2257.8032226563, -2578.9780273438, 48.628128051758, 0, 0, 158.24830627441},
{-2254.9040527344, -2582.7707519531, 44.784378051758, 0, 0, 213.9593963623},
{-2261.0319824219, -2579.9240722656, 40.229690551758, 0, 0, 153.13287353516},
{-2273.2668457031, -2575.4318847656, 40.6796875, 0, 0, 171.11824035645},
{-2270.4860839844, -2569.61328125, 47.578125, 0, 0, 335.90966796875},
{-2276.9904785156, -2570.2084960938, 49.078125, 0, 0, 96.544151306152}, 
{-2466.1477050781, -2310.4418945313, 23.078195571899, 0, 0, 87.586532592773},
{-2466.3933105469, -2311.1926269531, 31.47812461853, 0, 0, 177.8039855957},
{-2475.7233886719, -2284.56640625, 20.421875, 0, 0, 130.48648071289}, 
{-2474.8706054688, -2284.1518554688, 27.484375, 0, 0, 359.76257324219}, 
{-2470.8781738281, -2288.3090820313, 31.328125, 0, 0, 242.19874572754},
{-2443.236328125, -2278.4846191406, 30.778125762939, 0, 0, 36.739181518555},
{-2439.572265625, -2278.1713867188, 22.378196716309, 0, 0, 287.22024536133},
{-2420.328125, -2269.1733398438, 30.878124237061, 0, 0, 27.886533737183},
{-2416.7416992188, -2269.9404296875, 22.478197097778, 0, 0, 289.77304077148},
{-2227.2509765625, -2269.9196777344, 46.564994812012, 0, 0, 244.44107055664},
{-2229.8168945313, -2267.4489746094, 46.564994812012, 0, 0, 51.425903320313},
{-2227.7993164063, -2273.8146972656, 33.033744812012, 0, 0, 326.18270874023},
{-2217.1042480469, -2247.9282226563, 33.341011047363, 0, 0, 127.46483612061},
{-2219.4970703125, -2255.3317871094, 38.472332000732, 0, 0, 210.2248840332},
{-2215.5180664063, -2254.5603027344, 46.872261047363, 0, 0, 243.85372924805},
{-2217.1164550781, -2250.6867675781, 46.872261047363, 0, 0, 105.82112884521},
}

-- Vendors
-- IDs: 1
local vendorSpawnPosTable = {
-- {skinID,PositionX,PositionY,PositionZ,RotationX,RotationY,RotationZ},
{1,-2151.38671875, -2337.3215332031, 30.56875038147, 0, 0, 252.03715515137},
}

-- Jobs
-- IDs: 24, 70
local jobsSpawnPosTable = {
-- {"npcName",skinID,PositionX,PositionY,PositionZ,RotationX,RotationY,RotationZ},
{"Wilkins",24,-2148.896484375, -2387.0327148438, 30.668750762939, 0, 0, 297.86895751953}, -- gives Extermination Jobs
{"Dr Lovestrange",70,-2149.0549316406, -2383.8237304688, 30.668750762939, 0, 0, 294.79827880859}, -- gives Science Jobs
}

-- NPC's & Settlements Code

-- Creating a safe zone around Whetstone; no zombies, no loot, no damage (unless it's caused by the environment [fall damage, ...])
whetstone_safezone = createColPolygon(-2179.9270019531, -2380.1596679688,-2301.0578613281, -2653.3435058594,-2097.9387207031, -2662.2844238281,-1892.9733886719, -2581.0612792969,-1919.5893554688, -2369.705078125,-2050.4284667969, -2208.9035644531,-2246.7185058594, -2137.7419433594,-2496.2729492188, -2251.2111816406,-2410.8432617188, -2524.6831054688)

local npcTableSoldiers = {}
local npcTableVendors = {}
local npcTableJobs = {}
local npcColShape = {}
function spawnNPCsAtSettlement()
	-- Spawn all soldiers at their respective positions, random skins for more varied gameplay
	local soldierSkins = {281, 282, 285, 284, 312, 191, 157, 31}
	for i, soldiers in ipairs(soldierSpawnPosTable) do
		npcTableSoldiers[i] = createPed(soldierSkins[math.random(1,#soldierSkins)],soldiers[1],soldiers[2],soldiers[3],soldiers[6])
		setElementData(npcTableSoldiers[i],"isNPC",true)
	end
	-- Spawn all vendors
	for i, vendors in ipairs(vendorSpawnPosTable) do
		npcTableVendors[i] = createPed(vendors[1],vendors[2],vendors[3],vendors[4],vendors[7])
		setElementData(npcTableVendors[i],"isNPC",true)
	end
	-- Spawn all NPCs that offer jobs
	for i, jobs in ipairs(jobsSpawnPosTable) do
		npcTableJobs[i] = createPed(jobs[2],jobs[3],jobs[4],jobs[5],jobs[8])
		npcColShape[i] = createColSphere(jobs[3],jobs[4],jobs[5],2)
		attachElements(npcColShape[i],npcTableJobs[i])
		setElementData(npcColShape[i],"npcCol",npcTableJobs[i])
		setElementData(npcColShape[i],"npcName",jobs[1])
		setElementData(npcTableJobs[i],"isNPC",true)
	end
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),spawnNPCsAtSettlement)			


function prohibitWeaponsInSafeZone(hitElement)
	if getElementType(hitElement) == "player" then
		triggerClientEvent(hitElement,"onPlayerToggleWeaponsInSafeZone",hitElement,false)
	end
end
addEventHandler("onColShapeHit",whetstone_safezone,prohibitWeaponsInSafeZone)

function enableWeaponsOutsideSafeZone(leaveElement)
	if getElementType(leaveElement) == "player" then
		triggerClientEvent(leaveElement,"onPlayerToggleWeaponsInSafeZone",leaveElement,true)
	end
end
addEventHandler("onColShapeLeave",whetstone_safezone,enableWeaponsOutsideSafeZone)

function onJobRewardPlayer(xp,sp,items,itemsNumber)
	if tonumber(xp) and tonumber(sp) then
		playerSkillsTable[client]["XP"] = math.floor(playerSkillsTable[client]["XP"]+(xp+xp*(playerSkillsTable[client]["EngineerAnalysisChance"]/100)))
		playerSkillsTable[client]["SP"] = playerSkillsTable[client]["SP"]+sp
		triggerClientEvent(client,"onPlayerUpdateSkillsToJournal",client,playerSkillsTable[client])
		triggerClientEvent(client,"onPlayerGUIUpdateXP",client,playerSkillsTable[client]["XP"],playerSkillsTable[client]["SP"],playerSkillsTable[client]["conversionXP"])
		
	end
	if items ~= "" or items ~= "itemsReward" and tonumber(itemsNumber) and itemsNumber > 0 then
		setElementData(client,items,getElementData(client,items)+itemsNumber)
	end
	playerJobTable[client] = {}
end
addEvent("onPlayerRewardForCompletedJob",true)
addEventHandler("onPlayerRewardForCompletedJob",root,onJobRewardPlayer)
-- setElementPosition(localPlayer,-2147.5129394531, -2386.4167480469,31)
function onJobSetExterminationToPlayer(jobType,location,x,y,z,killsRequired,xpReward,spReward,itemsReward,itemsRewardNumber)
	playerJobTable[client] = {}
	playerJobTable[client]["jobType"] = jobType
	playerJobTable[client]["location"] = location
	playerJobTable[client]["x"],playerJobTable[client]["y"],playerJobTable[client]["z"] = x,y,z
	playerJobTable[client]["killsRequired"] = killsRequired
	playerJobTable[client]["xpReward"] = xpReward
	playerJobTable[client]["spReward"] = spReward
	playerJobTable[client]["itemsReward"] = itemsReward
	playerJobTable[client]["itemsRewardNumber"] = itemsRewardNumber
end
addEvent("onJobSetExterminationToPlayer",true)
addEventHandler("onJobSetExterminationToPlayer",root,onJobSetExterminationToPlayer)

function onJobSetRequiredKills(value)
	playerJobTable[client]["killsRequired"] = value
end
addEvent("onJobSetRequiredKills",true)
addEventHandler("onJobSetRequiredKills",root,onJobSetRequiredKills)

function onJobSetScienceToPlayer(jobType,itemNeeded,requiredItemNumber,xpReward,spReward,itemsReward,itemsRewardNumber)
	playerJobTable[client] = {}
	playerJobTable[client]["jobType"] = jobType
	playerJobTable[client]["itemNeeded"] = itemNeeded
	playerJobTable[client]["requiredItemNumber"] = requiredItemNumber
	playerJobTable[client]["xpReward"] = xpReward
	playerJobTable[client]["spReward"] = spReward
	playerJobTable[client]["itemsReward"] = itemsReward
	playerJobTable[client]["itemsRewardNumber"] = itemsRewardNumber
end
addEvent("onJobSetScienceToPlayer",true)
addEventHandler("onJobSetScienceToPlayer",root,onJobSetScienceToPlayer)

function onJobTakeRequiredItem(item,value)
	setElementData(client,item,getElementData(client,item)-value)
end
addEvent("onJobTakeRequiredItem",true)
addEventHandler("onJobTakeRequiredItem",root,onJobTakeRequiredItem)


			
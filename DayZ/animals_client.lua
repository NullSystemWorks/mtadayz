--[[
#---------------------------------------------------------------#
----*			DayZ MTA Script animals_client.lua			*----
----* This Script is owned by Marwin, you are not allowed to use or own it.
----* Owner: Marwin W., Germany, Lower Saxony, Otterndorf
----* Skype: xxmavxx96
----*														*----
#---------------------------------------------------------------#
]]

snipertxd = engineLoadTXD ("mods/bear.txd");
engineImportTXD (snipertxd, 12);
sniperdff = engineLoadDFF ("mods/bear.dff", 12);
engineReplaceModel (sniperdff, 12);

snipertxd = engineLoadTXD ("mods/goat.txd");
engineImportTXD (snipertxd, 13);
sniperdff = engineLoadDFF ("mods/goat.dff", 13);
engineReplaceModel (sniperdff, 13);

snipertxd = engineLoadTXD ("mods/wolf.txd");
engineImportTXD (snipertxd, 14);
sniperdff = engineLoadDFF ("mods/wolf.dff", 14);
engineReplaceModel (sniperdff, 14);

snipertxd = engineLoadTXD ("mods/cow1.txd");
engineImportTXD (snipertxd, 15);
sniperdff = engineLoadDFF ("mods/cow1.dff", 15);
engineReplaceModel (sniperdff, 15);

snipertxd = engineLoadTXD ("mods/cow2.txd");
engineImportTXD (snipertxd, 16);
sniperdff = engineLoadDFF ("mods/cow2.dff", 16);
engineReplaceModel (sniperdff, 16);

function animalDamage(attacker,weapon)
	if attacker == getLocalPlayer() then
		if getElementData(source,"animal") then
			if weapon and weapon > 1 then
				triggerServerEvent("createDeadAnimal",source)
			end
		end
	end	
end
addEventHandler ( "onClientPedDamage",getRootElement(),animalDamage)

function animalMovement(ped)
setTimer(function()
local rotation = math.random(1,359)
	if getElementData(ped,"animal") then
		setPedRotation(ped,rotation)
		setPedAnimation (ped, "ped", "Player_Sneak", -1, true, true, true)
	else return
	end	
end,4000,0)
end
addEvent("onAnimalMovement",true)
addEventHandler("onAnimalMovement",getRootElement(),animalMovement)
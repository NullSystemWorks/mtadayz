--[[
#---------------------------------------------------------------#
----*			DayZ MTA Script animals_client.lua			*----
----* This Script is owned by Marwin, you are not allowed to use or own it.
----* Owner: Marwin W., Germany, Lower Saxony, Otterndorf
----* Skype: xxmavxx96
----*														*----
#---------------------------------------------------------------#
]]

snipertxd = engineLoadTXD ("mods/animals/bear.txd");
engineImportTXD (snipertxd, 12);
sniperdff = engineLoadDFF ("mods/animals/bear.dff", 12);
engineReplaceModel (sniperdff, 12);

snipertxd = engineLoadTXD ("mods/animals/goat.txd");
engineImportTXD (snipertxd, 13);
sniperdff = engineLoadDFF ("mods/animals/goat.dff", 13);
engineReplaceModel (sniperdff, 13);

snipertxd = engineLoadTXD ("mods/animals/wolf.txd");
engineImportTXD (snipertxd, 14);
sniperdff = engineLoadDFF ("mods/animals/wolf.dff", 14);
engineReplaceModel (sniperdff, 14);

snipertxd = engineLoadTXD ("mods/animals/cow1.txd");
engineImportTXD (snipertxd, 15);
sniperdff = engineLoadDFF ("mods/animals/cow1.dff", 15);
engineReplaceModel (sniperdff, 15);

snipertxd = engineLoadTXD ("mods/animals/cow2.txd");
engineImportTXD (snipertxd, 16);
sniperdff = engineLoadDFF ("mods/animals/cow2.dff", 16);
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
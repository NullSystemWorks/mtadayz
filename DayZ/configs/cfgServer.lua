--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: cfgServer.lua							*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: SERVER														*----
#-----------------------------------------------------------------------------#
]]

outputDebugString("[DayZ] cfgServer loaded")

shownInfos["nomag"] = "No ammo left for this weapon!"
shownInfos["youconsumed"] = "You consumed"
shownInfos["needwatersource"] = "You have to be inside a body of water!"
shownInfos["filledup"] = "You filled your Water Bottle up!"
shownInfos["noradio"] = "You have no Radio Device!"
	
--GAME PLAY
gameplayVariables["zombieblood"] = 4500 -- Zombie Blood/Health - DEFAULT: 4500
gameplayVariables["foodrestore"] = 100 -- Amount of hunger to be restored when eating - DEFAULT: 100
gameplayVariables["thirstrestore"] = 100 -- Amount of hunger to be restored when drinking - DEFAULT: 100
gameplayVariables["loseHunger"] = -1.5 -- Amount of losing hunger per minute - DEFAULT: -1.5
gameplayVariables["loseThirst"] = -1.5 -- Amount of losing thirst per minute - DEFAULT: -1.5
gameplayVariables["loseWire"] = 1000 -- Amount of losing blood when hitting a Wirefence that's not yours. DEFAULT: 1000
gameplayVariables["playerzombies"] = 6 -- At what amount of zombies should they respawn? - DEFAULT: 6
gameplayVariables["amountzombies"] = 3 -- How often should the script iterate through zombie spawning (= how many zombies should spawn)? - DEFAULT: 3
gameplayVariables["temperaturewater"] = -0.1 -- Amount of temperature to be lost when in water - DEFAULT: -0.01
gameplayVariables["temperaturesprint"] = 0.005 -- Amount of temperature to be gained when sprinting - DEFAULT: 0.005
gameplayVariables["sprintthirst"] = -0.2 -- Amount of losing thirst when sprinting - DEFAULT: -0.2
gameplayVariables["enablenight"] = false -- Whether or not the night should be darker - DEFAULT: false - SET TO true to enable - remember you need to set it in editor_client.lua too.
gameplayVariables["itemrespawntimer"] = 14400000 -- Number of milliseconds that should elapse before the items will respawn. Note: You can also do math on the number.
gameplayVariables["autostartaddons"] = true -- Allow the gamemode to autostart resources with addon_ prefix
gameplayVariables["enableprone"] = true --Whether or not prone is enabled for players - DEFAULT: true
gameplayVariables["respawnwarning"] = true -- Should the warning "BEWARE OF MASSIVE LAG" when items are being respawned be displayed? If set to true, warning will be displayed. - DEFAULT: true
gameplayVariables["fuelEnabled"] = true -- Is the vehicle fuel enabled? - DEFAULT: true
gameplayVariables["realtime"] = false -- Enables/Disables real time use. When disabled, gameplayVariables["customtime"] is in effect - DEFAULT: false
gameplayVariables["customtime"] = 10000 -- How long should an ingame minute be (in ms)? Example: 10000ms (10s) realtime = 1 minute gametime - DEFAULT: 10000
gameplayVariables["pingkick"] = true -- Should the ping kicker be enabled? - DEFAULT: true 
	
-- SERVER BACKUP
gameplayVariables["backupenabled"] = true -- Whether or not backup should be enabled. Backup = saves all tents, accounts & vehicles. - DEFAULT: true - Set to false to disable backup.
gameplayVariables["backupinterval"] = 3600000 -- Number of milliseconds that should elapse before backup. Minimum: 50. - 1000 milliseconds = 1 second. - DEFAULT: 3600000ms (= 1 hour)
	
-- BATTLDAYZ SETUP
gameplayVariables["packetlosskick"] = true -- Allow the gamemode to kick a player if his packet loss is 100% for 5 seconds. DEFAULT: true
gameplayVariables["packetlossmax"] = 10 -- Set the max packet loss counter DEFAULT: 10
gameplayVariables["maxslots"] = 30 -- Max slot amount in your server( Include VIP Slots ) - DEFAULT: 30
gameplayVariables["combatlog"] = true -- Disable/Enable anti combat logging - DEFAULT: true - USE AT YOUR OWN RISK!
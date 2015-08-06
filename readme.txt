First of all, thank you for downloading and using MTA DayZ. This means a lot to us, as it shows that our work and dedication
will not be in vain. This README aims to show you everything about MTA DayZ, including how to set it up and what commands
are available for admins.

## SETTING UP THE MTA DAYZ SERVER ##
Once you have moved the contents of mtadayz.zip to the resources folder, open acl.xml and add the following lines in the admin group:

    <object name="resource.DayZ"></object>
    <object name="resource.login"></object>
    <object name="resource.slothbot"></object>
    
Now open mtaserver.conf, scroll down and add these lines:

    <resource src="DayZ" startup="1" protected="0"></resource>
    <resource src="login" startup="1" protected="0"></resource>
    <resource src="slothbot" startup="1" protected="0"></resource>
	
The following resources should have startup set to 0:

scoreboard, mapcycler, mapmanager, spawnmanager, votemanager

Version 0.9.0 will hopefully be the last version to do that, but you must replace your current internal.db with the fresh one provided
in the download! It's located in the same directory as mtaserver.conf and acl.xml.

And that's it! Start the server and MTA DayZ will start automatically. 


## COMMANDS ##
As of Version 0.9.4, the following commands are available for admins:

/add <admin/supporter/remove> <Player>
admin: Makes the player an admin
supporter: Makes the player a supporter
remove: Removes the player from being admin/supporter

/backup
Will create a backup of all vehicles (must be enabled in editor_server.lua)


## EXPORTED FUNCTIONS ##
getPlayerBlood - Arguments: element player. Returns: Amount of blood the player has (int)
setPlayerBlood - Arguments: element player, int amount. Effect: sets player's blood to specified amount
getPlayerZombiesKilled - Arguments: element player. Returns: Amount of zombies player has killed (int)
setPlayerZombiesKilled - Arguments: element player, int amount. Effect: sets amount of killed zombies for player to specified value
getPlayerHeadshots - Arguments: element player. Returns: Amount of head shots player has delivered (int)
setPlayerHeadshots - Arguments: element player, int amount. Effect: sets amount of head shots player has delivered to specified value
getPlayerMurders - Arguments: element player. Returns: Amount of murders player has committed (int)
setPlayerMurders - Arguments: element player, int amount. Effect: sets amount of murders to specified value
getPlayerBanditsKilled - Arguments: element player. Returns: Amount of bandits player has killed
setPlayerBanditsKilled - Arguments: element player, int amount. Effect: sets amount of killed bandits to specified value
getPlayerTemperature - Arguments: element player. Returns: Temperature of player (int)
setPlayerTemperature - Arguments: element player, int amount. Effect: sets temperature to specified value
getPlayerHumanity - Arguments: element player. Returns: Humanity of player (int)
setPlayerHumanity - Arguments: element player, int amount. Effect: sets humanity to specified value


## FAQ ##
Q: Help! Vehicles won't spawn/appear!
A: Check the vehicles database. Does it contain any entries? If not, delete the vehicleManager from the console (delaccount vehicleManager) and restart the server.

Q: Error/Warning X is appearing in the server console!
A: Please post your server log in the forum: http://mta-dayz.org/forum

Q: What just happened?! I have been kicked when I tried to enter my Rhino!
A: The anticheat measures prevent players who are not admins (ACL-wise) from entering vehicles which do not normally spawn via the MTA DayZ script.

Q: The inventory is broken!
A: Please provide a screenshot/video/accurate description of what exactly broke. Add server log and, if possible, the client log too.

Q: I'm getting this strange error: "Infinite/too long execution (DayZ)".
A: This error appears when items are respawning. We are trying to reduce lag as much as possible, but sometimes, the server is struggling with respawning said items.
Usually, it should dissipate after a few minutes, but if the error persists, try restarting the server. In general, it is advised to restart the server
every 24-48 hours to prevent possible, yet undetected memory leaks.

Q: I want to help developing! How and where can I apply?
A: Send a private message to Lawliet on the MTA forum. Read this topic before you apply: https://forum.multitheftauto.com/viewtopic.php?f=108&t=88188

Q: Pfft, this gamemode is compiled! I want it decompiled/I'm going to decompile it/I'm going to destroy all your work!
A: To be honest, if you really wish to decompile it...feel free to do so. The gamemode will be, once we have version 1.0.0, open source anyway.
So, instead of hindering us in our progress and development, just apply, become a part of the team, and help us that way. Decompiling it
won't help anyone. If you want to add something to make your server unique, why not tell us? We might listen if you can give us a good reason.

Q: There is a question I have that does not appear in the FAQ!
A: Go to the forum http://mta-dayz.org/forum, and ask there. We'll answer. Eventually.



First of all, thank you for downloading and using MTA DayZ. This means a lot to us, as it shows that our work and dedication
will not be in vain. This README aims to show you everything about MTA DayZ, including how to set it up and what commands
are available for admins.

## SETTING UP THE MTA DAYZ SERVER ##
Once you have moved the contents of mtadayz.zip to the resources folder, open acl.xml and add the following lines in the admin group:

    <object name="resource.DayZ"></object>
    <object name="resource.login"></object>
    <object name="resource.slothbot"></object>
    <object name="user.[YOUR_NAME]"></object>
    
    You need edit "[YOUR_NAME]" per your nickname in game for playing with your admin rights.
    
Now open mtaserver.conf, scroll down and add these lines:

    <resource src="DayZ" startup="1" protected="0"></resource>
    <resource src="login" startup="1" protected="0"></resource>
    <resource src="slothbot" startup="1" protected="0"></resource>
	
The following resources should have startup set to 0:

scoreboard, mapcycler, mapmanager, spawnmanager, votemanager

And that's it! Start the server and MTA DayZ will start automatically. 


## COMMANDS ##
As of Version 0.9.4, the following commands are available for admins:

/add <admin/supporter/remove> <Player>
admin: Makes the player an admin
supporter: Makes the player a supporter
remove: Removes the player from being admin/supporter


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
getDayZVersion - No Arguments. Returns running DayZ version

## FAQ ##
Q: Help! Vehicles won't spawn/appear!
A: Check the vehicles database. Does it contain any entries? If not, delete the vehicleManager from the console (delaccount vehicleManager) and restart the server.

Q: Error/Warning X is appearing in the server console!
A: Please create an issue in our Github repository and all the info you can give us( Debugs, Images, CodeSnippets ) You can use https://paste.mta-day.org/

Q: What just happened?! I have been kicked when I tried to enter my Rhino!
A: The anticheat measures prevent players who are not admins (ACL-wise) from entering vehicles which do not normally spawn via the MTA DayZ script.

Q: The inventory is broken!
A: Please provide a screenshot/video/accurate description of what exactly broke. Add server log and, if possible, the client log too.

Q: I'm getting this strange error: "Infinite/too long execution (DayZ)".
A: This was fixed in latest versions, please update you server.

Q: How to change backpack slots in this gamemode ?
A: You can do this by modifying the configuration file "cfgServer.lua" (DayZ/configs/cfgServer.lua). Take care to change the "maxslots" variable in the file "cfgSecurity.lua" (DayZ/configs/cfgSecurity.lua) for the anti-cheat.

Q: I want to help developing! How and where can I apply?
A: You can start by creating pull requests fixing or creating new features. We will contact you if we think you are suit for the job.

Q: There is a question I have that does not appear in the FAQ!
A: You can ask it on our forums or join discord!

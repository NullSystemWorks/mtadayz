MTA:DayZ - Version 0.6

Thank you for downloading "MTA:DayZ", a gamemode similiar to DayZ by "Rocket" Hall, where your main aim
is to survive the post-apocalyptic world of San Andreas by scavenging for food, avoiding or defending against
zombies and other, possibly hostile, players.
With the files contained is this gamemode, you are able and eligible to host your very own version of
"MTA:DayZ". Before you can start, there are a few things you have to do and keep in mind to fully maximize
your and other players experience, which shall be elaborated on in the following text:


[[ ----- FOLDER: installation ----- ]]
The folder "installation" contains a file called "internal.db". It is needed to ensure that tents, vehicles and userdata is saved properly. Move this file to this path: ...\server\mods\deathmatch

If your OS (or the server control panel) asks you if you want to replace the old internal.db with the new one, press "Yes".


[[ ----- ACL ----- ]]
In order to let the resources save necessary data (vehicles, tents & user data), you have to give admin rights to the respective resources. Open your ACL.xml, navigate yourself to the group "Admin" and copy and paste this:

<object name="resource.DayZ"></object>
<object name="resource.login"></object>
<object name="resource.slothbot"></object>

If you are the server owner, you also have to add yourself as an admin. If you did not do that already, copy and paste this after <object name="resources.slothbot"></object>:

<object name="user.X"></object>

X is the name you login with when entering the server.


[[ ----- FOLDER: resources ----- ]]
The folder "resources" contains all files necessary to play "MTA:DayZ" - as such, placing the file in the wrong direction or altering them may render the gamemode useless and you will be unable to play or even start it.
To avoid this, move the folder [DayZ-MTA] to this path: ...\server\mods\deathmatch\resources


[[ ----- mtaserver.conf ----- ]]
To let the gamemode itself start, you have to alter your mtaserver.conf (the config file). If you plan to play this gamemode locally (LAN), you have to alter local.conf. In any case, the same configuration applies.
First, you have to rename your server, otherwise, the gamemode won't start as it makes a check to see if the name is within the "whitelist". Details can be checked in the license.txt.

	<!-- This parameter specifies the name the server will be visible as in the ingame server browser 
		 and on Game-Monitor. It is a required parameter. -->
	<servername>GTA:SA DayZ Version [LOCATION] | community.vavegames.net | additional info</servername>


Add the three resources provided below to the line (the line where you let the server start resources automatically) and remove the votemanager:

	<!-- Specifies resources that are loaded when the server starts and/or which are protected from being stopped. To specify several resources, add more <resource> parameter(s). -->

   			 <resource src="DayZ" startup="1" protected="0"></resource>
   			 <resource src="login" startup="1" protected="0"></resource>
   			 <resource src="slothbot" startup="1" protected="0"></resource>


Remove the very last line of the config file to prevent any conflicts with the gamemode.


[[ ----- GENERAL INFO ----- ]]
You must not spawn a vehicle by using the admin panel, as this action will destroy the database (internal.db), and all data will be lost as a result.

The first time you start the gamemode, you have to add yourself as an admin of the gamemode. This can be accomplished by entering the server and typing this into the chatbox:
/add admin <name>
<name> = Name the person appears with - change it if it's too complicated to write or an error prevents you from adding yourself or a player as an admin.

Supporters can be added by typing this into the chatbox:
/add supporter <name>
<name> = Name the person appears with - change it if it's too complicated to write or an error prevents you from adding yourself or a player as a supporter.

If you want to remove an admin or supporter, type this into the chatbox:
/add remove <name>
<name> = Name the person appears with - change it if it's too complicated to write or an error prevents you from removing yourself or a player as a supporter.

Additional commands include:

/kickall -> kicks all players
/pmsg <text> > global message, can be seen by every player
/givevip <accountname> <amount> > Adds groupslots to the group of the player specified in <accountname>

Items respawn every 4 hours - keep in mind that this process will result in major lag, to the point where most players will be kicked due to timing out or a temporary shutdown of the server.
As of the newest update, server owners are able to edit the time for a respawn. Open editor_server.lua and check gameplayVariables["itemrespawntimer"].


[[ ----- SUPPORT ----- ]]
Support can only be provided in the official forum: http://community.vavegames.net/
Business inquiries, questions, suggestions and the such are to be submitted in the offical forum only.


resourceRoot = getResourceRootElement(getThisResource())
infoTable = {}
infoTable["account"] = ""
infoTable["pass"] = ""
Login_Edit = {}
marwinButtons = {}
sx,sy = guiGetScreenSize()
font = {}
scale = 1
setPlayerHudComponentVisible("area_name",false)
setPlayerHudComponentVisible("radar",false)
showChat(false)
showCursor(not isCursorShowing())
local sound = playSound("dayzsoundtrack.mp3",true)
setSoundVolume(sound,0.5)
local reason = ""
local registerCheck = false
local loginCheck = false

if sx < 1152 then
	scale = sx/1152
end

font[-1] = guiCreateFont( "font2.ttf", 8*scale )
font[-2] = guiCreateFont("font2.ttf",16*scale)
font[0] = guiCreateFont( "font.ttf", 16*scale )
font[1] = guiCreateFont( "font.ttf", 18*scale )
font[2] = guiCreateFont( "font.ttf", 20*scale )
font[3] = guiCreateFont( "font.ttf", 24*scale )
font[4] = guiCreateFont( "font.ttf", 90*scale )

--[[

TO DO:

Options:

Continue Story / Start Story (Login / Register)
Change Character
Configure

NOW:

Continue Story (= Login)
Start Story (= Register)
News (= Changelog)


]]

--Button
function createMarwinButton(x,y,widht,height,text,bool,parent,info)
	marwinButtons[info] = guiCreateStaticImage(x,y,widht,height,"images/button.png", bool,parent or nil)
	guiBringToFront(marwinButtons[info])
	marwinLabel = guiCreateLabel(0,0,1,1,text,bool,marwinButtons[info])
	guiBringToFront(marwinLabel)
	setElementData(marwinLabel,"parent",marwinButtons[info])
	setElementData(marwinButtons[info],"info",info)
	guiSetFont(marwinLabel,font[-2])
	guiLabelSetVerticalAlign (marwinLabel, "center")
	guiLabelSetHorizontalAlign (marwinLabel, "center")
	addEventHandler("onClientMouseEnter",marwinLabel,markButton,false)
	addEventHandler("onClientMouseLeave",marwinLabel,unmarkButton,false)
	return marwinLabel
end

function markButton ()
	parent = getElementData(source,"parent")
	guiStaticImageLoadImage (parent,"images/button.png")
	setElementData(getLocalPlayer(),"clickedButton",parent)
	playSound("button.mp3")
end

function unmarkButton (b,s)
	parent = getElementData(source,"parent")
	guiStaticImageLoadImage (parent,"images/button.png")
	setElementData(getLocalPlayer(),"clickedButton",false)
end


local onlinenews = true -- if true, it try to get DayZ changelog from GitHub. Otherwise it uses news table; Default: true
local news = {
	"[03/XX/17]\nVersion 0.9.9.1a is out!\n\n--- CHANGELOG ---\nMTA DayZ has gone open source!\nYou can get the newest version at our repository:\n\n https://github.com/NullSystemWorks/mtadayz"
}
local oldnews = {
	"[07/05/16]\nVersion 0.9.8a is out!\n\n--- CHANGELOG ---\nMTA DayZ has gone open source!\nYou can get the newest version at our repository:\n\nhttps://github.com/mtadayz/MTADayZ",
	"[06/24/16]\nVersion 0.9.7a is out!\n\n--- CHANGELOG ---\nMTA DayZ has gone open source!\nYou can get the newest version at our repository:\n\nhttps://github.com/mtadayz/MTADayZ",
	"[09/19/15]\nVersion 0.9.6a is out!\n\n--- CHANGELOG ---\nMTA DayZ has gone open source!\nYou can get the newest version at our repository:\n\nhttps://github.com/mtadayz/MTADayZ",
	"[08/19/15]\nVersion 0.9.5a is out!\n\n--- CHANGELOG ---\n[NEW]Language: Romanian (ro)\n[NEW]Status Effects: Sepsis, Infection & Unconsciousness\n[NEW]Items: Epi-Pen, Range Finder\n[NEW]Reworked inventory UI (rightclick to use items!)\n[NEW]Crosshair integration (please remove addon_crosshair if you have it)\n[NEW]Difficulty options (Normal, Veteran, Hardcore)\n[NEW]Salute animation (press , [Comma])\n[CHANGE]Weapon damage + magazine sizes\n[FIX]Not being able to access tents\n\n\n\nThe complete changelog can be found at mta-dayz.org/forum!",
	"[08/06/15]\nVersion 0.9.4a is out!\n\n--- CHANGELOG ---\n[NEW]Major restructuring of code base\n[NEW]Language: Spanish (es)\n[NEW]Helicrash sites now have 6 loot points\n[NEW]Dynamic Weather System\n[NEW]Binoculars image will fill out entire screen now\n[FIX]Vehicles not respawning at their initial spawnpoints\n[FIX]Bug with British Assault Pack\n[FIX]Temperature not decreasing when it's cold or night\n[FIX]Temperature increasing too fast (and beyond 37°) when sprinting or in vehicle\n\n\nThe complete changelog can be found at mta-dayz.org/forum!",
	"[07/28/15]\nVersion 0.9.2a is out!\n\n--- CHANGELOG ---\n[NEW]Language: Chinese\n[NEW]Toggleable GPS (/gps)\n[NEW]New compass images\n[NEW]Toggleable Compass (/compass)\n[FIX]Some zombies\n[FIX]GPS not showing correct position\n[FIX]Teleportation & Duping Bug\n[FIX]Not being able to administer \nblood bags\n\n\nThe complete changelog can be found at mta-dayz.org/forum!",
	"[07/20/15]\nVersion 0.9.0 is out!\n\n--- CHANGELOG ---\n[NEW]Vehicles are saved in custom database\n[NEW]Revamped Vehicle HUD\n[NEW]Multi-Language Support*\n[NEW]Gender Selection\n[NEW]Keycards for Area 69 and San Fierro Carrier\n[NEW]Heroes take less damage from zombies and weapons\n[NEW]Added 16 cars, 5 helicopters, 1 plane & 3 boats\n[CHANGED]Icons for HUD\n\n\nThe complete changelog can be found at mtadayz.heliohost.org!\n\n\n*Languages available at time of release: English, German, Czech, Dutch, Portuguese"
}


local StartWindow = {
    label = {},
    staticimage = {}
}

StartWindow.staticimage["invis"] = guiCreateStaticImage(0,0,1,1,"images/background_transparent.png",true)

StartWindow.staticimage["upper"] = guiCreateStaticImage(0.00, 0.00, 1.00, 0.10, "images/background_news.png", true, StartWindow.staticimage["invis"])
StartWindow.staticimage["lower"] = guiCreateStaticImage(0.00, 0.90, 1.00, 0.10, "images/background_news.png", true, StartWindow.staticimage["invis"])
StartWindow.staticimage["logo"] = guiCreateStaticImage(0.07, 0.11, 0.41, 0.27, "images/mtadayz_logo.png", true, StartWindow.staticimage["invis"])

StartWindow.label["version"] = guiCreateLabel(0.71, 0.04, 0.29, 0.05, "Version: ", true, StartWindow.staticimage["invis"])
guiLabelSetVerticalAlign(StartWindow.label["version"], "center")
guiSetFont(StartWindow.label["version"],font[-2])

StartWindow.label["error"] = guiCreateLabel(0.01, 0.83, 0.39, 0.07, "", true, StartWindow.staticimage["invis"])
guiLabelSetVerticalAlign(StartWindow.label["error"], "center")

StartWindow.staticimage["continuebutton"] = createMarwinButton(0.16, 0.48, 0.16, 0.05, "Continue Your Story", true, StartWindow.staticimage["invis"], "showLogin")

StartWindow.staticimage["startbutton"] = createMarwinButton(0.16, 0.55, 0.16, 0.05, "Start Your Story", true, StartWindow.staticimage["invis"], "showRegister")

StartWindow.staticimage["newsbutton"] = createMarwinButton(0.16, 0.62, 0.16, 0.05, "News", true, StartWindow.staticimage["invis"], "showNews")

guiSetVisible(StartWindow.staticimage["invis"],false)


local ContinueStory = {
    button = {},
    staticimage = {},
    edit = {},
    label = {}
}
ContinueStory.staticimage["invis"] = guiCreateStaticImage(0,0,1,1,"images/background_transparent.png",true)

ContinueStory.staticimage["ContinueStorywindow"] = guiCreateStaticImage(0.29, 0.36, 0.39, 0.24, "images/background_news.png", true, ContinueStory.staticimage["invis"])
guiSetAlpha(ContinueStory.staticimage["ContinueStorywindow"], 0.80)

ContinueStory.label["continuestory"] = guiCreateLabel(0.00, 0.00, 1.00, 0.15, "Continue Your Story", true, ContinueStory.staticimage["ContinueStorywindow"])
guiLabelSetHorizontalAlign(ContinueStory.label["continuestory"], "center", false)

ContinueStory.label["username"] = guiCreateLabel(0.03, 0.28, 0.28, 0.14, "Username", true, ContinueStory.staticimage["ContinueStorywindow"])
ContinueStory.edit["name"] = guiCreateEdit(0.02, 0.42, 0.65, 0.15, infoTable["account"], true, ContinueStory.staticimage["ContinueStorywindow"])

ContinueStory.label["password"] = guiCreateLabel(0.03, 0.67, 0.28, 0.14, "Password", true, ContinueStory.staticimage["ContinueStorywindow"])
ContinueStory.edit["pass"] = guiCreateEdit(0.02, 0.81, 0.65, 0.15, infoTable["pass"], true, ContinueStory.staticimage["ContinueStorywindow"])
guiEditSetMasked(ContinueStory.edit["pass"], true)

ContinueStory.button["continue"] = guiCreateButton(0.82, 0.81, 0.17, 0.16, "Continue", true, ContinueStory.staticimage["ContinueStorywindow"])

ContinueStory.button["close"] = guiCreateButton(0.91, 0.05, 0.07, 0.15, "x", true, ContinueStory.staticimage["ContinueStorywindow"])

guiSetVisible(ContinueStory.staticimage["invis"],false)


local StartStory = {
    button = {},
    staticimage = {},
    edit = {},
    label = {}
}

StartStory.staticimage["invis"] = guiCreateStaticImage(0,0,1,1,"images/background_transparent.png",true)

StartStory.staticimage["startwindow"] = guiCreateStaticImage(0.29, 0.36, 0.39, 0.24, ":login/images/background_news.png", true, StartStory.staticimage["invis"])
guiSetAlpha(StartStory.staticimage["startwindow"], 0.80)

StartStory.label["startstory"] = guiCreateLabel(0.00, 0.00, 1.00, 0.15, "Start Your Story", true, StartStory.staticimage["startwindow"])
guiLabelSetHorizontalAlign(StartStory.label["startstory"], "center", false)
StartStory.label["username"] = guiCreateLabel(0.03, 0.28, 0.28, 0.14, "Username", true, StartStory.staticimage["startwindow"])
StartStory.edit["name"] = guiCreateEdit(0.02, 0.42, 0.65, 0.15, "", true, StartStory.staticimage["startwindow"])
StartStory.label["password"] = guiCreateLabel(0.03, 0.67, 0.28, 0.14, "Password", true, StartStory.staticimage["startwindow"])
StartStory.edit["pass"] = guiCreateEdit(0.02, 0.81, 0.65, 0.15, "", true, StartStory.staticimage["startwindow"])
guiEditSetMasked(StartStory.edit["pass"], true)

StartStory.button["start"] = guiCreateButton(0.82, 0.81, 0.17, 0.16, "Start", true, StartStory.staticimage["startwindow"])
StartStory.button["close"] = guiCreateButton(0.91, 0.05, 0.07, 0.15, "x", true, StartStory.staticimage["startwindow"])

guiSetVisible(StartStory.staticimage["invis"],false)

local NewsWindow = {
    button = {},
    staticimage = {},
    scrollpane = {},
    label = {}
}
NewsWindow.staticimage["newswindow"] = guiCreateStaticImage(0.10, 0.17, 0.80, 0.67, "images/background_news.png", true)
guiSetAlpha(NewsWindow.staticimage["newswindow"], 0.90)

NewsWindow.scrollpane["changelogscroll"] = guiCreateScrollPane(0.01, 0.16, 0.39, 0.81, true, NewsWindow.staticimage["newswindow"])

NewsWindow.label["changelog"] = guiCreateLabel(0.00, 0.00, 0.92, 1.00, "Loading changelog...", true, NewsWindow.scrollpane["changelogscroll"])
guiLabelSetHorizontalAlign(NewsWindow.label["changelog"], "left", true)

NewsWindow.label["newslabel"] = guiCreateLabel(0.00, 0.01, 1.00, 0.06, "News", true, NewsWindow.staticimage["newswindow"])
guiLabelSetHorizontalAlign(NewsWindow.label["newslabel"], "center", false)

NewsWindow.label["changeloglabel"] = guiCreateLabel(0.01, 0.10, 0.39, 0.06, "Changelog", true, NewsWindow.staticimage["newswindow"])
guiLabelSetHorizontalAlign(NewsWindow.label["changeloglabel"], "center", false)

NewsWindow.button["close"] = guiCreateButton(0.96, 0.02, 0.03, 0.05, "x", true, NewsWindow.staticimage["newswindow"])

NewsWindow.label["info"] = guiCreateLabel(0.44, 0.16, 0.54, 0.16, "MTA: DayZ\nOriginal Creator: Marwin\nCurrent Team: NullSystemWorks\n\nVersion: 0.9.9.2a", true, NewsWindow.staticimage["newswindow"])
guiLabelSetHorizontalAlign(NewsWindow.label["info"], "left", true)

NewsWindow.label["contributorslabel"] = guiCreateLabel(0.44, 0.78, 0.39, 0.06, "Contributors", true, NewsWindow.staticimage["newswindow"])
NewsWindow.label["contributorstop"] = guiCreateLabel(0.44, 0.84, 0.39, 0.06, "", true, NewsWindow.staticimage["newswindow"])
NewsWindow.label["contributors"] = guiCreateLabel(0, 0, 5.00, 1, "Loading contributors...", true, NewsWindow.label["contributorstop"])

guiSetVisible(NewsWindow.staticimage["newswindow"],false)
guiSetVisible(NewsWindow.staticimage["contributors"],false)


function showStartWindow()
	guiSetInputMode("no_binds_when_editing")
	guiSetVisible(StartWindow.staticimage["invis"],true)
	oldFile = xmlLoadFile("preferencesL.xml")
	confFile = xmlLoadFile("@preferencesL.xml")
	if not confFile and oldFile then
		confFile = xmlCreateFile("@preferencesL.xml","user")
		local usr = xmlNodeGetAttribute(oldFile,"username")
		local pass = xmlNodeGetAttribute(oldFile,"pass")
		xmlNodeSetAttribute(confFile, "username", usr)
		xmlNodeSetAttribute(confFile, "pass", pass)
		xmlSaveFile(confFile)
	end
	if oldFile then
		xmlUnloadFile(oldFile)
	end
	confFile = xmlLoadFile("@preferencesL.xml")
	if (confFile) then
		infoTable["account"] = xmlNodeGetAttribute(confFile,"username")
		infoTable["pass"] = xmlNodeGetAttribute(confFile,"pass")
		
		guiSetText(ContinueStory.edit["name"],infoTable["account"])
		guiSetText(ContinueStory.edit["pass"],infoTable["pass"])
	else
		confFile = xmlCreateFile("@preferencesL.xml","user")
		xmlNodeSetAttribute(confFile,"username","")
		xmlNodeSetAttribute(confFile,"pass","")
		
		infoTable["account"] = getPlayerName(localPlayer)
		infoTable["pass"] = ""
		
	end
	xmlSaveFile(confFile)
end

--LOGIN
function clickPanelButton(button, state)
	if button == "left" and state == "up" then
		local element = getElementData(localPlayer,"clickedButton")
		if element then 
			local info = getElementData(element,"info")
			if info then
				if info == "showLogin" then
					guiSetVisible(ContinueStory.staticimage["invis"],true)
					guiSetVisible(StartWindow.staticimage["continuebutton"],false)
					guiSetVisible(StartWindow.staticimage["startbutton"] ,false)
					guiSetVisible(StartWindow.staticimage["newsbutton"] ,false)
					
					guiSetVisible(marwinButtons["showLogin"],false)
					guiSetVisible(marwinButtons["showRegister"],false)
					guiSetVisible(marwinButtons["showNews"],false)
					
					guiBringToFront(ContinueStory.staticimage["invis"])
				elseif info == "showRegister" then
					guiSetVisible(StartStory.staticimage["invis"],true)
					guiSetVisible(StartWindow.staticimage["continuebutton"] ,false)
					guiSetVisible(StartWindow.staticimage["startbutton"] ,false)
					guiSetVisible(StartWindow.staticimage["newsbutton"] ,false)
					
					guiSetVisible(marwinButtons["showLogin"],false)
					guiSetVisible(marwinButtons["showRegister"],false)
					guiSetVisible(marwinButtons["showNews"],false)
					
					guiBringToFront(StartStory.staticimage["invis"])
				elseif info == "showNews" then
					guiSetVisible(NewsWindow.staticimage["newswindow"],true)
					guiSetVisible(NewsWindow.staticimage["contributors"],true)
					guiSetVisible(StartWindow.staticimage["continuebutton"] ,false)
					guiSetVisible(StartWindow.staticimage["startbutton"] ,false)
					guiSetVisible(StartWindow.staticimage["newsbutton"] ,false)
					
					guiSetVisible(marwinButtons["showLogin"],false)
					guiSetVisible(marwinButtons["showRegister"],false)
					guiSetVisible(marwinButtons["showNews"],false)
					
					guiBringToFront(NewsWindow.staticimage["newswindow"])
				end
			end
		end
	end
end
addEventHandler("onClientClick",getRootElement(),clickPanelButton)

function processLoginOrRegistering(button, state)
	if button == "left" and state == "up" then
		--Login Handling
		if source == ContinueStory.button["continue"] then
			local username = guiGetText(ContinueStory.edit["name"])
			local password = guiGetText(ContinueStory.edit["pass"])
			if not (tostring(username) == "") and not (tostring(password) == "") then
				triggerServerEvent("onClientSendLoginDataToServer", getLocalPlayer(), username, password)
			else
				if tostring(username) == "" then
					reason = "Username is missing!"
					onErrorOutputReason(reason)
					return false
				elseif tostring(password) == "" then
					reason = "Password is missing!"
					onErrorOutputReason(reason)
					return false
				end
			end
		elseif source == StartStory.button["start"] then
			local username = guiGetText(StartStory.edit["name"])
			local password = guiGetText(StartStory.edit["pass"])
			if not (tostring(username) == "") then
				if not (tostring(password) == "") then
					triggerServerEvent("onClientSendRegisterDataToServer", getLocalPlayer(), username, password)
				else
					reason = "Password is missing!"
					onErrorOutputReason(reason)
					return false
				end
			else
				reason = "Username is missing!"
				onErrorOutputReason(reason)
				return false
			end
		end
	end
end
addEventHandler("onClientGUIClick",ContinueStory.button["continue"],processLoginOrRegistering,false)
addEventHandler("onClientGUIClick",StartStory.button["start"],processLoginOrRegistering,false)

function stopSoundAndFadeCamera()
	if sound then
		stopSound(sound)
	end
end

function hideNewsWindow(button,state)
	if button == "left" then
		guiSetVisible(NewsWindow.staticimage["newswindow"],false)
		guiSetVisible(StartWindow.staticimage["continuebutton"] ,true)
		guiSetVisible(StartWindow.staticimage["startbutton"] ,true)
		guiSetVisible(StartWindow.staticimage["newsbutton"] ,true)
		
		guiSetVisible(marwinButtons["showLogin"],true)
		guiSetVisible(marwinButtons["showRegister"],true)
		guiSetVisible(marwinButtons["showNews"],true)
		
		guiSetVisible(NewsWindow.staticimage["contributors"],false)

	end
end
addEventHandler("onClientGUIClick",NewsWindow.button["close"],hideNewsWindow,false)

function hideContinueWindow(button,state)
	if button == "left" then
		guiSetVisible(ContinueStory.staticimage["invis"],false)
		guiSetVisible(StartWindow.staticimage["continuebutton"] ,true)
		guiSetVisible(StartWindow.staticimage["startbutton"] ,true)
		guiSetVisible(StartWindow.staticimage["newsbutton"] ,true)
		
		guiSetVisible(marwinButtons["showLogin"],true)
		guiSetVisible(marwinButtons["showRegister"],true)
		guiSetVisible(marwinButtons["showNews"],true)
	end
end
addEventHandler("onClientGUIClick",ContinueStory.button["close"],hideContinueWindow,false)

function hideStartWindow(button,state)
	if button == "left" then
		guiSetVisible(StartStory.staticimage["invis"],false)
		guiSetVisible(StartWindow.staticimage["continuebutton"] ,true)
		guiSetVisible(StartWindow.staticimage["startbutton"] ,true)
		guiSetVisible(StartWindow.staticimage["newsbutton"] ,true)
		
		guiSetVisible(marwinButtons["showLogin"],true)
		guiSetVisible(marwinButtons["showRegister"],true)
		guiSetVisible(marwinButtons["showNews"],true)
	end
end
addEventHandler("onClientGUIClick",StartStory.button["close"],hideStartWindow,false)

function onErrorOutputReason(reason)
	if reason then
		guiSetFont(StartWindow.label["error"],font[-2])
		guiSetText(StartWindow.label["error"],reason)
		setTimer(function() guiSetText(StartWindow.label["error"],"") end,3000,1)
	end
end
addEvent("onErrorOutputReason",true)
addEventHandler("onErrorOutputReason",root,onErrorOutputReason)

function checkIfRegisterOrLoginOkay(check)
	if check == "register" then
		registerCheck = true
		stopSoundAndFadeCamera()
	elseif check == "login" then
		loginCheck = true
		stopSoundAndFadeCamera()
	else
		registerCheck = false
		loginCheck = false
	end
end
addEvent("checkIfRegisterOrLoginOkay",true)
addEventHandler("checkIfRegisterOrLoginOkay",root,checkIfRegisterOrLoginOkay)

local xcntri,ycntri = 0,0
function startContributorsAnim()
	if guiGetVisible(NewsWindow.label["contributors"]) then
		if xcntri < -5 then
			xcntri = 0
		end
		xcntri = xcntri-0.005
		guiSetPosition(NewsWindow.label["contributors"],xcntri,ycntri,true)
	end
end

-- Load changelog
function loadAPIData(ele,data)
	if (ele == "changelog") then
		if (data ~= "ERROR") then
			guiSetText(NewsWindow.label["changelog"],data)
		end -- else keep offline news
	elseif (ele == "contributors") then
		local v = exports.DayZ:getDayZVersion()
		if v then
			guiSetText(StartWindow.label["version"],"Version: "..v)
		else
			guiSetText(StartWindow.label["version"],"Version: N/A")
		end
		
		if (data ~= "ERROR") then
			local v = {fromJSON(data)}
			local contri = ""
			for i, all in ipairs(v) do
				contri = contri..all["login"].." ["..all["contributions"].." contributions]".." | "
			end
			guiSetText(NewsWindow.label["contributors"],contri)
			addEventHandler("onClientRender",root,startContributorsAnim)
		else
			guiSetText(NewsWindow.label["contributors"],"Can't load contributors list")
		end
	end
end
addEvent("loadAPIData",true)
addEventHandler("loadAPIData",root,loadAPIData)

--BUILD WINDOW ON RESOURCE START
addEventHandler("onClientResourceStart", resourceRoot, 
	function ()
		showStartWindow()
		guiSetInputMode("no_binds_when_editing")	
		triggerServerEvent("pullChangelog",localPlayer,onlinenews)
	end
)

--onPlayerDoneLogin
function hideLoginWindow(accountName, pass)
	guiSetVisible(StartWindow.staticimage["invis"],false)
	guiSetVisible(ContinueStory.staticimage["invis"],false)
	guiSetVisible(StartStory.staticimage["invis"],false)
	guiSetVisible(NewsWindow.staticimage["newswindow"],false)
	showCursor(false)
	destroyElement(marwinButtons["showLogin"])
	destroyElement(marwinButtons["showRegister"])
	destroyElement(marwinButtons["showNews"])
	setElementData(localPlayer,"clickedButton",nil)
	toggleSavePassword(accountName, pass)
	if(guiGetText(NewsWindow.label["contributors"]) ~= "Can't load contributors list") then
		removeEventHandler("onClientRender",root,startContributorsAnim)
	end
end
addEvent("onPlayerDoneLogin", true)
addEventHandler("onPlayerDoneLogin", getRootElement(), hideLoginWindow)

--toggle save password
function toggleSavePassword(name, pass)
	confFile = xmlLoadFile("@preferencesL.xml")
	xmlNodeSetAttribute(confFile, "username", name)
	xmlNodeSetAttribute(confFile, "pass", pass)
	xmlSaveFile(confFile)
	xmlUnloadFile(confFile)
end

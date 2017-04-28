resourceRoot = getResourceRootElement(getThisResource())
infoTable = {}
Login_Edit = {}
marwinButtons = {}
sx,sy = guiGetScreenSize()
font = {}
scale = 1
setPlayerHudComponentVisible("area_name",false)
setPlayerHudComponentVisible("radar",false)
sound = playSound("dayzsoundtrack.mp3",true)
setSoundVolume(sound,0.5)

if sx < 1152 then
	scale = sx/1152
end

font[-1]= guiCreateFont( "font2.ttf", 8*scale )
font[0] = guiCreateFont( "font.ttf", 16*scale )
font[1] = guiCreateFont( "font.ttf", 18*scale )
font[2] = guiCreateFont( "font.ttf", 20*scale )
font[3] = guiCreateFont( "font.ttf", 24*scale )
font[4] = guiCreateFont( "font.ttf", 90*scale )

--Button
function createMarwinButton(x,y,widht,height,text,bool,parent,info)
	button = guiCreateStaticImage(x,y,widht,height,"images/button.png", bool,parent or nil)
	table.insert(marwinButtons,button)
	guiBringToFront(button)
	label = guiCreateLabel(0,0,1,1,text,bool,button)
	guiBringToFront(label)
	setElementData(label,"parent",button)
	setElementData(button,"info",info)
	guiSetFont(label,font[0])
	guiLabelSetVerticalAlign (label, "center")
	guiLabelSetHorizontalAlign (label, "center")
	addEventHandler("onClientMouseEnter",label,markButton,false)
	addEventHandler("onClientMouseLeave",label,unmarkButton,false)
	return label
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
	"[03/XX/17]\nVersion 0.9.9a is out!\n\n--- CHANGELOG ---\nMTA DayZ has gone open source!\nYou can get the newest version at our repository:\n\nhttps://github.com/mtadayz/MTADayZ"
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

function showLogin()
	guiSetInputMode("no_binds_when_editing")
	showCursor(true)
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
	else
		confFile = xmlCreateFile("@preferencesL.xml","user")
		xmlNodeSetAttribute(confFile,"username","")
		xmlNodeSetAttribute(confFile,"pass","")
		
		infoTable["account"] = getPlayerName(localPlayer)
		infoTable["pass"] = ""
	end
	xmlSaveFile(confFile)
	
	local number = math.random(1,5)
	
	background_front = guiCreateStaticImage(0.00, 0.00, 1, 1, "images/background_"..number..".png", true)
	background_news = guiCreateStaticImage(0.72, 0.20, 0.27, 0.70, "images/background_news.png", true, background_front)
	background_panel = guiCreateScrollPane(0.00, 0.00, 1.00, 1.00, true, background_news)
	background_news_label = guiCreateLabel(0.01, 0.01, 1, 0.1, "NEWS", true,background_panel)
	background_news_text = guiCreateLabel(0.01, 0.10, 1.00, 2.00, news[1],true,background_panel)
	background_contributors = guiCreateStaticImage(0.72, 0.92, 0.27, 0.05, "images/background_news.png", true, background_front)
	background_contributors_contri = guiCreateLabel(0.00, 0.00, 1.00, 0.50, "CONTRIBUTORS",true,background_contributors)
	background_contributors_label = guiCreateLabel(0.00, 0.50, 5.00, 0.50, "Loading contributors...",true,background_contributors)
	title_label = guiCreateLabel(0.29, 0.08, 0.43, 0.18, "MTA DayZ", true,background_front)
	version_label = guiCreateLabel(0.29, 0.22, 0.34, 0.13, "", true,background_front)
	login_label = guiCreateLabel(0.05, 0.64, 0.20, 0.05, "LOGIN", true,background_front)
	Login_Edit[1] = guiCreateEdit(0.05, 0.67, 0.25, 0.05, infoTable["account"], true,background_front)
	Login_Edit[2] = guiCreateEdit(0.31, 0.67, 0.25, 0.05, infoTable["pass"], true,background_front)
	register_label = guiCreateLabel(0.05, 0.79, 0.20, 0.05, "REGISTER", true,background_front)
	Login_Edit[3] = guiCreateEdit(0.05, 0.82, 0.25, 0.05, "", true,background_front)
	Login_Edit[4] = guiCreateEdit(0.31, 0.82, 0.25, 0.05, "", true,background_front)
	loginButton = createMarwinButton(0.59, 0.67, 0.11, 0.05, "Login", true, background_front, "login")
	registerButton = createMarwinButton(0.59, 0.82, 0.11, 0.05, "Register", true, background_front, "register")
	error_label = guiCreateLabel(0.05, 0.56, 0.50, 0.06, "", true, background_front)

	guiSetFont(login_label,font[0])
	guiSetFont(title_label,font[4])
	guiSetFont(version_label,font[3])
	guiSetFont(register_label,font[0])
	guiSetFont(error_label,font[1])
	guiSetAlpha(background_news,0.7)
	guiSetAlpha(background_contributors,0.7)
	guiLabelSetHorizontalAlign(background_news_text,"left",true)
	guiLabelSetHorizontalAlign(background_news_label,"center",true)
	guiLabelSetHorizontalAlign(background_contributors_contri,"center",true)
	--guiRadioButtonSetSelected(Login_Edit[5],true)
	guiEditSetMasked(Login_Edit[2],true)
	guiEditSetMasked(Login_Edit[4],true)
	if number == 2 or number == 5 then
		guiLabelSetColor(title_label,0,0,0)
		guiLabelSetColor(version_label,0,0,0)
	else
		guiLabelSetColor(title_label,255,255,255)
		guiLabelSetColor(version_label,255,255,255)
	end
end

--LOGIN
function clickPanelButton (button, state)
	if button == "left" and state == "up" then
	local element = getElementData(getLocalPlayer(),"clickedButton")
	if element then 
		local info = getElementData(element,"info")
		if info and info == "login" then
			local username = guiGetText(Login_Edit[1])
			local password = guiGetText(Login_Edit[2])
			if not (tostring(username) == "") and not (tostring(password) == "") then
				triggerServerEvent("onClientSendLoginDataToServer", getLocalPlayer(), username, password)
				stopSound(sound)
				setCameraTarget(localPlayer)
			else
				reason = "Missing Password or Username!"
				guiSetText(error_label,reason)
				setTimer(function() guiSetText(error_label,"") end,3000,1)
				return false
			end
		elseif info and info == "guest" then  
				return
		elseif info and info == "register" then  
				local username = guiGetText(Login_Edit[3])
				local pass = guiGetText(Login_Edit[4])
						
				if not (tostring(username) == "") then
					if not (tostring(pass) == "") then
						triggerServerEvent("onClientSendRegisterDataToServer", getLocalPlayer(), username, pass)
						stopSound(sound)
						setCameraTarget(localPlayer)
					else
						reason = "No password was entered!"
						guiSetText(error_label,reason)
						setTimer(function() guiSetText(error_label,"") end,3000,1)
						return false
					end
				else
					reason = "No username was entered!"
					guiSetText(error_label,reason)
					setTimer(function() guiSetText(error_label,"") end,3000,1)
					return false
				end	
			end
		end
	end
end
addEventHandler("onClientClick",getRootElement(),clickPanelButton)

addEvent("onErrorOutputReason",true)
function onErrorOutputReason(reason)
	if reason then
		guiSetText(error_label,reason)
		setTimer(function() guiSetText(error_label,"") end,3000,1)
	end
end
addEventHandler("onErrorOutputReason",root,onErrorOutputReason)

local xcntri,ycntri = 0.00,0.50
function startContributorsAnim()
	if xcntri < -4.00 then
		xcntri = 1.00
	end
	xcntri = xcntri-0.01
	guiSetPosition(background_contributors_label,xcntri,ycntri,true)
end

-- Load changelog
function loadAPIData(ele,data)
	if (ele == "changelog") then
		if (data ~= "ERROR") then
			guiSetText(background_news_text,data)
		end -- else keep offline news
	elseif (ele == "contributors") then
		local v = exports.DayZ:getDayZVersion()
		if v then
			guiSetText(version_label,"Version: "..v)
		else
			--guiSetText(version_label,"")
		end
		
		if (data ~= "ERROR") then
			local v = {fromJSON(data)}
			local contri = ""
			for i, all in ipairs(v) do
				contri = contri..all["login"].." ["..all["contributions"].." contributions]".." | "
			end
			guiSetText(background_contributors_label,contri)
			addEventHandler("onClientRender",root,startContributorsAnim)
		else
			guiSetText(background_contributors_label,"Can't load contributors list")
		end
	end
end
addEvent("loadAPIData",true)
addEventHandler("loadAPIData",root,loadAPIData)

--BUILD WINDOW ON RESOURCE START
addEventHandler("onClientResourceStart", resourceRoot, 
	function ()
		fadeCamera(false,2000,0,0,0)
		setCameraMatrix(6000,6000,2000)
		triggerServerEvent("pullChangelog",getLocalPlayer(),onlinenews)
		showLogin()
		guiSetInputMode("no_binds_when_editing")	
	end
)

--onPlayerDoneLogin
function hideLoginWindow(accountName, pass)
	guiSetVisible(background_front,false)
	showCursor(false)
	destroyElement(label)
	setElementData(getLocalPlayer(),"clickedButton",false)
	toggleSavePassword(accountName, pass)
	removeEventHandler("onClientRender",root,dayR)
	if(guiGetText(background_contributors_label) ~= "Can't load contributors list") then
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
local sourceX, sourceY = 1440, 900
local ft = dxCreateFont(":DayZ/fonts/28dayslater.ttf")
 
 local texts = { }
 
function dxDrawTextPerLetter ( text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, delay )
    if ( not texts [ text ] ) then
        texts [ text ] =
            {
                index = 1,
                lastUpdate = getTickCount ( )
            }
    end
    if ( texts [ text ] ) then
        dxDrawText ( text:sub ( 1, texts [ text ].index ), left, top, right, bottom, color or tocolor ( 255, 255, 255, 255 ), scale or 1, font or "default", alignX or "left", alignY or "top", clip, wordBreak, postGUI, colorCoded, subPixelPositioning )
        if ( getTickCount ( ) - texts [ text ].lastUpdate >= ( delay or 60 ) ) then
            texts [ text ].index = ( texts [ text ].index + 1 )
            texts [ text ].lastUpdate = getTickCount ( )
        end
    end
end
local rColor = {
{255,0,0},
{66,0,66},
{0,255,66},
{0,255,0},
{255,255,0},
{0,255,255},
{255,255,66}
}
local r,g,b = unpack(rColor[math.random(1,#rColor)])

function dayR( )
	if ft then
		dxDrawTextPerLetter ( "MTA DayZ", ( 40 / sourceX ) * sx, ( 850 / sourceY ) * sy, ( 187 / sourceX ) * sx, ( 324 / sourceY ) * sy, tocolor(r, g, b, 255), 2.00, ft, "left", "top", false, false, true, false, false,200 )
        dxDrawText( "MTA DayZ", ( 40 / sourceX ) * sx, ( 850 / sourceY ) * sy, ( 187 / sourceX ) * sx, ( 324 / sourceY ) * sy, tocolor(0, 0, 0, 150), 2.00, ft, "left", "top", false, false, true, false, false )
	end
end
--addEventHandler ( "onClientRender", root, dayR)
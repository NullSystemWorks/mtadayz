resourceRoot = getResourceRootElement( getThisResource( ) )
localPlayer = getLocalPlayer()
versionstring = "MTA:DayZ\nVersion: 0.8b\nLast Update: 30.05.15"
infoTable = {}
Login_Edit = {}
marwinButtons = {}
sx,sy = guiGetScreenSize()
font = {}
scale = 1

if sx < 1152 then
	scale = sx/1152
end
if sx < 1024 then
	outputChatBox("We highly recommend you to at least use 1024x768 as resolution!", 255, 0, 0)
end

font[-1] = guiCreateFont( "font2.ttf", 8*scale )
font[0] = guiCreateFont( "font.ttf", 14*scale )
font[1] = guiCreateFont( "font.ttf", 18*scale )
font[2] = guiCreateFont( "font.ttf", 20*scale )
font[3] = guiCreateFont( "font.ttf", 24*scale )

--Button
function createMarwinButton(x,y,widht,height,text,bool,parent,info)
	button = guiCreateStaticImage(x,y,widht,height,"images/button_standard.png", bool,parent or nil)
	table.insert(marwinButtons,button)
	guiBringToFront(button)
	label = guiCreateLabel(0,0,1,1,text,bool,button)
	guiBringToFront(label)
	setElementData(label,"parent",button)
	setElementData(button,"info",info)
	guiSetFont(label,font[1])
	guiLabelSetVerticalAlign (label, "center")
	guiLabelSetHorizontalAlign (label, "center")
	addEventHandler("onClientMouseEnter",label,markButton,false)
	addEventHandler("onClientMouseLeave",label,unmarkButton,false)
	return label
end

function markButton ()
	parent = getElementData(source,"parent")
	guiStaticImageLoadImage (parent,"images/button_mouse.png")
	setElementData(getLocalPlayer(),"clickedButton",parent)
	playSound("button.mp3")
end

function unmarkButton (b,s)
	parent = getElementData(source,"parent")
	guiStaticImageLoadImage (parent,"images/button_standard.png")
	setElementData(getLocalPlayer(),"clickedButton",false)
end
--Button end

function build_loginWin()
	guiSetInputMode("no_binds_when_editing")
	showCursor(true)
	--transfer old login data to new secure place
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
	--
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
	--is this even needed?
	--[[confFile = xmlLoadFile("@preferences.xml")
	if (confFile) then
		xmlNodeSetAttribute(confFile,"username","")
		xmlNodeSetAttribute(confFile,"pass","")
	end]]
	--Create Window
	--Background
		background_front = guiCreateStaticImage( 0.2, 0.25, 0.6, 0.5, "images/background_1.png", true )
		tab_front = guiCreateStaticImage( 0, 0, 1, 0.075, "images/tab.png", true ,background_front)
		--Header Text
			headline = guiCreateLabel(0,0.15,1,0.8,"MTA:DayZ I LOGIN PANEL",true,tab_front)
			guiSetFont(headline,font[2])
			guiLabelSetHorizontalAlign (headline, "center")
		--Version
			guestInfo = guiCreateLabel(0.025, 0.1, 0.325, 0.3,versionstring,true,background_front)
			guiSetFont(guestInfo,font[1])
			guiLabelSetHorizontalAlign (guestInfo, "center")
			guiLabelSetColor ( guestInfo,50,255,50)	
		--Login
			--login_box = guiCreateStaticImage( 0.025, 0.1, 0.325, 0.85, "images/box_background.png", true , background_front)
			loginButton = createMarwinButton(0.1,0.825,0.175,0.1,"Login",true,background_front,"login")
			--Text
			loginInfo = guiCreateLabel(0.025, 0.46, 0.325, 0.175,"Login!",true,background_front)
			guiSetFont(loginInfo,font[1])
			guiLabelSetHorizontalAlign (loginInfo, "center")
			guiLabelSetColor ( loginInfo,50,255,50)
				--Username
				username = guiCreateLabel(0.025, 0.55, 0.325, 0.04,"Username",true,background_front)
				guiSetFont(username,font[0])
				guiLabelSetHorizontalAlign (username, "center")
					--Edit Box
					Login_Edit[1] = guiCreateEdit(0.1, 0.6, 0.175, 0.055, infoTable["account"], true,background_front)
				--Password
				password = guiCreateLabel(0.025, 0.675, 0.325, 0.04,"Password",true,background_front)
				guiSetFont(password,font[0])
				guiLabelSetHorizontalAlign (password, "center")
				loginIcon = guiCreateStaticImage( 0.1, 0.46, 0.03, 0.05, "images/login_icon.png", true , background_front)
					--Edit Box
					Login_Edit[2] = guiCreateEdit(0.1, 0.725, 0.175, 0.055, infoTable["pass"], true,background_front)
					guiEditSetMasked(Login_Edit[2],true)
		--Register
			--register_box = guiCreateStaticImage( 0.375, 0.45, 0.325, 0.5, "images/box_background.png", true , background_front)
			registerButton = createMarwinButton(0.45,0.825,0.175,0.1,"Register",true,background_front,"register")
			--Text
			registerInfo = guiCreateLabel(0.375, 0.15, 0.325, 0.1,"Register!",true,background_front)
			guiSetFont(registerInfo,font[1])
			guiLabelSetHorizontalAlign (registerInfo, "center")
			guiLabelSetColor ( registerInfo,50,255,50)
				--Username
				username = guiCreateLabel(0.375, 0.25, 0.325, 0.04,"Username",true,background_front)
				guiSetFont(username,font[0])
				guiLabelSetHorizontalAlign (username, "center")
					--Edit Box
					Login_Edit[3] = guiCreateEdit(0.45, 0.3, 0.175, 0.055, "", true,background_front)
				--Password
				password = guiCreateLabel(0.375, 0.375, 0.325, 0.04,"Password",true,background_front)
				guiSetFont(password,font[0])
				guiLabelSetHorizontalAlign (password, "center")
				loginIcon = guiCreateStaticImage( 0.45, 0.15, 0.03, 0.05, "images/signup_icon.png", true , background_front)
					--Edit Box
					Login_Edit[4] = guiCreateEdit(0.45, 0.425, 0.175, 0.055, "", true,background_front)		
					guiEditSetMasked(Login_Edit[4],true)
				--Password #2
				password2 = guiCreateLabel(0.375, 0.5, 0.325, 0.04,"Repeat password",true,background_front)
				guiSetFont(password2,font[0])
				guiLabelSetHorizontalAlign (password2, "center")
					--Edit Box
					Login_Edit[5] = guiCreateEdit(0.45, 0.55, 0.175, 0.055, "", true,background_front)		
					guiEditSetMasked(Login_Edit[5],true)
				--Gender
				--malebutton = guiCreateRadioButton(0.46, 0.65, 0.15, 0.05, "Male", true, background_front)
				--femalebutton = guiCreateRadioButton(0.46, 0.71, 0.15, 0.05, "Female", true, background_front)
		--News/Updates
			--News Headline
				newsH = guiCreateLabel(0.726, 0.115, 0.25, 0.05,"News:",true,background_front)
				guiSetFont(newsH,font[0])
				guiLabelSetHorizontalAlign (newsH, "center")
				guiLabelSetColor ( newsH,50,255,50)
			--news_box1
			news_box1 = guiCreateStaticImage( 0.73, 0.16, 0.244, 0.2, "images/news.png", true , background_front)
			guiSetAlpha(news_box1,0.8)
			news1 = guiCreateLabel(0.025, 0.125, 1, 1,"-",true,news_box1)
			guiSetFont(news1,"default-bold-small")
			news_box1_new = guiCreateStaticImage( 0, 0, 0.15, 0.1, "images/new.png", true , news_box1)
			guiSetVisible(news_box1_new,false)
			--news_box2
			news_box2 = guiCreateStaticImage( 0.73, 0.36, 0.244, 0.2, "images/news.png", true , background_front)
			guiSetAlpha(news_box2,0.4)
			news2 = guiCreateLabel(0.025, 0.125, 1, 1,"-",true,news_box2)
			guiSetFont(news2,"default-bold-small")
			news_box2_new = guiCreateStaticImage( 0, 0, 0.15, 0.1, "images/new.png", true , news_box2)
			guiSetVisible(news_box2_new,false)
			--news_box3
			news_box3 = guiCreateStaticImage( 0.73, 0.56, 0.244, 0.2, "images/news.png", true , background_front)
			guiSetAlpha(news_box3,0.8)
			news3 = guiCreateLabel(0.025, 0.125, 1, 1,"-",true,news_box3)
			guiSetFont(news3,"default-bold-small")
			news_box3_new = guiCreateStaticImage( 0, 0, 0.15, 0.1, "images/new.png", true , news_box3)
			guiSetVisible(news_box3_new,false)
			--news_box4
			news_box4 = guiCreateStaticImage( 0.73, 0.76, 0.244, 0.19, "images/news.png", true , background_front)
			guiSetAlpha(news_box4,0.4)
			news4 = guiCreateLabel(0.025, 0.125, 1, 1,"-",true,news_box4)
			guiSetFont(news4,"default-bold-small")
			news_box4_new = guiCreateStaticImage( 0, 0, 0.15, 0.1, "images/new.png", true , news_box4)
			guiSetVisible(news_box4_new,false)
			--others
			news_box = guiCreateStaticImage( 0.726, 0.1, 0.25, 0.85, "images/box_background.png", true , background_front)
			guiCreateStaticImage(0.79, 0.114, 0.028, 0.045, "images/on.png", true , background_front)
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
			else
				reason = "Missing Password or Username!"
				outputChatBox("[LOGIN ERROR]#FF9900 "..reason,255,255,255,true)
			end
		elseif info and info == "guest" then  
				showLoginWindow(false)
		elseif info and info == "register" then  
				local username = guiGetText(Login_Edit[3])
				local pass1 = guiGetText(Login_Edit[4])
				local pass2 = guiGetText(Login_Edit[5])				
				if not (tostring(username) == "") then
					if not (tostring(pass1) == "") then
						if pass1 == pass2 then
							triggerServerEvent("onClientSendRegisterDataToServer", getLocalPlayer(), username, pass1)				
						else
							reason = "Passwords do not match!"
							outputChatBox("[REGISTRATION ERROR]#FF9900 "..reason,255,255,255,true)
						end
					else
						reason = "No password was entered!"
						outputChatBox("[REGISTRATION ERROR]#FF9900 "..reason,255,255,255,true)
					end
				else
					reason = "No username was entered!"
					outputChatBox("[REGISTRATION ERROR]#FF9900 "..reason,255,255,255,true)
				end	
			end
		end
	end
end
addEventHandler("onClientClick",getRootElement(),clickPanelButton)

function onClientGetNews(text1,text2,text3,text4,bool1,bool2,bool3,bool4)
	--workaround fix for line breaks
	local text1 = string.gsub(text1, "<br>", "\n")
	local text2 = string.gsub(text2, "<br>", "\n")
	local text3 = string.gsub(text3, "<br>", "\n")
	local text4 = string.gsub(text4, "<br>", "\n")
	guiSetText(news1,text1)
	guiSetText(news2,text2)
	guiSetText(news3,text3)
	guiSetText(news4,text4)
	guiSetVisible(news_box1_new,bool1 == "true" and true or false)
	guiSetVisible(news_box2_new,bool2 == "true" and true or false)
	guiSetVisible(news_box3_new,bool3 == "true" and true or false)
	guiSetVisible(news_box4_new,bool4 == "true" and true or false)
end
addEvent("onClientGetNews",true)
addEventHandler("onClientGetNews",getRootElement(),onClientGetNews)

--BUILD WINDOW ON RESOURCE START
addEventHandler("onClientResourceStart", resourceRoot, 
	function ()
		build_loginWin()
		guiSetVisible(background_front,false)
		showLoginWindow(true)
		guiSetInputMode("no_binds_when_editing")
		--playSound("winsound.mp3")
		fadeCamera (true) 
		setCameraMatrix(1468.8785400391, -919.25317382813, 100.153465271, 1468.388671875, -918.42474365234, 99.881813049316)
		triggerServerEvent("requestServerNews", localPlayer) 	
	end
)

--onPlayerDoneLogin
function hideLoginWindow(accountName, pass)
	showLoginWindow(false)
	toggleSavePassword(accountName, pass)
end
addEvent("onPlayerDoneLogin", true)
addEventHandler("onPlayerDoneLogin", getRootElement(), hideLoginWindow)

--toggle save password
function toggleSavePassword(name, pass)
	confFile = xmlLoadFile("@preferencesL.xml")
	xmlNodeSetAttribute(confFile, "username", name)
	xmlNodeSetAttribute(confFile, "pass", pass)
	xmlSaveFile(confFile)
end

function showLoginWindow(bool)
setElementData(getLocalPlayer(),"clickedButton",false)
	showCursor(bool)
	if bool then
		guiSetPosition(background_front,0.2, -0.75,true)
		addEventHandler("onClientRender",getRootElement(),rollLoginPanel)
		rollProgress = 1
		rollIn = true
		guiSetInputMode("no_binds_when_editing")
	else
		guiSetPosition(background_front,0.2, 0.25,true)
		addEventHandler("onClientRender",getRootElement(),rollLoginPanel)
		rollProgress = 0
		rollIn = false
		guiSetInputMode("allow_binds")
	end
	randomDirAnim = (math.random() > 0.5) and -1 or 1
	useXAxis = (math.random() > 0.5) and true or false
	animType = useXAxis and "InBounce" or "InElastic"
end

--rollIn = true

function rollLoginPanel ()
	local eval
	if rollIn then
		if rollProgress > 0 then
			rollProgress = ((rollProgress * 1000) - 15)/1000
			if rollProgress < 0 then rollProgress = 0 end
			eval = getEasingValue(rollProgress, animType)
		else
			removeEventHandler("onClientRender",getRootElement(),rollLoginPanel)
			return
		end
	else
		if rollProgress < 1 then
			rollProgress = ((rollProgress * 100) + 3)/100
			if rollProgress > 1 then rollProgress = 1 end
			eval = getEasingValue(rollProgress, "InQuad")
		else
			removeEventHandler("onClientRender",getRootElement(),rollLoginPanel)
			return
		end
	end
	if useXAxis then
		guiSetPosition(background_front,0.2,0.25+randomDirAnim*eval,true)	
	else
		guiSetPosition(background_front,0.2+randomDirAnim*eval,0.25,true)
	end
	guiSetVisible(background_front,true)
end

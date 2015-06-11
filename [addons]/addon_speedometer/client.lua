root = getRootElement()

-------------------------
-- Initialize Settings --
-------------------------
settingsObject = Settings:new(defaultSpeedometerSettings,"settings.xml")

local function s(setting,settingType)
	return settingsObject:get(setting,settingType)
end

---------------
-- Constants --
---------------

mile = 1.609344
fonts = {"default","default-bold","clear","arial","sans","pricedown","bankgothic","diploma","beckett"}

----------------------------
-- Vehicle Specific Settings
----------------------------

vehiclesXml = Xml:new("vehicles.xml","vehicles")
--vehicleSettings = {}

--[[
-- Reads the vehicles XML file and sets the settings for the given vehicle.
--
-- @param   vehicle   vehicle: The vehicle the player is currently in.
-- ]]
function updateVehicleSettings(vehicle)
	local model = getElementModel(vehicle)
	vehiclesXml:open()
	settingsObject:set("maxSpeed",tonumber(vehiclesXml:getAttribute({tag="vehicle",attribute={id=model}},"maxspeed")),"vehicle")
	settingsObject:set("scale",tonumber(vehiclesXml:getAttribute({tag="vehicle",attribute={id=model}},"scale")),"vehicle")
	settingsObject:set("fromAngle",tonumber(vehiclesXml:getAttribute({tag="vehicle",attribute={id=model}},"fromAngle")),"vehicle")
	settingsObject:set("addAngle",tonumber(vehiclesXml:getAttribute({tag="vehicle",attribute={id=model}},"addAngle")),"vehicle")
	vehiclesXml:unload()
end

----------
-- Info --
----------
g_showInfo = false
g_showInfoIntervall = 120
info = DrawInfo:new()

function showInfo()
	g_showInfo = true
end

--------------------------------
-- Initiate Clientside script --
--------------------------------

function initiate()
	settingsObject:loadFromXml()
	--loadSettings()
	bindKey("L","down",toggleVehicleLights)
	screenWidth, screenHeight = guiGetScreenSize()
	addEventHandler("onClientRender",root,draw)
	if s("showInfo") then
		setTimer(showInfo,g_showInfoIntervall * 1000,0)
	end
	
	-- Add methods to open the settings GUI
	showInfoText = ""
	if toggleSettingsGuiCommand ~= nil then
		showInfoText = "Enter /"..toggleSettingsGuiCommand.." in the chat"
		addCommandHandler(toggleSettingsGuiCommand,toggleGui)
	end
	if toggleSettingsGuiKey ~= nil then
		if showInfoText ~= "" then
			showInfoText = showInfoText.." or press "..toggleSettingsGuiKey
		else
			showInfoText = "Press "..toggleSettingsGuiKey
		end
		bindKey(toggleSettingsGuiKey,"down",toggleGui)
	end
	if showInfoText ~= "" then
		showInfoText = showInfoText.." to change settings"
	end
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),initiate)


-------------
-- Drawing --
-------------

--[[
-- Retrieves the given color from the settings and returns
-- it as hex color value.
--
-- @param   string   name: The name of the color (e.g. "font")
-- @param   float    fade (optional): This number is multiplied with the alpha
-- 			part of the color, to fade the element the color
-- 			is used with
-- @return  color   A color created with tocolor()
-- ]]
local function getColor(name,fade)
	if fade == nil then
		fade = 1
	end
	return tocolor(s(name.."ColorRed"),s(name.."ColorGreen"),s(name.."ColorBlue"),s(name.."ColorAlpha") * fade)
end

-- Stores the current reached maxspeed
local maxSpeedReached = 0
-- Saves the vehicle model the player is currently in
local currentVehicleModel = nil

--[[
-- Draws the basic speedometer and altimeter (numbers, needle, background, etc.).
-- ]]
draw = function()

	if not s("enabled") then
		return
	end



	-- Check if player is currently in a vehicle
	local vehicle = getVehicleFromPlayer(getLocalPlayer())
	if not vehicle then
		maxSpeedReached = 0
		return
	end

	local vehicleType = getVehicleType(vehicle)
	if s("altimeterEnabled") and (vehicleType == "Helicopter" or vehicleType == "Plane") then
		drawAltimeter(vehicle)
	end

	-- Check vehicle model (not vehicle element, since model can be changed while
	-- the element stays the same, e.g. in race)
	if getElementModel(vehicle) ~= currentVehicleModel then
		updateVehicleSettings(vehicle)
		currentVehicleModel = getElementModel(vehicle)
		-- With a new vehicle, the reached maxspeed may be way off, so reset it
		maxSpeedReached = 0
	end

	-- Initiate variables needed for drawing
	x0 = screenWidth * s("left")
	y0 = screenHeight * s("top")

	local settingType = nil
	if s("useVehicleSpecificSettings") then
		settingType = "vehicle"
	end

	local startingAngle = s("fromAngle",settingType)
	local maxAngle = s("addAngle",settingType)
	local linesEvery = s("scale",settingType)
	local mode = s("mode")
	local bgSize = s("backgroundSize")
	local size = screenWidth / 14 * s("size")
	local maxSpeed = s("maxSpeed",settingType)
	local fontSize = s("fontSize")
	local fontType = s("fontType")

	--local lineColor = tocolor(s("lineColorRed"),s("lineColorGreen"),s("lineColorBlue"),s("lineColorAlpha"))
	--local fontColor = tocolor(s("fontColorRed"),s("fontColorGreen"),s("fontColorBlue"),s("fontColorAlpha"))
	--local needleColor = tocolor(s("needleColorRed"),s("needleColorGreen"),s("needleColorBlue"),s("needleColorAlpha"))
	--local maxspeedColor = tocolor(s("maxspeedColorRed"),s("maxspeedColorGreen"),s("maxspeedColorBlue"),s("maxspeedColorAlpha"))
	--local backgroundColor = tocolor(s("backgroundColorRed"),s("backgroundColorGreen"),s("backgroundColorBlue"),s("backgroundColorAlpha"))
	local lineColor = getColor("line")
	local fontColor = getColor("font")
	local needleColor = getColor("needle")
	local maxspeedColor = getColor("maxspeed")
	local backgroundColor = getColor("background")
	--if s("style") == "night" then
	if getVehicleOverrideLights(vehicle) == 2 then
		lineColor = tocolor(s("lineColorNightRed"),s("lineColorNightGreen"),s("lineColorNightBlue"),s("lineColorNightAlpha"))
		fontColor = tocolor(s("fontColorNightRed"),s("fontColorNightGreen"),s("fontColorNightBlue"),s("fontColorNightAlpha"))
		needleColor = tocolor(s("needleColorNightRed"),s("needleColorNightGreen"),s("needleColorNightBlue"),s("needleColorNightAlpha"))
		maxspeedColor = tocolor(s("maxspeedColorNightRed"),s("maxspeedColorNightGreen"),s("maxspeedColorNightBlue"),s("maxspeedColorNightAlpha"))
		backgroundColor = tocolor(s("backgroundColorNightRed"),s("backgroundColorNightGreen"),s("backgroundColorNightBlue"),s("backgroundColorNightAlpha"))
	end

	-- Draw info if necessary
	info:draw()
	if g_showInfo and s("showInfo") then
		--local text = "Enter /speedometer in the chat to change settings."
		g_showInfo = false
		-- Draw directly below speedometer
		--
		local x = x0 - dxGetTextWidth(showInfoText) / 2
		local y = y0 + size * (bgSize + 0.2) / 2
		info:start(showInfoText,x,y,screenWidth)
	end
	
	-- Get vehicle's current speed
	local speedx, speedy, speedz = getElementVelocity(vehicle)
	
	-- Vehicle velocity couldnt be retrieved
	if not speedx then
		return
	end
	
	-- Calculate speed based on all three speed values
	local actualSpeed = (speedx^2 + speedy^2 + speedz^2)^(0.5) * 100

	dontDisplayMaxSpeedReached = false
	if actualSpeed > maxSpeedReached then
		maxSpeedReached = actualSpeed
		--dontDisplayMaxSpeedReached = true
	end
	
	-- Fill variables depending on current mode
	if mode == "kph" then
		actualSpeed = actualSpeed * mile
		maxSpeedReachedToDisplay = maxSpeedReached * mile
		--maxSpeed = getMaxspeedFromVehicleId(model)
	else
		actualSpeed = actualSpeed
		maxSpeedReachedToDisplay = maxSpeedReached
		maxSpeed = maxSpeed / mile
		linesEvery = linesEvery / 2
		
		
	end

	-- Round maxspeed to fit the scale (down if necessary) TODO: maybe round up instead of down?
	maxSpeed = maxSpeed - maxSpeed % linesEvery



	-- Speed shouldn't be higher than maxspeed
	if actualSpeed > maxSpeed then
		actualSpeed = maxSpeed
		if mode == "kph" then
			maxSpeedReached = maxSpeed / mile
		else
			maxSpeedReached = maxSpeed
		end
	end
	
	-- Draw background
	local width = size * bgSize
	local height = size * bgSize
	dxDrawImage(x0 - width / 2,y0 - height / 2,width,height,"bg.png",0,0,0,backgroundColor,false)
	dxDrawImage(x0 - width / 2,y0 - height / 2,width,height,"border.png",0,0,0,tocolor(0,0,0,200),false)
	local width = size * 0.18
	local height = size * 0.18
	dxDrawImage(x0 - width / 2,y0 - height / 2,width,height,"center.png",0,0,0,tocolor(0,0,0,180),false)
	

	-- Draw numbers
	for i=0,maxSpeed,linesEvery do
		local angle = startingAngle - (i * maxAngle) / maxSpeed
		local x = x0 + math.sin(math.rad(angle))*(size - size/7.5)
		local y = y0 + math.cos(math.rad(angle))*(size - size/7.5)
		--dxDrawText(tostring(i),x,y,x,y,tocolor(0,0,0,255),1.3,"default","center","center",false,false)
		dxDrawText(tostring(i),x,y,x,y,fontColor,fontSize*size/100,fontType,"center","center",false,false)
		
	end

	-- Draw lines
	for i=0,maxSpeed,linesEvery/2 do
		local angle = startingAngle - (i * maxAngle) / maxSpeed
		lineColor = lineColor
		lineColor2 = lineColor
		if i % linesEvery == 0 then
			local x1,y1 = calculateCoordinates(angle,size - size/60)
			local x2,y2 = calculateCoordinates(angle,size + size/15)
			dxDrawLine( x1, y1, x2, y2, lineColor,2)
		else
			local x1,y1 = calculateCoordinates(angle,size + size/60)
			local x2,y2 = calculateCoordinates(angle,size + size/15)
			dxDrawLine( x1, y1, x2, y2, lineColor2,1)
		end
	end

	-- Draw maximal speed reached
	if not dontDisplayMaxSpeedReached and s("showMaxSpeedReached") then
		local angle = startingAngle - (maxSpeedReachedToDisplay * maxAngle) / maxSpeed
		local x1,y1 = calculateCoordinates(angle,size - size/60)
		local x2,y2 = calculateCoordinates(angle,size + size/15)

		dxDrawLine( x1, y1, x2, y2, maxspeedColor,2)
	end

	-- Draw Odometer
	drawOdometer()
	

	-- Draw needle

	-- Calculate angle based on current speed
	
	local angle = startingAngle - (actualSpeed * maxAngle) / maxSpeed
	--local angle = startingAngle + (actualSpeed * (maxAngle - startingAngle)) / maxSpeed

	local x = x0 + math.sin(math.rad(angle))*size
	local y = y0 + math.cos(math.rad(angle))*size

	local x2,y2 = calculateCoordinates(angle,-size * 0.15)


	
	--dxDrawText("angle: "..tostring(round(angle)),10,500)
	dxDrawLine( x2, y2, x, y, needleColor,3)
end

--[[
-- Draws the altimeter.
--
-- @param   vehicle   vehicle: The vehicle the player is currently in
-- ]]
function drawAltimeter(vehicle)
	local bgSize = 2.3
	local startingAngle = 180
	local maxAngle = 360
	local size = screenWidth / 14 * s("altimeterSize")
	local linesEvery = 1

	local fontSize = s("altimeterFontSize")
	local fontType = s("altimeterFontType")

	local lineColor = tocolor(s("lineColorRed"),s("lineColorGreen"),s("lineColorBlue"),s("lineColorAlpha"))
	local fontColor = tocolor(s("fontColorRed"),s("fontColorGreen"),s("fontColorBlue"),s("fontColorAlpha"))
	local needleColor = tocolor(s("needleColorRed"),s("needleColorGreen"),s("needleColorBlue"),s("needleColorAlpha"))
	local backgroundColor = tocolor(0,0,0,s("backgroundColorAlpha"))
	if getVehicleOverrideLights(vehicle) == 2 then
		lineColor = tocolor(s("lineColorNightRed"),s("lineColorNightGreen"),s("lineColorNightBlue"),s("lineColorNightAlpha"))
		fontColor = tocolor(s("fontColorNightRed"),s("fontColorNightGreen"),s("fontColorNightBlue"),s("fontColorNightAlpha"))
		needleColor = tocolor(s("needleColorNightRed"),s("needleColorNightGreen"),s("needleColorNightBlue"),s("needleColorNightAlpha"))
		backgroundColor = tocolor(0,0,0,s("backgroundColorNightAlpha"))
	end

	-- Initiate variables needed for drawing
	x0 = screenWidth * s("altimeterLeft")
	y0 = screenHeight * s("altimeterTop")

	-- Draw background
	local width = size * bgSize
	local height = size * bgSize
	dxDrawImage(x0 - width / 2,y0 - height / 2,width,height,"bg.png",0,0,0,backgroundColor,false)
	dxDrawImage(x0 - width / 2,y0 - height / 2,width,height,"border.png",0,0,0,tocolor(0,0,0,200),false)
	

	-- Draw numbers
	for i=0,9,linesEvery do
		local angle = startingAngle - (i * maxAngle) / 10
		local x = x0 + math.sin(math.rad(angle))*(size - size/5.7)
		local y = y0 + math.cos(math.rad(angle))*(size - size/5.7)
		--dxDrawText(tostring(i),x,y,x,y,tocolor(0,0,0,255),1.3,"default","center","center",false,false)
		dxDrawText(tostring(i),x,y,x,y,fontColor,fontSize*size/100,fontType,"center","center",false,false)
		
	end

	-- Draw lines
	for i=0,100,2 do
		local angle = startingAngle - (i * maxAngle) / 100
		lineColor = lineColor
		lineColor2 = lineColor
		if i % 10 == 0 then
			local x1,y1 = calculateCoordinates(angle,size - size/35)
			local x2,y2 = calculateCoordinates(angle,size + size/8.75)
			dxDrawLine( x1, y1, x2, y2, lineColor,2)
		else
			local x1,y1 = calculateCoordinates(angle,size + size/35)
			local x2,y2 = calculateCoordinates(angle,size + size/8.75)
			dxDrawLine( x1, y1, x2, y2, lineColor2,1)
		end
	end

	-- Draw needle
	-- Calculate angle based on current speed
	local _,_,height = getElementPosition(vehicle)
	
	local angle = startingAngle - (height / 100 * maxAngle) / 10

	local x,y = calculateCoordinates(angle,size / 2)
	local x2,y2 = calculateCoordinates(angle,-10)
	dxDrawLine( x2, y2, x, y, needleColor,3)

	-- Draw needle
	-- Calculate angle based on current speed
	local angle = startingAngle - (height / 10 * maxAngle) / 10

	local x,y = calculateCoordinates(angle,size)
	local x2,y2 = calculateCoordinates(angle,-10)
	dxDrawLine( x2, y2, x, y, needleColor,3)
end

--[[
-- Calculates the coordinates on the screen based on the center position of the
-- speedometer, the angle and the distance to the center.
--
-- @param   int   angle: The angle
-- @param   int   size: The distance in pixels from the center
-- ]]
function calculateCoordinates(angle,size)
	local x = x0 + math.sin(math.rad(angle))*size
	local y = y0 + math.cos(math.rad(angle))*size
	return x,y
end


------------------
-- Settings Gui --
------------------

local gui = {}

local function handleEdit(element)
	for k,v in pairs(gui) do
		if element == v and settingsObject.settings.default[k] ~= nil then
			if type(settingsObject.settings.main[k]) == "boolean" then
				settingsObject:set(k,guiCheckBoxGetSelected(element))
			else
				settingsObject:set(k,guiGetText(element))
			end
		end
	end
end

local function handleClick()

	handleEdit(source)

	if source == gui.buttonSave then
		settingsObject:saveToXml()
		odometerSettings:saveToXml()
	end
	if source == gui.buttonClose then
		closeGui()
	end
end

local function addColor(color,name,top)
	guiCreateLabel(24,top,80,20,name..":",false,gui.tabStyles)
	local defaultButton = {}
	gui[color.."Red"] = guiCreateEdit(120,top,50,20,tostring(s(color.."Red")),false,gui.tabStyles)
	table.insert(defaultButton,{mode="set",edit=gui[color.."Red"],value=s(color.."Red","default")})
	gui[color.."Green"] = guiCreateEdit(175,top,50,20,tostring(s(color.."Green")),false,gui.tabStyles)
	table.insert(defaultButton,{mode="set",edit=gui[color.."Green"],value=s(color.."Green","default")})
	gui[color.."Blue"] = guiCreateEdit(230,top,50,20,tostring(s(color.."Blue")),false,gui.tabStyles)
	table.insert(defaultButton,{mode="set",edit=gui[color.."Blue"],value=s(color.."Blue","default")})
	gui[color.."Alpha"] = guiCreateEdit(285,top,50,20,tostring(s(color.."Alpha")),false,gui.tabStyles)
	table.insert(defaultButton,{mode="set",edit=gui[color.."Alpha"],value=s(color.."Alpha","default")})
	addEditButton(350,top,50,20,"default",false,gui.tabStyles,unpack(defaultButton))
end

--[[
-- Creates the GUI if it isn't already.
-- ]]
function createGui()
	if gui.window ~= nil then
		return
	end

	gui.window = guiCreateWindow ( 320, 240, 500, 560, "Speedometer settings", false )

	-- Create Tabs
	gui.tabs = guiCreateTabPanel(0,24,500,400,false,gui.window)
	gui.tabGeneral = guiCreateTab("General",gui.tabs)
	addHelp("General settings for the speedometer.",gui.tabGeneral)
	gui.tabStyles = guiCreateTab("Styles",gui.tabs)
	addHelp("Styling settings that affect both the speedometer and the altimeter. You can change between those styles by turning your vehicle lights on/off (using 'L').",gui.tabStyles)
	gui.tabAltimeter = guiCreateTab("Altimeter",gui.tabs)
	addHelp(gui.tabAltimeter,"Settings for the altimeter.")
	gui.tabOdometer = guiCreateTab("Odometer",gui.tabs)

	-- Tab: Odometer
	createOdometerGui(gui.tabOdometer)

	-- Tab: General
	gui.enabled = guiCreateCheckBox(24,20,140,20,"Enable Speedometer",s("enabled"),false,gui.tabGeneral)
	addHelp(gui.enabled,"Shows or hides the Speedometer")
	gui.showMaxSpeedReached = guiCreateCheckBox(200,20,200,20,"Show maximum speed reached",s("showMaxSpeedReached"),false,gui.tabGeneral)
	addHelp("If enabled, shows a colored line on the speedometer, representing the maximum speed reached. (You can change the color in the 'Styles'-Tab.)",gui.showMaxSpeedReached)

	local label = guiCreateLabel(24,50,70,20,"Size:",false,gui.tabGeneral)
	gui.size = guiCreateEdit(100,50,80,20,tostring(s("size")),false,gui.tabGeneral)
	addHelp("The size of the speedometer (relative to screen resolution).",gui.size,label)
	addEditButton(190,50,60,20,"smaller",false,gui.tabGeneral,{mode="add",edit=gui.size,add=-0.1})
	addEditButton(260,50,60,20,"bigger",false,gui.tabGeneral,{mode="add",edit=gui.size,add=0.1})
	addEditButton(330,50,60,20,"default",false,gui.tabGeneral,{mode="set",edit=gui.size,value=s("size","default")})

	local label = guiCreateLabel(24,80,80,20,"Font size:",false,gui.tabGeneral)
	gui.fontSize = guiCreateEdit(100,80,80,20,tostring(s("fontSize")),false,gui.tabGeneral)
	addHelp("The size of the numbers on the speedometer. This font size is also scaled based on the size of the speedometer.",gui.fontSize,label)
	addEditButton(190,80,60,20,"smaller",false,gui.tabGeneral,{mode="add",edit=gui.fontSize,add=-0.1})
	addEditButton(260,80,60,20,"bigger",false,gui.tabGeneral,{mode="add",edit=gui.fontSize,add=0.1})
	addEditButton(330,80,60,20,"default",false,gui.tabGeneral,{mode="set",edit=gui.fontSize,value=s("fontSize","default")})

	local label = guiCreateLabel(24,110,80,20,"Font type:",false,gui.tabGeneral)
	gui.fontType = guiCreateEdit(100,110,80,20,tostring(s("fontType")),false,gui.tabGeneral)
	addHelp("Switch between the available font types.",gui.fontType,label)
	addEditButton(190,110,60,20,"<--",false,gui.tabGeneral,{mode="cyclebackwards",edit=gui.fontType,values=fonts})
	addEditButton(260,110,60,20,"-->",false,gui.tabGeneral,{mode="cycle",edit=gui.fontType,values=fonts})
	addEditButton(330,110,60,20,"default",false,gui.tabGeneral,{mode="set",edit=gui.fontType,value=s("fontType","default")})

	guiCreateLabel(24, 140, 60, 20, "Position:", false, gui.tabGeneral )

	local label = guiCreateLabel(100, 140, 40, 20, "Top:", false, gui.tabGeneral )
	gui.top = guiCreateEdit( 140, 140, 60, 20, tostring(s("top")), false, gui.tabGeneral )
	addHelp("The relative position of the speedometer from the top border of the screen. For example 0.5 means the speedometer is positioned in the middle of the screen.",gui.top,label)

	addEditButton(258, 140, 40, 20, "up", false, gui.tabGeneral, {mode="add",edit=gui.top,add=-0.01})
	addEditButton(258, 166, 40, 20, "down", false, gui.tabGeneral, {mode="add",edit=gui.top,add=0.01})
	
	local label = guiCreateLabel(100, 166, 40, 20, "Left:", false, gui.tabGeneral )
	gui.left = guiCreateEdit( 140, 166, 60, 20, tostring(s("left")), false, gui.tabGeneral )
	addHelp("The relative position of the speedometer from the left border of the screen. For example 0.5 means the speedometer is positioned in the middle of the screen.",gui.left,label)
	addEditButton(210, 166, 40, 20, "left", false, gui.tabGeneral, {mode="add",edit=gui.left,add=-0.01})
	addEditButton( 306, 166, 40, 20, "right", false, gui.tabGeneral, {mode="add",edit=gui.left,add=0.01})
	
	addEditButton(360, 166, 50, 20, "default", false, gui.tabGeneral,
		{mode="set",edit=gui.top,value=s("top","default")},
		{mode="set",edit=gui.left,value=s("left","default")}
	)



	guiCreateLabel(24,200,60,20,"Mode:",false,gui.tabGeneral)
	gui.mode = guiCreateEdit( 100, 200,80,20,tostring(s("mode")),false,gui.tabGeneral)
	local button1 = addEditButton(190,200,80,20,"toggle Mode",false,gui.tabGeneral,{mode="cycle",edit=gui.mode,values={"kph","mph"}})
	addHelp("Changes the display of the speedometer between kph (km/h) or mph (and if enabled the odometer between km and miles).",gui.mode,button1)

	gui.useVehicleSpecificSettings = guiCreateCheckBox(24,230,180,20,"Use vehicle specific settings",s("useVehicleSpecificSettings"),false,gui.tabGeneral)
	addHelp("Replaces the following two settings by settings specific to the vehicle you are currently in. This means e.g. a slow vehicle can have a lower maxspeed on the speedometer. If you want to have the same speedometer scale (e.g. 0,20,30,..280), deactivate this option.",gui.useVehicleSpecificSettings)

	local label = guiCreateLabel(24,260,180,20,"Maxspeed:",false,gui.tabGeneral)
	gui.maxSpeed = guiCreateEdit(100,260,50,20,tostring(s("maxSpeed")),false,gui.tabGeneral)
	addHelp("The maximum speed (greatest number on the scale) shown on the speedometer. Please note that this number is rounded to fit the scale.",gui.maxSpeed,label)
	addEditButton(160,260,50,20,"default",false,gui.tabGeneral,{mode="set",edit=gui.maxSpeed,value=s("maxSpeed","default")})

	local label = guiCreateLabel(240,260,180,20,"Speed scale:",false,gui.tabGeneral)
	gui.scale = guiCreateEdit(320,260,50,20,tostring(s("scale")),false,gui.tabGeneral)
	addHelp("Show digits on the speedometer every x numbers. For example '20' would mean the numbers 0,20,40,60,.. would be displayed.",gui.scale,label)
	addEditButton(380,260,50,20,"default",false,gui.tabGeneral,{mode="set",edit=gui.scale,value=s("scale","default")})

	
	-- Tab: Styles
	local label = guiCreateLabel(24,20,100,20,"Day Style",false,gui.tabStyles)
	guiLabelSetColor(label,255,0,0)
	guiSetFont(label,"default-bold-small")



	guiCreateLabel(125,40,40,20,"Red",false,gui.tabStyles)
	guiCreateLabel(180,40,40,20,"Green",false,gui.tabStyles)
	guiCreateLabel(235,40,40,20,"Blue",false,gui.tabStyles)
	guiCreateLabel(285,40,40,20,"Alpha",false,gui.tabStyles)

	addColor("lineColor","Line Color",60)
	addColor("fontColor","Font Color",84)
	addColor("needleColor","Needle Color",108)
	addColor("maxspeedColor","Maxspeed",132)
	addColor("backgroundColor","Background",156)

	local label = guiCreateLabel(24,200,100,20,"Night Style",false,gui.tabStyles)
	guiLabelSetColor(label,128,128,255)
	guiSetFont(label,"default-bold-small")

	guiCreateLabel(125,220,40,20,"Red",false,gui.tabStyles)
	guiCreateLabel(180,220,40,20,"Green",false,gui.tabStyles)
	guiCreateLabel(235,220,40,20,"Blue",false,gui.tabStyles)
	guiCreateLabel(285,220,40,20,"Alpha",false,gui.tabStyles)

	addColor("lineColorNight","Line Color",240)
	addColor("fontColorNight","Font Color",264)
	addColor("needleColorNight","Needle Color",288)
	addColor("maxspeedColorNight","Maxspeed",312)
	addColor("backgroundColorNight","Background",336)


	-- Tab: Altimeter
	gui.altimeterEnabled = guiCreateCheckBox(24,20,300,20,"Enable Altimeter for Planes and Helicopters",s("altimeterEnabled"),false,gui.tabAltimeter)
	addHelp(gui.enabled,"Shows or hides the Altimeter for planes and helicopters.")

	guiCreateLabel(24,50,70,20,"Size:",false,gui.tabAltimeter)
	gui.altimeterSize = guiCreateEdit(100,50,80,20,tostring(s("altimeterSize")),false,gui.tabAltimeter)
	addHelp("The relative size of the altimeter.",gui.altimeterSize)
	addEditButton(190,50,60,20,"smaller",false,gui.tabAltimeter,{mode="add",edit=gui.altimeterSize,add=-0.1})
	addEditButton(260,50,60,20,"bigger",false,gui.tabAltimeter,{mode="add",edit=gui.altimeterSize,add=0.1})
	addEditButton(330,50,60,20,"default",false,gui.tabAltimeter,{mode="set",edit=gui.altimeterSize,value=s("altimeterSize","default")})

	local label = guiCreateLabel(24,80,80,20,"Font size:",false,gui.tabAltimeter)
	gui.altimeterFontSize = guiCreateEdit(100,80,80,20,tostring(s("altimeterFontSize")),false,gui.tabAltimeter)
	addHelp("The size of the numbers on the altimeter. This font size is also scaled based on the size of the altimeter.",gui.altimeterFontSize,label)
	addEditButton(190,80,60,20,"smaller",false,gui.tabAltimeter,{mode="add",edit=gui.altimeterFontSize,add=-0.1})
	addEditButton(260,80,60,20,"bigger",false,gui.tabAltimeter,{mode="add",edit=gui.altimeterFontSize,add=0.1})
	addEditButton(330,80,60,20,"default",false,gui.tabAltimeter,{mode="set",edit=gui.altimeterFontSize,value=s("altimeterFontSize","default")})

	local label = guiCreateLabel(24,110,80,20,"Font type:",false,gui.tabAltimeter)
	gui.altimeterFontType = guiCreateEdit(100,110,80,20,tostring(s("altimeterFontType")),false,gui.tabAltimeter)
	addHelp("Switch between the available font types.",gui.altimeterFontType,label)
	addEditButton(190,110,60,20,"<--",false,gui.tabAltimeter,{mode="cyclebackwards",edit=gui.altimeterFontType,values=fonts})
	addEditButton(260,110,60,20,"-->",false,gui.tabAltimeter,{mode="cycle",edit=gui.altimeterFontType,values=fonts})
	addEditButton(330,110,60,20,"default",false,gui.tabAltimeter,{mode="set",edit=gui.fontType,value=s("altimeterFontType","default")})

	guiCreateLabel(24, 140, 60, 20, "Position:", false, gui.tabAltimeter )

	local label = guiCreateLabel(100, 140, 40, 20, "Top:", false, gui.tabAltimeter )
	gui.altimeterTop = guiCreateEdit( 140, 140, 60, 20, tostring(s("altimeterTop")), false, gui.tabAltimeter )
	addHelp("The relative position of the altimeter from the top border of the screen. For example 0.5 means the altimeter is positioned in the middle of the screen.",gui.altimeterTop,label)

	addEditButton(258, 140, 40, 20, "up", false, gui.tabAltimeter, {mode="add",edit=gui.altimeterTop,add=-0.01})
	addEditButton(258, 166, 40, 20, "down", false, gui.tabAltimeter, {mode="add",edit=gui.altimeterTop,add=0.01})
	
	local label = guiCreateLabel(100, 166, 40, 20, "Left:", false, gui.tabAltimeter )
	gui.altimeterLeft = guiCreateEdit( 140, 166, 60, 20, tostring(s("altimeterLeft")), false, gui.tabAltimeter )
	addHelp("The relative position of the altimeter from the left border of the screen. For example 0.5 means the altimeter is positioned in the middle of the screen.",gui.altimeterLeft,label)
	addEditButton(210, 166, 40, 20, "left", false, gui.tabAltimeter, {mode="add",edit=gui.altimeterLeft,add=-0.01})
	addEditButton( 306, 166, 40, 20, "right", false, gui.tabAltimeter, {mode="add",edit=gui.altimeterLeft,add=0.01})
	
	addEditButton(360, 166, 50, 20, "default", false, gui.tabAltimeter,
		{mode="set",edit=gui.altimeterTop,value=s("altimeterTop","default")},
		{mode="set",edit=gui.altimeterLeft,value=s("altimeterLeft","default")}
	)


	-- Always visible
	gui.helpMemo = guiCreateMemo(0,440,500,80,"Move your mouse over a GUI Element to get help (if available).",false,gui.window)
	guiHelpMemo = gui.helpMemo

	gui.buttonSave = guiCreateButton( 160, 530, 50, 20, "Save", false, gui.window )
	addHelp("Saves the settings on your local computer in an XML file. This means that they will be saved even if you leave this server.",gui.buttonSave)
	gui.buttonClose = guiCreateButton( 240, 530, 50, 20, "Close", false, gui.window )
	addHelp("Closes without saving the settings to file. You changes will stay until you leave this server.",gui.buttonClose)

	addEventHandler("onClientGUIClick",gui.window,handleClick)
	addEventHandler("onClientGUIChanged",gui.window,handleEdit)
	addEventHandler("onClientMouseEnter",gui.window,handleHelp)
end


--[[
-- Opens the GUI and also creates it if necessary.
-- ]]
function openGui()
	createGui()
	
	guiSetVisible(gui.window,true)
	showCursor(true)

	-- When GUI is opened, remove the info under the speedometer permanently
	settingsObject:set("showInfo",false)
	--changeSetting("showInfo",false)
	settingsObject:saveToXml("showInfo")
	--saveSettings("showInfo")
end

--[[
-- Closes the GUI
-- ]]
function closeGui()
	guiSetVisible(gui.window,false)
	showCursor(false)
end

--[[
-- Shows/hides the GUI depending on the current state.
-- ]]
function toggleGui()
	if guiGetVisible(gui.window) then
		closeGui()
	else
		openGui()
	end
end

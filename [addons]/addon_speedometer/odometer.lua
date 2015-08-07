root = getRootElement()

-----------------------
-- Initiate Settings --
-----------------------

odometerSettings = Settings:new(defaultOdometerSettings,"odometer_settings.xml")

local s = function(setting,settingType)
	return odometerSettings:get(setting,settingType)
end

---------------
-- Constants --
---------------

fonts = {"default","default-bold","clear","arial","sans","pricedown","bankgothic","diploma","beckett"}
styles = {"analog","digital"}
local digitTypeNormal = 0
local digitTypeTripHundred = 1

-----------------------
-- Distance Settings --
-----------------------
distance = Settings:new({totalDistance=0,tripDistance=0},"distance.xml")

function saveDistance()
	distance:saveToXml()
end

-----------------------
-- Initiate Odometer --
-----------------------

local timerIntervall = 50

function initiateOdometer()
	--loadSettings()
	odometerSettings:loadFromXml()
	distance:loadFromXml()
	screenWidth, screenHeight = guiGetScreenSize()
	--addEventHandler("onClientRender",root,draw)
	setTimer(calculateDistance,timerIntervall,0)
	setTimer(saveDistance,10000,0)
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),initiateOdometer)

-------------
-- Drawing --
-------------

--[[
-- This draws both odometers if the player is in a vehicle.
-- This function is called from the speedometer script's onClientRender handler.
-- ]]
function drawOdometer()
	if not getVehicleFromPlayer(getLocalPlayer()) then
		return
	end
	prepareDrawOdometer("trip")
	prepareDrawOdometer("total")
end

--[[
-- Draw a single digit
--
-- @param   int    x: The x coordinate
-- @param   int    y: The y coordinate
-- @param   float  number: Which number to draw, if in between two digits
-- 				this will be a floating point number
-- @param   int    numberType: If it is the hunderd-meter digit of the trip
-- 				counter or not
-- @param   float  padding: The horizontal distance to the left or right border
-- ]]
function drawOdometerDigit(x,y,number,numberType,padding)
	local bottomNumber = math.ceil(number)
	if bottomNumber > 9 then bottomNumber = 0 end
	local topNumber = math.floor(number)

	local state = number - topNumber

	local topBottom = y+fontHeight - fontHeight * state
	local bottomTop = y+fontHeight - fontHeight * state
	
	local backgroundColor = tocolor(
				s("digitBackgroundColorRed"),
				s("digitBackgroundColorGreen"),
				s("digitBackgroundColorBlue"),
				s("digitBackgroundColorAlpha"))
	local fontColor = tocolor(
				s("fontColorRed"),
				s("fontColorGreen"),
				s("fontColorBlue"),
				s("fontColorAlpha"))
	if numberType == digitTypeTripHundred then
		
		backgroundColor = tocolor(
				s("digitBackgroundColor2Red"),
				s("digitBackgroundColor2Green"),
				s("digitBackgroundColor2Blue"),
				s("digitBackgroundColor2Alpha"))
		fontColor = tocolor(
				s("fontColor2Red"),
				s("fontColor2Green"),
				s("fontColor2Blue"),
				s("fontColor2Alpha"))
	end
	local fontScale = screenWidth / 1200 * s("scale")


	--dxDrawRectangle( x-1, y-1, textWidth * padding + 2, fontHeight + 2, tocolor(255,255,255,100))
	dxDrawRectangle( x, y, textWidth * padding, fontHeight, backgroundColor)
	
	dxDrawText( tostring(topNumber), x, y, x+textWidth*padding, topBottom, fontColor,fontScale,s("font"),"center","bottom",true,false,false)
	dxDrawText( tostring(bottomNumber), x, bottomTop, x+textWidth*padding, y+fontHeight, fontColor,fontScale,s("font"),"center","top",true,false,false)
end

--[[
-- Calculates the single digits and draws them, as well
-- as the background.
--
-- @param   string   odometerType: Whether its the trip or total-odometer
-- ]]
function prepareDrawOdometer(odometerType)
	local number = 0
	local numberOfDigits = 0
	local left = 0
	local top = 0
	if odometerType == "trip" then
		if not s("tripEnabled") then
			return false
		end
		number = distance:get("tripDistance") / 100
		left = s("tripLeft")
		top = s("tripTop")
		numberOfDigits = s("tripNumberOfDigits")
	elseif odometerType == "total" then
		if not s("totalEnabled") then
			return false
		end
		number = distance:get("totalDistance") / 100
		left = s("totalLeft")
		top = s("totalTop")
		numberOfDigits = s("totalNumberOfDigits")
	else
		return false
	end
	-- Convert distance into miles (for display only) if speedometer is set to that
	if settingsObject:get("mode") == "mph" then
		number = number / mile
	end

	local style = s("style")

	-- starting position
	local posX = screenWidth * left
	local posY = screenHeight * top

	-- settings
	local digitPadding = s("digitPadding")
	local spaceBetweenDigits = s("spaceBetweenDigits")
	local backgroundColor = tocolor(s("backgroundColorRed"),s("backgroundColorGreen"),s("backgroundColorBlue"),s("backgroundColorAlpha"))

	local fontScale = screenWidth / 1200 * s("scale")

	if style == "analog" then	
	-- get font properties
		fontHeight = dxGetFontHeight(fontScale,s("font"))
		textWidth = dxGetTextWidth("0",fontScale,s("font"))
	else
		fontHeight = dxGetFontHeight(fontScale,s("font"))
		fontWidth = dxGetTextWidth(string.rep("0",numberOfDigits),s("font"))
	end

	-- calculate stuff from properties and settings
	local digitWidth = textWidth * digitPadding
	--local spaceBetweenDigitsAbsolute = digitWidth * (spaceBetweenDigits)
	local spaceBetweenDigitsAbsolute = 2

	
	local backgroundPaddingHorizontal = s("backgroundPaddingHorizontal")
	local backgroundPaddingVertical = s("backgroundPaddingVertical")
	local backgroundWidth = numberOfDigits * (digitWidth + spaceBetweenDigitsAbsolute) + backgroundPaddingHorizontal*2 - spaceBetweenDigitsAbsolute

	-- Draw background
	if s("positionFrom") == "center" then
		posX = posX - backgroundWidth / 2
	elseif s("positionFrom") == "right" then
		posX = posX - backgroundWidth
	end
	dxDrawRectangle( posX, posY, backgroundWidth, fontHeight + backgroundPaddingVertical*2, backgroundColor )
	
	if s("style") == "analog" then

		if odometerType == "total" then
			numberOfDigits = numberOfDigits + 1
		end
	
		-- Calculate single digits
		for i = 1, numberOfDigits, 1 do
		
			local numberToDraw = number % (10^i)
			if i > 1 then
				numberToDraw = numberToDraw / (10^(i - 1))
				if numberToDraw % 1 < tonumber("0."..string.rep("9",i - 1)) then
					numberToDraw = math.floor(numberToDraw)
				else
					numberToDraw = math.floor(numberToDraw) + (numberToDraw * 10^(i-1)) % 1
				end
			end
			local digitType = digitTypeNormal
			if i == 1 and odometerType == "trip" then
				digitType = digitTypeTripHundred
			end
			if odometerType == "trip" or i > 1 then
				-- Draw single digit
				drawOdometerDigit(posX + backgroundPaddingHorizontal + (numberOfDigits - i)*(digitWidth + (spaceBetweenDigitsAbsolute)),posY + backgroundPaddingVertical,numberToDraw,digitType,digitPadding)
			end
			--[[
			if odometerType == "trip" then
				drawDigit(posX + backgroundPaddingLeftRight + (numberOfDigits - i)*(digitWidth + (spaceBetweenDigitsAbsolute)),posY,numberToDraw,digitType,digitPadding)
			elseif i > 1 then
				drawDigit(posX + backgroundPaddingLeftRight + (numberOfDigits - i)*(digitWidth + (spaceBetweenDigitsAbsolute)),posY,numberToDraw,digitType,digitPadding)
			end]]
		end

	else
		dxDrawText(tostring(round(number)),posX,posY)
	end
	
end



----------------------------------
-- Calculate Distance Travelled --
----------------------------------

local prevX, prevY, prevZ = 0
local maxDistance = 1000 / (1000 / timerIntervall)


--[[
-- Add up the distance travelled in the intervall specified.
-- ]]
function calculateDistance()
	local vehicle = getVehicleFromPlayer(getLocalPlayer())

	-- dont save anything if..
	-- # player..
	--    is dead
	--    is not in a vehicle
	--    is in a frozen vehicle
	--    cannot move forward
	if isLocalPlayerDead or not vehicle or isElementFrozen(vehicle) or not isControlEnabled("forwards") then
		return
	end

	-- only after all that, count any distance
	local x,y,z = getElementPosition(vehicle)
	if prevX ~= 0 then
		local distanceSinceLast = ((x-prevX)^2 + (y-prevY)^2 + (z-prevZ)^2)^(0.5)

		-- Only save if distance is small enough to have been achieved by legal means
		if distanceSinceLast < maxDistance then
			distance:set("totalDistance",distance:get("totalDistance") + distanceSinceLast) 
			distance:set("tripDistance",distance:get("tripDistance") + distanceSinceLast)
			--s("totalDistance") = s("totalDistance") + distance
			--s("tripDistance") = s("tripDistance") + distance
		end
	end
	prevX = x
	prevY = y
	prevZ = z
end

--[[
-- Help function which retrieves the vehicle the player is in,
-- but only if he is the controller of the vehicle.
--
-- @param   player   player: The player to get the vehicle from
-- ]]
function getVehicleFromPlayer(player)
	local vehicles = getElementsByType("vehicle")
	for k,v in ipairs(vehicles) do
		if player == getVehicleController(v) then
			return v
		end
	end
	return false
end

------------------
-- Settings Gui --
------------------

local gui = {}

local function handleEdit(element)
	for k,v in pairs(gui) do
		if element == v and odometerSettings.settings.default[k] ~= nil then
			if type(odometerSettings.settings.default[k]) == "boolean" then
				odometerSettings:set(k,guiCheckBoxGetSelected(element))
				--changeSetting(k,guiCheckBoxGetSelected(element))
			else
				odometerSettings:set(k,guiGetText(element))
				--changeSetting(k,guiGetText(element))
			end
		end
	end
end

local function handleClick()
	
	handleEdit(source)
	if source == gui.buttonTripTopLeftDefault then
		guiSetText(gui.tripLeft,defaultOdometerSettings.tripLeft)
		guiSetText(gui.tripTop,defaultOdometerSettings.tripTop)
	end

	if source == gui.buttonSave then
		saveSettings()
	end
	if source == gui.buttonResetTripOdometer then
		distance:set("tripDistance",0)
		--settings.tripDistance = 0
	end
	if source == gui.buttonClose then
		closeGui()
	end
end

local function addColor(color,name,top)
	guiCreateLabel(24,top,80,20,name..":",false,gui.tabStyle)
	local defaultButton = {}
	gui[color.."Red"] = guiCreateEdit(120,top,50,20,tostring(s(color.."Red")),false,gui.tabStyle)
	table.insert(defaultButton,{mode="set",edit=gui[color.."Red"],value=s(color.."Red","default")})
	gui[color.."Green"] = guiCreateEdit(175,top,50,20,tostring(s(color.."Green")),false,gui.tabStyle)
	table.insert(defaultButton,{mode="set",edit=gui[color.."Green"],value=s(color.."Green","default")})
	gui[color.."Blue"] = guiCreateEdit(230,top,50,20,tostring(s(color.."Blue")),false,gui.tabStyle)
	table.insert(defaultButton,{mode="set",edit=gui[color.."Blue"],value=s(color.."Blue","default")})
	gui[color.."Alpha"] = guiCreateEdit(285,top,50,20,tostring(s(color.."Alpha")),false,gui.tabStyle)
	table.insert(defaultButton,{mode="set",edit=gui[color.."Alpha"],value=s(color.."Alpha","default")})
	addEditButton(350,top,50,20,"default",false,gui.tabStyle,unpack(defaultButton))
end

--[[
-- Creates the odometer GUI. Will be added to a TAB in the speedometer
-- GUI.
--
-- @param    gui-element   parent: The gui element to add the gui to
-- ]]
function createOdometerGui(parent)
	if gui.tabPanel ~= nil then
		return
	end

	--gui.window = guiCreateWindow ( 320, 240, 500, 700, "Odometer settings", false )

	-- Create Tabs
	gui.tabPanel = guiCreateTabPanel(8,14,464,354,false,parent)
	gui.tabGeneral = guiCreateTab("General",gui.tabPanel)
	gui.tabStyle = guiCreateTab("Style",gui.tabPanel)
	gui.tabAdvanced = guiCreateTab("Advanced",gui.tabPanel)

	-- Tab: General
	local label = guiCreateLabel(14, 26, 140, 20, "Total Distance Odometer", false, gui.tabGeneral)
	guiLabelSetColor(label,255,0,0)
	guiSetFont(label,"default-bold-small")

	gui.totalEnabled = guiCreateCheckBox(160,26,80,20,"enable",s("totalEnabled"),false,gui.tabGeneral)
	
	guiCreateLabel(30, 56, 60, 20, "Position:", false, gui.tabGeneral )

	guiCreateLabel(100, 56, 40, 20, "Top:", false, gui.tabGeneral )
	gui.totalTop = guiCreateEdit( 140, 56, 60, 20, tostring(s("totalTop")), false, gui.tabGeneral )
	
	guiCreateLabel(100, 86, 40, 20, "Left:", false, gui.tabGeneral )
	gui.totalLeft = guiCreateEdit( 140, 86, 60, 20, tostring(s("totalLeft")), false, gui.tabGeneral )

	addEditButton( 275, 56, 40, 20, "up", false, gui.tabGeneral, {mode="add",edit=gui.totalTop,add=-0.01})
	addEditButton( 275, 86, 40, 20, "down", false, gui.tabGeneral, {mode="add",edit=gui.totalTop,add=0.01})
	addEditButton( 230, 86, 40, 20, "left", false, gui.tabGeneral, {mode="add",edit=gui.totalLeft,add=-0.01})
	addEditButton( 320, 86, 40, 20, "right", false, gui.tabGeneral, {mode="add",edit=gui.totalLeft,add=0.01})
	
	addEditButton( 380, 86, 50, 20, "default", false, gui.tabGeneral,
		{mode="set",edit=gui.totalTop,value=s("totalTop","default")},
		{mode="set",edit=gui.totalLeft,value=s("totalLeft","default")}
	)

	local label = guiCreateLabel(14, 120, 80, 20, "Trip Odometer", false, gui.tabGeneral )
	guiLabelSetColor(label,255,0,0)
	guiSetFont(label,"default-bold-small")

	gui.tripEnabled = guiCreateCheckBox(160,120,80,20,"enable",s("tripEnabled"),false,gui.tabGeneral)
	gui.buttonResetTripOdometer = guiCreateButton( 240, 120, 180, 20, "Reset trip odometer to zero", false, gui.tabGeneral )

	guiCreateLabel(30, 150, 60, 20, "Position:", false, gui.tabGeneral )

	guiCreateLabel(100, 150, 40, 20, "Top:", false, gui.tabGeneral )
	gui.tripTop = guiCreateEdit( 140, 150, 60, 20, tostring(s("tripTop")), false, gui.tabGeneral )
	

	guiCreateLabel(100, 180, 40, 20, "Left:", false, gui.tabGeneral )
	gui.tripLeft = guiCreateEdit( 140, 180, 60, 20, tostring(s("tripLeft")), false, gui.tabGeneral )

	addEditButton(275, 150, 40, 20, "up", false, gui.tabGeneral, {mode="add",edit=gui.tripTop,add=-0.01})
	addEditButton(275, 180, 40, 20, "down", false, gui.tabGeneral, {mode="add",edit=gui.tripTop,add=0.01})
	addEditButton(230, 180, 40, 20, "left", false, gui.tabGeneral, {mode="add",edit=gui.tripLeft,add=-0.01})
	addEditButton( 320, 180, 40, 20, "right", false, gui.tabGeneral, {mode="add",edit=gui.tripLeft,add=0.01})

	addEditButton(380, 180, 50, 20, "default", false, gui.tabGeneral,
		{mode="set",edit=gui.tripTop,value=s("tripTop","default")},
		{mode="set",edit=gui.tripLeft,value=s("tripLeft","default")}
	)
	
	

	-- Tab: Style
	guiCreateLabel(30, 14, 100, 20, "Style:", false, gui.tabStyle)

	gui.style = guiCreateEdit(100, 14, 80, 20, s("style"), false, gui.tabStyle)
	local button1 = addEditButton( 190, 14, 50, 20, "<-", false, gui.tabStyle, {mode="cyclebackwards",edit=gui.style,values=styles})
	local button2 = addEditButton( 310, 14, 50, 20, "->", false, gui.tabStyle, {mode="cycle",edit=gui.style,values=styles})
	addHelp("Style 'digital' is not yet finished.",gui.style,button1,button2)

	guiCreateLabel(30, 44, 100, 20, "Font:", false, gui.tabStyle)

	guiCreateLabel( 100, 44, 60, 20, "Type", false, gui.tabStyle )
	gui.font = guiCreateEdit( 140, 44, 100, 20, tostring(s("font")), false, gui.tabStyle )
	addEditButton( 250, 44, 50, 20, "<-", false, gui.tabStyle, {mode="cyclebackwards",edit=gui.font,values=fonts})
	addEditButton( 310, 44, 50, 20, "->", false, gui.tabStyle, {mode="cycle",edit=gui.font,values=fonts})

	guiCreateLabel(100, 74, 100, 20, "Scale", false, gui.tabStyle)
	gui.scale = guiCreateEdit( 140, 74, 50, 20, tostring(s("scale")), false, gui.tabStyle )
	addEditButton( 200, 74, 70, 20, "smaller", false, gui.tabStyle, {mode="add",add=-0.1,edit=gui.scale})
	addEditButton( 280, 74, 70, 20, "bigger", false, gui.tabStyle, {mode="add",add=0.1,edit=gui.scale})
	addEditButton( 380, 74, 60, 20, "default", false, gui.tabStyle, {mode="set",value=s("scale","default"),edit=gui.scale})

	guiCreateLabel(120, 110, 60, 20, "Red", false, gui.tabStyle)
	guiCreateLabel(175, 110, 60, 20, "Green", false, gui.tabStyle)
	guiCreateLabel(230, 110, 60, 20, "Blue", false, gui.tabStyle)
	guiCreateLabel(285, 110, 60, 20, "Alpha", false, gui.tabStyle)

	addColor("fontColor","Font",134)
	addColor("fontColor2","Font 2",158)
	addColor("digitBackgroundColor","Digit Bg",182)
	addColor("digitBackgroundColor2","Digit Bg 2",206)
	addColor("backgroundColor","Background",230)



	-- Tab: Advanced
	guiCreateLabel(24,14,160,20, "Positioning based on upper..", false, gui.tabAdvanced)
	gui.positionFrom = guiCreateEdit(200,14,100,20,tostring(s("positionFrom")),false,gui.tabAdvanced)
	addEditButton(304,14,50,20,"->",false,gui.tabAdvanced,{mode="cycle",edit=gui.positionFrom,values={"left","center","right"}})

	guiCreateLabel(24,556,100,20,"",false,gui.tabAdvanced)

	guiCreateLabel(100,44,140,20,"Space (between digits):",false,gui.tabAdvanced)
	gui.spaceBetweenDigits = guiCreateEdit(248,44,100,20,tostring(s("spaceBetweenDigits")),false,gui.tabAdvanced)

	guiCreateLabel(24,44,100,20,"Padding:",false,gui.tabAdvanced)

	guiCreateLabel(100,74,100,20,"Digits:",false,gui.tabAdvanced)
	gui.digitPadding = guiCreateEdit(140,74,100,20,tostring(s("digitPadding")),false,gui.tabAdvanced)
	addEditButton(360,74,50,20,"default",false,gui.tabAdvanced,{mode="set",edit=gui.digitPadding,value=s("digitPadding","default")})

	guiCreateLabel(100,104,140,20,"Background (vertical):",false,gui.tabAdvanced)
	gui.backgroundPaddingVertical = guiCreateEdit(250,104,100,20,tostring(s("backgroundPaddingVertical")),false,gui.tabAdvanced)
	addEditButton(360,104,50,20,"default",false,gui.tabAdvanced,{mode="set",edit=gui.backgroundPaddingVertical,value=s("backgroundPaddingVertical","default")})

	guiCreateLabel(100,128,140,20,"Background (horizontal):",false,gui.tabAdvanced)
	gui.backgroundPaddingHorizontal = guiCreateEdit(250,128,100,20,tostring(s("backgroundPaddingHorizontal")),false,gui.tabAdvanced)
	addEditButton(360,128,50,20,"default",false,gui.tabAdvanced,{mode="set",edit=gui.backgroundPaddingHorizontal,value=s("backgroundPaddingHorizontal","default")})

	-- Not in Tabs

	-- Not needed if included in speedometer gui
	--gui.buttonSave = guiCreateButton( 50, 660, 50, 20, "Save", false, gui.window )
	--gui.buttonClose = guiCreateButton( 200, 660, 50, 20, "Close", false, gui.window )

	addEventHandler("onClientGUIClick",gui.tabPanel,handleClick)
	addEventHandler("onClientGUIChanged",gui.tabPanel,handleEdit)

end

-- Not needed if included in speedometer gui
--[[
function openGui()
	createGui()
	
	guiSetVisible(gui.window,true)
	showCursor(true)
end

function closeGui()
	guiSetVisible(gui.window,false)
	showCursor(false)
end

function toggleGui()
	if guiGetVisible(gui.window) then
		closeGui()
	else
		openGui()
	end
end

addCommandHandler("odometer",toggleGui)
]]



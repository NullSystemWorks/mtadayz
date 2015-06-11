
-- This file defines the default settings the player will have
-- before he changes and saves the settings himself (if he does).

defaultSpeedometerSettings = {
	["enabled"] = true,
	["showMaxSpeedReached"] = true,
	["useVehicleSpecificSettings"] = true,
	["maxSpeed"] = 280,
	["fromAngle"] = 300,
	["addAngle"] = 280,
	["mode"] = "kph",
	["scale"] = 20,
	["size"] = 1,
	["fontSize"] = 1,
	["fontType"] = "default",
	["backgroundSize"] = 2.2,
	-- Position
	["top"] = 0.75,
	["left"] = 0.88,

	-- Colors
	["lineColorRed"] = 255,
	["lineColorGreen"] = 255,
	["lineColorBlue"] = 255,
	["lineColorAlpha"] = 255,

	["fontColorRed"] = 255,
	["fontColorGreen"] = 255,
	["fontColorBlue"] = 255,
	["fontColorAlpha"] = 255,

	["needleColorRed"] = 180,
	["needleColorGreen"] = 180,
	["needleColorBlue"] = 180,
	["needleColorAlpha"] = 255,

	["maxspeedColorRed"] = 255,
	["maxspeedColorGreen"] = 255,
	["maxspeedColorBlue"] = 0,
	["maxspeedColorAlpha"] = 255,

	["backgroundColorRed"] = 0,
	["backgroundColorGreen"] = 0,
	["backgroundColorBlue"] = 0,
	["backgroundColorAlpha"] = 40,

	["lineColorNightRed"] = 220,
	["lineColorNightGreen"] = 220,
	["lineColorNightBlue"] = 220,
	["lineColorNightAlpha"] = 255,

	["fontColorNightRed"] = 220,
	["fontColorNightGreen"] = 220,
	["fontColorNightBlue"] = 220,
	["fontColorNightAlpha"] = 255,

	["needleColorNightRed"] = 100,
	["needleColorNightGreen"] = 240,
	["needleColorNightBlue"] = 100,
	["needleColorNightAlpha"] = 255,

	["maxspeedColorNightRed"] = 255,
	["maxspeedColorNightGreen"] = 255,
	["maxspeedColorNightBlue"] = 0,
	["maxspeedColorNightAlpha"] = 255,

	["backgroundColorNightRed"] = 0,
	["backgroundColorNightGreen"] = 0,
	["backgroundColorNightBlue"] = 0,
	["backgroundColorNightAlpha"] = 20,

	-- Altimeter Settings
	["altimeterEnabled"] = true,
	["altimeterSize"] = 0.6,
	["altimeterFontSize"] = 1.4,
	["altimeterFontType"] = "default",
	["backgroundSize"] = 2.2,
	-- Position
	["altimeterTop"] = 0.79,
	["altimeterLeft"] = 0.73,

	["showInfo"] = true

}

defaultOdometerSettings = {
	["font"] = "default",
	["scale"] = 1,
	["style"] = "analog",
	["positionFrom"] = "center",
	["digitPadding"] = 1.6,
	["spaceBetweenDigits"]= 0.1,
	["backgroundPaddingVertical"] = 5,
	["backgroundPaddingHorizontal"] = 4,

	-- Colors
	["digitBackgroundColorRed"] = 40,
	["digitBackgroundColorGreen"] = 40,
	["digitBackgroundColorBlue"] = 40,
	["digitBackgroundColorAlpha"] = 255,

	["fontColorRed"] = 255,
	["fontColorGreen"] = 255,
	["fontColorBlue"] = 255,
	["fontColorAlpha"] = 255,

	["digitBackgroundColor2Red"] = 230,
	["digitBackgroundColor2Green"] = 230,
	["digitBackgroundColor2Blue"] = 230,
	["digitBackgroundColor2Alpha"] = 255,

	["fontColor2Red"] = 255,
	["fontColor2Green"] = 0,
	["fontColor2Blue"] = 0,
	["fontColor2Alpha"] = 255,

	["backgroundColorRed"] = 0,
	["backgroundColorGreen"] = 0,
	["backgroundColorBlue"] = 0,
	["backgroundColorAlpha"] = 0,

	-- Total distance odometer
	["totalEnabled"] = true,
	["totalTop"] = 0.698,
	["totalLeft"] = 0.88,
	["totalNumberOfDigits"] = 6,

	-- Trip odometer
	["tripEnabled"] = true,
	["tripTop"] = 0.78,
	["tripLeft"] = 0.88,
	["tripNumberOfDigits"] = 4


}
--------------------
-- Other settings --
--------------------

-- This sets the key and command name to open/close the settings gui.
-- If you don't want to use one of them, set it's value to nil.
toggleSettingsGuiKey = "F3" 
toggleSettingsGuiCommand = "speedometer"

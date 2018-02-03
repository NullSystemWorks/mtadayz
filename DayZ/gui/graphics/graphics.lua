--[[
#-----------------------------------------------------------------------------#
----*					MTA DayZ: graphics.lua							*----
----* Original Author: Marwin W., Germany, Lower Saxony, Otterndorf		*----

----* This gamemode is being developed by L, CiBeR96, 1B0Y				*----
----* Type: CLIENT														*----
#-----------------------------------------------------------------------------#
]]



graphicsPanel = {
    label = {},
    radiobutton = {},
    button = {},
    window = {},
    scrollbar = {},
    combobox = {},
	comboboxitem = {},
}

graphicsPanel.window[1] = guiCreateWindow(0.14, 0.32, 0.69, 0.38, "Graphics Options", true)
guiWindowSetSizable(graphicsPanel.window[1], false)

graphicsPanel.label[1] = guiCreateLabel(0.02, 0.21, 0.20, 0.06, "Draw Distance:", true, graphicsPanel.window[1])
graphicsPanel.scrollbar[1] = guiCreateScrollBar(0.23, 0.21, 0.22, 0.06, true, true, graphicsPanel.window[1])
graphicsPanel.label[5] = guiCreateLabel(0.24, 0.14, 0.20, 0.06, tostring(getFarClipDistance()), true, graphicsPanel.window[1])

graphicsPanel.label[2] = guiCreateLabel(0.02, 0.35, 0.20, 0.06, "Texture Detail:", true, graphicsPanel.window[1])
graphicsPanel.combobox[1] = guiCreateComboBox(0.23, 0.35, 0.22, 0.24, "", true, graphicsPanel.window[1])
graphicsPanel.comboboxitem[1] = guiComboBoxAddItem(graphicsPanel.combobox[1], "High")
graphicsPanel.comboboxitem[2] = guiComboBoxAddItem(graphicsPanel.combobox[1], "Low")

graphicsPanel.label[3] = guiCreateLabel(0.02, 0.50, 0.20, 0.06, "Sky Detail:", true,graphicsPanel.window[1])
graphicsPanel.combobox[2] = guiCreateComboBox(0.23, 0.51, 0.22, 0.24, "", true, graphicsPanel.window[1])
graphicsPanel.comboboxitem[3] = guiComboBoxAddItem(graphicsPanel.combobox[2], "High")
graphicsPanel.comboboxitem[4] = guiComboBoxAddItem(graphicsPanel.combobox[2], "Low")

graphicsPanel.label[4] = guiCreateLabel(0.02, 0.66, 0.20, 0.06, "Water Detail:", true, graphicsPanel.window[1])
graphicsPanel.combobox[3] = guiCreateComboBox(0.23, 0.66, 0.22, 0.24, "", true, graphicsPanel.window[1])
graphicsPanel.comboboxitem[5] = guiComboBoxAddItem(graphicsPanel.combobox[3], "High")
graphicsPanel.comboboxitem[6] = guiComboBoxAddItem(graphicsPanel.combobox[3], "Low")

graphicsPanel.label[6] = guiCreateLabel(0.50, 0.35, 0.20, 0.06, "Bloom:", true, graphicsPanel.window[1])
graphicsPanel.combobox[4] = guiCreateComboBox(0.71, 0.35, 0.22, 0.24, "", true, graphicsPanel.window[1])
graphicsPanel.comboboxitem[7] = guiComboBoxAddItem(graphicsPanel.combobox[4], "Activate")
graphicsPanel.comboboxitem[8] = guiComboBoxAddItem(graphicsPanel.combobox[4], "Deactivate")

graphicsPanel.label[7] = guiCreateLabel(0.50, 0.51, 0.20, 0.06, "HDR:", true, graphicsPanel.window[1])
graphicsPanel.combobox[5] = guiCreateComboBox(0.71, 0.51, 0.22, 0.24, "", true, graphicsPanel.window[1])
graphicsPanel.comboboxitem[9] = guiComboBoxAddItem(graphicsPanel.combobox[5], "Activate")
graphicsPanel.comboboxitem[10] = guiComboBoxAddItem(graphicsPanel.combobox[5], "Deactivate")

graphicsPanel.label[8] = guiCreateLabel(0.02, 0.90, 0.07, 0.07, "Preset:", true, graphicsPanel.window[1])
graphicsPanel.label[9] = guiCreateLabel(0.13, 0.83, 0.07, 0.07, "High", true, graphicsPanel.window[1])
guiLabelSetHorizontalAlign(graphicsPanel.label[9], "center", false)
guiLabelSetVerticalAlign(graphicsPanel.label[9], "center")
graphicsPanel.label[10] = guiCreateLabel(0.28, 0.83, 0.07, 0.07, "Medium", true, graphicsPanel.window[1])
guiLabelSetHorizontalAlign(graphicsPanel.label[10], "center", false)
guiLabelSetVerticalAlign(graphicsPanel.label[10], "center")
graphicsPanel.label[11] = guiCreateLabel(0.43, 0.83, 0.07, 0.07, "Low", true, graphicsPanel.window[1])
guiLabelSetHorizontalAlign(graphicsPanel.label[11], "center", false)
guiLabelSetVerticalAlign(graphicsPanel.label[11], "center")
graphicsPanel.label[12] = guiCreateLabel(0.58, 0.83, 0.07, 0.07, "Custom", true, graphicsPanel.window[1])
guiLabelSetHorizontalAlign(graphicsPanel.label[12], "center", false)
guiLabelSetVerticalAlign(graphicsPanel.label[12], "center")
graphicsPanel.radiobutton[1] = guiCreateRadioButton(0.15, 0.90, 0.02, 0.06, "", true, graphicsPanel.window[1])
graphicsPanel.radiobutton[2] = guiCreateRadioButton(0.31, 0.90, 0.02, 0.06, "", true, graphicsPanel.window[1])
graphicsPanel.radiobutton[3] = guiCreateRadioButton(0.45, 0.90, 0.02, 0.06, "", true, graphicsPanel.window[1])
graphicsPanel.radiobutton[4] = guiCreateRadioButton(0.60, 0.90, 0.02, 0.06, "", true, graphicsPanel.window[1])
graphicsPanel.button[1] = guiCreateButton(0.76, 0.86, 0.10, 0.09, "Save", true, graphicsPanel.window[1])
graphicsPanel.button[2] = guiCreateButton(0.89, 0.86, 0.10, 0.09, "Cancel", true, graphicsPanel.window[1])
graphicsPanel.label[13] = guiCreateLabel(0.72, 0.08, 0.20, 0.06, "FPS: ", true, graphicsPanel.window[1])

guiSetVisible(graphicsPanel.window[1],false)


local GraphicsPanelOpen = false
function toggleGraphicsPanel()
	if getElementData(localPlayer,"logedin") then
		if not GraphicsPanelOpen then
			guiSetVisible(graphicsPanel.window[1],true)
			GraphicsPanelOpen = true
			showCursor(not isCursorShowing())
			
			local oldGraphicsFile = xmlLoadFile("graphics.xml")
			local graphicsFile = xmlLoadFile("@graphics.xml")
			
			-- 0 = High/Activate, 1 = Low/Deactivate
			local drawDistance = 100
			local textureDetail = 1
			local skyDetail = 1
			local waterDetail = 1
			local bloomDetail = 1
			local hdrDetail = 1
			local savedPreset = 3 -- Low Preset
			if not graphicsFile and oldGraphicsFile then
				graphicsFile = xmlCreateFile("graphics.xml","settings")
				drawDistance = xmlNodeGetAttribute(oldGraphicsFile,"drawdistance")
				textureDetail = xmlNodeGetAttribute(oldGraphicsFile,"texture")
				skyDetail = xmlNodeGetAttribute(oldGraphicsFile,"sky")
				waterDetail = xmlNodeGetAttribute(oldGraphicsFile,"water")
				bloomDetail = xmlNodeGetAttribute(oldGraphicsFile,"bloom")
				hdrDetail = xmlNodeGetAttribute(oldGraphicsFile,"hdr")
				savedPreset = xmlNodeGetAttribute(oldGraphicsFile,"savedpreset")
				
				xmlNodeSetAttribute(graphicsFile,"drawdistance",drawDistance)
				xmlNodeSetAttribute(graphicsFile,"texture",textureDetail)
				xmlNodeSetAttribute(graphicsFile,"sky",skyDetail)
				xmlNodeSetAttribute(graphicsFile,"water",waterDetail)
				xmlNodeSetAttribute(graphicsFile,"bloom",bloomDetail)
				xmlNodeSetAttribute(graphicsFile,"hdr",hdrDetail)
				xmlNodeSetAttribute(graphicsFile,"savedpreset",savedPreset)
				xmlSaveFile(graphicsFile)
			end
			if oldGraphicsFile then
				xmlUnloadFile(oldGraphicsFile)
			end
			graphicsFile = xmlLoadFile("@graphics.xml")
			if graphicsFile then
				drawDistance = xmlNodeGetAttribute(graphicsFile,"drawdistance")
				textureDetail = xmlNodeGetAttribute(graphicsFile,"texture")
				skyDetail = xmlNodeGetAttribute(graphicsFile,"sky")
				waterDetail = xmlNodeGetAttribute(graphicsFile,"water")
				bloomDetail = xmlNodeGetAttribute(graphicsFile,"bloom")
				hdrDetail = xmlNodeGetAttribute(graphicsFile,"hdr")
				savedPreset = xmlNodeGetAttribute(graphicsFile,"savedpreset")
			else
				graphicsFile = xmlCreateFile("@graphics.xml","settings")
				xmlNodeSetAttribute(graphicsFile,"drawdistance",100)
				xmlNodeSetAttribute(graphicsFile,"texture",1)
				xmlNodeSetAttribute(graphicsFile,"sky",1)
				xmlNodeSetAttribute(graphicsFile,"water",1)
				xmlNodeSetAttribute(graphicsFile,"bloom",1)
				xmlNodeSetAttribute(graphicsFile,"hdr",1)
				xmlNodeSetAttribute(graphicsFile,"savedpreset",3)
				
				drawDistance = xmlNodeGetAttribute(graphicsFile,"drawdistance")
				textureDetail = xmlNodeGetAttribute(graphicsFile,"texture")
				skyDetail = xmlNodeGetAttribute(graphicsFile,"sky")
				waterDetail = xmlNodeGetAttribute(graphicsFile,"water")
				bloomDetail = xmlNodeGetAttribute(graphicsFile,"bloom")
				hdrDetail = xmlNodeGetAttribute(graphicsFile,"hdr")
				savedPreset = xmlNodeGetAttribute(graphicsFile,"savedpreset")
			end
			applySavedGraphicsToGui(drawDistance,textureDetail,skyDetail,waterDetail,bloomDetail,hdrDetail,savedPreset)
			xmlSaveFile(graphicsFile)		
				
		else
			guiSetVisible(graphicsPanel.window[1],false)
			GraphicsPanelOpen = false
			showCursor(not isCursorShowing())
			saveGraphicsToXML()
		end
	end
end
addCommandHandler("Show Graphics",toggleGraphicsPanel)
bindKey("F3","down","Show Graphics")

-- Preset Graphics Code
function getSelectedPresetGraphicOption()
	if guiRadioButtonGetSelected(graphicsPanel.radiobutton[1]) then -- High
		setPresetGraphics(1)
	elseif guiRadioButtonGetSelected(graphicsPanel.radiobutton[2]) then -- Medium
		setPresetGraphics(2)
	elseif guiRadioButtonGetSelected(graphicsPanel.radiobutton[3]) then -- Low
		setPresetGraphics(3)
	elseif guiRadioButtonGetSelected(graphicsPanel.radiobutton[4]) then -- Custom
		-- revert to custom settings if they exist, if not, set everything to same as low
	end
end
addEventHandler("onClientGUIClick",graphicsPanel.radiobutton[1],getSelectedPresetGraphicOption,false)
addEventHandler("onClientGUIClick",graphicsPanel.radiobutton[2],getSelectedPresetGraphicOption,false)
addEventHandler("onClientGUIClick",graphicsPanel.radiobutton[3],getSelectedPresetGraphicOption,false)

function setPresetGraphics(level)
	if level then
		-- 0 = High/Activate, 1 = Low/Deactivate
		local drawDistance = 100
		local textureDetail = 1
		local skyDetail = 1
		local waterDetail = 1
		local bloomDetail = 1
		local hdrDetail = 1
		local savedPreset = 3 -- Low Preset
		if level == 1 then
			drawDistance = 5000
			textureDetail = 0
			skyDetail = 0
			waterDetail = 0
			bloomDetail = 0
			hdrDetail = 0
			applySavedGraphicsToGui(drawDistance,textureDetail,skyDetail,waterDetail,bloomDetail,hdrDetail,level)
		elseif level == 2 then
			drawDistance = 2500
			textureDetail = 0
			skyDetail = 0
			waterDetail = 0
			bloomDetail = 1
			hdrDetail = 1
			applySavedGraphicsToGui(drawDistance,textureDetail,skyDetail,waterDetail,bloomDetail,hdrDetail,level)
		elseif level == 3 then
			drawDistance = 100
			textureDetail = 1
			skyDetail = 1
			waterDetail = 1
			bloomDetail = 1
			hdrDetail = 1
			applySavedGraphicsToGui(drawDistance,textureDetail,skyDetail,waterDetail,bloomDetail,hdrDetail,level)
		end
		saveGraphicsToXML()
	end
end

function saveGraphicsToXML()
	local graphicsFile = xmlLoadFile("@graphics.xml")
	local drawDistance = getFarClipDistance()
	local textureDetail = guiComboBoxGetSelected(graphicsPanel.combobox[1])
	local skyDetail = guiComboBoxGetSelected(graphicsPanel.combobox[2])
	local waterDetail = guiComboBoxGetSelected(graphicsPanel.combobox[3])
	local bloomDetail = guiComboBoxGetSelected(graphicsPanel.combobox[4])
	local hdrDetail = guiComboBoxGetSelected(graphicsPanel.combobox[5])
	local savedPreset = 3
	if guiRadioButtonGetSelected(graphicsPanel.radiobutton[1]) then
		savedPreset = 1
	elseif guiRadioButtonGetSelected(graphicsPanel.radiobutton[2]) then
		savedPreset = 2
	elseif guiRadioButtonGetSelected(graphicsPanel.radiobutton[3]) then
		savedPreset = 3
	elseif guiRadioButtonGetSelected(graphicsPanel.radiobutton[4]) then
		savedPreset = 4
	end
	
	if not graphicsFile then
		graphicsFile = xmlCreateFile("graphics.xml","settings")
		xmlNodeSetAttribute(graphicsFile,"drawdistance",drawDistance)
		xmlNodeSetAttribute(graphicsFile,"texture",textureDetail)
		xmlNodeSetAttribute(graphicsFile,"sky",skyDetail)
		xmlNodeSetAttribute(graphicsFile,"water",waterDetail)
		xmlNodeSetAttribute(graphicsFile,"bloom",bloomDetail)
		xmlNodeSetAttribute(graphicsFile,"hdr",hdrDetail)
		xmlNodeSetAttribute(graphicsFile,"savedpreset",savedPreset)
	else
		xmlNodeSetAttribute(graphicsFile,"drawdistance",drawDistance)
		xmlNodeSetAttribute(graphicsFile,"texture",textureDetail)
		xmlNodeSetAttribute(graphicsFile,"sky",skyDetail)
		xmlNodeSetAttribute(graphicsFile,"water",waterDetail)
		xmlNodeSetAttribute(graphicsFile,"bloom",bloomDetail)
		xmlNodeSetAttribute(graphicsFile,"hdr",hdrDetail)
		xmlNodeSetAttribute(graphicsFile,"savedpreset",savedPreset)
	end
	
	xmlSaveFile(graphicsFile)
	xmlUnloadFile(graphicsFile)
end

function applySavedGraphicsToGui(drawDistance,textureDetail,skyDetail,waterDetail,bloomDetail,hdrDetail,savedPreset)
	guiRadioButtonSetSelected(graphicsPanel.radiobutton[tonumber(savedPreset)],true)
	
	guiScrollBarSetScrollPosition(graphicsPanel.scrollbar[1],drawDistance/100)
	guiSetText(graphicsPanel.label[5],tostring(drawDistance))
	
	guiComboBoxSetSelected(graphicsPanel.combobox[1],textureDetail)
	guiComboBoxSetSelected(graphicsPanel.combobox[2],skyDetail)
	guiComboBoxSetSelected(graphicsPanel.combobox[3],waterDetail)
	guiComboBoxSetSelected(graphicsPanel.combobox[4],bloomDetail)
	guiComboBoxSetSelected(graphicsPanel.combobox[5],hdrDetail)
end

function applyGraphics()
	local drawDistance = guiGetText(graphicsPanel.label[5])
	local textureDetail = guiComboBoxGetSelected(graphicsPanel.combobox[1])
	local skyDetail = guiComboBoxGetSelected(graphicsPanel.combobox[2])
	local waterDetail = guiComboBoxGetSelected(graphicsPanel.combobox[3])
	local bloomDetail = guiComboBoxGetSelected(graphicsPanel.combobox[4])
	local hdrDetail = guiComboBoxGetSelected(graphicsPanel.combobox[5])
	
	setFarClipDistance(tonumber(drawDistance))
	
	if textureDetail == 0 then
		toggleTextureDetail(true)
	elseif textureDetail == 1 then
		toggleTextureDetail(false)
	end
	
	if skyDetail == 0 then
		toggleSkyDetail(true)
	elseif skyDetail == 1 then
		toggleSkyDetail(false)
	end
	
	if waterDetail == 0 then
		toggleWaterShader(true)
	elseif waterDetail == 1 then
		toggleWaterShader(false)
	end
	
	if bloomDetail == 0 then
		toggleBloom(true)
	elseif bloomDetail == 1 then
		toggleBloom(false)
	end
	
	if hdrDetail == 0 then
		toggleHDR(true)
	elseif hdrDetail == 1 then
		toggleHDR(false)
	end

	saveGraphicsToXML()
end
addEventHandler("onClientGUIClick",graphicsPanel.button[1],applyGraphics,false)

function closeGraphicsPanelWithButton()
	guiSetVisible(graphicsPanel.window[1],false)
end
addEventHandler("onClientGUIClick",graphicsPanel.button[2],closeGraphicsPanelWithButton,false)

addEventHandler("onClientRender",root, function()
	if GraphicsPanelOpen then
		local getDrawDistance = math.max(guiScrollBarGetScrollPosition(graphicsPanel.scrollbar[1])*50,100)
		guiSetText(graphicsPanel.label[5],tostring(getDrawDistance))
		
		guiSetText(graphicsPanel.label[13],"FPS: "..math.floor(getCurrentFPS()))
	end
end)

-- Switch to custom preset if any of the other GUI elements is clicked
addEventHandler("onClientGUIScroll",graphicsPanel.scrollbar[1],function() guiRadioButtonSetSelected(graphicsPanel.radiobutton[4],true) end,false)
addEventHandler("onClientGUIClick",graphicsPanel.combobox[1],function() guiRadioButtonSetSelected(graphicsPanel.radiobutton[4],true) end,false)
addEventHandler("onClientGUIClick",graphicsPanel.combobox[2],function() guiRadioButtonSetSelected(graphicsPanel.radiobutton[4],true) end,false)
addEventHandler("onClientGUIClick",graphicsPanel.combobox[3],function() guiRadioButtonSetSelected(graphicsPanel.radiobutton[4],true) end,false)
addEventHandler("onClientGUIClick",graphicsPanel.combobox[4],function() guiRadioButtonSetSelected(graphicsPanel.radiobutton[4],true) end,false)
addEventHandler("onClientGUIClick",graphicsPanel.combobox[5],function() guiRadioButtonSetSelected(graphicsPanel.radiobutton[4],true) end,false)
	


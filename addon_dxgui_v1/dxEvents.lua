--[[
/***************************************************************************************************************
*
*  PROJECT:     dxGUI
*  LICENSE:     See LICENSE in the top level directory
*  FILE:        dxEvents.lua
*  PURPOSE:     dxGUI Events
*  DEVELOPERS:  Skyline <xtremecooker@gmail.com>
*
*  dxGUI is available from http://community.mtasa.com/index.php?p=resources&s=details&id=4871
*
****************************************************************************************************************/
]]

addEvent("onClientDXMouseEnter",false)
addEvent("onClientDXMouseLeave",false)
addEvent("onClientDXClick",false)
addEvent("onClientDXDoubleClick",false)
addEvent("onClientDXChanged",false)
addEvent("onClientDXPropertyChanged",false)
addEvent("onClientDXScroll",false)
addEvent("onClientDXSpin",false)
addEvent("onClientDXMove",false)
addEvent("onClientDXDestroy",false)
addEvent("onClientDXDestoryAll",false)

--[[
	Event: onClientDXMouseEnter
	Trigger For: All Elements
	Description: Bind an event handler to be fired when the mouse enters an element, 
		or trigger that handler on an element.
	Source: 
	Parameters: 
]]

--[[
	Event: onClientDXMouseLeave
	Trigger For: All Elements
	Description: Bind an event handler to be fired when the mouse leaves an element, 
		or trigger that handler on an element.
	Source: 
	Parameters: 
]]

--[[
	Event: onClientDXClick
	Trigger For: All Elements
	Description: Bind an event handler to be fired when the mouse clicks an element, 
		or trigger that handler on an element.
	Source: 
	Parameters: 
]]

--[[
	Event: onClientDXDoubleClick
	Trigger For: All Elements
	Description: Bind an event handler to be fired when the mouse double-clicks an element, 
		or trigger that handler on an element.
	Source: 
	Parameters: 
]]

--[[
	Event: onClientDXChanged
	Trigger For: CheckBox,RadioButton,EditBox,Memo
	Description: Bind an event handler to be fired when the element changed.
	Source: 
	Parameters: 
]]

--[[
	Event: onClientDXPropertyChanged
	Trigger For: All Elements
	Description: Bind an event handler to be fired when the element property changed.
	Source: 
	Parameters: 
]]

--[[
	Event: onClientDXScroll
	Trigger For: Scrollbar
	Description: Bind an event handler to be fired when the element property changed.
	Source: 
	Parameters: 
]]


--[[
	Event: onClientDXSpin
	Trigger For: Spinner
	Description: Bind an event handler to be fired when the element property changed.
	Source: 
	Parameters: 
]]

--[[
	Event: onClientDXMove
	Trigger For: Windows ( may will be available in all elements at 1.4.1 or higher versions )
	Description: Bind an event handler to be fired when the element property changed.
	Source: 
	Parameters: 
]]

--[[
	Event: onClientDXDestroy
	Trigger For: All Elements
	Description: Bind an event handler to be fired when the element destroy by the dxDestroyElements.
	Source: 
	Parameters: 
]]

--[[
	Event: onClientDXDestoryAll
	Trigger For: All Elements
	Description: Bind an event handler to be fired when the all elements destroy by the dxDestroyElements
	Source: 
	Parameters: 
]]
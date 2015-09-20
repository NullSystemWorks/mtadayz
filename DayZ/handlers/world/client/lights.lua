function initTrafficLights()
setTrafficLightState ( "disabled" )
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), initTrafficLights)

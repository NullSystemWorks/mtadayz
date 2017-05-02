addEvent("onClientServerVersionValidate",true)

function onStart()
	outputDebugString(string.format("Server version: %s",tostring(version)))
end
addEventHandler("onResourceStart",resourceRoot,onStart)

function versionValidate(clientVer)
	if not clientVer then return end --Client will ignore
	
	local validate
	
	if (clientVer ~= version) then
		validate = false
	else
		validate = true
	end
	
	return triggerClientEvent(client,"onClientVersionVersionValidateReturn",resourceRoot,validate)
end
addEventHandler("onClientServerVersionValidate",root,versionValidate)
addEvent("onClientServerVersionValidateReturn",true)

function onStart()
	local version = getClientVersion()
	if not version then
		return --We'll delete the cache just to be sure, as version isn't available.
	end
	
	triggerServerEvent("onClientServerVersionValidate",resourceRoot,version)
	return true
end
addEventHandler("onClientResourceStart",resourceRoot,onStart)

function onValidationCompleted(state)
	if not state then
		clearCache()
		--triggerServerEvent("forcePlayerRedirect",resourceRoot)
		return true
	end
	
	outputDebugString("[Cache] Validation completed. Client up-to-date.")
	return true
end
addEventHandler("onClientServerVersionValidateReturn",root,onValidationCompleted)

function getClientVersion()
	local version
	
	if (fileExists("version.txt")) then
		local verFile = fileOpen("version.txt")
		version = fileRead(verFile,fileGetSize(verFile))
		fileClose(verFile)
	else
		clearCache()
		downloadFile("version.txt")
		return false
	end
	
	return version
end


function clearCache()
	outputDebugString("[Cache] clearCache()")
	return true
end

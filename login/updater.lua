function createfile(data, path, status)
	if data and path then
		if status == "removed" then
			if fileExists(path) then
				fileDelete(path)
			end
		else
			local fileHandler = fileCreate(path)
			fileWrite(fileHandler, data)
			fileClose(fileHandler)
		end
	end
end

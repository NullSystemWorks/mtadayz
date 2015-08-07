function onStart()
	if mods and type(mods) == "table" and #mods >= 1 then
		outputConsole("Loading "..#mods.." mods...")
		
		--Load the mods
		for k,v in ipairs(mods) do
			dff = v[2]
			txd = v[3]
			col = v[4]
			
			if (txd and txd ~= "") then
				txd = engineLoadTXD("mods/"..txd)
				engineImportTXD(txd,v[1])
			end
			if (col and col ~= "") then
				col = engineLoadCOL("mods/"..col)
				engineReplaceCOL(col,v[1])
			end
			if (dff and dff ~= "") then
				dff = engineLoadDFF("mods/"..dff)
				engineReplaceModel(dff,v[1])
			end

			
			--Output what mod we just loaded
			outputConsole("Mod "..v[2].." loaded.")
		end
		outputConsole("Finished loading mods.")
		return true
	end
	return
end
addEventHandler("onClientResourceStart",resourceRoot,onStart)
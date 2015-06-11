------------------
-- Settings System
------------------

Settings = {}
function Settings:new(defaultSettings,filename)
	local object = {}
	setmetatable(object,self)
	self.__index = self
	object.settingsXml = Xml:new(filename,"settings")
	object.settings = {}
	object.settings.default = defaultSettings
	return object
end
function Settings:set(setting,value,settingType)
	if settingType == nil then
		settingType = "main"
	end

	--var_dump("settings",self)
	local defaultType = type(self.settings.default[setting])
	if defaultType == "string" then
		value = tostring(value)
	elseif defaultType == "number" then
		value = tonumber(value)
	elseif defaultType == "boolean" then
		value = toboolean(value)
	end
	if self.settings[settingType] == nil then
		self.settings[settingType] = {}
	end
	self.settings[settingType][setting] = value
end
function Settings:loadFromXml(settingType)
	if settingType == nil then
		settingType = "main"
	end
	self.settingsXml:open()

	for k,v in pairs(self.settings.default) do
		local value = self.settingsXml:getAttribute("root",k)
		if value ~= false and value ~= "" then
			self:set(k,value,settingType)
		else
			self:set(k,v,settingType)
		end
	end
	self.settingsXml:unload()
end

function Settings:saveToXml(setting,settingType)
	if settingType == nil then
		settingType = "main"
	end
	self.settingsXml:open()

	for k,v in pairs(self.settings[settingType]) do
		if setting == nil or setting == k then
			self.settingsXml:setAttribute("root",k,v)
		end
	end
	self.settingsXml:save()
	self.settingsXml:unload()
end
function Settings:get(setting,settingType)
	datatype = type(self.settings.default[setting])
	if settingType == nil then
		settingType = "main"
	end
	local value = nil
	if (self.settings[settingType] ~= nil) then
		value = self.settings[settingType][setting]
	end
	--if settingType == "vehicle" then
	--	var_dump("setting",setting,"value",value)
	--end
	if type(value) == datatype then
		return value
	end
	return self.settings.default[setting]
end

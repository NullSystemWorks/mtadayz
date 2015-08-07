-- ## XML Stuff

Xml = {}
function Xml:new(file,rootName)
	local object = {}
	setmetatable(object,self)
	self.__index = self
	object.file = file
	object.rootName = rootName
	object.rootNode = nil
	return object
end
function Xml:open(tryToOpenAutomatically)
	self.autoOpened = false
	
	if self.rootNode ~= nil then
		return
	end
	if tryToOpenAutomatically then
		self.autoOpened = true
		
	end
	local rootNode = xmlLoadFile(self.file)
	if not rootNode then
		rootNode = xmlCreateFile(self.file,self.rootName)
	end
	self.rootNode = rootNode
	return rootNode
end
function Xml:save(unload,auto)
	if auto then
		if not self.autoOpened then
			return
		else
			unload = true
		end
	end
	xmlSaveFile(self.rootNode)
	if unload then
		self:unload()
	end
end
function Xml:getValue(node)
	self:open(true)
	if node == "root" then
		node = self.rootNode
	end
	local value = xmlNodeGetValue(node)
	return value
end
function Xml:getAttribute(node,attributeName)
	self:open(true)
	if type(node) == "table" then
		node = self:findNode(node)
		if node == false then
			return false
		end
	end
	if node == "root" then
		node = self.rootNode
	end
	local attribute = xmlNodeGetAttribute(node,tostring(attributeName))
	return attribute
end

--[[
-- setAttribute
--
-- Sets the attribute of a certain node.
--
-- @param   Node/table  node: The node or a table (see findNode for format)
-- @param   string      attributeName: The name of the attribute
-- @param   string      attributeValue: The value of the attribute
-- @return  false/nil: Returns false if no valid node was found (only if 'node' is a table)
-- ]]
function Xml:setAttribute(node,attributeName,attributeValue)
	self:open(true)
	if type(node) == "table" then
		node = self:findNode(node)
		if node == false then
			return false
		end
	end
	if node == "root" then
		node = self.rootNode
	end
	xmlNodeSetAttribute(node,tostring(attributeName),tostring(attributeValue))
	self:save(false,true)
end
function Xml:setValue(node,value)
	self:open(true)
	if node == "root" then
		node = self.rootNode
	end
	xmlNodeSetValue(node,tostring(value))
	self:save(false,true)
end
function Xml:unload()
	xmlUnloadFile(self.rootNode)
	self.rootNode = nil
end
--[[
-- findNode
--
-- Finds the first node that matches the definition
-- in the table:
--
-- table.parent - search the children of this node
-- 	(defaults to root)
-- table.tag - search only for nodes with this name
-- table.attribute - search only for nodes that contain
-- 	the key=value combination(s) in this table
-- table.create - if true, it creates the node if it
-- 	doesnt find one
--
-- @param   table   table: See above
-- @return  node/false: returns the found node, or false
-- 	if it hasn't found or created one
-- ]]
function Xml:findNode(table)
	local parent = table.parent
	if parent == nil or parent == "root" then
		parent = self.rootNode
	end
	local tag = table.tag
	local attribute = table.attribute
	if attribute == nil then
		attribute = {}
	end
	
	local children = xmlNodeGetChildren(parent)
	if children == false then return false end
	for i,node in ipairs(children) do
		if self:matchNode(node,tag,attribute) then
			return node
		end
	end
	if table.create == true then
		return self:createChild(parent,tag,attribute)
	end
	return false
end

--[[
-- createChild
--
-- Creates a child node based on the tag and key=value
-- pairs in the attribute table.
--
-- @param   Node    parent: The node the child should be created under
-- @param   string  tag: The name of the tag
-- @param   table   attribute: A table of key=value pairs that should be added to the new child
-- @return  Node    node: Returns the newly created node
-- ]]
function Xml:createChild(parent,tag,attribute)
	if tag == nil then
		tag = "node"
	end
	if attribute == nil then
		attribute = {}
	end
	local node = xmlCreateChild(parent,tag)
	for k,v in pairs(attribute) do
		xmlNodeSetAttribute(node,tostring(k),tostring(v))
	end
	return node
end

--[[
-- matchNode
--
-- Matches a single node against its tag-name and
-- the given attributes.
--
-- @param   Node    node: The node that has to be checked
-- @param   string  tag: The name of the node
-- @param   table   attribute: A table of key=value pairs of attributes
-- @return  true/false: returns true if the node matches, false otherwise
-- ]]
function Xml:matchNode(node,tag,attribute)
	-- check if tag (node-name) matches (or rather if it doesn't)
	if tag ~= nil and xmlNodeGetName(node) ~= tag then
		return false
	end
	-- check if attributes match (or rather if one doesn't)
	for k,v in pairs(attribute) do
		local attr = xmlNodeGetAttribute(node,k)
		if attr ~= tostring(v) then
			return false
		end
	end
	return true
end

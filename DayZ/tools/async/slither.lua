local _LICENSE = -- zlib / libpng
[[
Copyright (c) 2011-2015 Bart van Strien

This software is provided 'as-is', without any express or implied
warranty. In no event will the authors be held liable for any damages
arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented; you must not
  claim that you wrote the original software. If you use this software
  in a product, an acknowledgment in the product documentation would be
  appreciated but is not required.

  2. Altered source versions must be plainly marked as such, and must not be
  misrepresented as being the original software.

  3. This notice may not be removed or altered from any source
  distribution.
]]

class =
{
	_VERSION = "Slither 20150712",
	-- I have no better versioning scheme, deal with it
	_DESCRIPTION = "Slither is a pythonic class library for lua",
	_URL = "http://bitbucket.org/bartbes/slither",
	_LICENSE = _LICENSE,
}

-- Because we parse "string paths", yet we need an actual table
local function stringtotable(path)
	local t = _G
	local name

	for part in path:gmatch("[^%.]+") do
		t = name and t[name] or t
		name = part
	end

	return t, name
end

-- Derives an MRO from a list of (direct) parents
local function buildmro(parents)
	local mro = {}
	local inmro = {}
	for i, v in ipairs(parents) do
		for j, w in ipairs(v.__mro__) do
			-- If it's already in the mro, we move it backwards by removing
			-- it and then reinserting
			if inmro[w] then
				for i, v in ipairs(mro) do
					if v == w then
						table.remove(mro, i)
						break
					end
				end
			end

			table.insert(mro, w)
			inmro[w] = true
		end
	end

	return mro
end

local AnnotationWrapper -- defined later as a class

-- This is where the actual class generation happens
local function class_generator(name, b, t)
	-- Compose a list of parents
	local parents = {}
	for _, v in ipairs(b) do
		parents[v] = true
		for _, v in ipairs(v.__parents__) do
			parents[v] = true
		end
	end

	-- Create our 'temp' table, which ends up being the class object
	local temp = { __parents__ = {} }
	for i, v in pairs(parents) do
		table.insert(temp.__parents__, i)
	end

	-- Add class access to the original prototype
	temp.__prototype__ = t
	temp.__prototype__.__name__ = name

	-- Build the MRO (Member Resolution Order)
	temp.__mro__ = buildmro(b)
	table.insert(temp.__mro__, 1, temp.__prototype__)

	-- Store a reference to the library table here
	local classlib = class

	-- Create our class by attaching a metatable to our object
	local class = setmetatable(temp, {
		-- We first catch __class__ and __name__, then check the MRO, in order.
		-- If we still don't have a match, make sure we're not matching a
		-- special method, then call __getattr__ if defined.
		__index = function(self, key)
			if key == "__class__" then return temp end
			if key == "__name__" then return name end
			for i, v in ipairs(temp.__mro__) do
				if v[key] ~= nil then return v[key] end
			end
			if tostring(key):match("^__.+__$") then return end
			if self.__getattr__ then
				return self:__getattr__(key)
			end
		end,

		-- Attaching things to our class later on can simply be modeled
		-- as assigning to the original input table.
		__newindex = function(self, key, value)
			t[key] = value
		end,

		-- Storage for annotations
		__annotations__ = {},

		-- Here we 'allocate' an object
		allocate = function(instance)
			-- Create our object's metatable
			local smt = getmetatable(temp)
			local mt = {__index = smt.__index}

			-- Assigning to the object either calls __setattr__ or sets it on
			-- the object directly.
			function mt:__newindex(key, value)
				if self.__setattr__ then
					return self:__setattr__(key, value)
				else
					return rawset(self, key, value)
				end
			end

			-- If __cmp__ is defined, we want to emit both the eq and lt
			-- operations, we cache it on the class itself and then assign it
			-- to our metatable.
			if temp.__cmp__ then
				if not smt.eq or not smt.lt then
					function smt.eq(a, b)
						return a.__cmp__(a, b) == 0
					end
					function smt.lt(a, b)
						return a.__cmp__(a, b) < 0
					end
				end
				mt.__eq = smt.eq
				mt.__lt = smt.lt
			end

			-- Now map the rest of our special functions to metamethods
			for i, v in pairs{
				__call__ = "__call", __len__ = "__len",
				__add__ = "__add", __sub__ = "__sub",
				__mul__ = "__mul", __div__ = "__div",
				__mod__ = "__mod", __pow__ = "__pow",
				__neg__ = "__unm", __concat__ = "__concat",
				__str__ = "__tostring",
				} do
				if temp[i] then mt[v] = temp[i] end
			end

			-- Finally join our (possibly given) instance with the metatable
			return setmetatable(instance or {}, mt)
		end,

		-- Our 'new' call, first allocate an object of this class, then call
		-- the constructor.
		__call = function(self, ...)
			local instance = getmetatable(self).allocate()
			if instance.__init__ then instance:__init__(...) end
			return instance
		end
		})

	-- If annotations are used, we are left with a bunch of AnnotationWrapper
	-- objects, here we resolve them and replace them with the resulting value.
	for i, v in pairs(t) do
		if classlib.isinstance(v, AnnotationWrapper) then
			local extra
			t[i] = v:resolve(i, class)
		end
	end

	-- Now we deal with class attributes
	for i, v in ipairs(t.__attributes__ or {}) do
		class = v(class) or class
	end

	return class
end

-- Here we determine if we've been passed a list of parents, and if so, convert
-- them from strings if necessary. Then we produce a new function that results
-- in the final call to class_generator. If we've not been passed parents, call
-- class_generator now, we already have our prototype.
local function inheritance_handler(set, name, ...)
	local args = {...}

	for i = 1, select("#", ...) do
		if args[i] == nil then
			error("nil passed to class, check the parents")
		end
	end

	local t = nil
	if #args == 1 and type(args[1]) == "table" and not args[1].__class__ then
		t = args[1]
		args = {}
	end

	for i, v in ipairs(args) do
		if type(v) == "string" then
			local t, name = stringtotable(v)
			args[i] = t[name]
		end
	end

	local func = function(t)
		local class = class_generator(name, args, t)
		if set then
			local root_table, name = stringtotable(name)
			root_table[name] = class
		end
		return class
	end

	if t then
		return func(t)
	else
		return func
	end
end

-- If class.private is called, we don't set the resulting variable
function class.private(name)
	return function(...)
		return inheritance_handler(false, name, ...)
	end
end

-- But if class is called, we do
class = setmetatable(class, {
	__call = function(self, name)
		return function(...)
			return inheritance_handler(true, name, ...)
		end
	end,
})

-- issubclass is a "simple" search
-- Note the "fancy" feature where issubclass(A, A) is true because {A} is the
-- first list of parents searched.
function class.issubclass(class, parents)
	if parents.__class__ then parents = {parents} end
	for i, v in ipairs(parents) do
		local found = true
		if v ~= class then
			found = false
			for _, p in ipairs(class.__parents__) do
				if v == p then
					found = true
					break
				end
			end
		end
		if not found then return false end
	end
	return true
end

-- And isinstance defers to issubclass.
function class.isinstance(obj, parents)
	return type(obj) == "table" and obj.__class__ and
			class.issubclass(obj.__class__, parents)
end

-- Our AnnotationWrapper is a purely file local class, it's used to store
-- deferred application of Annotations. That is, when the class gets built,
-- then Annotations are applied, so the class name, and the class prototype
-- are available to the annotation.
AnnotationWrapper = class.private "AnnotationWrapper"
{
	__init__ = function(self, lhs, rhs)
		self.lhs, self.rhs = lhs, rhs
	end,

	-- We're just building a left-to-right linked list here
	__add__ = function(self, other)
		self.rhs = self.__class__(self.rhs, other)
		return self
	end,

	-- Since we have a left-to-right linked list, we can just
	-- apply them recursively outwards.
	resolve = function(self, name, cls)
		if class.isinstance(self.rhs, self.__class__) then
			self.rhs = self.rhs:resolve(name, cls)
		end
		local val, extra = self.lhs:apply(self.rhs, name, cls)

		-- If an extra value was returned, store it in the class metatable
		if extra then
			local anTable = getmetatable(cls).__annotations__
			anTable[self.lhs.__class__] = anTable[self.lhs.__class__] or {}
			anTable[self.lhs.__class__][name] = extra
		end

		return val
	end,
}

-- Our annotation baseclass, nothing fancy, but it just defines the + operator,
-- and, perhaps more importantly, has access to AnnotationWrapper.
class.Annotation = class.private "class.Annotation"
{
	-- We're being applied to 'other', so return an AnnotationWrapper, so we
	-- can be resolved later
	__add__ = function(self, other)
		return AnnotationWrapper(self, other)
	end,

	-- A default implementation of apply which does, predictably, nothing
	-- Note: The value returned by the annotation replaces the previous value,
	-- so if nothing (nil) is returned, it will become nil, this is intentional
	apply = function(self, f, name, class)
		return f
	end,

	-- Obtain annotation information from a class member, if it exists
	get = function(self, class, name)
		local anTable = getmetatable(class).__annotations__
		if not anTable then return nil end
		anTable = anTable[self]
		if not anTable then return nil end
		return anTable[name]
	end,

	-- Get all occurences of this annotation's data on a class
	iterate = function(self, class)
		local anTable = getmetatable(class).__annotations__
		if not anTable then return function() return nil end end
		anTable = anTable[self]
		if not anTable then return function() return nil end end
		return pairs(anTable)
	end,

	-- Get all occurences of this annotation's and its subclasses' data on a
	-- class
	iterateFull = function(self, cls)
		local anTable = getmetatable(cls).__annotations__
		if not anTable then return function() return nil end end

		return coroutine.wrap(function()
			for ann, data in pairs(anTable) do
				-- If this annotation data was left by this class, or one of its
				-- subclasses, iterate over the data
				if class.issubclass(ann, self) then
					for member, value in pairs(data) do
						coroutine.yield(ann, member, value)
					end
				end
			end
		end)
	end,
}

class.Override = class.private "class.Override" (class.Annotation)
{
	apply = function(self, f, name, class)
		for i, v in ipairs(class.__parents__) do
			if v[name] then
				return f
			end
		end

		error(name .. " is marked override, but does not override a field or" ..
				" method from a baseclass")
	end,
}

-- Export a Class Commons interface
-- to allow interoperability between
-- class libraries.
-- See https://github.com/bartbes/Class-Commons
--
-- NOTE: Implicitly global, as per specification, unfortunately there's no nice
-- way to both provide this extra interface, and use locals.
if common_class ~= false then
	common = {}
	function common.class(name, prototype, superclass)
		prototype.__init__ = prototype.init
		return class_generator(name, {superclass}, prototype)
	end

	function common.instance(class, ...)
		return class(...)
	end
end

return class

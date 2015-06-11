------------
-- Draw Text
------------


DrawInfo = {}
DrawInfo.fadeTime = 200
DrawInfo.displayTime = 10000
DrawInfo.started = nil

function DrawInfo:new()
	local object = {}
	setmetatable(object,self)
	self.__index = self
	return object
end
function DrawInfo:draw()
	if self.started == nil then
		return
	end

	local passed = getTickCount() - self.started

	if passed > self.displayTime then
		self.started = nil
		return
	end
	local fade = 1

	if passed < self.fadeTime then
		fade = 1 / self.fadeTime * passed
	end
	if passed > self.displayTime - self.fadeTime then
		fade = 1 / self.fadeTime * math.abs(passed - self.displayTime)
	end
	dxDrawText(self.text,self.left,self.top,self.right,self.top,tocolor(255,200,200,255*fade),1,"default","left","top",false,true,true)
end
function DrawInfo:start(text,left,top,right)
	self.started = getTickCount()
	self.text = text
	self.left = left
	self.top = top
	if right == nil then
		right = left
	end
	self.right = right
end

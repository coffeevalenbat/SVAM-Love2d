Fade = {}
Fade.__index = Fade
ActiveFade = {}

function Fade.new(trackN,speed,fade)
	local instance = setmetatable({},Fade)
	instance.trackN = trackN
	instance.TN = trackN
	instance.speed = speed
	instance.fade = fade
	instance.target = -1

	if type(instance.trackN) == "string" then
		instance.TN = 1
	end

	table.insert(ActiveFade, instance)

end

function Fade:upd()
	if self.fade == "in" then
		svam:fadeIn(self.trackN,self.speed)
		self.target = 1
	elseif self.fade == "out" then
		svam:fadeOut(self.trackN,self.speed)
		self.target = 0
	end



	if self.target == svam.currentTrack[self.TN]:getVolume() then
		self:remove()
	end
	self:checkInstances()
end

function Fade:checkInstances()
	for i,instance in ipairs(ActiveFade) do
		if (instance.TN == self.TN and instance ~= self) then
			self:remove()
		end
	end
end

function Fade:remove()
	for i,instance in ipairs(ActiveFade) do
		if instance == self then
			table.remove(ActiveFade,i)
		end
	end
end

function svam:updateAutoFade(dt)
	for i,instance in ipairs(ActiveFade) do
		instance:upd(dt)
	end
end

--cleaner shortcuts
svam.newAutoFade = Fade.new
svam = {}
svam.currentTrack = nil
svam.Tracklist = nil

local cwd   = (...):gsub('%.init$', '').."/"
require(cwd.."fadeObjs")

function svam:clearSong()
	self:stopSong()
	for i,v in ipairs(svam.currentTrack) do
		table.remove(svam.currentTrack, i)
	end
	svam.currentTrack = nil
	svam.Tracklist = nil
end


function svam:stopSong()
	for i=1,#svam.currentTrack do
		love.audio.stop(svam.currentTrack[i])
	end
end


function svam:playSong(tab,mv)
if svam.currentTrack ~= nil then
	self:clearSong()
end

local tracks = {}
local dir = ""

if mv == nil then
	mv = 1
end

if type(tab) == "string" and love.filesystem.getInfo(tab).type == "directory" then
	dir = tab.."/"
	tab = love.filesystem.getDirectoryItems(tab)
end
	for i = 1, #tab do
		local track = love.audio.newSource(dir..tab[i],"stream")
		track:setLooping(true)
		if type(mv) ~= "table" then
			track:setVolume(mv)
		elseif mv[i]==nil then
			track:setVolume(1)
		else
			track:setVolume(mv[i])
		end
		table.insert(tracks,track)
	end
	svam.currentTrack = tracks
	love.audio.play(tracks)
	svam.Tracklist = tab
end

function svam:fadeIn(trackN,speed)
	if trackN == "all" then
		for t = 1,#svam.currentTrack do
			local track =svam.currentTrack[t]
			track:setVolume(math.min(track:getVolume() + speed,1))
		end
	else
		local track =svam.currentTrack[trackN]
		track:setVolume(math.min(track:getVolume() + speed,1))
	end
end

function svam:fadeOut(trackN,speed)
	if trackN == "all" then
		for t = 1,#svam.currentTrack do
			local track =svam.currentTrack[t]
			track:setVolume(math.max(track:getVolume() - speed,0))

		end
	else
		local track =svam.currentTrack[trackN]
		track:setVolume(math.max(track:getVolume() - speed,0))
	end
end
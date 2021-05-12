# SVAM-Love2d
Simple Vertically Dynamic Music system for the Love2D/LÖVE engine, made by an unexperienced Lua programmer (Me).

# What is this?
This is an experiment by me to learn Love2D/Lua in general, the goal's to have a simple to use Vertically dynamic music system for Love2D.

# How do I use this? 
Simple! copy the svam folder from this repo to your project's main folder and at the top of your main.lua file you must add the line require("svam"), This will give you access to all functions related to the library.

# Playing a song
To simply play a song, use the svam:playSong() function, this takes two parameters, one is either a table containing all sources to the tracks to be played simoultaneously or the location of a folder which contains all tracks, this means that music can be kept in individual folders and then called by the folder name, although beware, the folder must only contain audio files. The second argument is global volume, based from 0 (Silence) to 1 (Full volume), this can either be a single number or a sequencial table containing volumes for each track to be played, if neither volume is specified, it will be filled up with max volume.

Example:

```lua
require("svam")
function love:load()
  svam:playSong("songFolder",1)
end
```

# Fading in and out

There is 2 ways to do fading, one is to use the svam:fadeIn() and svam:fadeOut() functions, these take 2 arguments, the track number to be modified (You can also use "all" and it'll fade all currently playing channels), and the speed of the fade. This has to be done manually, meaning that if a full fade wants to be done, the function has to be constantly called.

Example:

```lua
require("svam")
function love:load()
  svam:playSong("songFolder",1)
end

function love:update(dt)
  svam:fadeOut(1,0.05)
end
```

A way to avoid this is to use "Autofades", these are small objects that can be created with svam.newAutoFade(), these take the same 2 arguments as the functions above but also take the direction of the fade, this can be either "in" or "out", otherwise they act the same as the mentioned before. Note that with autofades, you must also call the svam:updateAutoFade(dt) function in your love:update(dt) function for them to work correctly, they will automatically delete themselves once they've gotten to their target volume, also, these are objects, so calling them once is more than enough.


Example:

```lua
require("svam")
function love:load()
  svam:playSong("songFolder",0)
  svam.newAutoFade("all",.05,"in")
end

function love:update(dt)
  svam:updateAutoFade(dt)
end
```

# Stopping and clearing

When you wanna stop a song totally, your best bet is to use the svam:stopSong() function, it'll only stop the song playing, it will not touch anything like volume or where the song is. the svam:clearSong() function in the other hand will clear everything about the song, leaving many funcions NIL which may be dangerous and provoke a crash, only use this one if you wanna save up on ram or you're sure nothing in your code is trying to mess with it.

# Other things

There is a variable inside svam that contains all currently playing tracks's filenames, this may be useful if you're trying to edit something.

# As of the lack of examples...

I have a full tiny project with a few songs to show off the library but for some reason my stupid ass wifi won't upload the music files, so for the sake of simplicity I'm only uploading the library. Sorry folks.

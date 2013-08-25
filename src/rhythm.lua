--require 'enemies'

function initRhythm ()


   soundNames = 
      {"330", "440", "660", "880", "drum1", "drum2", "drum3", "pluck1", "pluck2", "pluck3", "drum-new1", "drum-new2", "drum-new3", "drum-new4", "220-long", "110-saw"}

   effectNames = {"enemy-hit", "enemy-miss"}

   effects = {}
   for i=1,#effectNames do
      local p = love.audio.newSource("sound/" .. effectNames[i] .. ".ogg", "static")
      table.insert(effects, p)
   end

   trackDrum = {"pluck2", "pluck3", "drum-new1", "drum-new2", "drum-new3", "drum-new4"}
   track1 =
      {"440", "660", "880", "drum1", "drum2", "drum3", "pluck1"}

   sounds = {}
   meter = math.random(3,5)
--   meter = 3
   tangoSize = 5
   scoreSize = meter * 2 -- 10 is constant
   debug = false
   current = {}
   switchSpeed = 10 -- seconds?

   tempo = 0.2 -- seconds

   tempoCounter = 0
   switchCounter = 0
   tangoCounter = 0
   scoreCounter = 0

   tango = {}
--   tango = {{true,false,true}}
   for i=1,tangoSize do
      tango[i] = {}
      for j=1,meter do
	 local m = math.random(0,1)
	 tango[i][j] = (m == 1)
      end
   end

   current = tango[math.random(1,#tango)]

   if debug then
      print("current contents:")
      for i=1,#current do
	 print(current[i])
      end
   end

   for i=1,#soundNames do
      local p = love.audio.newSource("sound/" .. soundNames[i] .. ".ogg", "static")
      table.insert(sounds, p)
   end

   drums = {}
   for i=1,#trackDrum do
      local p = love.audio.newSource("sound/" .. trackDrum[i] .. ".ogg", "static")

   if debug then print (p) end
      table.insert(drums, p)
   end

   beat = {}
   for i=1,meter do
      local r = math.random(1,#drums)
      beat[i] = drums[r]
   end
   

   score = {}
--   score = {sounds[1], sounds[2],sounds[2]}
   for i=1,scoreSize do
      local r = math.random(1,#sounds)
      score[i] = sounds[r]
   end

end

function updateRhythm (dt)

   tempoCounter = dt + tempoCounter

   if tempoCounter >= tempo then
      
      tempoCounter = tempoCounter - tempo

      tangoCounter = tangoCounter + 1
      scoreCounter = scoreCounter + 1
      switchCounter = switchCounter + 1

      if switchCounter >= switchSpeed then 
	 current = tango[math.random(1,#tango)]
	 switchCounter = 1
      end

      if debug then
	 print("current contents:")
	 for i=1,#current do
	    print(current[i])
	 end
      end

      if tangoCounter > #current then
	 tangoCounter = 1
      end

      if scoreCounter > #score then
	 scoreCounter = 1
      end

      if debug then
	 print ("tangoCounter: " .. tangoCounter)
	 print ("scoreCounter: " .. scoreCounter)
	 print ("tango: " .. #current)
	 print ("score: " .. #score)
      end

      enemyStep()
      if current[tangoCounter] then
	 love.audio.play(score[scoreCounter])
      end

      love.audio.play(beat[tangoCounter])

   end

end

--require 'enemies'

function initRhythm ()

   soundNames = 
      {"440", "660", "880", "drum1", "drum2", "drum3", "pluck1"}

   track1 =
      {"440", "660", "880", "drum1", "drum2", "drum3", "pluck1"}

   sounds = {}
   meter = math.random(3,5)
--   meter = 3
   tangoSize = 5
   scoreSize = meter * 2 -- 10 is constant
   debug = true
   current = {}
   switchSpeed = 10 -- seconds?

   tempo = 0.5 -- seconds

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

   print("current contents:")
   if debug then
      for i=1,#current do
	 print(current[i])
      end
   end

   for i=1,#soundNames do
      local p = love.audio.newSource("sound/" .. soundNames[i] .. ".ogg", "static")
      table.insert(sounds, p)
   end


   score = {}
--   score = {sounds[1], sounds[2],sounds[2]}
   for i=1,scoreSize do
      local r = math.random(1,#sounds)
      score[i] = sounds[r]
   end

--   love.audio.play(sounds[1])
   
end

function updateRhythm (dt)

   -- switch here

   tempoCounter = dt + tempoCounter

--   print ("tempoCounter: " .. tempoCounter)

   if tempoCounter >= tempo then
      
      tempoCounter = tempoCounter - tempo

      tangoCounter = tangoCounter + 1
      scoreCounter = scoreCounter + 1
      switchCounter = switchCounter + 1

      if switchCounter >= switchSpeed then 
	 current = tango[math.random(1,#tango)]
	 switchCounter = 1
      end

      print(gridtest)

      print("current contents:")
      if debug then
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



      if current[tangoCounter] then
	 updateEnemies()
	 love.audio.play(score[scoreCounter])
      end

   end

end

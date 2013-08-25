function initParticle ()

   burstImg = love.graphics.newImage("graphics/twin-part.png")

   particles = {}

   burst = {}
   burst.scale = 1 
   burst.width = burstImg:getWidth()
   burst.height = burstImg:getHeight()
   -- laser burst: set bunch of properties for it
   burst.particle = love.graphics.newParticleSystem(burstImg, 10)
   burst.particle:setLifetime(1)
   burst.particle:setSpread(math.rad(45)) -- in radians! this bug was not fun to track down
   burst.particle:setEmissionRate(100)
   burst.particle:setSpeed(100, 200)
   burst.particle:setGravity(0)
   burst.particle:setSizes(2, 1)
   burst.particle:setColors(255, 255, 255, 255, 58, 128, 255, 0)
--   burst.particle:setColors(220, 105, 20, 255, 194, 30, 18, 0) -- fire particle with part1.png
   burst.particle:setLifetime(0.25)
   burst.particle:setParticleLife(0.5)
--   burst.particle:setLifetime(1)
--   burst.particle:setParticleLife(1)
   burst.particle:setSpin(1)
   burst.particle:setSpinVariation(2,1)
   -- neat spinning effects with stuff like this
--   burst.particle:setRadialAcceleration(-2000)
--   burst.particle:setTangentialAcceleration(1000) 
   burst.particle:stop()

end


function endContact(laser, b, coll)

-- bah, numbering lasers won't work, because array changes, need pid or unique id
   print ("i: " .. i)
   print (laser .. " contacting " .. b)

end
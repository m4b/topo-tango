function initParticles ()

   particles = {}

   burstImg = love.graphics.newImage("image/twin-part.png")

   burst = {}
   burst.scale = 1
   burst.width = burstImg:getWidth()
   burst.height = burstImg:getHeight()
   -- laser burst: set bunch of properties for it
   burst.particle = love.graphics.newParticleSystem(burstImg, 100)
   burst.particle:setLifetime(1)
   burst.particle:setSpread(math.rad(360)) -- in radians! this bug was not fun to track down
   burst.particle:setEmissionRate(100)
   burst.particle:setSpeed(100, 200)
   burst.particle:setGravity(0)
   burst.particle:setSizes(3, 5)
   burst.particle:setColors(255, 255, 255, 255, 0, 153, 255, 0)
--   burst.particle:setColors(220, 105, 20, 255, 194, 30, 18, 0) -- fire particle with part1.png
   burst.particle:setLifetime(0.5)
   burst.particle:setParticleLife(0.5)
   burst.particle:setSpin(math.pi/2)
   burst.particle:setSpinVariation(0,1)
   burst.particle:setRadialAcceleration(-1000)
--   burst.particle:setTangentialAcceleration(-100) 
   burst.particle:stop()

   particles.burst = burst

end


function startParticles(x,y)

   particles.burst.particle:setPosition(x, y)
   particles.burst.particle:setDirection((math.rad(90)))
   particles.burst.particle:start()

end

function drawParticles()

   for _,i in pairs(particles) do
--      love.graphics.setColorMode("modulate")
      love.graphics.setBlendMode("additive")
      love.graphics.draw(i.particle)
      love.graphics.setBlendMode("alpha")
   end

end

function updateParticles (dt)

   for _,i in pairs(particles) do
      i.particle:update(dt)
   end
end

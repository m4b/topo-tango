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

   boss = {}
   boss.scale = 1
   boss.width = burstImg:getWidth()
   boss.height = burstImg:getHeight()
   -- laser boss: set bunch of properties for it
   boss.particle = love.graphics.newParticleSystem(burstImg, 100)
   boss.particle:setLifetime(1)
   boss.particle:setSpread(math.rad(360)) -- in radians! this bug was not fun to track down
   boss.particle:setEmissionRate(100)
   boss.particle:setSpeed(100, 200)
   boss.particle:setGravity(0)
   boss.particle:setSizes(1, 3)
   boss.particle:setColors(220, 105, 20, 255, 194, 30, 18, 0) -- fire particle with part1.png
   boss.particle:setLifetime(0.5)
   boss.particle:setParticleLife(0.5)
   boss.particle:setSpin(math.pi/2)
   boss.particle:setSpinVariation(0,1)
--   boss.particle:setRadialAcceleration(-1000)
--   boss.particle:setTangentialAcceleration(-100) 
   boss.particle:stop()

   particles.boss = boss

end

function startParticles(x,y)

   particles.burst.particle:setPosition(x, y)
   particles.burst.particle:setDirection((math.rad(90)))
   particles.burst.particle:start()

end

function startBossParticles(x,y,name)

   particles.boss.particle:setColors(153, 255, 0, 255, 194, 30, 18, 0)
   if name == "player_0" then
      particles.boss.particle:setColors(255, 153, 0, 255, 194, 30, 18, 0)
   end
   particles.boss.particle:setPosition(x, y)
   particles.boss.particle:setDirection((math.rad(90)))
   particles.boss.particle:start()

end

function startBossExplode(x,y)

   particles.boss.particle:setEmissionRate(400)
   particles.boss.particle:setSpeed(200, 400)
   particles.boss.particle:setGravity(0)
   particles.boss.particle:setSizes(4, 10)
   particles.boss.particle:setColors(220, 105, 20, 255, 194, 30, 18, 0) -- fire 
   particles.boss.particle:setLifetime(4.0)
   particles.boss.particle:setParticleLife(1.0)

   particles.boss.particle:setPosition(x, y)
   particles.boss.particle:setDirection((math.rad(90)))
   particles.boss.particle:setRadialAcceleration(-1000)
--   particles.boss.particle:setTangentialAcceleration(-100) 
   particles.boss.particle:start()

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





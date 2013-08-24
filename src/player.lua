player = class:new()

function player:init(x,y)

   self.debug = true
   self.players = {}
   self.radius = 7
   self.speed = 10
   self.rotSpeed = 10

   for i = 0, 1  do 
      local p = {}
      local x = math.random(0,world.width)
      local y = math.random(0,world.height)
      p.body = love.physics.newBody(world.world, x, y, "dynamic")
      p.shape = love.physics.newCircleShape(self.radius)
      p.fixture = love.physics.newFixture(p.body, p.shape)
      p.fixture:setUserData("player" .. i)
      p.fixture:setRestitution(0)
      p.body:applyForce(math.random(-300,300),math.random(-300,300))
      p.body:setFixedRotation(true)
      --p.body:applyAngularImpulse(math.random(-100,100))

      table.insert(self.players,p)
   end

end

function player:draw()
--      print(self.players)
   for i = 1, #self.players do
      local rot = self.players[i].body:getAngle() - math.rad(90)
      local rad = self.players[i].shape:getRadius()
      local x = self.players[i].body:getX()
      local y = self.players[i].body:getY()

      love.graphics.setColor(255,255,255)
      love.graphics.circle("fill", x,y,rad,16)
      if self.debug then 
	 local x2 = x + (math.cos (rot) * self.radius)
	 local y2 = y + (math.sin (rot) * self.radius)
	 love.graphics.circle("fill", x, y, rad)
	 love.graphics.setColor(0, 0, 0)
	 love.graphics.line(x, y, x2, y2)
      end
   end
end

function player:move(dt)

   local rot = self.players[1].body:getAngle()
   local xrotfactor = math.sin(rot)
   local yrotfactor = math.cos(rot)

   if love.keyboard.isDown ("w") then
      self.players[1].body:applyForce(self.speed * xrotfactor,-self.speed * yrotfactor)
   end

   if love.keyboard.isDown("s") then
      self.players[1].body:applyForce(-self.speed * xrotfactor,self.speed * yrotfactor)
   end

   if love.keyboard.isDown("a")then
      self.players[1].body:setAngle(rot - (self.rotSpeed * dt))

   end
      
   if love.keyboard.isDown("d") then
      self.players[1].body:setAngle(rot + (self.rotSpeed * dt))
   end


end
player = class:new()

function player:init(x,y)

   self.debug = true
   self.players = {}
   self.radius = 8

   for i = 0, 1  do 
      local p = {}
      p.body = love.physics.newBody(world.world, world.height/2, world.width/2, "dynamic")
      p.shape = love.physics.newCircleShape(self.radius)
      p.fixture = love.physics.newFixture(p.body, p.shape)
      p.fixture:setUserData("player" .. i)
      p.fixture:setRestitution(0.4)
      p.body:applyForce(math.random(-300,300),math.random(-300,300))
      p.body:applyAngularImpulse(math.random(-100,100))

      table.insert(self.players,p)
   end

end

function player:draw()
--      print(self.players)
   for i = 1, #self.players do
      local rot = self.players[i].body:getAngle()
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
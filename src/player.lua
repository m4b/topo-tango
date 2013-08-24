player = class:new()

function player:init(x,y)

   self.debug = true
   self.players = {}
   self.radius = 20

   for i = 0, 1  do 
      local p = {}
      p.body = love.physics.newBody(world.world, 0, 0, "dynamic")
      p.shape = love.physics.newCircleShape(self.radius)
      p.fixture = love.physics.newFixture(p.body, p.shape)
      p.fixture:setUserData("player" .. i)
      p.fixture:setRestitution(0.9)
      table.insert(p,self.players)
   end

end

function player:draw()

   for i = 0, #self.players - 1 do
      love.graphics.setColor(255,255,255)
      love.graphics.circle("fill", self.players[i].body:getX(), self.players[i].body:getY(), self.players[i].shape:getRadius(), 16)

   end

--[[
   love.graphics.draw(img, -- what image we draw
      self.x, self.y, -- where
      self.rot, -- rotation to apply
      self.scale, self.scale, -- x,y scale
      self.width/2, self.height/2) -- offset
   -- last two parameters allow us to rotate about center of image
   end
   --]]

end
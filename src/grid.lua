grid = class:new()

function grid:init()

   self.grid = {}
   self.width = 40
   self.height = 30
   self.dim = 16
   self.debug = true

   for i=1,self.width do
--      self.grid[i] = {}
      for j=1,self.height do
	 local create = math.random(0,5)
	 if create == 1 then
	    local p = {}
	    p.body = love.physics.newBody(world.world, (i*self.dim), (j*self.dim), "static")
	    p.shape = love.physics.newRectangleShape(self.dim*-.5, self.dim*-.5, self.dim, self.dim)
	    p.fixture = love.physics.newFixture(p.body, p.shape)
	    p.fixture:setUserData("grid_" .. i .. "_" .. j)
	    table.insert(self.grid,p)
	    --	 self.grid[i][j] = 0
	 end
      end
   end

end

function grid:draw()
   
   love.graphics.setColor(255,0,0)
   for i=1,#self.grid do

      love.graphics.polygon("fill", self.grid[i].body:getWorldPoints(self.grid[i].shape:getPoints()))
      
--	    love.graphics.rectangle("fill", i*16, j*16, 16, 16)
   end

end


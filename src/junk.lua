function initJunk ()

   junk = {}
   numJunk = 200
   widthVariance = 4
   heightVariance = 8
   colorVariance = 1

   local r = 0
   local g = 96
   local b = 96

   for i=1,numJunk do
      local emptyCoords = getEmptyTile()
      local p ={}
      local x = (emptyCoords.x* 16) + math.random(1,15)
      local y = (emptyCoords.y* 16)  + math.random(1,15)
      local width = math.random(2,widthVariance)
      local height = math.random(2,heightVariance)
      local type
      -- add third kind for joints
      type = addPhysicsCircleTo(p, x, y, width, "dynamic", "junk")


      --[[
      if (math.random(0,1) == 1) then
	 type = addPhysicsRectangleTo(p, x, y, width, height, "dynamic", "junk")
	 p.draw=function() 
	    love.graphics.polygon("fill", p.physics.body:getWorldPoints(p.physics.shape:getPoints()))
	 end
      else
	 local x1 = x
	 local y1 = y
	 local x2 = x - (width/2)
	 local y2 = y + height
	 local x3 = x + (width/2)
	 local y3 = y + height
	 print ("x1:" .. x1)
	 print ("y1:" .. y1)
	 type = addPhysicsPolygonTo(p, x, y, x1, y1, x2, y2, x3, y3, "dynamic", "junk")
      end
      --]]

      addColorTo(p,
		 r,
		 g,
		 b)
      table.insert(junk, p)
   end

   --[[

   testJunk = {}
   for i=1,10 do
      local emptyCoords = getEmptyTile()
      local x = (emptyCoords.x * 16) + (math.random(1,16))
      local y = (emptyCoords.y * 16) + (math.random(1,16))
      local type
      local p = {}
      local type2
      local p2 = {}
      local width = math.random(4,widthVariance)
      local height = math.random(4,heightVariance)
      type = addPhysicsRectangleTo(p, x, y, width, height, "dynamic", "junk")
      type2 = addPhysicsRectangleTo(p2, x+width, y+height, width, height, "dynamic", "junk")
      p.draw=function() 
	 love.graphics.polygon("fill", p.physics.body:getWorldPoints(p.physics.shape:getPoints()))
      end
      p2.draw=function() 
	 love.graphics.polygon("fill", p2.physics.body:getWorldPoints(p2.physics.shape:getPoints()))
      end

      joint = love.physics.newDistanceJoint(p.physics.body, p2.physics.body, x, y, x+width, y+height, true )
      

      addColorTo(p,
		 255,
		 0,
		 0)

      addColorTo(p2,
		 255,
		 0,
		 0)

      table.insert(testJunk, p)
      table.insert(testJunk, p2)

   end
   --]]   

end

function drawJunk ()

   for i=1,#junk do
      junk[i].setColor()
      love.graphics.setBlendMode("additive")
--      love.graphics.setColorMode("modulate")
      junk[i].draw()
      love.graphics.setBlendMode("alpha")
   end
   --[[
   for i=1,#testJunk do
      testJunk[i].setColor()
      testJunk[i].draw()
   end
   --]]

end

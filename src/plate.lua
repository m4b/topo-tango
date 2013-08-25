function initPlate()

   plateWidth = 2
   plateHeight = 12
   
--   numEnemies = 10 -- REMEMBER TO USE LUKE'S ENEMY VALUE AFTER PUSHES
   numPlates = numEnemies

   plates={}

--   enemies = {}
   local counter = 0
   plateEnemies=enemies
   for _,i in pairs(enemies) do
      
      local left = {}
      local right = {}
      local e = i.physics
      local b = i.physics.body
      local x = e.body:getX()
      local y = e.body:getY()
      addPhysicsRectangleTo(left,
			    x-(plateWidth/2),
			    y+(i.height/2)-(plateHeight/2),
			    plateWidth, plateHeight, "dynamic", "plate"..counter)

      addPhysicsRectangleTo(right,
			    x+i.width-(plateWidth/2),
			    y+(i.height/2)-(plateHeight/2),
			    plateWidth, plateHeight, "dynamic", "plate"..counter)
      e.plate = {}
      e.plate.left = left
      e.plate.right = right
      i.physics.ljoint = love.physics.newWeldJoint(b,left.physics.body, x-(i.width/2), y, false)
      i.physics.rjoint = love.physics.newWeldJoint(b,right.physics.body, x+(i.width/2), y, false)
      table.insert(plates,e.plate)
      counter = counter + 1
   end

end

function drawPlate()

   for _,i in pairs(plates) do
      love.graphics.setColor(255,0,0)
      i.left.draw()
      love.graphics.setColor(0,255,0)
      i.right.draw()
   end
   

end

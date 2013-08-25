numPlayers = 0

function addControlsTo(object, up, down, left, right) -- assumes object has physics.body
	object.controls = function(dt)
		if love.keyboard.isDown(up)    then object.physics.body:applyForce(       0, -dt*100) end
		if love.keyboard.isDown(down)  then object.physics.body:applyForce(       0,  dt*100) end
		if love.keyboard.isDown(left)  then object.physics.body:applyForce(-dt*100,        0) end
		if love.keyboard.isDown(right) then object.physics.body:applyForce( dt*100,        0) end
	end
end

function createPlayer(x, y,                  -- position
                      r, g, b,               -- color
                      up, down, left, right) -- controls
	local player = {}
	numPlayers = numPlayers + 1 -- added
	addPhysicsCircleTo(player, x, y, 7, 'dynamic', 'player')
	addColorTo(player, r, g, b)
	addControlsTo(player, up, down, left, right)

	player.draw = function()
		color = ((math.sin(love.timer.getTime()*tempo*10)*.5)+.5)*255

		love.graphics.setColor(color,color,color)
		love.graphics.circle('fill', 
		                     player.physics.body:getX(), 
		                     player.physics.body:getY(), 
		                     10, 
		                     32)

		player.setColor()
		love.graphics.circle('fill', 
		                     player.physics.body:getX(), 
		                     player.physics.body:getY(), 
		                     player.radius, 
		                     32)

		love.graphics.setColor(255-color,255-color,255-color)
		love.graphics.circle('fill', 
		                     player.physics.body:getX(), 
		                     player.physics.body:getY(), 
		                     3, 
		                     32)
	end

	return player
end




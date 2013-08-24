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
	addPhysicsCircleTo(player, x, y, 7, 'dynamic', "CALLBACK")
	addColorTo(player, r, g, b)
	addControlsTo(player, up, down, left, right)
	return player
end

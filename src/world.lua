function initWorld()
	love.physics.setMeter(100)
	world = love.physics.newWorld(0, 0, false)
	world:setCallbacks(beginContact, endContact, preSolve, postSolve)
end

function updateWorld(dt)
	world:update(dt)
end

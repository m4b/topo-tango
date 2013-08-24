function initWorld()
	love.physics.setMeter(100)
	world = love.physics.newWorld(0, 0, true)
end

function updateWorld(dt)
	world:update(dt)
end

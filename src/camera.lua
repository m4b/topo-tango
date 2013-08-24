function initCamera()
	camera = {}
	camera.goal = {}

	camera.x    = windowWidth/2
	camera.y    = windowHeight/2
	camera.zoom = 1

	camera.goal.x    = windowWidth/2
	camera.goal.y    = windowHeight/2
	camera.goal.zoom = 1
end

function updateCamera(dt)
	local minX = windowWidth*100
	local maxX = -windowWidth*100
	local minY = windowHeight*100
	local maxY = -windowHeight*100

	for _,i in pairs(players) do
		if i.physics.body:getX() < minX then minX = i.physics.body:getX() end
		if i.physics.body:getX() > maxX then maxX = i.physics.body:getX() end
		if i.physics.body:getY() < minY then minY = i.physics.body:getY() end
		if i.physics.body:getY() > maxY then maxY = i.physics.body:getY() end
	end

	minX = minX - 128
	maxX = maxX + 128
	minY = minY - 128
	maxY = maxY + 128

	camera.goal.x = (maxX+minX)/2
	camera.goal.y = (maxY+minY)/2
	local scaleX = windowWidth/(maxX-minX)
	local scaleY = windowHeight/(maxY-minY)
	camera.goal.zoom = math.min(scaleX,scaleY)

	camera.x = camera.x + ((camera.goal.x - camera.x) * dt * 4)
	camera.y = camera.y + ((camera.goal.y - camera.y) * dt * 4)
	camera.zoom = camera.zoom + ((camera.goal.zoom - camera.zoom) * dt * 4)
end

function drawCamera()
	love.graphics.translate(windowWidth/2,windowHeight/2)
	love.graphics.scale(camera.zoom,camera.zoom)
	love.graphics.translate(-camera.x,-camera.y)
end

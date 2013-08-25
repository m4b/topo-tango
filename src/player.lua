function initPlayers()
	players = {}
	playerCounter = 0
	points = 0

	local redCoords = getEmptyTile()
	local blueCoords = getEmptyTile()
	player1 = createPlayer(redCoords.x*16+8, redCoords.y*16+8, 255, 153, 0, 0, 'w', 's', 'a', 'd')
	player2 = createPlayer(blueCoords.x*16+8, blueCoords.y*16+8, 153, 255, 0, 1, 'up', 'down', 'left', 'right')
	table.insert(players, player1)
	table.insert(players, player2)
end

function drawPlayers()
	love.graphics.setColor(255,255,255,64)
	for a, i in pairs(players) do
		for b, j in pairs(players) do
			if a ~= b then
				love.graphics.line(i.physics.body:getX(),
				                   i.physics.body:getY(),
				                   j.physics.body:getX(),
				                   j.physics.body:getY())
			end
		end
	end

	for _, i in pairs(players) do
		i.setColor()
		i.draw()
	end
end

function processControls(dt)
	for _, i in pairs(players) do
		i.controls(dt)
	end
end

function getPlayerByName(name)
	for _,i in pairs(players) do
		if name == i.physics.fixture:getUserData() then
			return i
		end
	end
end

function deletePlayer(player)
	for index,i in pairs(players) do
		if player == i then
			table.remove(players,index)
			return
		end
	end
end

--------------------------------------------------------------------------------

function addControlsTo(object, up, down, left, right) -- assumes object has physics.body
	object.controls = function(dt)
		if love.keyboard.isDown(up)    then object.physics.body:applyForce(        0,-dt*30000) end
		if love.keyboard.isDown(down)  then object.physics.body:applyForce(        0, dt*30000) end
		if love.keyboard.isDown(left)  then object.physics.body:applyForce(-dt*30000,        0) end
		if love.keyboard.isDown(right) then object.physics.body:applyForce( dt*30000,        0) end
	end
end

function createPlayer(x, y,                  -- position
                      r, g, b, colorState,   -- color
                      up, down, left, right) -- controls

	local player = {}

	player.colorState = colorState
	player.hp = 100

	addPhysicsCircleTo(player, x, y, 7, 'dynamic', "player_"..playerCounter)
	playerCounter = playerCounter + 1

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

require 'rhythm'

function initEnemies()
	enemyWalkSpeed = 100
	enemyRotationSpeed = 10
	enemies = {}
	numEnemies = 100

	for i=1,numEnemies do
		local emptyCoords = getEmptyTile(grid)
		table.insert(enemies, createEnemy(emptyCoords.x, emptyCoords.y, 0))
	end
end

function updateEnemies()
	for _, i in pairs(enemies) do
		i.readNextNote()
	end
end

function createEnemy(x, y, rotation)
	local enemy = {}

	enemy.state = math.random(0,1)

	-- goal location & rotation in grid, exact
	enemy.grid = {}
	enemy.grid.x = x
	enemy.grid.y = y
	enemy.grid.rotation = rotation

	-- goal location & rotation in grid, pixel val
	enemy.goal = {}
	enemy.goal.x = x*16
	enemy.goal.y = y*16
	enemy.goal.rotation = rotation*math.pi/2

	-- location & rotation in grid, pixel val
	addPhysicsRectangleTo(enemy, x*16, y*16, 16, 16, 'static', "enemy")

	-- movement sequence and track #
	enemy.sequence = {}
--	enemy.track = math.random("NUMBER OF TRACKS | BASE")
	for i = 1,meter do enemy.sequence[i] = math.random(6) end

	-- update regardless of beat
	enemy.update = function(dt)

		local gridX = enemy.grid.x * 16
		local gridY = enemy.grid.y * 16
		local gridRot = enemy.grid.rotation

		if enemy.goal.x < gridX then
			enemy.goal.x = enemy.goal.x + dt * enemyWalkSpeed
			if enemy.goal.x > gridX then enemy.goal.x = gridX end
		end

		if enemy.goal.x > gridX then
			enemy.goal.x = enemy.goal.x - dt * enemyWalkSpeed
			if enemy.goal.x < gridX then enemy.goal.x = gridX end
		end

		if enemy.goal.y < gridY then
			enemy.goal.y = enemy.goal.y + dt * enemyWalkSpeed
			if enemy.goal.y > gridY then enemy.goal.y = gridY end
		end

		if enemy.goal.y > gridY then
			enemy.goal.y = enemy.goal.y - dt * enemyWalkSpeed
			if enemy.goal.y < gridY then enemy.goal.y = gridY end
		end

		if enemy.goal.rotation < gridRot then
			enemy.goal.rotation = enemy.goal.rotation + dt * enemyRotationSpeed
			if enemy.goal.rotation > gridRot then enemy.goal.rotation = gridRot end
		end

		if enemy.goal.rotation > gridRot then
			enemy.goal.rotation = enemy.goal.rotation - dt * enemyRotationSpeed
			if enemy.goal.rotation < gridRot then enemy.goal.rotation = gridRot end
		end

	--	local phyX = enemy.physics.body:getX()
	--	local phyY = enemy.physics.body:getY()
	--	enemy.physics.body:setX(phyX + ((enemy.goal.x - phyX) * dt * enemyWalkSpeed))
	--	enemy.physics.body:setY(phyY + ((enemy.goal.y - phyY) * dt * enemyWalkSpeed))
		enemy.physics.body:setX(enemy.goal.x)
		enemy.physics.body:setY(enemy.goal.y)
	end

	-- call on beat
	enemy.readNextNote = function()
		local nextNote = enemy.sequence[tangoCounter]
		local newX = enemy.grid.x
		local newY = enemy.grid.y

		    if nextNote == 1 then newX = newX + 1 -- NEED TO TAKE INTO ACCOUNT ROTATION
		elseif nextNote == 2 then newX = newX - 1 -- NEED TO TAKE INTO ACCOUNT ROTATION
		elseif nextNote == 3 then newY = newY + 1 -- NEED TO TAKE INTO ACCOUNT ROTATION
		elseif nextNote == 4 then newY = newY - 1 -- NEED TO TAKE INTO ACCOUNT ROTATION
		elseif nextNote == 5 then enemy.grid.rotation = enemy.grid.rotation + 1
		elseif nextNote == 6 then enemy.grid.rotation = enemy.grid.rotation - 1
		end

		-- VALIDATE MOVEMENT
		if grid[newX][newY] == 0 then
			grid[enemy.grid.x][enemy.grid.y] = 0
			enemy.grid.x = newX
			enemy.grid.y = newY
			grid[newX][newY] = 2
		end
	end

	-- draw
		enemy.draw = function()
		love.graphics.push()
			love.graphics.translate(enemy.goal.x+8,enemy.goal.y+8)
			love.graphics.rotate(enemy.goal.rotation*math.pi*.5)
			love.graphics.setColor(255,255,255)
			love.graphics.rectangle('fill',-8,-8,16,16)
			if enemy.state == 0 then love.graphics.setColor(255,153,0);
			                    else love.graphics.setColor(153,255,0);end
			love.graphics.rectangle('fill',-5,-5,10,10)
		love.graphics.pop()
	end

	return enemy
end

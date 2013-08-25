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

function updateEnemies(dt)
	for _, i in pairs(enemies) do
	   i.update(dt)
	end
end

function enemyStep()
	for _, i in pairs(enemies) do
		i.readNextNote()
	end
end

function drawEnemies()
	love.graphics.setColor(255,255,255)
	for _, i in pairs(enemies) do
		i.draw()
	end
end

function createEnemy(x, y, rotation)
	local enemy = {}

	enemy.invertedStep = math.random(0,1)

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
	addPhysicsRectangleTo(enemy, x*16, y*16, 16, 16, 'static', "CALLBACK")

	-- movement sequence and track #
	enemy.sequence = {}
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

		enemy.physics.body:setX(enemy.goal.x)
		enemy.physics.body:setY(enemy.goal.y)
	end

	-- call on beat
	enemy.readNextNote = function()
		if (current[tangoCounter] and enemy.invertedStep == 1) or ((not current[tangoCounter]) and enemy.invertedStep == 0) then
			local nextNote = enemy.sequence[tangoCounter]
			local newX = enemy.grid.x
			local newY = enemy.grid.y
			local direction = enemy.grid.rotation%4

			if direction == 0 then
				    if nextNote == 1 then newX = newX + 1
				elseif nextNote == 2 then newX = newX - 1
				elseif nextNote == 3 then newY = newY + 1
				elseif nextNote == 4 then newY = newY - 1
				elseif nextNote == 5 then enemy.grid.rotation = enemy.grid.rotation + 1
				elseif nextNote == 6 then enemy.grid.rotation = enemy.grid.rotation - 1
				end
			elseif direction == 1 then
				    if nextNote == 1 then newY = newY + 1
				elseif nextNote == 2 then newY = newY - 1
				elseif nextNote == 3 then newX = newX - 1
				elseif nextNote == 4 then newX = newX + 1
				elseif nextNote == 5 then enemy.grid.rotation = enemy.grid.rotation + 1
				elseif nextNote == 6 then enemy.grid.rotation = enemy.grid.rotation - 1
				end
			elseif direction == 2 then
				    if nextNote == 1 then newX = newX - 1
				elseif nextNote == 2 then newX = newX + 1
				elseif nextNote == 3 then newY = newY - 1
				elseif nextNote == 4 then newY = newY + 1
				elseif nextNote == 5 then enemy.grid.rotation = enemy.grid.rotation + 1
				elseif nextNote == 6 then enemy.grid.rotation = enemy.grid.rotation - 1
				end
			elseif direction == 3 then
				    if nextNote == 1 then newY = newY - 1
				elseif nextNote == 2 then newY = newY + 1
				elseif nextNote == 3 then newX = newX + 1
				elseif nextNote == 4 then newX = newX - 1
				elseif nextNote == 5 then enemy.grid.rotation = enemy.grid.rotation + 1
				elseif nextNote == 6 then enemy.grid.rotation = enemy.grid.rotation - 1
				end
			end

			-- VALIDATE MOVEMENT
			if grid[newX][newY] == 0 then
				grid[enemy.grid.x][enemy.grid.y] = 0
				enemy.grid.x = newX
				enemy.grid.y = newY
				grid[newX][newY] = 2
			end
		end
	end

	-- draw
		enemy.draw = function()
		love.graphics.push()
			love.graphics.translate(enemy.goal.x+8,enemy.goal.y+8)
			love.graphics.rotate(enemy.goal.rotation*math.pi*.5)
			love.graphics.setColor(255,255,255)
			love.graphics.rectangle('fill',-8,-8,16,16)
			if enemy.invertedStep == 0 then love.graphics.setColor(255,153,0);
			                    else love.graphics.setColor(153,255,0);end
			love.graphics.rectangle('fill',-5,-5,10,10)
		love.graphics.pop()
	end

	return enemy
end

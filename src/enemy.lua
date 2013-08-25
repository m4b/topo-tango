require 'rhythm'

function initEnemies()
	enemyCounter = 0
	enemyWalkSpeed = 100
	enemyRotationSpeed = 10
	enemies = {}
	numEnemies = 20

	for i=1,numEnemies do
		local emptyCoords = getEmptyTile()
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

function getEnemyByName(name)
	for _,i in pairs(enemies) do
		if name == i.physics.fixture:getUserData() then
			return i
		end
	end
end

function deleteEnemy(enemy)
	enemy.physics.body:destroy()
	for index,i in pairs(enemies) do
		if enemy == i then
			table.remove(enemies,index)
			return
		end
	end
end

--------------------------------------------------------------------------------

function createEnemy(x, y, rotation)
	local enemy = {}

	enemy.invertedStep = math.random(0,1)
	enemy.colorState = math.random(0,1)
	enemy.hp = 5
	enemy.pulseOffset = math.random(0,10)/10 * math.pi

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
	addPhysicsRectangleTo(enemy, x*16, y*16, 16, 16, 'static', "enemy_"..enemyCounter)
	enemyCounter = enemyCounter + 1

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
			if grid[newX][newY] < 2 then
				grid[enemy.grid.x][enemy.grid.y] = 0
				enemy.grid.x = newX
				enemy.grid.y = newY
				grid[newX][newY] = 2
			end
		end
	end

	enemy.draw = function()
		love.graphics.push()
			local r,g
			local radius = enemy.hp + 1
			local pulse = math.sin(love.timer.getTime()*8+enemy.pulseOffset)*.5+.5
			if enemy.colorState == 0 then r,g = 255,153
			                         else r,g = 153,255 end

			love.graphics.translate(enemy.goal.x+8,enemy.goal.y+8)
			love.graphics.rotate(enemy.goal.rotation*math.pi*.5)

			love.graphics.setColor(r+(255-r)*pulse,g+(255-g)*pulse,255*pulse)
--			love.graphics.rectangle('fill',-8,-8,16,16)

			love.graphics.rectangle('fill',-8, -7, 16, 14)
			love.graphics.rectangle('fill', -7,-8, 14, 16)
			love.graphics.triangle('fill', -7, -8, -8, -7, -7, -7)
			love.graphics.triangle('fill',  7, -8,  8, -7,  7, -7)
			love.graphics.triangle('fill', -7,  8, -8,  7, -7,  7)
			love.graphics.triangle('fill',  7,  8,  8,  7,  7,  7)

			love.graphics.setColor(r+(255-r)*(1-pulse),g+(255-g)*(1-pulse),255*(1-pulse))
			love.graphics.rectangle('fill',-radius,-radius,radius*2,radius*2)
			love.graphics.rectangle('fill',-2,4,4,8)
		love.graphics.pop()
	end

	return enemy
end

function initEnemies()
	enemySpeed = 10
	enemies = {}

	for i=1,10 do
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
--	enemy.track = math.random("NUMBER OF TRACKS | BASE")
	for i = 0,meter-1 do enemy.sequence[i] = math.random(6) end

	-- update regardless of beat
	enemy.update = function(dt)
		if tempoCounter >= tempo then
			enemy.readNextNode()
		end

		local gridX = enemy.grid.x * 16
		local gridY = enemy.grid.y * 16
		local gridRot = enemy.grid.rotation

		if enemy.goal.x < gridX then
			enemy.goal.x = enemy.goal.x + dt * enemySpeed
			if enemy.goal.x > gridX then enemy.goal.x = gridX end
		end

		if enemy.goal.x > gridX then
			enemy.goal.x = enemy.goal.x - dt * enemySpeed
			if enemy.goal.x < gridX then enemy.goal.x = gridX end
		end

		if enemy.goal.y < gridY then
			enemy.goal.y = enemy.goal.y + dt * enemySpeed
			if enemy.goal.y > gridY then enemy.goal.y = gridY end
		end

		if enemy.goal.y > gridY then
			enemy.goal.y = enemy.goal.y - dt * enemySpeed
			if enemy.goal.y < gridY then enemy.goal.y = gridY end
		end

		if enemy.goal.rotation < gridRot then
			enemy.goal.rotation = enemy.goal.rotation + dt * enemySpeed
			if enemy.goal.rotation > gridRot then enemy.goal.rotation = gridRot end
		end

		if enemy.goal.rotation > gridRot then
			enemy.goal.rotation = enemy.goal.rotation - dt * enemySpeed
			if enemy.goal.rotation < gridRot then enemy.goal.rotation = gridRot end
		end
	end

	-- call on beat
	enemy.readNextNote = function()
		local nextNote = enemy.sequence[timeCurrentBeat%meter]

		    if nextNote == 1 then enemy.grid.x = enemy.grid.x + 1 -- NEED TO TAKE INTO ACCOUNT ROTATION
		elseif nextNote == 2 then enemy.grid.x = enemy.grid.x - 1 -- NEED TO TAKE INTO ACCOUNT ROTATION
		elseif nextNote == 3 then enemy.grid.y = enemy.grid.y + 1 -- NEED TO TAKE INTO ACCOUNT ROTATION
		elseif nextNote == 4 then enemy.grid.y = enemy.grid.y - 1 -- NEED TO TAKE INTO ACCOUNT ROTATION
		elseif nextNote == 5 then enemy.grid.rotation = enemy.grid.rotation + 1
		elseif nextNote == 6 then enemy.grid.rotation = enemy.grid.rotation - 1
		end

		-- VALIDATE MOVEMENT
	end

	-- draw
	enemy.draw = function()
		love.graphics.push()
		--	love.graphics.translate(enemy.physics.body:getX()+8,enemy.physics.body:getY()+8)
		--	love.graphics.translate(enemy.goal.x+8,enemy.goal.y+8)
			love.graphics.translate(enemy.grid.x*16+8,enemy.grid.y*16+8)
			love.graphics.rotate(enemy.goal.rotation*math.pi*.5)
			love.graphics.rectangle('fill',-8,-8,16,16)
		love.graphics.pop()
	end

	return enemy
end

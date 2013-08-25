function initBoss()
	bossSpawned = false
end

function spawnBoss()
	boss = {}
	local coords = getEmptyTile()
	local x = coords.x*16+8
	local y = coords.y*16+8

	addPhysicsCircleTo(boss, x, y, 24, 'dynamic', 'boss')

	boss.sequence = {}
	for i = 1,meter do boss.sequence[i] = math.random(6) end

	boss.draw = function()
		love.graphics.push()
			love.graphics.translate(boss.physics.body:getX(),boss.physics.body:getY())
			love.graphics.rotate(boss.physics.body:getAngle())
			love.graphics.setColor(255,153,0)
			love.graphics.arc('fill',0,0,24,0,math.pi,16)
			love.graphics.setColor(153,255,0)
			love.graphics.arc('fill',0,0,24,-math.pi,0,16)
		love.graphics.pop()
	end
end

function bossStep()
	if boss then
		local nextNote = boss.sequence[tangoCounter]
		local angle = boss.physics.body:getAngle()

	--	    if nextNote == 1 then boss.physics.body:applyForce(math.cos(angle)*10000,math.sin(angle)*10000)
	--	elseif nextNote == 2 then boss.physics.body:applyForce(math.cos(angle+math.pi/2)*10000,math.sin(angle+math.pi/2)*10000)
	--	elseif nextNote == 3 then boss.physics.body:applyForce(math.cos(angle-math.pi/2)*10000,math.sin(angle-math.pi/2)*10000)
	--	elseif nextNote == 4 then boss.physics.body:applyForce(math.cos(angle+math.pi)*10000,math.sin(angle+math.pi)*10000)
	--	elseif nextNote == 5 then boss.physics.body:applyTorque(-1000)
	--	elseif nextNote == 6 then boss.physics.body:applyTorque(1000)
	--	end
	end
end

function updateBoss(dt)
	if table.getn(enemies) <= 0 and bossSpawned == false then
		bossSpawned = true
		spawnBoss()
	end

	if bossSpawned then

	end
end

function collideWithBoss(normX,normY,player)
	print(math.atan2(normY,normX))
end

function drawBoss()
	if boss then
		boss.draw()
	end
end

require 'particle'

function initBoss()
	bossSpawned = false
	defeatedBoss = false
end

function spawnBoss()
   if not defeatedBoss then
	boss = {}
	boss.maxHp = 20
	boss.hp = boss.maxHp
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
			love.graphics.setColor(255,255,255,128)
			love.graphics.circle('fill',0,0,(math.sin(love.timer.getTime()*10)*.5+.5)*(24*(boss.hp/boss.maxHp)))
		love.graphics.pop()
	end
   end
end

function bossStep()
	if bossSpawned then
		local nextNote = boss.sequence[tangoCounter]
		local angle = boss.physics.body:getAngle()

		    if nextNote == 1 then boss.physics.body:applyForce(math.cos(angle)*10000,math.sin(angle)*10000)
		elseif nextNote == 2 then boss.physics.body:applyForce(math.cos(angle+math.pi/2)*10000,math.sin(angle+math.pi/2)*10000)
		elseif nextNote == 3 then boss.physics.body:applyForce(math.cos(angle-math.pi/2)*10000,math.sin(angle-math.pi/2)*10000)
		elseif nextNote == 4 then boss.physics.body:applyForce(math.cos(angle+math.pi)*10000,math.sin(angle+math.pi)*10000)
		elseif nextNote == 5 then boss.physics.body:applyTorque(-1000)
		elseif nextNote == 6 then boss.physics.body:applyTorque(1000)
		end
	end
end

function updateBoss(dt)
	if table.getn(enemies) <= 0 and bossSpawned == false then
		bossSpawned = true
		spawnBoss()
	end
end

function collideWithBoss(normX,normY,player)
	local normAngle = math.atan2(normY,normX)
	local correctedAngle = normAngle-boss.physics.body:getAngle()
	while correctedAngle < -math.pi do correctedAngle = correctedAngle + (math.pi * 2) end
	while correctedAngle > math.pi do correctedAngle = correctedAngle - (math.pi * 2) end

	if player == player1 and correctedAngle < 0 then
	   boss.hp = boss.hp - 1 
	   points = points + 1
	end -- damage to boss
	if player == player1 and correctedAngle > 0 then
	   player1.hp = player1.hp - 1 
	end -- damage to player1
	if player == player2 and correctedAngle < 0 then
	   player2.hp = player2.hp - 1 
	end -- damage to player2
	if player == player2 and correctedAngle > 0 then
	   boss.hp = boss.hp - 1
	   points = points + 1
	end -- damage to boss

	if boss.hp <= 0 then
	   startBossExplode(boss.physics.body:getX(),boss.physics.body:getY())
	   boss.physics.body:destroy()
	   boss = nil
	   bossSpawned = false
	   bossDefeated = true
	end
end

function drawBoss()
	if bossSpawned then
	   boss.draw()
	end
end

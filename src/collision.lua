collisions = {}

function beginContact(a, b, coll)
	local obj = {}
	obj.x, obj.y = coll:getPositions()
	obj.radius = 1
	table.insert(collisions, obj)

	local playerName
	local enemyName
	if string.find(a:getUserData(),"player_") then playerName = a:getUserData() end
	if string.find(b:getUserData(),"player_") then playerName = b:getUserData() end
	if string.find(a:getUserData(),"enemy_") then enemyName = a:getUserData() end
	if string.find(b:getUserData(),"enemy_") then enemyName = b:getUserData() end
	if playerName and enemyName then
		local player = getPlayerByName(playerName)
		local enemy = getEnemyByName(enemyName)
		if player and enemy then
			if player.colorState == enemy.colorState then
				enemy.hp = enemy.hp - 1
				enemy.colorState = 1 - enemy.colorState
				points = points + 1
				if enemy.hp <= 0 then
					deleteEnemy(enemy)
					print("TANGO!")
				end
			else
				player.hp = player.hp - 1
				if player.hp <= 0 then deletePlayer(player) end	
			end
		end
	end
end

function drawCollisions()
	love.graphics.setColor(255,0,0)
	for _,i in pairs(collisions) do
		love.graphics.circle("fill",i.x,i.y,i.radius,32)
	end
end

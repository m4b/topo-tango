require 'world'
require 'camera'
require 'grid'
require 'drawing'
require 'physics'
require 'player'
require 'rhythm'
require 'enemy'
require 'plate'

function love.load()
   love.graphics.setMode(640, 480) --, false, true, 4)
	windowWidth = love.graphics.getWidth()
	windowHeight = love.graphics.getHeight()

	initWorld()

	grid = genLevel()
	entities = {}

	for i = 0, 39 do for j = 0, 29 do if grid[i][j] == 1 then
		local entity = {}
		addPhysicsRectangleTo(entity, i*16, j*16, 16, 16, 'static', 'CALLBACK')
		entity.draw = function() -- overwrite default physicsRectangle draw
			love.graphics.setColor(0,153,255)
			love.graphics.rectangle('fill', i*16, j*16+1, 16, 14)
			love.graphics.rectangle('fill', i*16+1, j*16, 14, 16)
		end
		table.insert(entities, entity)
	end end end

	players = {}
	local redCoords = getEmptyTile(grid)
	table.insert(players, createPlayer(redCoords.x*16+8, redCoords.y*16+8, 255, 153, 0, 'w', 's', 'a', 'd'))
	local blueCoords = getEmptyTile(grid)
	table.insert(players, createPlayer(blueCoords.x*16+8, blueCoords.y*16+8, 153, 255, 0, 'up', 'down', 'left', 'right'))


	initCamera()
	initRhythm()
	initEnemies()
--	initPlate()

end


                                ---- update ----

function love.update(dt)
	updateCamera(dt)
	updateWorld(dt)
	updateRhythm(dt)

	for _, i in pairs(players) do
		i.controls(dt)
	end

	for _, i in pairs(enemies) do
	   i.update(dt)
--	   i.physics.body:applyLinearImpulse(math.random(-10,10),math.random(-10,10))
	end
end

                                ---- render ----

function love.draw()
	drawCamera()


	love.graphics.setColor(32,32,32)
	-- draw the tiles
	for i = 0, 39 do for j = 0, 29 do
		love.graphics.rectangle('fill',i*16+2,j*16+2,12,12)
	end end

	for _, i in pairs(entities) do
		i.draw()
	end

	for _, i in pairs(players) do
		i.setColor()
		i.draw()
	end

	love.graphics.setColor(255,255,255)
	for _, i in pairs(enemies) do
		i.draw()
	end

--	drawPlate()

end

function love.keyreleased(key, unicode) if key == 'escape' then love.event.push('quit') end end

require 'world'
require 'camera'
require 'grid'
require 'drawing'
require 'physics'
require 'player'
require 'rhythm'
require 'enemy'
require 'plate'
require 'collision'

function love.load()
	love.graphics.setMode(640, 480)
	windowWidth = love.graphics.getWidth()
	windowHeight = love.graphics.getHeight()

	initWorld()
	initGrid()
	initPlayers()
	initCamera()
	initRhythm()
	initEnemies()
--	initPlate()

end

function love.update(dt)
	updateCamera(dt)
	updateWorld(dt)
	updateRhythm(dt)
	processControls(dt)
	updateEnemies(dt)
end

function love.draw()
	drawCamera()
	drawGrid()
	drawPlayers()
	drawEnemies()
--	drawPlate()

end

function love.keyreleased(key, unicode) if key == 'escape' then love.event.push('quit') end end

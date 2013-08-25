require 'world'
require 'camera'
require 'grid'
require 'drawing'
require 'physics'
require 'player'
require 'rhythm'
require 'enemy'
require 'plate'
require 'particle'
require 'collision'
require 'overlay'

globalDebug = true

function love.load()
	windowWidth = love.graphics.getWidth()
	windowHeight = love.graphics.getHeight()


	initWorld()
	initGrid()
	initPlayers()
	initCamera()
	initRhythm()
	initEnemies()
	initOverlays()
	initParticles()
	love.graphics.setNewFont(8)
--	love.graphics.setFont(love.graphics.newFont(8))
	love.graphics.setLineWidth(10)
end

function love.update(dt)
	updateCamera(dt)
	updateWorld(dt)
	updateRhythm(dt)
	updateParticles(dt)
	processControls(dt)
	updateEnemies(dt)

end

function love.draw()

	love.graphics.push()
	drawCamera()
	drawGrid()
	drawPlayers()
	drawEnemies()
	drawParticles()
	--	drawCollisions()
	love.graphics.pop()

	love.graphics.setColor(0,0,0,192)
	love.graphics.rectangle('fill',5,5,64,34)
	love.graphics.setColor(255,255,255)
	love.graphics.print("Points: "..points,10,10)
	love.graphics.setColor(255,153,0)
	love.graphics.print("HP: "..player1.hp,10,18)
	love.graphics.setColor(153,255,0)
	love.graphics.print("HP: "..player2.hp,10,26)

	drawOverlays()

end

function love.keyreleased(key, unicode) if key == 'escape' then love.event.push('quit') end end
function love.keypressed(key, unicode) displayImage = displayImage + 1 end

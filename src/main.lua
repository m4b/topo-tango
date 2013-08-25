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
	--love.graphics.newFont(8))
	love.graphics.setFont(love.graphics.newFont(8))
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



function beginContact(a, b, coll)

   o1 = a:getUserData()
   o2 = b:getUserData()

   -- can be just one contact point, i.e., can be nil
   x1, y1, x2, y2 = coll:getPositions()

   if globalDebug then 
      text = text .."\n".. o1 .." colliding with ".. o2
      print (text)
   end

   if string.sub(o1,1,#"player") == "player" and o2 == "enemy" then
      startParticle(x1,y1)
   elseif string.sub(o2,1,#"player") == "player" and o1 == "enemy" then
      startParticle(x1,y1)
   end

end

function love.keyreleased(key, unicode) if key == 'escape' then love.event.push('quit') end end
function love.keypressed(key, unicode) displayImage = displayImage + 1 end

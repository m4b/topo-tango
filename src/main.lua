function love.load()

   require "class"
   require "world"
   require "player"

   globalDebug = true

   -- set font for FPS
   font = love.graphics.newFont(love._vera_ttf, 10)
   love.graphics.setFont(font)
   love.graphics.setColor(200, 200, 200);

   world:init() -- initialize world
   player:init()

--   bg = love.graphics.newImage("graphics/star-background.png")

   -- callback debug string
   text = ""

end

function love.draw(dt)

  -- love.graphics.draw(bg,0,0)

   player:draw()
   love.graphics.print("FPS: " .. love.timer.getFPS(), 0, 0)
   if globalDebug then
      love.graphics.print(text, 0, 0)
   end

end

function love.update (dt)

   if love.keyboard.isDown("q") or love.keyboard.isDown("escape") then
      love.quit()
   end

   world.world:update(dt) -- sets world in motion
--   player:update(dt)

    if string.len(text) > 768 then    -- cleanup when 'text' gets too long
        text = ""
    end

end

function love.quit()
   love.event.quit()
end


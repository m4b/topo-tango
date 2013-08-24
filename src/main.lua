function love.load()

   require "class"
   require "bugship"
   require "laser"
   require "world"
   require "asteroid"

   globalDebug = true

   -- set font for FPS
   font = love.graphics.newFont(love._vera_ttf, 10)
   love.graphics.setFont(font)
   love.graphics.setColor(200, 200, 200);

   world:init() -- initialize world
   asteroid:init()
   bugship:init(400,300) -- start the bugship in the middle
   laser:load()

   bg = love.graphics.newImage("graphics/star-background.png")

   -- callback debug string
   text = ""

end

function love.draw(dt)

   love.graphics.draw(bg,0,0)
   bugship:draw()
   laser:draw()
   asteroid:draw()
   world:draw() -- unused

   love.graphics.print("FPS: " .. love.timer.getFPS(), 0, 0)
   if globalDebug then
      love.graphics.print(text, 0, 0)
   end

end

function love.update (dt)

   if love.keyboard.isDown("q") or love.keyboard.isDown("escape") then
      love.quit()
   end

   bugship:update(dt)
   laser:update(dt)
   world.world:update(dt) -- sets world in motion
   asteroid:update(dt)

    if string.len(text) > 768 then    -- cleanup when 'text' gets too long
        text = ""
    end

end

function love.quit()
   love.event.quit()
end

function endContact(a, b, coll)

   o1 = a:getUserData()
   o2 = b:getUserData()
   text = text.."\n".. o1 .." uncolliding with ".. o2

   -- bah, numbering lasers won't work, because array changes, need pid or unique id
   if string.sub(o1,1,#"laser") == "laser" then
      local i = tonumber (string.sub(o1,#"laser"+1)) -- must be very careful here
      laser:endContact(o1,o2,coll,i)
   elseif string.sub(o2,1,#"laser") == "laser" then
      local i = tonumber (string.sub(o2,#"laser"+1))
      laser:endContact(o2,o1,coll,i)
   end

end
function initOverlays()
	love.graphics.setDefaultImageFilter("nearest","nearest")
	logo = love.graphics.newImage("image/logo.png")
	instructions1 = love.graphics.newImage("image/instructions1.png")
	instructions2 = love.graphics.newImage("image/instructions2.png")
	controls1 = love.graphics.newImage("image/controls1.png")
	controls2 = love.graphics.newImage("image/controls2.png")
	continue = love.graphics.newImage("image/continue.png")
	displayImage = 0
end

function drawOverlays()
	love.graphics.setColor(255,255,255)

	-- controls
	if displayImage > 0 then
		love.graphics.push()
			love.graphics.translate(10,windowHeight-10-controls1:getHeight())
			love.graphics.draw(controls1)
		love.graphics.pop()

		love.graphics.push()
			love.graphics.translate(windowWidth-10-controls2:getWidth(),windowHeight-10-controls2:getHeight())
			love.graphics.draw(controls2)
		love.graphics.pop()
	end

	love.graphics.translate(windowWidth/2,windowHeight/2)

	-- splash and instructions
	if displayImage == 0 then
		love.graphics.push()
			local scale = (math.sin(love.timer.getTime()*5)*.5+.5)+4
			love.graphics.scale(scale,scale)
			love.graphics.translate(-logo:getWidth()/2,-logo:getHeight()/2)
			love.graphics.draw(logo)
		love.graphics.pop()
	elseif displayImage == 1 then
		love.graphics.push()
			love.graphics.scale(3,3)
			love.graphics.translate(-instructions1:getWidth()/2,-instructions1:getHeight()/2)
			love.graphics.draw(instructions1)
		love.graphics.pop()
	elseif displayImage == 2 then
		love.graphics.push()
			love.graphics.scale(3,3)
			love.graphics.translate(-instructions2:getWidth()/2,-instructions2:getHeight()/2)
			love.graphics.draw(instructions2)
		love.graphics.pop()
	end

	-- hit to continue
	if displayImage <= 2 then
		love.graphics.translate(0,windowHeight/4)
		local scale = (math.sin(love.timer.getTime())*.5+.5)*.5+1
		love.graphics.scale(scale,scale)
		love.graphics.translate(-continue:getWidth()/2,-continue:getHeight()/2)
		love.graphics.draw(continue)
	end
end

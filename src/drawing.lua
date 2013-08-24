function addColorTo(object, r, g, b)
	object.setColor = function()
		love.graphics.setColor(r, g, b)
	end
end

function addRectangleTo(object, x, y, width, height)
	object.x = x
	object.y = y
	object.width = width
	object.height = height
	object.draw = function() love.graphics.rectangle('fill',x,y,width,height) end
end

function addCircleTo(object, x, y, radius)
	object.x = x
	object.y = y
	object.radius = radius
	object.draw = function() love.graphics.circle('fill',x,y,radius,32) end
end

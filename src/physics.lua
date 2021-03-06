function addPhysicsRectangleTo(object, x, y, width, height, mode, callbackName) -- x,y = topleft corner
	object.width = width
	object.height = height

	local p = {}
	p.body    = love.physics.newBody(world, x, y, mode)
	p.shape   = love.physics.newRectangleShape(width/2, height/2, width, height)
	p.fixture = love.physics.newFixture(p.body, p.shape)
	p.fixture:setUserData(callbackName)
	p.fixture:setRestitution(.3)
	object.physics = p

	object.draw = function()
		love.graphics.rectangle('fill', 
		                        object.physics.body:getX(), 
		                        object.physics.body:getY(), 
		                        object.width, 
		                        object.height)
	end
end

function addPhysicsCircleTo(object, x, y, radius, mode, callbackName) -- x,y = center
	object.radius = radius

	local p = {}
	p.body    = love.physics.newBody(world, x, y, mode)
	p.shape   = love.physics.newCircleShape(radius)
	p.fixture = love.physics.newFixture(p.body, p.shape)
	p.fixture:setUserData(callbackName)
	p.fixture:setRestitution(.3)
	object.physics = p

	object.draw = function()
		love.graphics.circle('fill', 
		                     object.physics.body:getX(), 
		                     object.physics.body:getY(), 
		                     object.radius, 
		                     32)
	end
end

function addPhysicsPolygonTo(object, x, y, x1, y1, x2, y2, x3, y3, mode, callbackName) -- x,y = topleft corner
--	object.width = width
--	object.height = height

	local p = {}
	p.body    = love.physics.newBody(world, x, y, mode)
	p.shape   = love.physics.newPolygonShape(x1, y1, x2, y2, x3, y3)
--width/2, height/2, width, height)
	p.fixture = love.physics.newFixture(p.body, p.shape)
	p.fixture:setUserData(callbackName)
	p.fixture:setRestitution(.3)
	object.physics = p

	object.draw = function()
		love.graphics.polygon('fill', 
				      object.physics.body:getWorldPoints(object.physics.shape:getPoints()))
	end
end


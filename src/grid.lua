function initGrid()
	local width = 20
	local height = 20

	grid = genLevel(width,height,2)
	local test = genLevel(width,height,1)
	entities = {}

	for i = 0, width-1 do for j = 0, height-1 do
		local entity = {}
		if grid[i][j] == 1 then
			grid[i][j] = 2
			addPhysicsRectangleTo(entity, i*16, j*16, 16, 16, 'static', 'CALLBACK')
			entity.draw = function() -- overwrite default physicsRectangle draw
				local multiplier = math.sin(i+j+love.timer.getTime()*10)*.2+.8
				love.graphics.setColor(0,153*multiplier,255*multiplier)
				love.graphics.rectangle('fill', i*16, j*16+1, 16, 14)
				love.graphics.rectangle('fill', i*16+1, j*16, 14, 16)
				love.graphics.triangle('fill', i*16+1, j*16,
				                               i*16, j*16+1,
				                               i*16+1, j*16+1)
				love.graphics.triangle('fill', i*16+15, j*16,
				                               i*16+16, j*16+1,
				                               i*16+15, j*16+1)
				love.graphics.triangle('fill', i*16+1, j*16+16,
				                               i*16, j*16+15,
				                               i*16+1, j*16+15)
				love.graphics.triangle('fill', i*16+15, j*16+16,
				                               i*16+16, j*16+15,
				                               i*16+15, j*16+15)

				love.graphics.setColor(0,204*multiplier,255*multiplier)
				love.graphics.rectangle('fill', i*16+3, j*16+3, 10, 10)
			end
		else
			grid[i][j] = test[i][j]
			addRectangleTo(entity, i*16, j*16, 16, 16)
			if test[i][j] == 0 then addColorTo(entity, 128, 0, 76)
			                   else addColorTo(entity, 76, 0, 128)
			end
			entity.draw = function()
				entity.setColor()
				love.graphics.triangle('fill', i*16+3, j*16+3,
				                               i*16+13, j*16+3,
				                               i*16+3, j*16+13)
			end
		end
		table.insert(entities, entity)
	end end
end

function drawGrid()
	-- draw the tiles
	love.graphics.setColor(32,32,32)
	for i = 0, grid.width-1 do for j = 0, grid.height-1 do
		love.graphics.rectangle('fill',i*16+1,j*16+1,14,14)
	end end

	for _, i in pairs(entities) do
		i.draw()
	end
end

--------------------------------------------------------------------------------

function genGrid(width,height,dist,copy)
	local grid = {}
	grid.width = width
	grid.height = height

	for i = 0, width-1 do
		grid[i] = {}
		for j = 0, height-1 do
			if copy then grid[i][j] = copy[i][j]
			        else grid[i][j] = math.min(math.random(0,dist),1)
				     grid[i][j] = 1 - grid[i][j]
			end
		end
	end

	return grid
end

function genLevel(width,height,dist)
	local grid = genGrid(width,height,dist)

	for generations = 0, 8 do
		local oldGrid = genGrid(width,height,dist,grid)
		for i = 1, width-2 do for j = 1, height-2 do
			local count = oldGrid[i  ][j-1]+
			              oldGrid[i  ][j+1]+
			              oldGrid[i-1][j  ]+
			              oldGrid[i+1][j  ]+
			              oldGrid[i+1][j+1]+
			              oldGrid[i+1][j-1]+
			              oldGrid[i-1][j+1]+
			              oldGrid[i-1][j-1]
			if grid[i][j] == 0 and 6 <= count and count <=8 then grid[i][j] = 1
			elseif grid[i][j] == 1 and (3 > count or count > 8) then grid[i][j] = 0
			end
		end end
	end

	for i = 0, width-1 do for _, j in pairs({0, height-1}) do grid[i][j] = 1 end end
	for _, i in pairs({0, width-1}) do for j = 0, height-1 do grid[i][j] = 1 end end

	return grid
end

function getEmptyTile()
	local coords = {}
	coords.x = math.random(grid.width)-1
	coords.y = math.random(grid.height)-1
	while grid[coords.x][coords.y] ~= 0 do
		coords.x = math.random(grid.width)-1
		coords.y = math.random(grid.height)-1
	end

	return coords
end

function genGrid(copy)
	local grid = {}
	for i = 0, 39 do
		grid[i] = {}
		for j = 0,29 do
			if copy then grid[i][j] = copy[i][j]
			        else grid[i][j] = math.min(math.random(0,1),1)
				     grid[i][j] = 1 - grid[i][j]
			end
		end
	end

	return grid
end

function genLevel()
	local grid = genGrid()

	for generations = 0, 8 do
		local oldGrid = genGrid(grid)
		for i = 1, 38 do for j = 1, 28 do
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

	for i = 0, 39 do for _, j in pairs({0, 29}) do grid[i][j] = 1 end end
	for _, i in pairs({0, 39}) do for j = 0, 29 do grid[i][j] = 1 end end

	return grid
end

function getEmptyTile(grid)
	local coords = {}
	coords.x = math.random(40)-1
	coords.y = math.random(30)-1
	while grid[coords.x][coords.y] == 1 do
		coords.x = math.random(40)-1
		coords.y = math.random(30)-1
	end

	return coords
end

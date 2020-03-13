--[[ The colors lua script takes three arguments:
	* first - the hex color for which the gradient will start from
	* last  - the hex color for which the gradient will end
	* steps - the number of steps from the first to the last color,
		  in general the number of steps is equal to the number
		  of total colors minus 1
--]]

local colors = {}
function colors.gradient(first,last,steps)
	steps = steps or 1
	gradientcolors = {}
	if string.sub(first,1,1) == "#" then 
		first = string.sub(first,2,7)
	end
	if string.sub(last,1,1) == "#" then 
		last = string.sub(last,2,7)
	end
	-- We obtain the RGB values for the first and last color
	first_red   = tonumber(string.sub(first,1,2),16)
	first_blue  = tonumber(string.sub(first,3,4),16)
	first_green = tonumber(string.sub(first,5,6),16)

	last_red    = tonumber(string.sub(last,1,2),16)
	last_blue   = tonumber(string.sub(last,3,4),16)
	last_green  = tonumber(string.sub(last,5,6),16)

	for step=0,steps,1 do
		color_red   = math.floor(first_red + ((last_red - first_red)/steps)*step)
		color_blue  = math.floor(first_blue + ((last_blue - first_blue)/steps)*step)
		color_green = math.floor(first_green + ((last_green - first_green)/steps)*step)
		color = "#" .. string.format("%x",color_red) .. string.format("%x", color_blue) .. string.format("%x", color_green)
		table.insert(gradientcolors,color)
	end
	return gradientcolors
end

return colors









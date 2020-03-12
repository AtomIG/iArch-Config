
function hextorgb (hex) -- This function takes a hex color and converts it to a table containing its rgb values
	rgb = {}
	if string.sub(hex,1,1) == "#" then
		offset = 1
	else
		offset = 0
	end
	for index=1+offset,5+offset,2 do
		color = tonumber(string.sub(hex,index,index+1),16)
		table.insert(rgb,tostring(color))
	end
	return rgb
end

function rgbtohex (rgb) -- This function take a table of rgb number corresponding to a color and produces the corresponding hex number
	color = {}
	for index,data in ipairs(rgb) do
		color_hex = string.format("%x",data)
		table.insert(color,color_hex)
	end
	hex = "#"
	for index,data in ipairs(color) do
		hex = hex .. data
	end
	return hex
end

---[[
function gradient (first,last,steps) -- steps = the number of colors to be outputted minus one
	steps = steps or 1
	gradientcolors = {} --This is a table which will contain all the colors for the desired gradient
	firstrgb = hextorgb(first)
	lastrgb = hextorgb(last)
	for step=0,steps,1 do
		color_red   = string.format("%i",math.floor(firstrgb[1] + ((lastrgb[1]-firstrgb[1])/steps)*step))
		color_blue  = string.format("%i",math.floor(firstrgb[2] + ((lastrgb[2]-firstrgb[2])/steps)*step))	
		color_green = string.format("%i",math.floor(firstrgb[3] + ((lastrgb[3]-firstrgb[3])/steps)*step))
		table.insert(gradientcolors,rgbtohex({color_red,color_blue,color_green}))
	end
	return gradientcolors
end

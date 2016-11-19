item = {}

function item.new()
	obj = {}

	obj.x = math.random(0,400)
	obj.y = math.random(0,400)
	obj.selected = false

	return obj
end

function love.load()
	love.window.setMode(400,400, {vsync=true});
	x = 200;
	y = 200;

	rect = {
		x = 100,
		y = 100,
		width = 100,
		height = 100,
		select = { active = false, mouseX = 0, mouseY = 0 }
	}
	items = {}

end

function love.update(dt)
	for i in pairs(items) do
		if items[i].selected == true then
			if love.keyboard.isDown("up") then
				items[i].y = items[i].y-2;
			end
			if love.keyboard.isDown("down") then
				items[i].y = items[i].y+2;
			end
			if love.keyboard.isDown("right") then
				items[i].x = items[i].x+2;
			end
			if love.keyboard.isDown("left") then
				items[i].x = items[i].x-2;
			end
		end
	end
	if love.keyboard.isDown("lctrl") then
		if love.keyboard.isDown("q") then
			love.event.quit()
		end
	end

	if rect.select.active then
		rect.select.width = love.mouse.getX() - rect.x
		rect.select.height = love.mouse.getY() - rect.y
	end

end

function love.keypressed(key, scancode, isrepeat )
	if key == "a" then
		table.insert(items, 0, item.new())
		items[0].x = math.random(0,400)
	end
end

function love.mousepressed(x, y, button)
  if button == "l" then
		rect.select.active = true;
		rect.x = x
		rect.y = y
  end
	if button == "r" then
		for i in pairs(items) do
			items[i].selected = false;
			if x >= items[i].x and x <= items[i].x + 20 then
				if y >= items[i].y and y <= items[i].y + 20 then
					items[i].selected = true;
				end
			end
		end
	end
end

function love.mousereleased(x, y, button)
  if button == "l" then
		for i in pairs(items) do
			print(rect.x .. " " .. rect.select.width .. " " .. items[i].x)
			if rect.x <= items[i].x and items[i].x + 20 <= rect.x+rect.select.width then
				print ("in")
				if rect.y <= items[i].y and items[i].y + 20 <= rect.y+rect.select.height then
					items[i].selected = true;
				else
					items[i].selected = false;
				end
			else
				items[i].selected = false;
			end
		end

		rect.select.active = false

	end
end

function love.draw()
	love.graphics.setBackgroundColor( 255, 255, 255 )
	love.graphics.setColor(0,0,0,255)
	love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
	love.graphics.setColor(255,0,0,255)
	for i in pairs(items) do
		love.graphics.rectangle("fill", items[i].x, items[i].y, 20, 20)
	end
	love.graphics.setColor(0,255,100,255)
	love.graphics.setLineWidth(5)
	love.graphics.setLineStyle("smooth")
	for i in pairs(items) do
		if items[i].selected == true then
			love.graphics.rectangle("line", items[i].x, items[i].y, 20, 20)
		end
	end

	love.graphics.setLineWidth(2)
	love.graphics.setLineStyle("rough")
	if rect.select.active then
		love.graphics.rectangle("line", rect.x, rect.y, rect.select.width, rect.select.height)
	end

end

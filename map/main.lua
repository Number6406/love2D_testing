require "generator"

DEBUG = true -- debug active

cam = {x=0,y=0}

timer = 0
map = {}

function love.load(arg)
  --[[
    for k,v in pairs(arg) do
    -- arguments à tester
    end
  ]]

  if DEBUG then

    print()
    print("========DEBUG STARTS HERE==========")
  end

  map = generate(4654545)

end

function love.update(dt)

end

function love.draw()
  printFlat(map, cam)
end

function love.update(dt)
  timer = timer + dt
  
  if love.keyboard.isDown("up") then
    cam.y = cam.y-1;
  end
  if love.keyboard.isDown("down") then
    cam.y = cam.y+1;
  end
  if love.keyboard.isDown("right") then
    cam.x = cam.x+1;
  end
  if love.keyboard.isDown("left") then
    cam.x = cam.x-1;
  end

  if love.keyboard.isDown("lctrl") then
    if love.keyboard.isDown("q") then
      love.event.quit()
    end
  end
  timer = timer%1

end

require "gui"
require "button"

function love.load()

  ui = gui:new()
  item = gui:new()

  item.dim.width = 50

  item.dim.height = 50
  item2 = item:clone()

  item2.dim.width = 50
  item2.dim.height = 50

  item2.pos.x = 200
  item2.pos.y = 200

  ui.dim.height = 100
  ui.dim.width = 200

  b = button:new()
  b.dim.width = 500
  b.dim.height = 30
  b.style.background = {
    r = 0,
    g = 0,
    b = 255,
    a = 255
  }
  
  item2.style.background = {
    r = 255,
    g = 255,
    b = 0,
    a = 255
  }

  item.style.background = {
    r = 255,
    g = 0,
    b = 0,
    a = 255
  }

  ui.pos.y = 20

  ui:add(item)
  ui:add(item2)
  ui:add(button)

end

function love.update()
  --print(ui:isHovered())
end

function love.draw()
  ui:draw()
end

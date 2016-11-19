require "class"

id_gui = 1
gui_instances = {}

gui = {}
gui.__index = gui

function gui:new()

  local instance = setmetatable({}, gui)

  instance.id = id_gui
  id_gui = id_gui + 1

  instance.parent = nil

  instance.children = {}

  instance.visible = true

  instance.pos = {
    type = "relative",
    x = 0,
    y = 0
  }

  instance.dim = {
    type = "px",
    width = 0,
    height = 0
  }

  instance.style = {
    background = {
        r = 200,
        g = 200,
        b = 200,
        a = 255
    },
    color = "0,0,0,255",
    border = {
      size = 1,
      color = "220,220,220,255"
    },
    hover = {
      background = "200,200,200,200",
      color = "0,0,0,255"
    },
    mouse = {
      base = "",
      click = "",
      drag = "",
      resize = ""
    }
  }

  instance.util = {
    selectable = false,
    clickable = false,
    draggable = false,
    resizable = false,
    hoverable = false
  }

  table.insert(gui_instances, instance.id, instance)

  return instance

end

function gui:clone()
  local clone_instance = clone(self)
  clone_instance.id = id_gui
  id_gui = id_gui + 1
  table.insert(gui_instances, clone_instance.id, clone_instance)
  return clone_instance
end

function gui:isHovered()
  mouseX = love.mouse.getX()
  mouseY = love.mouse.getY()

  minX = self.pos.x
  maxX = self.pos.x+self.dim.width
  minY = self.pos.y
  maxY = self.pos.y+self.dim.height

  if mouseX >= minX and mouseX <= maxX then
    if mouseY >= minY and mouseY <= maxY then
      return true
    end
  end

  return false
end

function gui:add(child)
  if self.children == nil then
    self.children = {}
  end
  table.insert(self.children, child)
  child.parent = self.id
end

--Banane flambée !!!
function gui:draw(o)
  if o == nil then o = self end
  if o.visible == true then
    o:setColor()
    o:drawRect()
  end

  if self.children ~= nil then
    sizeCh = table.getn(self.children)
    for c = 1,sizeCh do
      self.children[c]:draw()
    end
  end
end

function gui:setColor()
  love.graphics.setColor(self.style.background.r,self.style.background.b,self.style.background.g,self.style.background.a)
end

function gui:drawRect()
  if self.pos.type == "relative" and self.parent ~= nil then
    love.graphics.rectangle("fill", gui_instances[self.parent].pos.x + self.pos.x, gui_instances[self.parent].pos.y + self.pos.y, self.dim.width, self.dim.height)
  else
    love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.dim.width, self.dim.height)
  end
end

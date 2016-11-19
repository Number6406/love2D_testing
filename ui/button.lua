require "gui"
require "class"

button = {}
button.__index = gui

function button:new()

  local instance = setmetatable({}, button)

  instance = clone(gui:new())

  instance.text = "oui"

  return instance

end

function button:draw()
  gui:draw(self)
end

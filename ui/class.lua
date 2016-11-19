class = {}

function class:new(class)
  local obj = {}
  obj = setmetatable({}, class)
  self.__index = class
  return obj
end

function clone(obj)
  if type(obj) ~= 'table' then return obj end
  local res = setmetatable({}, getmetatable(obj))
  for k, v in pairs(obj) do res[clone(k)] = clone(v) end
  return res
end

local utils = require("libs.utils")

local RenderSystem = {}

function RenderSystem:new()
  local system = {}
  setmetatable(system, { __index = self })
  return system
end

function RenderSystem:draw(entityBody)
  local entity = entityBody:getUserData()
  if entity.draw then
    entity.draw()
  end
end

return RenderSystem

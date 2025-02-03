local utils = require("libs.utils")

local RenderSystem = {}

function RenderSystem:new()
  local system = {}
  setmetatable(system, { __index = self })
  return system
end

function RenderSystem:draw(world)
  for i, v in ipairs(world:getBodies()) do
    local entity = v:getUserData()
    if entity.draw then
      entity.draw()
    end
  end

end

return RenderSystem

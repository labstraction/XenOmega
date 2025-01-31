local RenderSystem = {}

local utils = require("utils")

function RenderSystem:new()
  local system = {}
  setmetatable(system, { __index = self })
  return system
end

function RenderSystem:draw(entityBody)
  love.graphics.setColor(1, 1, 1)
  local body = entityBody
  local fixtures = body:getFixtures()
  local fixture = fixtures[1]
  if fixture then
    love.graphics.polygon("line", body:getWorldPoints(fixture:getShape():getPoints()))
  end
end

return RenderSystem

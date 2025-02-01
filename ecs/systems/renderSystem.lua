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
  local entity = body:getUserData()
  local fixtures = body:getFixtures()
  local fixture = fixtures[1]
  if fixture then
    love.graphics.setLineWidth(2)
    love.graphics.polygon("line", body:getWorldPoints(unpack(entity:getComponent('graphic').draw)))
  end
end

return RenderSystem

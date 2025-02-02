local utils = require("libs.utils")

local RenderSystem = {}

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
    love.graphics.setLineWidth(3)
    if entity:getComponent('graphic').draw then
      love.graphics.polygon("line", body:getWorldPoints(utils.unpack(entity:getComponent('graphic').draw)))
    end
  end
  local particle = entity:getComponent('particle')
  if particle then
    love.graphics.setBlendMode("add")
          love.graphics.draw(particle:getEmitter('w').ps)
    love.graphics.setBlendMode("alpha")
  end
end

return RenderSystem

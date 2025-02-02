local utils = require "libs.utils"
local entity = {}

function entity:new(components)
  local newEntity = {
    components = components or {}
  }
  setmetatable(newEntity, {__index = self})
  return newEntity
end

function entity:addComponent(name, component)
  self.components[name] = component
  return self
end

function entity:getComponent(name)
  return self.components[name]
end

local entityType = {
  BULLET = 1,
  PLAYER = 2,
  ASTEROID = 3,
  POLIG = 4
}

return entity, entityType



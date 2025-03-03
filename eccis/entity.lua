local utils = require "libs.utils"
local entity = {}

function entity:new(components)
  local newEntity = {
    components = components or {},
    id = utils.uuid()
  }
  setmetatable(newEntity, {__index = self})
  return newEntity
end

function entity:add(name, component)
  self.components[name] = component
  return self
end

function entity:get(name)
  return self.components[name]
end

function entity:del(name)
  self.components[name] = nil
  return self
end

function entity:has(name)
  return self.components[name] ~= nil
end

return entity



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

return entity



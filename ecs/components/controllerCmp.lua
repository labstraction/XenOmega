local controllerCmp = {}

function controllerCmp.new(actions)
  local newController = {
    keys = {},
    actions = actions or {}
  }

  setmetatable(newController, { __index = controllerCmp })

  function love.keypressed(key)
    newController.keys[key] = true;
  end

  function love.keyreleased(key)
    newController.keys[key] = nil;
  end

  return newController
end

function controllerCmp:update(dt)
  for key, value in pairs(self.keys) do
    if value and self.actions[key] then
      self.actions[key](dt)
    end
  end
end

function controllerCmp:addAct(key, action)
  self.actions[key] = action
  return self
end

function controllerCmp:removeAct(key)
  self.actions[key] = nil
end

return controllerCmp;

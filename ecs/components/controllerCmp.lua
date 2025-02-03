local utils = require "libs.utils"
local controllerCmp = {controlled = {},  keys = {}}

function controllerCmp.new(actions)
  local id = utils.uuid()
  local newController = {uuid = id}
  controllerCmp.controlled[id] = {actions = actions}
  setmetatable(newController, { __index = controllerCmp })



  return newController
end

function controllerCmp:update(dt)
  print('control update')
  for key, value in pairs(self.keys) do
    for id, value in pairs(self.controlled) do
      if value and self.controlled[id].actions[key] then
        self.controlled[id].actions[key](dt)
      end
    end
  end
end

function controllerCmp:addAct(key, action)
  self.controlled[self.uuid].actions[key] = action
  return self
end

function controllerCmp:removeAct(key)
  self.controlled[self.uuid].actions[key] = nil
end

function love.keypressed(key)
  controllerCmp.keys[key] = true;
end

function love.keyreleased(key)
  controllerCmp.keys[key] = nil;
end

return controllerCmp;

local utils = require "libs.utils"
local brainCmp = {}

function brainCmp.new(strategies)
  local newBrain = {strategies = strategies or {}}
  setmetatable(newBrain, { __index = brainCmp })
  return newController
end

function brainCmp:update(dt, player)
    if #self.strategies > 0 then
        self.strategies[1](player)
    end
end


return controllerCmp;

local utils = require "libs.utils"
local brainCmp = {}

function brainCmp.new(strategy)
  local newBrain = {strategy = strategy or {state = 1, tactics = {}}}
  setmetatable(newBrain, { __index = brainCmp })
  return newBrain
end

function brainCmp:update(dt, player, world)
    if self.strategy.tactics[self.strategy.state] then
      self.strategy.state = self.strategy.tactics[self.strategy.state](dt, player, world)
    elseif self.strategy.tactics[1] then
      self.strategy.state = 1
      self.strategy.state = self.strategy.tactics[self.strategy.state](dt, player, world)
    end
end


return brainCmp;

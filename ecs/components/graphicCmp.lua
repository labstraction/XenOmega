local utils = require "libs.utils"
local graphicCmp = {}

function graphicCmp:new(draws)
  local newGraphic = {draws = draws}
  setmetatable(newGraphic, {__index = self})
  return newGraphic
end

function graphicCmp:drawAll(body)
  for _, value in pairs(self.draws) do
    love.graphics.setColor(utils.hexToRGB(value.color))
    love.graphics.setLineWidth(value.width)
    love.graphics.polygon("line", body:getWorldPoints(utils.unpack(value.line)))
  end
end

return graphicCmp
local utils = require "eccis.utils"


local graphSysBuilder = function ()

    local drawMapper = {
        polygon = function(mode, points) love.graphics.polygon(mode, points) end
    }

    local graphicSystem = function (entity)
        if not entity:has("graphic") then
            return false;
        end
        local graphic = entity:get("graphic");
        for _, element in ipairs(graphic) do
            love.graphics.setColor(utils.hexToRGB(element.color))
            love.graphics.setLineWidth(element.width)
            drawMapper[element.type](element.mode, element.points)
        end
    end
    return graphicSystem
end

return graphSysBuilder

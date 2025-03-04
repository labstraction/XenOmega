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
        love.graphics.setColor(utils.hexToRGB(graphic.color))
        love.graphics.setLineWidth(graphic.width)
        drawMapper[graphic.type](graphic.mode, graphic.points)

    end
    return graphicSystem
end

return graphSysBuilder

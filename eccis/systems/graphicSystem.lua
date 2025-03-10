local utils = require "eccis.libs.utils"


local graphSysBuilder = function ()

    local drawMapper = {
        polygon = function(mode, points) love.graphics.polygon(mode, points) end
    }

    local draw = function (entity)
        if not entity:has("graphic") then
            return false;
        end
        local graphic = entity:get("graphic");
        for _, element in ipairs(graphic) do
            love.graphics.setColor(utils.hexToRGB(element.color))
            love.graphics.setLineWidth(element.width)
            local points = element.points
            if entity.body then
                points = utils.pack(entity.body:getWorldPoints(utils.unpack(points)))
            end
            drawMapper[element.type](element.mode, points)
        end
    end
    return {draw = draw}
end

return graphSysBuilder

local utils = require "eccis.libs.utils"

local cameraSysBuilder = function(target, scale, smoothness)

    local camera = {
        x = 0,
        y = 0,
        scale = scale or 1,
        target = target,
        smoothness = smoothness or 0.01
    }

    local update = function(dt)
        if not camera.target.body then
            return false;
        end
        local x, y = camera.target.body:getPosition()
        camera.x = camera.x + (x - camera.x) * camera.smoothness
        camera.y = camera.y + (y - camera.y) * camera.smoothness
    end

    local apply = function()
        love.graphics.push()
        love.graphics.scale(camera.scale)
        love.graphics.translate(-camera.x + love.graphics.getWidth()/(2*camera.scale), 
                                -camera.y + love.graphics.getHeight()/(2*camera.scale))
    end
      
    local clear = function()
        love.graphics.pop()
    end


    return {update = update, apply = apply, clear = clear}
end

return cameraSysBuilder












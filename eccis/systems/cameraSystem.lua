local utils = require "eccis.utils"

local cameraSysBuilder = function(target, scale, smoothness)

    local camera = {
        x = 0,
        y = 0,
        scale = scale or 1,
        target = target,
        smoothness = smoothness or 0.1
    }

    local update = function(dt)
        if camera.target then
          local tx, ty = camera.target:getX(), camera.target:getY()
          camera.x = camera.x + (tx - camera.x) * camera.smoothness
          camera.y = camera.y + (ty - camera.y) * camera.smoothness
        end
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












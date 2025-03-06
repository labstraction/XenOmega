local utils = require "eccis.utils"

local controllerSysBuilder = function()

    local keys = {}

    local actions = {
        up = function(entity, dt)
            local angle = entity.body:getAngle()
            local fx = math.cos(angle) * 100000 * dt
            local fy = math.sin(angle) * 100000 * dt
            entity.body:applyForce(fx, fy)
        end
    }

    local update = function(dt, entity)

        function love.keypressed(key)
            utils.log(key)
            keys[key] = true;
        end

        function love.keyreleased(key)
            keys[key] = nil;
        end

        utils.log(keys)

        if not entity:has("controls") then
            return false;
        end
        local controls = entity:get("controls")
        for key, _ in pairs(keys) do
            if controls[key] then
                actions[controls[key]](entity, dt)
            end
        end
    end

    return {
        update = update
    }
end

return controllerSysBuilder


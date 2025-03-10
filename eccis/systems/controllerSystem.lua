local utils = require "eccis.libs.utils"
local entity = require "eccis.entity"
local ball = require "eccis.componets.weapons.ball"

local controllerSysBuilder = function(eventManager)

    local keys = {}

    local applyForce = function(body, value, angle, dt)
        local angle = body:getAngle() + angle
        local fx = math.cos(angle) * value * dt
        local fy = math.sin(angle) * value * dt
        body:applyForce(fx, fy)
    end

    local actions = {
        mainThrust = function(entity, dt)
            local engine = entity:get("engine")
            applyForce(entity.body, engine.mainThrust, 0,  dt)
        end,
        leftThrust = function(entity, dt)
            local engine = entity:get("engine")
            entity.body:applyTorque(-engine.torque * dt)
        end,
        rightThrust = function(entity, dt)
            local engine = entity:get("engine")
            entity.body:applyTorque(engine.torque * dt)
        end,
        fire = function(entity, dt)
            local bullet = entity:new()
            utils.log('stocazzo')
            bullet:add("graphic", ball.draw)
            bullet:add("position", { x = entity.body:getX(), y = entity.body:getY(), type = "dynamic" })
            bullet:add("collider", ball.collider)
            eventManager:fire("addEntity", bullet)
        end
    }

    local update = function(dt, entity)

        function love.keypressed(key)
            keys[key] = true;
        end

        function love.keyreleased(key)
            keys[key] = nil;
        end


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


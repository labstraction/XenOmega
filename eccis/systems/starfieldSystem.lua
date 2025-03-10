local utils = require "eccis.libs.utils"



local starfieldSysBuilder = function(target)

    

    local createStars = function(cx, cy)
        local layers = {
            {
                count = 50, speed = 1.5, size = 2, color = { 0.8, 0.8, 0.8, 1 }
            },
            {
                count = 100, speed = 1, size = 1.5, color = { 0.6, 0.6, 0.6, 1 }
            },
            {
                count = 200, speed = 0.5, size = 1, color = { 0.4, 0.4, 0.4, 1 }
            }
        }

        local stars = {}
        for _, layer in ipairs(layers) do
            for i = 1, layer.count do
                table.insert(stars, {
                    x = love.math.random(cx - 1000, cx + 1000),
                    y = love.math.random(cy - 1000, cy + 1000),
                    speed = layer.speed,
                    size = layer.size,
                    color = layer.color
                })
            end
        end

        return stars
    end

    local stars

    local update = function(dt)
        local body = target.body;
        local vx, vy = body:getLinearVelocity()
        local cx, cy = body:getPosition()

        if not stars then
            stars = createStars(cx, cy)
        end

        for _, star in ipairs(stars) do
            star.x = star.x - vx * dt * star.speed
            star.y = star.y - vy * dt * star.speed
    
            if star.x < cx - 1000 then
                star.x = cx + 1000; star.y = love.math.random(cy - 1000, cy + 1000)
            end
            if star.x > cx + 1000 then
                star.x = cx - 1000; star.y = love.math.random(cy - 1000, cy + 1000)
            end
            if star.y < cy - 1000 then
                star.y = cy + 1000; star.x = love.math.random(cx - 1000, cx + 1000)
            end
            if star.y > cy + 1000 then
                star.y = cy - 1000; star.x = love.math.random(cx - 1000, cx + 1000)
            end
        end
    end

    local draw = function()
        love.graphics.setColor(1, 1, 1)
        for _, star in ipairs(stars) do
            love.graphics.setColor(star.color)
            love.graphics.circle("fill", star.x, star.y, star.size)
        end
    end


    return { update = update, draw = draw }
end

return starfieldSysBuilder







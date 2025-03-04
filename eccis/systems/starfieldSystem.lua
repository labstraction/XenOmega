local starfieldSystem = {}

local function createStars(cx, cy)
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

function starfieldSystem:new()
    local system = {}
    setmetatable(system, {__index = self})
    return system
end

function starfieldSystem:update(dt, entityBody)

    local body = entityBody
    local vx, vy = body:getLinearVelocity()
    local cx = body:getX()
    local cy = body:getY()

    if not self.stars then
      self.stars = createStars(cx, cy)
    end
    

    for _, star in ipairs(self.stars) do
        star.x = star.x - vx * dt * star.speed
        star.y = star.y - vy * dt * star.speed

        if star.x < cx - 1000 then star.x = cx + 1000; star.y = love.math.random(cy - 1000, cy + 1000) end
        if star.x > cx + 1000 then star.x = cx - 1000; star.y = love.math.random(cy - 1000, cy + 1000) end
        if star.y < cy - 1000 then star.y = cy + 1000; star.x = love.math.random(cx - 1000, cx + 1000) end
        if star.y > cy + 1000 then star.y = cy - 1000; star.x = love.math.random(cx - 1000, cx + 1000) end
    end
end

function starfieldSystem:draw()
    love.graphics.setColor(1, 1, 1)
    for _, star in ipairs(self.stars) do
        love.graphics.setColor(star.color)
        love.graphics.circle("fill", star.x, star.y, star.size)
    end
end

return starfieldSystem
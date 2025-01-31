local ParticleSystem = {}

function ParticleSystem:new()
  local sistem = {}
  setmetatable(sistem, {__index = self})
  return sistem
end

function ParticleSystem:update(dt, entityBody)
  local body = entityBody
  local entity = body:getUserData()
  local particles = entity:getComponent("particles")
  
  for k, p in pairs(particles) do
    local active = false
    if k == "main" then active = love.keyboard.isDown("w")
    elseif k == "left" then active = love.keyboard.isDown("a")
    elseif k == "right" then active = love.keyboard.isDown("d") end

    if active then
      local x = body:getX() + math.cos(body:getAngle()) * p.offset.x
      local y = body:getY() + math.sin(body:getAngle()) * p.offset.y
      p.emitter:setPosition(x, y)
      p.emitter:update(dt)
      p.emitter:emit(10)
    end
  end
end

function ParticleSystem:draw(entityBody)
  local body = entityBody
  local entity = body:getUserData()
  love.graphics.setBlendMode("add")
  for _, entity in ipairs({entity}) do
    local particles = entity:getComponent("particles")
    if particles then
      for _, p in pairs(particles) do
        love.graphics.draw(p.emitter)
      end
    end
  end
  love.graphics.setBlendMode("alpha")
end

return ParticleSystem
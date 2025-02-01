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
  local emitters = entity:getComponent("emitters")
  local img = love.image.newImageData(1, 1)
  img:setPixel(0, 0, 1, 1, 1, 1)
  local ps = love.graphics.newParticleSystem(love.graphics.newImage(img), 1364)

  for _, emitter in pairs(emitters) do
    print("emitter", emitter.x, emitter.y)
      

      
      ps:setPosition(body:getX() + emitter.x, body:getY() + emitter.y)
      ps:setEmissionRate( 100 )
      ps:setParticleLifetime( 0.1, emitter.life )
      ps:setDirection( emitter.angle )
      ps:setSpread( 0.759043 )
      ps:setSpeed( 114.286, 190.476 )
      ps:setRadialAcceleration( 0, 0 )
      ps:setTangentialAcceleration( 0, 0 )
      ps:setSpin( 0, 0, 0 )
      ps:setColors( 255, 188, 0, 230, 145, 0, 62, 14 )
      print("emitter2", ps:getPosition())
      ps:emit(100)

      ps:update(dt)
  end
  
  -- for k, p in pairs(particles) do
  --   local active = false
  --   if k == "main" then active = love.keyboard.isDown("w")
  --   elseif k == "left" then active = love.keyboard.isDown("a")
  --   elseif k == "right" then active = love.keyboard.isDown("d") end

  --   if active then
  --     ox, oy = body:getWorldPoint(math.cos(body:getAngle()) * p.offset.x, math.sin(body:getAngle()) * p.offset.y)
  --     local x = body:getX() + ox
  --     local y = body:getY() + oy
  --     p.emitter:setPosition(x, y)
      
  --     p.emitter:emit(10)
  --   end
  --   p.emitter:update(dt)
  -- end
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
local ParticleSystem = {}

function ParticleSystem:new()
  local system = {}
  local img = love.image.newImageData(1, 1)
  img:setPixel(0, 0, 1, 1, 1, 1)
  system.ps = love.graphics.newParticleSystem(love.graphics.newImage(img), 1364)
  setmetatable(system, {__index = self})
  return system
end

function ParticleSystem:update(dt, entityBody)
  local body = entityBody
  local entity = body:getUserData()
  local particles = entity:getComponent("particles")
  local emitters = entity:getComponent("emitters")


  for _, emitter in pairs(emitters) do
    print("emitter", emitter.x, emitter.y)
      

      
      self.ps:setPosition(body:getWorldPoint(emitter.x, 0))
      self.ps:setEmissionRate( 100 )
      self.ps:setParticleLifetime( 0.01, 0.05 )
      self.ps:setDirection(body:getAngle() +3.14 )
      self.ps:setSpread( 0)
      self.ps:setSpeed( 10, 2000 )
      self.ps:setRadialAcceleration( 0, 0 )
      self.ps:setSizes(1, 3)
      self.ps:setAreaSpread('uniform', 5, 5)
      self.ps:setTangentialAcceleration( 0, 0 )
      self.ps:setSpin( 0, 0, 0 )
      self.ps:setColors( 255, 188, 0, 230, 145, 0, 62, 14 )
      print("emitter2", self.ps:getPosition())
      self.ps:emit(100)

      self.ps:update(dt)
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
    local emitters = entity:getComponent("emitters")
    if emitters then
      for _, p in pairs(emitters) do
        love.graphics.draw(self.ps)
      end
    end
  end
  love.graphics.setBlendMode("alpha")
end

return ParticleSystem
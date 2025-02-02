local particleCmp = {}

function particleCmp:new(emitters)

  local img = love.image.newImageData(1, 1)
  img:setPixel(0, 0, 1, 1, 1, 1)

  local newParticle = {
    emitters = emitters or {},
    image = img
  }

  setmetatable(newParticle, {__index = self})
  return newParticle
end

function particleCmp:addEmitter(name, x, y, direction, type)
  local newEmitter = love.graphics.newParticleSystem(love.graphics.newImage(self.image), 100)
  local data = {}
  data.oX = x
  data.oY = y
  data.oDirection = direction
  newEmitter:setEmissionRate(100)
  newEmitter:setParticleLifetime( 0.01, 0.05 )
  newEmitter:setSpread( 0)
  newEmitter:setSpeed( 10, 2000 )
  newEmitter:setRadialAcceleration( 0, 0 )
  newEmitter:setSizes(1, 3)
  newEmitter:setEmissionArea('uniform', 5, 5)
  newEmitter:setTangentialAcceleration( 0, 0 )
  newEmitter:setSpin( 0, 0, 0 )
  newEmitter:setColors( 255, 188, 0, 230, 145, 0, 62, 14 )

  self.emitters[name] = {ps = newEmitter, data = data}
  return self
end

function particleCmp:getEmitter(name)
  return self.emitters[name]
end

function particleCmp:updateEmitter(name, body, dt)
  local emitter = self:getEmitter(name)
  emitter.ps:setPosition(body:getWorldPoint(emitter.data.oX, emitter.data.oY))
  emitter.ps:setDirection(body:getAngle() + emitter.data.oDirection)
  emitter.ps:update(dt)
end

function particleCmp:emit(name)
  self:getEmitter(name):emit(100)
end

return particleCmp
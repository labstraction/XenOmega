local physicCmp = {}

function physicCmp.createBody(world,x, y, collider)

  local body = love.physics.newBody(world, x, y, "dynamic")
  local shape = love.physics.newPolygonShape(collider)
  love.physics.newFixture(body, shape, 1)
  body:setLinearDamping(0.2)
  body:setAngularDamping(0.2)
  return body

end


function physicCmp.applyForce(body, value, angle, dt)
  local angle = body:getAngle() + angle
  local fx = math.cos(angle) * value * dt
  local fy = math.sin(angle) * value * dt
  body:applyForce(fx, fy)
end

function physicCmp:emit(name)
  self.emitters[name]:emit(200)
end

function physicCmp:updateAll(body, dt)
  for key, _ in pairs(self.emitters) do
    self:updateEmitter(key, body, dt)
  end
end

function physicCmp:drawAll()
  love.graphics.setColor(1, 1, 1)
  for _, value in pairs(self.emitters) do
    love.graphics.setBlendMode("add")
        love.graphics.draw(value.ps)
    love.graphics.setBlendMode("alpha")
  end
end

return physicCmp
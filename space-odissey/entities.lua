entities.bullet = function(world, cx, cy, a)
  local body = love.physics.newBody(world, cx, cy, 'dynamic')
  body:setAngle(a);
  local shape = love.physics.newCircleShape(2);
  local fixture = love.physics.newFixture(body, shape);

  local entity = {}
  entity.lifeTime = 0.6;
  entity.type = entityType.BULLET
  entity.update = function(dt)
    pacmanEffect(body)
    entity.lifeTime = entity.lifeTime - dt;
    if entity.lifeTime <= 0 then
      body:destroy()
    end
  end
  entity.draw = function()
    love.graphics.circle('line', body:getX(), body:getY(), shape:getRadius());
  end
  entity.handleCollision = function(ent)
    body:destroy()
  end
  body:setUserData(entity);
  return body
end

entities.player = function(world, cx, cy)
  local body = love.physics.newBody(world, cx, cy, 'dynamic')
  body:setLinearDamping(0.2)
  body:setAngularDamping(1)
  local shape = love.physics.newPolygonShape(-5, -5, -5, 5, 10, 0)
  local fixture = love.physics.newFixture(body, shape, 50)

  local entity = {}
  entity.cooldown = 0;
  entity.type = entityType.PLAYER

  local reactions = {}
  reactions.up = function(dt)
    body:applyForce(10000 * math.cos(body:getAngle()) * dt, 10000 * math.sin(body:getAngle()) * dt)
  end
  reactions.down = function(dt)
    body:applyForce(-6000 * math.cos(body:getAngle()) * dt, -6000 * math.sin(body:getAngle()) * dt)
  end
  reactions.left = function(dt)
    body:applyTorque(-8000 * dt)
  end
  reactions.right = function(dt)
    body:applyTorque(8000 * dt)
  end
  reactions.x = function(dt)
    entity.cooldown = entity.cooldown - dt;
    if entity.cooldown <= 0 then
      entity.cooldown = 0.1
      local bullet = entities.bullet(world, body:getX() + 20 * math.cos(body:getAngle()),
        body:getY() + 20 * math.sin(body:getAngle()), body:getAngle());
      bullet:applyLinearImpulse(100 * math.cos(body:getAngle()) * dt, 100 * math.sin(body:getAngle()) * dt)
    end
  end

  entity.controller = controller.new(reactions)

  entity.update = function(dt)
    entity.controller.update(dt)

    local x, y = body:getLinearVelocity()
    body:setLinearVelocity(math.clamp(x, -200, 200), math.clamp(y, -200, 200))

    local av = body:getAngularVelocity()
    body:setAngularVelocity(math.clamp(av, -10, 10))

    pacmanEffect(body)
  end

  entity.draw = function()
    love.graphics.polygon('line', body:getWorldPoints(shape:getPoints()));
  end

  entity.handleCollision = function(ent)
    --body:destroy()
  end

  body:setUserData(entity);
  return body
end

entities.asteroid = function(world, cx, cy, r)
  local body = love.physics.newBody(world, cx, cy, 'dynamic')
  body:setLinearVelocity(math.random(-100, 100), math.random(-100, 100))
  local shape = love.physics.newCircleShape(r)
  local fixture = love.physics.newFixture(body, shape)
  fixture:setRestitution(1)

  local entity = {}
  entity.isDead = false
  entity.type = entityType.ASTEROID

  entity.update = function(dt)
    pacmanEffect(body)
    if entity.isDead then
      if shape:getRadius() > 5 then
        local asteroid1 = entities.asteroid(world, body:getX(), body:getY(), r / 2);
        asteroid1:setAngle(body:getAngle() + math.pi / 2)
        asteroid1:applyLinearImpulse(10 * math.cos(asteroid1:getAngle()) * dt, 10 * math.sin(asteroid1:getAngle()) * dt)

        local asteroid2 = entities.asteroid(world, body:getX(), body:getY(), r / 2);
        asteroid2:setAngle(body:getAngle() - math.pi / 2)
        asteroid2:applyLinearImpulse(10 * math.cos(asteroid2:getAngle()) * dt, 10 * math.sin(asteroid2:getAngle()) * dt)
      end
      body:destroy()
    end
  end

  entity.draw = function()
    love.graphics.circle('line', body:getX(), body:getY(), shape:getRadius());
  end

  entity.handleCollision = function(fix)
    if fix:getBody():getUserData().type == entityType.BULLET then
      entity.isDead = true;
    end
  end

  body:setUserData(entity);
  return body
end

return entities;

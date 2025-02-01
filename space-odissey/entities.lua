local controller = require('ecs.components.controllerCmp')

table.unpack = table.unpack or unpack

local entities = {}

local entityType = {
  BULLET = 1,
  PLAYER = 2,
  ASTEROID = 3,
  POLIG = 4
}


local function createPolygonShapes(vertices, body)
  if #vertices > 3 then
    local success, triangles = pcall(function ()
      return love.math.triangulate(vertices)
    end)
    if success then
      for _, triangle in ipairs(triangles) do
        if calculatePolygonArea(triangle) > 1 then
          local shape = love.physics.newPolygonShape(triangle)
          love.physics.newFixture(body, shape)
        end
      end
    end
  end
end

function calculatePolygonArea(vertices)
  local area = 0
  for i = 1, #vertices, 2 do
    local x1, y1 = vertices[i], vertices[i + 1]
    local x2, y2 = vertices[(i + 2 - 1) % #vertices + 1], vertices[(i + 3 - 1) % #vertices + 1]
    area = area + (x1 * y2 - x2 * y1)
  end
  return math.abs(area / 2)
end

local function hexToRGB(hex)
  hex = hex:gsub("#", "")
  local r = tonumber(hex:sub(1, 2), 16) / 255
  local g = tonumber(hex:sub(3, 4), 16) / 255
  local b = tonumber(hex:sub(5, 6), 16) / 255
  return r, g, b
end

local function pacmanEffect(body)
  -- if body:getX() > 800 then
  --   body:setX(0)
  -- end
  -- if body:getX() < 0 then
  --   body:setX(800)
  -- end
  -- if body:getY() > 600 then
  --   body:setY(0)
  -- end
  -- if body:getY() < 0 then
  --   body:setY(600)
  -- end
end

function math.clamp(val, lower, upper)
  return math.max(lower, math.min(upper, val))
end

-- Crea un body statico centrato sul baricentro
entities.polig = function(world, w)
  local cx, cy = 0, 0
  for _, p in ipairs(w.path) do
    cx = cx + p.x
    cy = cy + p.y
  end
  cx = cx / #w.path
  cy = cy / #w.path

  local vertices = {}
  for _, p in ipairs(w.path) do
    table.insert(vertices, p.x)
    table.insert(vertices, p.y)
  end


  if calculatePolygonArea(vertices) > 1 then
    local body
    pcall(function()
      body = love.physics.newBody(world, cx, cy, "static")
      createPolygonShapes(vertices, body)
    end)

    -- local shape = love.physics.newPolygonShape(vertices)
    -- love.physics.newFixture(body, shape)

    if body then
      local entity = {}
    entity.type = entityType.POLIG
    entity.update = function(dt)
    end
    entity.draw = function()
      if #vertices >= 8 then
        local r, g, b = hexToRGB(w.color or "#000000")
        love.graphics.setColor(r, g, b)
        love.graphics.polygon("line", body:getWorldPoints(table.unpack(vertices, 1, #vertices-2)))
        local vert = {body:getWorldPoints(table.unpack(vertices))}
        -- for i = 1, 10, 2 do
        --   if i<200 then
        --     love.graphics.print(i..', '..(i+1), vert[i], vert[i + 1], 0, 1)
        --     love.graphics.circle('line',vert[i], vert[i + 1], 5)
        --   end
          
        -- end
      end
    end
    entity.handleCollision = function(ent)
    end
    body:setUserData(entity);
    return body
    end
    
  end
end




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

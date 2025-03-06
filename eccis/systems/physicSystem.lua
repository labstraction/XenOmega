local utils = require "eccis.utils"


local physicsSysBuilder = function()

  local beginContact = function(a, b, coll)

  end

  local endContact = function(a, b, coll)

  end

  local preSolve = function(a, b, coll)

  end

  local postSolve = function(a, b, coll, normalimpulse, tangentimpulse)

  end

  local world = love.physics.newWorld(0, 0, true);
  world:setCallbacks(beginContact, endContact, preSolve, postSolve)

  local update = function(dt)
    world:update(dt)
  end

  local createBody = function(entity)
    if not entity.position then
      return nil;
    end
    local body = love.physics.newBody(world, entity.position.x, entity.position.y, entity.position.type or "dynamic");
    if not entity.collider then
      return body;
    end
    local shape = love.physics.newPolygonShape(entity.collider)
    love.physics.newFixture(body, shape, 1)
    body:setLinearDamping(0.2)
    body:setAngularDamping(0.2)
    return body
  end

  return { update = update, createBody = createBody, world = world }
end

return physicsSysBuilder









-- function physicCmp.createBody(world, x, y, collider)
--   local body = love.physics.newBody(world, x, y, "dynamic")
--   local shape = love.physics.newPolygonShape(collider)
--   love.physics.newFixture(body, shape, 1)
--   body:setLinearDamping(0.2)
--   body:setAngularDamping(0.2)
--   return body
-- end

-- function physicCmp.applyForce(body, value, angle, dt)
--   local angle = body:getAngle() + angle
--   local fx = math.cos(angle) * value * dt
--   local fy = math.sin(angle) * value * dt
--   body:applyForce(fx, fy)
-- end






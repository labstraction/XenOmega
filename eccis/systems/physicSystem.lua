local utils = require "eccis.libs.utils"


local physicsSysBuilder = function()
  local shapeMapper = {
    polygon = function(points) return love.physics.newPolygonShape(points) end,
    circle = function(radius) return love.physics.newCircleShape(radius) end
  }

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
    if not entity:has('position') then
      return nil;
    end
    local position = entity:get('position')
    local body = love.physics.newBody(world, position.x, position.y, position.type);
    if not entity:has('collider') then
      return body;
    end
    local collider = entity:get('collider')
    local shape = shapeMapper[collider.type](collider.points);
    love.physics.newFixture(body, shape, 1)
    body:setLinearDamping(0.01)
    body:setAngularDamping(0.01)
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

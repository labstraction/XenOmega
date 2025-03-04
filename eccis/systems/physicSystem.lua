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

  local world;
  world:setCallbacks(beginContact, endContact, preSolve, postSolve)

  local update = function(dt, _ , world)
    world:update(dt)
  end

  return { update = update, load = load, world = world }
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






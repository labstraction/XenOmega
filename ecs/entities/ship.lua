local entity = require("ecs.entity")
local shipTypes = require("ecs.entities.shipTypes")

local ship = entity:new()

function ship:new(world, x, y, shipType)

  local config = shipTypes[shipType or 1]

  local body = love.physics.newBody(world, x, y, "dynamic")
  local shape = love.physics.newPolygonShape(config.shape)
  love.physics.newFixture(body, shape, 1)
  body:setLinearDamping(0.2) -- Resistenza per realismo
  body:setAngularDamping(0.2) -- Resistenza per realismo

  local components = {
    graphic = {
      draw = config.draw
    },
    controls = {
      thrust = config.thrust,
      lateral_thrust = config.lateral,
      brake_force = config.brake,
      torque = config.torque
    },
    fuel = {
      max = config.fuel or 1000,
      current = config.fuel or 1000,
      consumption = 0.2
    },
    -- particles = {
    --   main = { emitter = createThrusterParticles(), offset = {x = 0, y = 15} },
    --   left = { emitter = createThrusterParticles(), offset = {x = -8, y = -5} },
    --   right = { emitter = createThrusterParticles(), offset = {x = 8, y = -5} }
    -- }
    emitters = config.emitters
  }

  body:setUserData(entity:new(components))

  return body
end

return ship



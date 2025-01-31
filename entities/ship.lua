local entity = require("ecs.entity")
local particleComponent = require("ecs.component")
local shipTypes = require("entities.shipTypes")

local ship = entity:new()

local function createThrusterParticles()
  local img = love.image.newImageData(1, 1)
  img:setPixel(0, 0, 1, 1, 1, 1)
  local ps = love.graphics.newParticleSystem(love.graphics.newImage(img), 1364)
  -- ps:setParticleLifetime(0.1, 0.3)
  -- ps:setSizeVariation(0)
  -- ps:setLinearAcceleration(-100, -100, 100, 100)
  -- ps:setColors(1, 0.5, 0, 1, 1, 0, 0, 0)

  ps:setEmissionRate( 67 )
  ps:setParticleLifetime( 0.357143, 1.11111 )
  ps:setDirection( -0.0105422 )
  ps:setSpread( 0.759043 )
  -- ps:setRelative( false )
  ps:setSpeed( 114.286, 190.476 )
  ps:setRadialAcceleration( 0, 0 )
  ps:setTangentialAcceleration( 0, 0 )
 
  ps:setSpin( 0, 0, 0 )
  ps:setColors( 255, 188, 0, 230, 145, 0, 62, 14 )
  -- ps:setColorVariation( 0 )
  -- ps:setAlphaVariation( 0.484127 )

  return ps
end

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
    particles = {
      main = { emitter = createThrusterParticles(), offset = {x = 0, y = 15} },
      left = { emitter = createThrusterParticles(), offset = {x = -8, y = -5} },
      right = { emitter = createThrusterParticles(), offset = {x = 8, y = -5} }
    }
  }

  body:setUserData(entity:new(components))

  return body
end

return ship



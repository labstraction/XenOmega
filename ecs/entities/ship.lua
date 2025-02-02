local entity = require("ecs.entity")
local shipTypes = require("ecs.entities.shipTypes")
local controllerCmp = require("ecs.components.controllerCmp")
local particleCmp   = require("ecs.components.particleCmp")
local utils         = require("libs.utils")
local graphicCmp    = require("ecs.components.graphicCmp")

local ship = entity:new()

function ship:new(world, x, y, shipType)
  
  local config = shipTypes[shipType or 1]

  local body = love.physics.newBody(world, x, y, "dynamic")
  local shape = love.physics.newPolygonShape(config.collider)
  love.physics.newFixture(body, shape, 1)
  body:setLinearDamping(0.2)
  body:setAngularDamping(0.2)


  local particle = particleCmp:new()
                              :addEmitter('w', -16, 0, math.pi)
                              :addEmitter('s', 20, 0, 0)
                              :addEmitter('q', 0, 16, math.pi/2)
                              :addEmitter('e', 0, -16, -math.pi/2)

  local graphic = graphicCmp:new(config.graphic)

  local actions = {}
  actions.w = function(dt)
    local angle = body:getAngle()
    local fx = math.cos(angle) * config.thrust * dt
    local fy = math.sin(angle) * config.thrust * dt
    body:applyForce(fx, fy)
    particle.emitters.w.ps:emit(100)
  end
  actions.s = function(dt)
    local angle = body:getAngle() + math.pi
    local fx = math.cos(angle) * config.brake * dt
    local fy = math.sin(angle) * config.brake * dt
    body:applyForce(fx, fy)
    particle.emitters.s.ps:emit(100)
  end
  actions.q = function(dt)
    local angle = body:getAngle() - math.pi/2
    local fx = math.cos(angle) * config.lateral * dt
    local fy = math.sin(angle) * config.lateral * dt
    body:applyForce(fx, fy)
    particle.emitters.q.ps:emit(100)
  end
  actions.e = function(dt)
    local angle = body:getAngle() + math.pi/2
    local fx = math.cos(angle) * config.lateral * dt
    local fy = math.sin(angle) * config.lateral * dt
    body:applyForce(fx, fy)
    particle.emitters.e.ps:emit(100)
  end
  actions.a = function(dt)
    body:applyTorque(-config.torque * dt)
  end
  actions.d = function(dt)
    body:applyTorque(config.torque* dt)
  end
  local controller = controllerCmp.new(actions)


  local components = {
    controller = controller,
    graphic = graphic,
    fuel = {
      max = config.fuel or 1000,
      current = config.fuel or 1000,
      consumption = 0.2
    },
    particle = particle
  }

  local entity = entity:new(components)

  entity.update = function (dt)
    entity.components.controller:update(dt)
    entity.components.particle:updateAll(body,dt)
  end

  entity.draw = function()
    entity.components.graphic:drawAll(body)
    entity.components.particle:drawAll()
  end

  body:setUserData(entity)

  return body
end

return ship



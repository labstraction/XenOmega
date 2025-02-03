local entity = require("ecs.entity")
local shipTypes = require("ecs.entities.shipTypes")
local controllerCmp = require("ecs.components.controllerCmp")
local particleCmp   = require("ecs.components.particleCmp")
local utils         = require("libs.utils")
local graphicCmp    = require("ecs.components.graphicCmp")
local physicCmp     = require("ecs.components.physicCmp")

local ship = entity:new()

function ship:new(world, x, y, shipType)
  
  local config = shipTypes[shipType or 1]

  local body = physicCmp.createBody(world, x, y, config.collider)

  local particle = particleCmp:new()
                              :addEmitter('w', -16, 0, math.pi)
                              :addEmitter('s', 20, 0, 0)
                              :addEmitter('q', 0, 16, math.pi/2)
                              :addEmitter('e', 0, -16, -math.pi/2)

  local graphic = graphicCmp:new(config.graphic)

  local actions = {}
  actions.w = function(dt)
    physicCmp.applyForce(body, config.thrust, 0,  dt)
    particle.emitters.w.ps:emit(100)
  end
  actions.s = function(dt)
    physicCmp.applyForce(body, config.brake, math.pi,  dt)
    particle.emitters.s.ps:emit(100)
  end
  actions.q = function(dt)
    physicCmp.applyForce(body, config.lateral, -math.pi/2,  dt)
    particle.emitters.q.ps:emit(100)
  end
  actions.e = function(dt)
    physicCmp.applyForce(body, config.lateral, math.pi/2,  dt)
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



local entity = require("ecs.entity")
local shipTypes = require("ecs.entities.shipTypes")
local particleCmp   = require("ecs.components.particleCmp")
local utils         = require("libs.utils")
local graphicCmp    = require("ecs.components.graphicCmp")
local physicCmp     = require("ecs.components.physicCmp")

local enemy = entity:new()

function enemy:new(world, x, y, shipType)
  
  local config = shipTypes[shipType or 2]

  local body = physicCmp.createBody(world, x, y, config.collider)

  local particle = particleCmp:new()
                              :addEmitter('w', -16, 0, math.pi)
                              :addEmitter('s', 20, 0, 0)
                              :addEmitter('q', 0, 16, math.pi/2)
                              :addEmitter('e', 0, -16, -math.pi/2)

  local graphic = graphicCmp:new(config.graphic)

  local strategies = {
    function(dt, player)
      local x, y = body:getPosition()
      local px, py = player:getPosition()
      local angle = math.atan2(py - y, px - x)
      body:setAngle(angle)
      body:applyForce(math.cos(angle) * 100, math.sin(angle) * 100)
    end
  }

  local brain = new brainCmp:new(strategies)


  local components = {
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
    entity.components.brain:update(dt)
    entity.components.particle:updateAll(body,dt)
  end

  entity.draw = function()
    entity.components.graphic:drawAll(body)
    entity.components.particle:drawAll()
  end

  body:setUserData(entity)

  return body
end

return enemy



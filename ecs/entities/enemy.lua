local entity = require("ecs.entity")
local shipTypes = require("ecs.entities.shipTypes")
local particleCmp   = require("ecs.components.particleCmp")
local utils         = require("libs.utils")
local graphicCmp    = require("ecs.components.graphicCmp")
local physicCmp     = require("ecs.components.physicCmp")
local brainCmp      = require("ecs.components.brainCmp")

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

  local strategy = {
    tactics = {
      function(dt, player, world)
        local nearest
        local min = 100000
        for i, v in ipairs(world:getBodies()) do
          print("State 1", body:getUserData().components.id, v:getUserData().components.id)
          if not (body:getUserData().components.id == v:getUserData().components.id) then

          local x, y = body:getPosition()
          local px, py = v:getPosition()
            local d = math.sqrt((px - x)^2 + (py - y)^2)
            print(d)
            if d < min then
              min = d
              nearest = v
            end
          end
        end
        if min <= 300 then
          return 2
        end
        local x, y = body:getPosition()
        local px, py = player:getPosition()
        local angle = math.atan2(py - y, px - x)
        body:setAngle(angle +0.1)
        body:applyForce(math.cos(angle) * config.thrust * dt, math.sin(angle) * config.thrust * dt)
        particle.emitters.w.ps:emit(100)
        return 1
      end,
      function(dt, player, world)
        local nearest
        local min = 100000
        for i, v in ipairs(world:getBodies()) do
          if not (body:getUserData().components.id == v:getUserData().components.id) then
          local x, y = body:getPosition()
          local px, py = v:getPosition()
            local d = math.sqrt((px - x)^2 + (py - y)^2)
            if d < min then
              min = d
              nearest = v
            end
          end
        end
        if min >= 300 then
          return 1
        end
        print("State 2")
        local x, y = body:getPosition()
        local px, py = nearest:getPosition()
        local angle = math.atan2(py - y, px - x)
        body:setAngle(angle +0.1)
        body:applyForce(math.cos(-angle) * config.thrust * dt, math.sin(-angle) * config.thrust * dt)
        particle.emitters.w.ps:emit(100)
        return 2
      end
    }
  }

  local brain = brainCmp.new(strategy)


  local components = {
    graphic = graphic,
    fuel = {
      max = config.fuel or 1000,
      current = config.fuel or 1000,
      consumption = 0.2
    },
    particle = particle,
    brain = brain,
    id = utils.uuid()
  }

  print("Enemy created", components.id)

  local entity = entity:new(components)

  entity.update = function (dt, player, world)
    entity.components.brain:update(dt, player, world)
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



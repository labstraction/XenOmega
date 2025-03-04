local utils = require "eccis.utils"


local utils = require "eccis.utils"


local graphSysBuilder = function ()

    local drawMapper = {
        polygon = function(mode, points) love.graphics.polygon(mode, points) end
    }

    local graphicSystem = function (entity)
        if not entity:has("graphic") then
            return false;
        end
        local graphic = entity:get("graphic");
        for _, element in ipairs(graphic) do
            love.graphics.setColor(utils.hexToRGB(element.color))
            love.graphics.setLineWidth(element.width)
            drawMapper[element.type](element.mode, element.points)
        end
    end
    return graphicSystem
end

return graphSysBuilder

local cameraSysBuilder = function(target, scale, smoothness)

    local camera = {
        x = 0,
        y = 0,
        scale = scale or 1,
        target = target,
        smoothness = smoothness or 0.1
    }

    local update = function(dt)
        if camera.target then
          local tx, ty = camera.target:getX(), camera.target:getY()
          camera.x = camera.x + (tx - camera.x) * camera.smoothness
          camera.y = camera.y + (ty - camera.y) * camera.smoothness
        end
    end

    local apply = function()
        love.graphics.push()
        love.graphics.scale(camera.scale)
        love.graphics.translate(-camera.x + love.graphics.getWidth()/(2*camera.scale), 
                                -camera.y + love.graphics.getHeight()/(2*camera.scale))
    end
      
    local clear = function()
        love.graphics.pop()
    end


    return {update = update, apply = apply, clear = clear}
end

return cameraSysBuilder


local utils = require("eccis.utils")

local physicsSystem = {}

function physicsSystem:new(world)
  local system = { world = world }
  setmetatable(system, {__index = self})
  return system
end


function physicsSystem:update(dt, world, player)
  for i, v in ipairs(world:getBodies()) do
    local body = v
    local entity = body:getUserData()
    entity.update(dt, player, world)
  end

  -- if love.keyboard.isDown("w") and fuel.current > 0 then
  --   print("Thrusting", utils.log(fuel)) 
  --   local fx = math.cos(angle) * controls.thrust * dt
  --   local fy = math.sin(angle) * controls.thrust * dt
  --   body:applyForce(fx, fy)
  --   --fuel.current = fuel.current - dt * controls.fuel.consumption
  -- end

  -- if love.keyboard.isDown("a") then
  --   body:applyTorque(-controls.torque * dt)
  -- elseif love.keyboard.isDown("d") then
  --   body:applyTorque(controls.torque * dt)
  -- end

  -- if love.keyboard.isDown("s") then
  --   local vx, vy = body:getLinearVelocity()
  --   body:applyForce(-vx * controls.brake_force * dt, -vy * controls.brake_force * dt)
  -- end
end

return physicsSystem


local physicCmp = {}

function physicCmp.createBody(world,x, y, collider)

  local body = love.physics.newBody(world, x, y, "dynamic")
  local shape = love.physics.newPolygonShape(collider)
  love.physics.newFixture(body, shape, 1)
  body:setLinearDamping(0.2)
  body:setAngularDamping(0.2)
  return body

end


function physicCmp.applyForce(body, value, angle, dt)
  local angle = body:getAngle() + angle
  local fx = math.cos(angle) * value * dt
  local fy = math.sin(angle) * value * dt
  body:applyForce(fx, fy)
end

function physicCmp:emit(name)
  self.emitters[name]:emit(200)
end

function physicCmp:updateAll(body, dt)
  for key, _ in pairs(self.emitters) do
    self:updateEmitter(key, body, dt)
  end
end

function physicCmp:drawAll()
  love.graphics.setColor(1, 1, 1)
  for _, value in pairs(self.emitters) do
    love.graphics.setBlendMode("add")
        love.graphics.draw(value.ps)
    love.graphics.setBlendMode("alpha")
  end
end

return physicCmp
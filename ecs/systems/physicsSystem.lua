local utils = require("utils")

local physicsSystem = {}

function physicsSystem:new(world)
  local system = { world = world }
  setmetatable(system, {__index = self})
  return system
end

function physicsSystem:update(dt, entityBody)
  local body = entityBody
  local entity = body:getUserData()
  local controls = entity:getComponent("controls")
  local fuel = entity:getComponent("fuel")

  local angle = body:getAngle()

  if love.keyboard.isDown("w") and fuel.current > 0 then
    print("Thrusting", utils.log(fuel)) 
    local fx = math.cos(angle) * controls.thrust * dt
    local fy = math.sin(angle) * controls.thrust * dt
    body:applyForce(fx, fy)
    --fuel.current = fuel.current - dt * controls.fuel.consumption
  end

  if love.keyboard.isDown("a") then
    body:applyTorque(-controls.torque * dt)
  elseif love.keyboard.isDown("d") then
    body:applyTorque(controls.torque * dt)
  end

  if love.keyboard.isDown("s") then
    local vx, vy = body:getLinearVelocity()
    body:applyForce(-vx * controls.brake_force * dt, -vy * controls.brake_force * dt)
  end
end

return physicsSystem
local ship = require("entities.ship")
local camera = require ("systems.cameraSystem")
local physicsSystem = require("systems.physicsSystem")
local renderSystem = require("systems.renderSystem")
local particleSystem = require("systems.particleSystem")
local starfieldSystem = require("systems.starfieldSystem")
local utils = require("utils")
local systems
local player
local world


function love.load()
  world = love.physics.newWorld(0, 0, true)
  love.physics.setMeter(32)

  systems = {
    starfieldSystem:new(),
    physicsSystem:new(world),
    renderSystem:new(),
    particleSystem:new()
  }

  camera = camera:new()
  camera:setScale(0.5)

  player = ship:new(world, 400, 300, 1)
end

function love.update(dt)
  world:update(dt)
  camera:setTarget(player)
  camera:update(dt)
  
  for _, system in ipairs(systems) do
    if system.update then
      system:update(dt, player)
    end
  end
end

function love.draw()
  camera:apply()
  for _, system in ipairs(systems) do
    if system.draw then
      system:draw(player)
    end
  end
  camera:clear()
end

function love.keypressed(key)
  -- Cambio nave debug
  if key == "1" then player = ship:new(world, camera.x, camera.y, 1) end
  if key == "2" then player = ship:new(world, camera.x, camera.y, 2) end
  if key == "3" then player = ship:new(world, camera.x, camera.y, 3) end
end
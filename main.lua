local ship = require("ecs.entities.ship")
local camera = require ("ecs.systems.cameraSystem")
local physicsSystem = require("ecs.systems.physicsSystem")
local renderSystem = require("ecs.systems.renderSystem")
local particleSystem = require("ecs.systems.particleSystem")
local starfieldSystem = require("ecs.systems.starfieldSystem")
local utils = require("libs.utils")
local systems
local player
local world


function love.load()

  world = love.physics.newWorld(0, 0, true)
  love.physics.setMeter(16)

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


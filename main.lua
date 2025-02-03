local ship = require("ecs.entities.ship")
local enemy = require("ecs.entities.enemy")
local camera = require ("ecs.systems.cameraSystem")
local physicsSystem = require("ecs.systems.physicsSystem")
local renderSystem = require("ecs.systems.renderSystem")
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
  }

  camera = camera:new()
  camera:setScale(0.5)

  player = ship:new(world, 400, 300, 1)

  for i = 1, 10 do
    local x = utils.random(0, 2000)
    local y = utils.random(0, 2000)
    enemy:new(world, x, y, 3)
  end
end

function love.update(dt)
  world:update(dt)
  camera:setTarget(player)
  camera:update(dt)
  systems[1]:update(dt, player)
  systems[2]:update(dt, world, player)  

end

function love.draw()

  camera:apply()
  for _, system in ipairs(systems) do
    if system.draw then
      system:draw(world)
    end
  end
  camera:clear()
  
end


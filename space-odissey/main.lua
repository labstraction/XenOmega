
local gameConf = require('game-conf')
local entities = require('entities')

local player
local world

local function beginContact(a, b, coll)
  if a:getBody():getUserData().handleCollision then
    a:getBody():getUserData().handleCollision(b)
  end
  if b:getBody():getUserData().handleCollision then
    b:getBody():getUserData().handleCollision(a)
  end
end

function love.load()
  world = love.physics.newWorld(0, 0, true)
  love.physics.setMeter(64)
  world:setCallbacks(beginContact)
  
  player = entities.player(world, 240, 135)
end

function love.update(dt)
  world:update(dt);
  for _, e in ipairs(world:getBodies()) do
    e:getUserData().update(dt)
  end
end

function love.draw()
  love.graphics.push()
  love.graphics.translate(-player:getX() + 240, -player:getY() + 135)
  for _, e in ipairs(world:getBodies()) do
    e:getUserData().draw()
  end
  love.graphics.pop()
end


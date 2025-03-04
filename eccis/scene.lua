local utils = require"libs.utils"
local entity = require"eccis.entity"

local scene = {}

function scene:new()
  local newScene = {
    entities = {},
    loadSystems = {},
    updateSystems = {},
    drawSystems = {},
    world = love.physics.newWorld(0, 0, true)
  }
  setmetatable(newScene, {__index = self})
  return newScene
end

function scene:newEntity()
  local newEntity = entity:new()
  self.entities = utils.insert(self.entities, newEntity)
  return newEntity;
end

function scene:addEntity(entity)
  self.entities = utils.insert(self.entities, entity)
end

function scene:addCamera(camera)
  self.camera = camera
end

function scene:addLoadSystem(system, priority)
  self.loadSystems = utils.insert(self.loadSystems, system)
end

function scene:addUpdateSystem(system, priority)
  self.updateSystems = utils.insert(self.updateSystems, system)
end

function scene:addDrawSystem(system, priority)
  self.drawSystems = utils.insert(self.drawSystems, system)
end

function scene:update(dt)
  for _, entity in ipairs(self.entities) do
    for _, system in ipairs(self.updateSystems) do
      system(dt, entity);
    end
  end
end

function scene:draw()
  self.camera:apply()
  for _, entity in ipairs(self.entities) do
    for _, system in ipairs(self.drawSystems) do
      utils.log('entity')
      utils.log(entity)
      system(entity)
    end
  end
  self.camera:clear()
end


return scene

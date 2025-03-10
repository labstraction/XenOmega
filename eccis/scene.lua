local utils = require "eccis.libs.utils"
local entity = require "eccis.entity"
local eventManagerBuilder = require "eccis.libs.event-manager"

local scene = {}

function scene:new()
    local newScene = {
        entities = {},
        loadSystems = {},
        updateSystems = {},
        drawSystems = {},
    }
    setmetatable(newScene, { __index = self })
    return newScene
end

function scene:newEntity()
    local newEntity = entity:new()
    self:addEntity(newEntity)
    return newEntity;
end

function scene:addEntity(entity)
    if self.physicSystem then
        local body = self.physicSystem:createBody(entity)
        if body then
            entity.body = body
        end
    end
    self.entities[entity.id] = entity
end

function scene:addCameraSystem(cameraSystem)
    self.cameraSystem = cameraSystem
end

function scene:addPhysicSystem(physicSystem)
    self.physicSystem = physicSystem
    for _, entity in pairs(self.entities) do
        if not entity.body then
            local body = self.physicSystem.createBody(entity)
            if body then
                entity.body = body
            end
        end
    end
end

function scene:addLoadSystem(system)
    self.loadSystems = utils.insert(self.loadSystems, system)
end

function scene:addUpdateSystem(system)
    self.updateSystems = utils.insert(self.updateSystems, system)
end

function scene:addDrawSystem(system)
    self.drawSystems = utils.insert(self.drawSystems, system)
end

function scene:update(dt)
    if self.physicSystem then self.physicSystem.update(dt) end
    if self.cameraSystem then self.cameraSystem.update(dt) end
    for _, entity in pairs(self.entities) do
        for _, system in ipairs(self.updateSystems) do
            system(dt, entity, self.physicSystem.world);
        end
    end
end

function scene:draw()
    self.cameraSystem:apply()
    for _, entity in pairs(self.entities) do
        for _, system in ipairs(self.drawSystems) do
            system(entity)
        end
    end
    self.cameraSystem:clear()
end


function scene:addSubscription(sub, callback)
    if not self.eventManager then
        self.eventManager = eventManagerBuilder();
    end
    self.eventManager.subscribe(sub, callback)
    return self.eventManager
end

return scene

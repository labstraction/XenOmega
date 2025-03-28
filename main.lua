local utils = require("eccis.libs.utils")
local scene = require("eccis.scene")
local cameraBuilder = require("eccis.systems.cameraSystem")
local graphicBuilder = require("eccis.systems.graphicSystem")
local physicBuilder = require("eccis.systems.physicSystem")
local controllerBuilder = require("eccis.systems.controllerSystem")
local starfieldBuilder = require("eccis.systems.starfieldSystem")
local interceptor = require("eccis.componets.ships.interceptor")
local scenes = {}
local currentScene = 1

function love.load()
    local firstScene = scene:new()
    local manager = firstScene:addSubscription("addEntity", function(entity)
        utils.log("addEntity")
        firstScene:addEntity(entity)
    end)
    local player = firstScene:newEntity()
    player:add("graphic", interceptor.draw)
    player:add("collider", interceptor.collider)
    player:add("position", { x = 0, y = 0, type = "dynamic" })
    player:add("engine", interceptor.engine)
    player:add("controls", { w = "mainThrust", a = "leftThrust", d = "rightThrust", l='fire' })
    local starfieldSystem = starfieldBuilder(player)
    firstScene:addDrawSystem(starfieldSystem.draw)
    firstScene:addUpdateSystem(starfieldSystem.update)
    local cameraSystem = cameraBuilder(player, 0.5, 0.1)
    firstScene:addCameraSystem(cameraSystem)
    local graphicSystem = graphicBuilder()
    firstScene:addDrawSystem(graphicSystem.draw)
    local physicSystem = physicBuilder()
    firstScene:addPhysicSystem(physicSystem)
    local controllerSystem = controllerBuilder(manager)
    firstScene:addUpdateSystem(controllerSystem.update)
    table.insert(scenes, firstScene)
end

function love.update(dt)
    scenes[currentScene]:update(dt)
end

function love.draw()
  scenes[currentScene]:draw()
end

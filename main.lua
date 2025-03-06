local utils = require("eccis.utils")
local scene = require("eccis.scene")
local cameraBuilder = require("eccis.systems.cameraSystem")
local graphicBuilder = require("eccis.systems.graphicSystem")
local physicBuilder = require("eccis.systems.physicSystem")
local controllerBuilder = require("eccis.systems.controllerSystem")
local interceptor = require("eccis.componets.ships.interceptor")
local scenes = {}
local currentScene = 1

function love.load()
    local firstScene = scene:new()
    local player = firstScene:newEntity()
    utils.log(player)
    player:add("graphic", interceptor.draw)
    player:add("collider", interceptor.collider)
    player:add("position", { x = 0, y = 0, type = "dynamic" })
    player:add("controls", { w = "up" })
    local cameraSystem = cameraBuilder(player, 0.5, 0.1)
    firstScene:addCameraSystem(cameraSystem)
    local graphicSystem = graphicBuilder()
    firstScene:addDrawSystem(graphicSystem)
    local physicSystem = physicBuilder()
    firstScene:addPhysicSystem(physicSystem)
    local controllerSystem = controllerBuilder()
    firstScene:addUpdateSystem(controllerSystem.update)
    table.insert(scenes, firstScene)
end

function love.update(dt)
    scenes[currentScene]:update(dt)
end

function love.draw()
  scenes[currentScene]:draw()
end

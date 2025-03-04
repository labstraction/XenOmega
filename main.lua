local utils = require("eccis.utils")
local scene = require("eccis.scene")
local cameraBuilder = require("eccis.systems.cameraSystem")
local graphicBuilder = require("eccis.systems.graphicSystem")
local interceptor = require("eccis.componets.graphic.interceptor")
local scenes = {}
local currentScene = 1

function love.load()
    local firstScene = scene:new()
    local player = firstScene:newEntity()
    player:add("graphic", interceptor)
    local camera = cameraBuilder(player, 0.3, 0.1)
    firstScene:addCamera(camera)
    local graphicSystem = graphicBuilder()
    firstScene:addDrawSystem(graphicSystem)
    table.insert(scenes, firstScene)
end

function love.update(dt)
    scenes[currentScene]:update(dt)
end

function love.draw()
  scenes[currentScene]:draw()
end

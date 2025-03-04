local utils = require("eccis.utils")
local scene = require("eccis.scene")
local cameraBuilder = require("eccis.systems.cameraSystem")
local interceptor = require("eccis.componets.graphic.interceptor")
local scenes = {}
local currentScene = 1

function love.load()
    local firstScene = scene:new()
    local player = firstScene:newEntity();
    player:add("graphic", interceptor)
    local camera = cameraBuilder(player, 1, 0.1)
    firstScene:addCamera(camera)
    table.insert(scenes, firstScene)
    utils.log(scenes)

end

function love.update(dt)


end

function love.draw()

  
end

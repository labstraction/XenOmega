local utils = require "eccis.utils"


local controllerSysBuilder = function()

    local controllerCmp = { controlled = {}, keys = {} }

    function love.keypressed(key)
        controllerCmp.keys[key] = true;
    end
    
    function love.keyreleased(key)
        controllerCmp.keys[key] = nil;
    end

    local update = function(dt, entity)
        if not entity:has("controls") then
            return false;
        end
        for key, value in pairs(self.keys) do
            for id, value in pairs(self.controlled) do
                if value and self.controlled[id].actions[key] then
                    self.controlled[id].actions[key](dt)
                end
            end
        end
    end

    return {update = update}
end

return controllerSysBuilder
















local controller = {}

controller.new = function (reactions)
  local react = {}
  if reactions then react = reactions end

  local newController = {keys = {}}

  function love.keypressed(key)
    newController.keys[key] = true;
  end

  function love.keyreleased(key)
    newController.keys[key] = nil;
  end

  newController.update = function (dt)
    for key, value in pairs(newController.keys) do
      if value and react[key] then
          react[key](dt)
      end
    end
  end

  return newController

end

return controller;




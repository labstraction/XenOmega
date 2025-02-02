local camera = {}

function camera:new()
  local newCamera = {
    x = 0,
    y = 0,
    scale = 1,
    target = nil,
    smoothness = 0.1
  }
  setmetatable(newCamera, {__index = self})
  return newCamera
end

function camera:update(dt)
  if self.target then
    local tx, ty = self.target:getX(), self.target:getY()
    self.x = self.x + (tx - self.x)-- * self.smoothness
    self.y = self.y + (ty - self.y)-- * self.smoothness
  end
end

function camera:apply()
  love.graphics.push()
  love.graphics.scale(self.scale)
  love.graphics.translate(-self.x + love.graphics.getWidth()/(2*self.scale), 
                          -self.y + love.graphics.getHeight()/(2*self.scale))
end

function camera:clear()
  love.graphics.pop()
end

function camera:setScale(s)
  self.scale = s
end

function camera:setTarget(t)
  self.target = t
end

return camera

local utils = {}


utils.log = function(value, depth, key)
  local linePrefix = ""
  local spaces = ""

  if key ~= nil then
    linePrefix = "["..key.."] = "
  end

  if depth == nil then
    depth = 0
  else
    depth = depth + 1
    for i=1, depth do spaces = spaces .. "  " end
  end

  if type(value) == 'table' then
    local mTable = getmetatable(value)
    if mTable == nil then
      print(spaces ..linePrefix.."(table) ")
    else
      print(spaces .."(metatable) ")
        value = mTable
    end		
    for tableKey, tableValue in pairs(value) do
      utils.log(tableValue, depth, tableKey)
    end
  elseif type(value)	== 'function' or 
      type(value)	== 'thread' or 
      type(value)	== 'userdata' or
      value		== nil
  then
    print(spaces..tostring(value))
  else
    print(spaces..linePrefix.."("..type(value)..") "..tostring(value))
  end
end

utils.uuid = function()
  local fn = function(x)
      local r = math.random(16) - 1
      r = (x == "x") and (r + 1) or (r % 4) + 9
      return ("0123456789abcdef"):sub(r, r)
  end
  return (("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"):gsub("[xy]", fn))
end

utils.random = function(min, max)
  local min, max = min or 0, max or 1
  return (min > max and (love.math.random()*(min - max) + max)) or (love.math.random()*(max - min) + min)
end

utils.pushRotate = function(x, y, r)
  love.graphics.push()
  love.graphics.translate(x, y)
  love.graphics.rotate(r or 0)
  love.graphics.translate(-x, -y)
end

utils.pushRotateScale = function(x, y, r, sx, sy)
  love.graphics.push()
  love.graphics.translate(x, y)
  love.graphics.rotate(r or 0)
  love.graphics.scale(sx or 1, sy or sx or 1)
  love.graphics.translate(-x, -y)
end

utils.calculatePolygonArea = function(vertices)
  local area = 0
  for i = 1, #vertices, 2 do
    local x1, y1 = vertices[i], vertices[i + 1]
    local x2, y2 = vertices[(i + 2 - 1) % #vertices + 1], vertices[(i + 3 - 1) % #vertices + 1]
    area = area + (x1 * y2 - x2 * y1)
  end
  return math.abs(area / 2)
end

utils.createPolygonShapes = function(vertices, body)
  if #vertices > 3 then
    local success, triangles = pcall(function ()
      return love.math.triangulate(vertices)
    end)
    if success then
      for _, triangle in ipairs(triangles) do
        if utils.calculatePolygonArea(triangle) > 1 then
          local shape = love.physics.newPolygonShape(triangle)
          love.physics.newFixture(body, shape)
        end
      end
    end
  end
end

utils.hexToRGB =function(hex)
  hex = hex:gsub("#", "")
  local r = tonumber(hex:sub(1, 2), 16) / 255
  local g = tonumber(hex:sub(3, 4), 16) / 255
  local b = tonumber(hex:sub(5, 6), 16) / 255
  return r, g, b
end

utils.clamp = function(val, lower, upper)
  return math.max(lower, math.min(upper, val))
end

utils.unpack = table.unpack or unpack

utils.sort = function(t, comp)
  local newTable = {utils.unpack(t)}
  table.sort(newTable, comp)
  return newTable
end

utils.insert = function(t, value)
  local newTable = {utils.unpack(t)}
  table.insert(newTable, value)
  return newTable
end

return utils
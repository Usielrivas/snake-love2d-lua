local Food = Object:extend()

function Food:new()
  local positionInitial = self:posicion()
  self.draw = {}
  self:create()
end

function Food:reset()
  self:delete()
  self:create()
end

function Food:delete()
    world:remove(self.draw[#self.draw])
    table.remove(self.draw)
end

function Food:create()
  local positionInitial = self:posicion()
  local newFood = { x = positionInitial.x, y = positionInitial.y, w = 20, h = 20, food = true, bg = Snake.BODY_COLOR }

  world:add(newFood, newFood.x, newFood.y, newFood.w, newFood.h)
  table.insert(self.draw, newFood)
end

function Food:posicion()
    local right = love.graphics.getWidth()
    local bottom = love.graphics.getHeight()

    local x = math.random(0, right)
    local y = math.random(0, bottom)
    
    return { x = x, y = y }
end

return Food

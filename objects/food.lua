local Food = Object:extend()

Food.COLOR = { r = 0, g = 1, b = 0 }
Food.COLOR_RED = { r = 1, g = 0, b = 0 }

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
  local newFood = { x = positionInitial.x, y = positionInitial.y, w = 20, h = 20, food = true, bg = Food.COLOR, state = 1 }

  world:add(newFood, newFood.x, newFood.y, newFood.w, newFood.h)
  table.insert(self.draw, newFood)
end

function Food:move()
    if #self.draw == 1 then
        local currentFood = self.draw[1]
        if currentFood.state == 1 then
          currentFood.bg = Food.COLOR_RED
          currentFood.state = 2
        else
          currentFood.bg = Food.COLOR
          currentFood.state = 1
        end
    end
end

function Food:posicion()
    local right = math.floor((love.graphics.getWidth() / Snake.CELL) - 1)
    local bottom = math.floor((love.graphics.getHeight() / Snake.CELL) - 1)

    local x = math.random(0, right * Snake.CELL)
    local y = math.random(0, bottom * Snake.CELL)

    return { x = x, y = y }
end

function Food:drawFood()
    for _, foodDraw in pairs(self.draw) do
      love.graphics.setColor(foodDraw.bg.r, foodDraw.bg.g, foodDraw.bg.b)
      love.graphics.rectangle("fill", foodDraw.x, foodDraw.y, foodDraw.w, foodDraw.h)
    end
end

return Food

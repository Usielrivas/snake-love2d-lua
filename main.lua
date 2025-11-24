function love.load()
 math.randomseed(os.time())
    Object = require 'libs.classic'
    Bump = require 'libs.bump'
    math.randomseed(os.time())

    world = Bump.newWorld()

    Snake = require 'objects.snake'
    snake = Snake()

    Food = require 'objects.food'
    food = Food()
end

function love.update(dt)
  snake:move(dt)
end

function love.draw()
    for _, foodDraw in pairs(food.draw) do
      love.graphics.setColor(foodDraw.bg.r, foodDraw.bg.g, foodDraw.bg.b)
      love.graphics.rectangle("fill", foodDraw.x, foodDraw.y, foodDraw.w, foodDraw.h)
    end

    for i, snakePart in pairs(snake.draw) do
      love.graphics.setColor(snakePart.bg.r, snakePart.bg.g, snakePart.bg.b)
      love.graphics.rectangle("fill", snakePart.x, snakePart.y, snakePart.w, snakePart.h)
    end
end

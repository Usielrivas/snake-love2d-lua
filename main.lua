function love.load()
 math.randomseed(os.time())
    Object = require 'libs.classic'
    Bump = require 'libs.bump'

    world = Bump.newWorld()

    Snake = require 'objects.snake'
    snake = Snake()
end

function love.update(dt)
  snake:move(dt)
end

function love.draw()
    for i, snakePart in pairs(snake.draw) do
      love.graphics.setColor(snakePart.bg.r, snakePart.bg.g, snakePart.bg.b)
      love.graphics.rectangle("fill", snakePart.x, snakePart.y, snakePart.w, snakePart.h)
    end
end

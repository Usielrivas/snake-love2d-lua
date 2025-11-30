function love.load()
  math.randomseed(os.time())
  Object = require 'libs.classic'
  Bump = require 'libs.bump'
  Snake = require 'objects.snake'
  Food = require 'objects.food'
  Info = require 'objects.info'

  math.randomseed(os.time())

  world = Bump.newWorld()
  snake = Snake()
  food = Food()
  info = Info()
end

function love.update(dt)
  snake:move(dt)
  info:move(snake.gameOver, #snake.draw, snake.control)
end

-- Touch (móvil)
function love.touchpressed(id, x, y)
    snake.control = snake:handleInput(x, y)
end

-- Mouse (PC)
function love.mousepressed(x, y, button)
    if button == 1 then
      snake.control = snake:handleInput(x, y)
    end
end

function love.draw()
  snake:drawSnake()
  food:drawFood()
  info:draw()
end

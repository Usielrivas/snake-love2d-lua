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
  info:move(snake.gameOver, #snake.draw)
end

function love.draw()
  info:draw()
  snake:drawSnake()
  food:drawFood()
end

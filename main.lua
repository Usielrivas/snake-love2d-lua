function love.load()
  font = love.graphics.newFont(20)
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
  love.graphics.setFont(font)
  love.graphics.print("Points: " .. (#snake.draw - 3), 300, 10)

  if snake.gameOver then
    love.graphics.setFont(font)
    love.graphics.print("Game Over, touch to new game.", 300, 300)
  end

  snake:drawSnake()
  food:drawFood()
end

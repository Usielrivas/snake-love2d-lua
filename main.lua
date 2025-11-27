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
  snake:drawSnake()
  food:drawFood()
end

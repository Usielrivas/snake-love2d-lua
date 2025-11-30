local Info = Object:extend()

Info.SnakeLargeInit = 3

function Info:new()
  self.fontMd = love.graphics.newFont(20)
  self.fontLg = love.graphics.newFont(24)
  self.gameOver = false
  self.points = 0
end

function Info:move(gameOver, SnakeLarge)
  self.gameOver = gameOver
  self.points = SnakeLarge - Info.SnakeLargeInit
end

function Info:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.setFont(self.fontMd)
  love.graphics.printf("Points: " .. self.points, 0, 10, love.graphics.getWidth(), 'center')

  if self.gameOver then
    love.graphics.setFont(self.fontLg)
    love.graphics.printf("Game Over, touch to new game.", 0, 200, love.graphics.getWidth(), 'center')
  end
end

return Info

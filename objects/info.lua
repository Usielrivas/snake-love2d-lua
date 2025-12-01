local Info = Object:extend()

Info.SnakeLargeInit = 3

function Info:new()
  self.fontMd = love.graphics.newFont(20)
  self.fontLg = love.graphics.newFont(24)
  self.gameOver = false
  self.points = 0
  self.textCenter = ""
  self.showTextCenter = false
end

function Info:move(gameOver, SnakeLarge, control)
  self.gameOver = gameOver
  self.points = SnakeLarge - Info.SnakeLargeInit

  if control == "pause" then
    self.textCenter = "Pause, click direction to continue"
  end

  self.showTextCenter = self.gameOver or control == "pause"
end

function Info:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.setFont(self.fontMd)
  love.graphics.printf("Points: " .. self.points, 0, 10, love.graphics.getWidth(), 'center')

  if self.showTextCenter then
    love.graphics.setFont(self.fontLg)
    love.graphics.printf(self.textCenter, 0, 200, love.graphics.getWidth(), 'center')
  end
end

return Info

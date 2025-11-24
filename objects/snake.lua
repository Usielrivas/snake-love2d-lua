local Snake = Object:extend()

Snake.COLOR_BASE = 255
Snake.tick = 0.12
Snake.CELL = 20
Snake.HEAD_COLOR = { r = 38 / Snake.COLOR_BASE, g = 112 / Snake.COLOR_BASE, b = 253 / Snake.COLOR_BASE }
Snake.BODY_COLOR = { r = 186 / Snake.COLOR_BASE, g = 38 / Snake.COLOR_BASE, b = 253 / Snake.COLOR_BASE }

function Snake:new()
    local head = { x = 20, y = 40, w = 20, h = 20, head = true, bg = Snake.HEAD_COLOR }
    local cola1 = { x = 20, y = 20, w = 20, h = 20, body = true, bg = Snake.BODY_COLOR }
    local cola2 = { x = 20, y = 0, w = 20, h = 20, body = true, bg = Snake.BODY_COLOR }
    self.timer = 0
    self.speed = 40
    self.control = 'pause'
    self.draw = {
        head,
        cola1,
        cola2,
    }

    for i, parte in pairs(self.draw) do
        world:add(parte, parte.x, parte.y, parte.w, parte.h)
    end
end

function Snake:move(dt)
    if love.keyboard.isDown("up") then
        self.control = 'up'
    end

    if love.keyboard.isDown("down") then
        self.control = 'down'
    end

    if love.keyboard.isDown("left") then
        self.control = 'left'
    end

    if love.keyboard.isDown("right") then
        self.control = 'right'
    end

    if love.keyboard.isDown("space") then
        self.control = 'pause'
    end

    self:run(dt)
end

function Snake:run(dt)
  self.timer = self.timer + dt
  if self.timer >= Snake.tick then
    self.timer = self.timer - Snake.tick
    
    self:direction()
  end
end

function Snake:head()
   return self.draw[1]
end

function Snake:direction()
    if self.control == 'pause' then
        return
    end

    local left = 0
    local right = love.graphics.getWidth()
    local top = 0
    local bottom = love.graphics.getHeight()

    local newHead = table.remove(self.draw)
    local headWas = self:head()
    headWas.head = false
    headWas.body = true
    headWas.bg = Snake.BODY_COLOR

    if self.control == 'right' then
      newHead.x = headWas.x + Snake.CELL
      if newHead.x > right then
      newHead.x = left
      end
      newHead.y = headWas.y
    end

    if self.control == 'left' then
      newHead.x = headWas.x - Snake.CELL
      if newHead.x < left then
      newHead.x = right
      end
      newHead.y = headWas.y
    end

    if self.control == 'up' then
      newHead.x = headWas.x
      newHead.y = headWas.y - Snake.CELL
      if newHead.y < top then
      newHead.y = bottom
      end
    end

    if self.control == 'down' then
      newHead.x = headWas.x
      newHead.y = headWas.y + Snake.CELL
      if newHead.y > bottom then
      newHead.y = top
      end
    end

    newHead.headWas = true
    newHead.bg = Snake.HEAD_COLOR
    table.insert(self.draw, 1, newHead)
end

return Snake

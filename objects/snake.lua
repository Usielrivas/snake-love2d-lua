local Snake = Object:extend()

Snake.HEAD = 1
Snake.COLOR_BASE = 255
Snake.CELL = 20
Snake.HEAD_COLOR = { r = 38 / Snake.COLOR_BASE, g = 112 / Snake.COLOR_BASE, b = 253 / Snake.COLOR_BASE }
Snake.BODY_COLOR = { r = 186 / Snake.COLOR_BASE, g = 38 / Snake.COLOR_BASE, b = 253 / Snake.COLOR_BASE }

function Snake:new()
    self.gameOver = false
    self.timer = 0
    self.speed = 40
    self.tick = 0.15
    self.control = 'pause'
    self.draw = self:init()

    for i, parte in pairs(self.draw) do
        world:add(parte, parte.x, parte.y, parte.w, parte.h)
    end
end

function Snake:init()
    local head = { x = 20, y = 40, w = Snake.CELL, h = Snake.CELL, head = true, bg = Snake.HEAD_COLOR }
    local cola1 = { x = 20, y = 20, w = Snake.CELL, h = Snake.CELL,  body = true, bg = Snake.BODY_COLOR }
    local cola2 = { x = 20, y = 0, w = Snake.CELL, h = Snake.CELL, body = true, bg = Snake.BODY_COLOR }

    return {
        head,
        cola1,
        cola2,
    }
end

function Snake:handleInput(x, y)
    local direction = self.control
    local screenW = love.graphics.getWidth()
    local screenH = love.graphics.getHeight()

    -- Si viene de touch, x y y están en 0–1, convertir
    if x < 1 and y < 1 then
        x = x * screenW
        y = y * screenH
    end

    local centerX = screenW / 2
    local centerY = screenH / 2

    local dx = x - centerX
    local dy = y - centerY

    if math.abs(dx) > math.abs(dy) then
        if dx > 0 then
          if self.control ~= "left" then
            direction = "right"
          end
        else
          if self.control ~= "right" then
            direction = "left"
          end
        end
    else
        if dy > 0 then
          if self.control ~= "up" then
            direction = "down"
          end
        else
          if self.control ~= "down" then
            direction = "up"
          end
        end
    end

    return direction
end

function Snake:move(dt)
    if love.keyboard.isDown("up") then
      if self.control ~= 'down' then self.control = 'up' end
    end

    if love.keyboard.isDown("down") then
      if self.control ~= 'up' then self.control = 'down' end
    end

    if love.keyboard.isDown("left") then
      if self.control ~= 'right' then self.control = 'left' end
    end

    if love.keyboard.isDown("right") then
      if self.control ~= 'left' then self.control = 'right' end
    end

    if love.keyboard.isDown("space") then
        self.control = 'pause'
    end

    self:run(dt)
end

function Snake:run(dt)
  self.timer = self.timer + dt
  if self.timer >= self.tick then
    self.timer = self.timer - self.tick
    
    self:direction()
  end
end

function Snake:head()
   return self.draw[Snake.HEAD]
end

function Snake:newHead()
    local headWas = self:head()
    local newHead = {
       x = headWas.x, 
       y = headWas.y,
       w = Snake.CELL,
       h = Snake.CELL,
       head = true,
       body = false,
       bg = Snake.HEAD_COLOR
     }

     return newHead
end

function Snake:headToBody()
   local head = self:head()
   head.bg = Snake.BODY_COLOR
   head.head = false
   head.body = true
end

function Snake:direction()
    if self.control == 'pause' then
        return
    end

    self.gameOver = false
    self:headToBody()
    local left = 0
    local right = love.graphics.getWidth()
    local top = 0
    local bottom = love.graphics.getHeight()
    local newHead = self:newHead()

    if self.control == 'right' then
      newHead.x = newHead.x + Snake.CELL
      if newHead.x >= right then newHead.x = 0 end
    end

    if self.control == 'left' then
      newHead.x = newHead.x - Snake.CELL
      if newHead.x < 0 then newHead.x = right - Snake.CELL end
    end

    if self.control == 'up' then
        newHead.y = newHead.y - Snake.CELL
        if newHead.y < 0 then newHead.y = bottom - Snake.CELL end
    end

    if self.control == 'down' then
      newHead.y = newHead.y + Snake.CELL
      if newHead.y >= bottom then newHead.y = 0 end
    end

    table.insert(self.draw, 1, newHead)
    world:add(newHead, newHead.x, newHead.y, newHead.w, newHead.h)
    local  _,  _, cols = world:check(newHead, newHead.x, newHead.y)
    self:ate(cols)
end

function Snake:ate(cols)
  local ate = false
  local reset = false
    
  for i, col in pairs(cols) do
    if col.other.food then
      ate = true
      food:reset()
      -- Aunmentar dificultad
      if self.tick >= 1 then
        self.tick = self.tick - 0.005
      end
    elseif not ate then
      reset = true
      self.control = 'pause'
      self.gameOver = true
    end
  end

  if not ate then
    world:remove(self.draw[#self.draw])
    table.remove(self.draw)
  end

  if reset then
    self:reset()
  end
end

function Snake:reset()
    for i, part in ipairs(self.draw) do
      world:remove(part)
    end

    food:reset()
    self.draw = self:init()
    for i, parte in pairs(self.draw) do
        world:add(parte, parte.x, parte.y, parte.w, parte.h)
    end
end

function Snake:drawSnake()
   for i, snakePart in pairs(self.draw) do
      love.graphics.setColor(snakePart.bg.r, snakePart.bg.g, snakePart.bg.b)
      love.graphics.rectangle("fill", snakePart.x, snakePart.y, snakePart.w, snakePart.h)
    end
end

return Snake

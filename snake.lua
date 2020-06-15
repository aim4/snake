require "constants"

Snake = Object:extend()

function Snake:new()
--    self.x = x
--    self.y = y
    self.direction = DIR_RIGHT -- default
    self.snake_body = {
        {x = 2, y = 0},
        {x = 1, y = 0},
        {x = 0, y = 0},
    }
    self.timer = 0
    self.timeLimit = 0.15
    self.is_alive = true
end

function Snake:update(dt)
    if not self.is_alive then
        return
    end
    self.timer = self.timer + dt
    if self.timer >= self.timeLimit then
        self.timer = self.timer - self.timeLimit
        self:move(self.direction)
    end 
end

function Snake:draw()
    love.graphics.setColor(palette[6])
    for i, c in ipairs(self.snake_body) do
        local x = c.x * SPACING_GRID
        local y = c.y * SPACING_GRID
        love.graphics.rectangle('fill', x, y, SPACING_GRID, SPACING_GRID)
    end
    love.graphics.reset()
end

function Snake:setDirection(direction)
    self.direction = direction
end

function Snake:move(direction)
    -- Remove tail. Add new body to head
    table.remove(self.snake_body, #self.snake_body)
    if direction == DIR_LEFT then
        self:moveLeft()
    elseif direction == DIR_RIGHT then
        self:moveRight()
    elseif direction == DIR_UP then
        self:moveUp()
    elseif direction == DIR_DOWN then
        self:moveDown()
    end
end

function Snake:moveLeft()
    local head = self:getHead()
    table.insert(self.snake_body, 1, {x = head.x - 1, y = head.y})
end

function Snake:moveRight()
    local head = self:getHead()
    table.insert(self.snake_body, 1, {x = head.x + 1, y = head.y})
end

function Snake:moveUp()
    local head = self:getHead()
    table.insert(self.snake_body, 1, {x = head.x, y = head.y - 1})

end

function Snake:moveDown()
    local head = self:getHead()
    table.insert(self.snake_body, 1, {x = head.x, y = head.y + 1})
end

function Snake:getHead()
    return self.snake_body[1]
end

function Snake:getDirection()
    return self.direction
end

function Snake:getX()
    local head = self:getHead()
    return head.x * SPACING_GRID
end

function Snake:getY()
    local head = self:getHead()
    return head.y * SPACING_GRID
end

function Snake:getIsAlive()
    return self.is_alive
end

function Snake:setIsAlive(is_alive)
    self.is_alive = is_alive
end


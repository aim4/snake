require "constants"

Snake = Object:extend()

function Snake:new()
--    self.x = x
--    self.y = y
    self.snake_body = {
        {x = 2, y = 0},
        {x = 1, y = 0},
        {x = 0, y = 0},
    }
    self.timer = 0
    self.timeLimit = 0.15
    self.is_alive = true
    self.directionQ = {DIR_RIGHT}
    self.increasingSize = false
end

function Snake:update(dt)
    if not self.is_alive then
        return
    end
    self.timer = self.timer + dt
    if self.timer >= self.timeLimit then
        self.timer = self.timer - self.timeLimit
        if #self.directionQ > 1 then
            table.remove(self.directionQ, 1)
        end

        self:move(self.directionQ[1])
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
    local n = #self.directionQ
    if (self.directionQ[n] == DIR_LEFT and direction == DIR_RIGHT)
        or (self.directionQ[n] == DIR_RIGHT and direction == DIR_LEFT)
        or (self.directionQ[n] == DIR_UP and direction == DIR_DOWN)
        or (self.directionQ[n] == DIR_DOWN and direction == DIR_UP) then
        return
    end


    table.insert(self.directionQ, direction)
end

function Snake:move(direction)
    -- Remove tail. Add new body to head
    -- Should not be able to move in opposite direction
    if self.increasingSize then
        self.increasingSize = false 
    else
        table.remove(self.snake_body, #self.snake_body)
    end
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
    return self.directionQ[1]
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

function Snake:increaseSize()
    self.increasingSize = true
end

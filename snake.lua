Snake = Object:extend()

function Snake:new(x, y)
    self.x = x
    self.y = y
    self.direction = DIR_RIGHT -- default
    self.snake_body = {
        {x = 2, y = 0},
        {x = 1, y = 0},
        {x = 0, y = 0},
    }
end

function Snake:update(dt)
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
    for i, c in ipairs(snake_body) do
        local x = c.x + 1
end

function Snake:moveRight()
end

function Snake:moveUp()
end

function Snake:moveDown()
end

function Snake:getHead()
    return self.snake_body[1]
end

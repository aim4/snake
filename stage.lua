require "constants"

Stage = Object:extend()

function Stage:new(x, y)
    self.x = x
    self.y = y

    self.w = GRID_X * SPACING_GRID
    self.h = GRID_Y * SPACING_GRID
    print(self.w, self.h)
end

function Stage:draw()
    love.graphics.rectangle('line', self.x, self.y, self.w, self.h)

    -- Draw gridlines
    love.graphics.setColor(1.0, 1.0, 1.0, 0.5)
    
    -- Vertical lines
    for i = 0, GRID_X do
        local x = i * SPACING_GRID
        love.graphics.line(x, 0, x, self.h)
    end
    
    -- Horizontal lines
    for i = 0, GRID_Y do
        local y = i * SPACING_GRID
        love.graphics.line(0, y, self.w, y)
    end
    love.graphics.reset()
end

function Stage:update(dt)
end

function Stage:addFruit()
    -- get random x and y
end

function Stage:removeFruit()
end

function Stage:getWidth()
    return self.w
end

function Stage:getHeight()
    return self.h
end


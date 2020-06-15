require "constants"
require "fruit"

Stage = Object:extend()

function Stage:new(x, y)
    self.x = x
    self.y = y
    
    self.w = GRID_X * SPACING_GRID
    self.h = GRID_Y * SPACING_GRID
    
    math.randomseed(os.time())
    self:addFruit()
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

    if self.fruit then
        self.fruit:draw()
    end
    love.graphics.reset()
end

function Stage:update(dt)
end

function Stage:addFruit()
    local x = math.random(0, GRID_X - 1) * SPACING_GRID
    local y = math.random(0, GRID_Y - 1) * SPACING_GRID
    self.fruit = Fruit(x, y, SPACING_GRID)
end

function Stage:removeFruit()
    self.fruit = nil
end

function Stage:getWidth()
    return self.w
end

function Stage:getHeight()
    return self.h
end

function Stage:getFruit()
    return self.fruit
end

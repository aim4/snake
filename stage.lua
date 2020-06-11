Stage = Object:extend()

function Stage:new(x, y, w, h)
    self.x = x
    self.y = y
    self.w = w
    self.h = h

    self.spacing = 25
end

function Stage:draw()
    love.graphics.rectangle('line', self.x, self.y, self.w, self.h)

    -- Draw gridlines
    love.graphics.setColor(1.0, 1.0, 1.0, 0.5)
    
    -- Vertical lines
    for i = 0, self.w, self.spacing do
        love.graphics.line(i, 0, i, self.h)
    end
    
    -- Horizontal lines
    for i = 0, self.h, self.spacing do
        love.graphics.line(0, i, self.w, i)
    end
    love.graphics.reset()
end

function Stage:update(dt)
end



Fruit = Object:extend()

function Fruit:new(x, y, l)
    -- TODO investigate missing fruit
    self.x = x
    self.y = y
    self.length = l
end

function Fruit:draw()
    love.graphics.setColor(1.0, 0.0, 0.0, 1.0)
    love.graphics.rectangle('fill', self.x, self.y, self.length, self.length)
    love.graphics.reset()
end

function Fruit:update(dt)
end

function Fruit:getX()
    return self.x
end

function Fruit:getY()
    return self.y
end

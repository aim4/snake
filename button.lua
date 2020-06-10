Button = Object:extend()

function Button:new(x, y, w, h)
    self.x = x
    self.y = y
    self.w = w
    self.h = h
end

function Button:draw()
    love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
end

function Button:update(dt)
end

function Button:press()
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
end

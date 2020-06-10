Button = Object:extend()

function Button:new(x, y, w, h, on_press, on_release)
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.on_press = on_press
    self.on_release = on_release

    self.pressed = false
end

function Button:draw()
    if self.pressed then
        love.graphics.setColor(palette[2])
        love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
        love.graphics.reset()
    end

    love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
end

function Button:update(dt)
end

function Button:press()
    self.pressed = true
    if self.on_press then
        self.on_press()
    end
end

function Button:release()
    self.pressed = false 
    if self.on_release then
        self.on_release()
    end
end

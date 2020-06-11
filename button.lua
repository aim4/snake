Button = Object:extend()

function Button:new(x, y, w, h)
    self.x = x
    self.y = y
    self.w = w
    self.h = h

    self.hovering = false
    self.name = ""
end

function Button:draw()
    if self.hovering then
        love.graphics.setColor(palette[3])
        love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
        love.graphics.reset()
    end

    love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
    local f = love.graphics.setNewFont(18)
    local w = f:getWidth(self.name)
    local h = f:getHeight(self.name)
    love.graphics.printf(self.name, self.x, self.y + h/5, self.w, "center")
    love.graphics.reset()
end

function Button:update(dt)
end

function Button:toggleHover()
    self.hovering = not self.hovering
end

function Button:press()
    if self.on_press then
        self.on_press()
    end
end

function Button:release()
    if self.on_release then
        self.on_release()
    end
end

function Button:setName(name)
    self.name = name
end

function Button:setOnPress(on_press)
    self.on_press = on_press
end

function Button:setOnRelease(on_release)
    self.on_release = on_release
end

function Button:setX(x)
    self.x = x
end

function Button:setY(y)
    self.y = y
end


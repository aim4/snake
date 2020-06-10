require "button"

Menu = Object:extend()

function Menu:new(x, y, w, h)
    self.x = x
    self.y = y
    self.w = w
    self.h = h

    self.buttons = {}
end

function Menu:draw()
    love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
    for i, b in ipairs(self.buttons) do
        b:draw()
    end
end

function Menu:update(dt)
end

function Menu:addButton(name, on_press, on_release)
    n = #self.buttons + 1
    local button_width = 50
    local button_height = 20
    for i = 1, n do
        local x = (self.w / 2) - button_width / 2
        local y = (i / (n + 1)) * self.h - button_height / 2
        local button = Button(x, y, button_width, button_height, on_press, on_release)
        table.insert(self.buttons, button)
    end
end

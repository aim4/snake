require "button"

Menu = Object:extend()

function Menu:new(x, y, w, h)
    self.x = x
    self.y = y
    self.w = w
    self.h = h

    self.buttons = {}
    self.current_button = 0
end

function Menu:draw()
    love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
    for i, b in ipairs(self.buttons) do
        b:draw()
    end
end

function Menu:update(dt)

end


-- Copy buttons to a new table
function Menu:addButton(name, on_press, on_release)
    local n = #self.buttons + 1
    local button_width = 60
    local button_height = 30
    for i = 1, #self.buttons do
        local button_x = (self.w / 2) - button_width / 2 + self.x
        local button_y = (i / (n + 1)) * self.h - button_height / 2 + self.y
        local button = self.buttons[i]
        button:setX(button_x)
        button:setY(button_y)
    end

    -- Add new button
    local button_x = (self.w / 2) - button_width / 2 + self.x
    local button_y = (n / (n + 1)) * self.h - button_height / 2 + self.y
    local button = Button(button_x, button_y, button_width, button_height)
    button:setName(name)
    button:setOnPress(on_press)
    button:setOnRelease(on_release)
    table.insert(self.buttons, button)

    if #self.buttons > 0 and self.current_button == 0 then
        self.current_button = 1
        self.buttons[self.current_button]:toggleHover()
    end
end

function Menu:keypressed(key)
    if key == "down" then
        self:nextButton()
    elseif key == "up" then
        self:prevButton()
    elseif key == "return" then
        if self:hoveringButton() then
            print('press button')
            local button = self.buttons[self.current_button]
            button:press()
        end
    end
end

function Menu:nextButton()
    print("next")
    local button = self.buttons[self.current_button]
    button:toggleHover()
    print(self.current_button, button.hovering)

    self.current_button = (self.current_button + 1) % (#self.buttons + 1)
    if self.current_button == 0 and #self.buttons > 0 then
        self.current_button = 1
    end

    button = self.buttons[self.current_button]
    button:toggleHover()
    print(self.current_button)
    print(self.current_button, button.hovering)

end

function Menu:prevButton()
    print("prev")
    local button = self.buttons[self.current_button]
    button:toggleHover()
    print(self.current_button, button.hovering)

    self.current_button = (self.current_button - 1) % #self.buttons
    if self.current_button == 0 and #self.buttons > 0 then
        self.current_button = 2
    end
    
    button = self.buttons[self.current_button]
    button:toggleHover()
    print(self.current_button, button.hovering)

    print(self.current_button)
end

function Menu:hoveringButton()
    return self.current_button > 0
end

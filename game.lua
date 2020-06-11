require "stage"
require "state"

Game = Object:extend()

function Game:new()
    self.state = State()
    self.menu = self:loadMainMenu()

    local w, h = love.graphics.getDimensions()
    self.stage = Stage(0, 0, w, h)
end

function Game:update(dt)
    if self.state.level == STATE_MENU then
        self.menu:update()
    end
end

function Game:draw()
    if self.state.level == STATE_MENU then
        self.menu:draw()
    elseif self.state.level == STATE_INGAME then
        self.stage:draw()
    end
end

function Game:keypressed(key)
    if self.state.level == STATE_MENU then
        self.menu:keypressed(key)
    end

end

function Game:loadMainMenu()
    local spacing = 100
    local w, h = love.graphics.getDimensions()
    local menu = Menu(spacing, spacing, w - 2 * spacing, h - 2 * spacing, spacing)

    local hello = function()
        print("hello")
        self.state.level = STATE_INGAME
    end
    menu:addButton("Start", hello, nil)

    local quit = function()
        love.event.quit()
    end
    menu:addButton("Quit", quit, nil)
    return menu
end


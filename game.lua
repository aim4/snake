require "snake"
require "stage"
require "state"

Game = Object:extend()

function Game:new()
    self.state = State()
    self.menu = self:loadMainMenu()
    self.snake = Snake()

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
        self.snake:draw()
    end
end

function Game:keypressed(key)
    if self.state.level == STATE_MENU then
        self.menu:keypressed(key)
    elseif self.state.level == STATE_INGAME then
        if isDirection(key) and self:snakeCanMove(key) then
            self.snake:move(key)
        end
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

function Game:snakeCanMove(direction)
    head = self.snake:getHead()
    local x = head.x
    local y = head.y

    if direction == DIR_LEFT then
        x = x - 1
    elseif direction == DIR_RIGHT then
        x = x + 1
    elseif direction == DIR_UP then
        y = y - 1
    elseif direction == DIR_DOWN then
        y = y + 1
    end

    return not(x < 0 or x > self.stage:getWidth() or y < 0 or y > self.stage:getHeight())
end

function isDirection(d)
    return d == DIR_LEFT or d == DIR_RIGHT or d == DIR_UP or d == DIR_DOWN
end

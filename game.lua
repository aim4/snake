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
    -- TODO display game over and paused text
    if self.state.game_over then
        return
    end
    if self.state.paused then
        return
    end
    if self.state.level == STATE_MENU then
        self.menu:update(dt)
    elseif self.state.level == STATE_INGAME then
        -- Check if snake hit wall
        local dir = self.snake:getDirection()
        if not self.snake:getIsAlive() then
            self.state.game_over = true
            return
        end
        if not self:snakeCanMove(dir) then
            self.snake:setIsAlive(false)
        end
        self.snake:update(dt)
    end
end

function Game:draw()
    if self.state.game_over then
        drawGameOverText()
    elseif self.state.paused then
        drawPauseText()
    end

    if self.state.level == STATE_MENU then
        self.menu:draw()
    elseif self.state.level == STATE_INGAME then
        self.stage:draw()
        self.snake:draw()
    end
end

function Game:keypressed(key)
    if key == "escape" then
        love.event.quit()
    end

    if self.state.level == STATE_MENU then
        self.menu:keypressed(key)
    elseif self.state.level == STATE_INGAME then
        if isDirection(key) and self:snakeCanMove(key) then
            self.snake:setDirection(key)
        elseif key == "space" then
            self.state.paused = not self.state.paused
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

    print(x, y)
    return not(x < 0 or x >= GRID_X or y < 0 or y >= GRID_Y)
end

function isDirection(d)
    return d == DIR_LEFT or d == DIR_RIGHT or d == DIR_UP or d == DIR_DOWN
end

function drawPauseText()
    local text = "Paused"
    love.graphics.setColor(palette[1])
    local f = love.graphics.setNewFont(18)
    local w = f:getWidth(text)
    sw, sh = love.graphics.getDimensions()

    love.graphics.printf(text, sw/2 - w/2, sh/2, w, "center")
    love.graphics.reset()
end

function drawGameOverText()
    local text = "Game Over"
    love.graphics.setColor(palette[5])
    local f = love.graphics.setNewFont(18)
    local w = f:getWidth(text)
    sw, sh = love.graphics.getDimensions()
    
    love.graphics.printf(text, sw/2 - w/2, sh/2, w, "center")
    love.graphics.reset()
end


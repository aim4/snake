lume = require "lume"
require "snake"
require "stage"
require "state"

Game = Object:extend()

function Game:new()
    self.state = State()
    self.menu = self:loadMainMenu()
    self.snake = Snake()
    self.score = 0
    self.highscore = 0

    local w, h = love.graphics.getDimensions()
    self.stage = Stage(0, 0, w, h)
    self:load()
end

function Game:update(dt)
    -- TODO display game over and paused text
    if self.state.game_over then
        if self.score > self.highscore then
            self.highscore = self.score
        end
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
        self.snake:update(dt)
         if isOutOfBounds(self.snake:getX(), self.snake:getY()) or self.snake:isSelfColliding() then
            self.snake:setIsAlive(false)
        end
       
        -- Check if got fruit
        if checkCollision(self.snake, self.stage:getFruit()) then
            self.stage:removeFruit()
            self.stage:addFruit()
            self.snake:increaseSize()
            self.score = self.score + 1
        end
    end
end

function Game:draw()
    if self.state.game_over then
        self:drawGameOverText()
        self:drawPlayAgain()
    elseif self.state.paused then
        self:drawPauseText()
    end

    if self.state.level == STATE_MENU then
        self.menu:draw()
    elseif self.state.level == STATE_INGAME then
        self:drawScore()
        self.stage:draw()
        self.snake:draw()
    end
end

function Game:keypressed(key)
    if key == "escape" then
        self:save()
        love.event.quit()
    end

    if self.state.level == STATE_MENU then
        self.menu:keypressed(key)
    elseif self.state.level == STATE_INGAME then
        if self.state.game_over then
            if key == "y" then
                self:clear()
            elseif key == "n" then
                self:save()
                love.event.quit()
            end
        end

        if isDirection(key) then
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
    local x = self.snake:getX() 
    local y = self.snake:getY()

    if direction == DIR_LEFT then
        x = x - SPACING_GRID
    elseif direction == DIR_RIGHT then
        x = x + SPACING_GRID
    elseif direction == DIR_UP then
        y = y - SPACING_GRID
    elseif direction == DIR_DOWN then
        y = y + SPACING_GRID
    end

    return not isOutOfBounds(x, y)
end

function isDirection(d)
    return d == DIR_LEFT or d == DIR_RIGHT or d == DIR_UP or d == DIR_DOWN
end

function Game:drawPauseText()
    local text = "Paused"
    love.graphics.setColor(palette[1])
    local f = love.graphics.setNewFont(18)
    local w = f:getWidth(text)
    sw, sh = love.graphics.getDimensions()

    love.graphics.printf(text, sw/2 - w/2, sh/2, w, "center")
    love.graphics.reset()
end

function Game:drawPlayAgain()
    local text = "Play Again? Y/N"
    love.graphics.setColor(palette[1])
    local f = love.graphics.setNewFont(18)
    local w = f:getWidth(text)
    sw, sh = love.graphics.getDimensions()

    love.graphics.printf(text, sw/2 - w/2, sh/2 + 20, w, "center")
    love.graphics.reset()
end


function Game:drawGameOverText()
    local text = "Game Over"
    love.graphics.setColor(palette[5])
    local f = love.graphics.setNewFont(18)
    local w = f:getWidth(text)
    sw, sh = love.graphics.getDimensions()
    
    love.graphics.printf(text, sw/2 - w/2, sh/2, w, "center")
    love.graphics.reset()
end

function Game:drawScore()
    love.graphics.setColor(1.0, 0.5, 0.0, 0.75)
    love.graphics.setNewFont(14)
    love.graphics.print("High Score: " .. self.highscore, 5, 0)
    love.graphics.print("Score: " .. self.score, 5, 16)
    love.graphics.reset()
end

function Game:clear()
    self.score = 0
    self.snake = nil
    self.snake = Snake()
    self.stage = nil
    self.stage = Stage(0, 0, w, h)

    self.state.game_over = false
    self.state.paused = false
    self.state.level = STATE_INGAME
end

function Game:save()
    data = {}
    data.score = self.highscore
    serialized = lume.serialize(data)
    love.filesystem.write("highscore.txt", serialized)
end

function Game:load()
    if love.filesystem.getInfo("highscore.txt") then
        file = love.filesystem.read("highscore.txt")
        data = lume.deserialize(file)
        self.highscore = data.score
    end
end

function checkCollision(a, b)
    return a:getX() == b:getX() and a:getY() == b:getY()
end

function isOutOfBounds(x, y)
    return (x < 0 or x >= GRID_X * SPACING_GRID or y < 0 or y >= GRID_Y * SPACING_GRID)
end


Object = require "classic"
require "constants"
require "menu"
require "state"

palette = {
    {1.0, 0.0, 0.0, 1.0}, -- red
    {0.0, 1.0, 0.0, 1.0}, -- green
    {0.4, 0.4, 1.0, 1.0}, -- blue
    {0.9, 1.0, 0.2, 1.0}, -- yellow
    {1.0 ,1.0, 1.0, 1.0} -- white

}

function love.load()
    state = State()
    loadMainMenu()
end

function love.update(dt)
    if state.level == STATE_MENU then
        menu:update()
    end
end

function love.draw()
    menu:draw()
end

function love:keypressed(key)
    if state.level == STATE_MENU then
        menu:keypressed(key)
    end
end


function loadMainMenu()
    local spacing = 100
    local w, h = love.graphics.getDimensions()
    menu = Menu(spacing, spacing, w - 2 * spacing, h - 2 * spacing, spacing)

    local hello = function()
        print("hello")
    end
    menu:addButton("Start", hello, nil)

    local quit = function()
        love.event.quit()
    end
    menu:addButton("Quit", quit, nil)
end


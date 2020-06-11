palette = {
    {1.0, 0.0, 0.0, 1.0}, -- red
    {0.0, 1.0, 0.0, 1.0}, -- green
    {0.4, 0.4, 1.0, 1.0}, -- blue
    {0.9, 1.0, 0.2, 1.0}, -- yellow
    {1.0 ,1.0, 1.0, 1.0} -- white

}

function love.load()
    Object = require "classic"
    require "menu"
    
    loadMainMenu()
end

function love.update(dt)
end

function love.draw()
    Menu:draw()
end

function loadMainMenu()
    local spacing = 100
    local w, h = love.graphics.getDimensions()
    Menu = Menu(spacing, spacing, w - 2 * spacing, h - 2 * spacing)

    local hello = function()
        print('hello')
    end
    Menu:addButton('Start', hello, nil)

    local quit = function ()
        love.event.quit()
    end
    Menu:addButton('Quit', quit, nil)
end


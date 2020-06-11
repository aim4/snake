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
    require "state"
    
    state = State()
    loadMainMenu()
end

function love.update(dt)
    menu:update()
end

function love.draw()
    menu:draw()
end

function love:keypressed(key)
    if state.level == "Menu" then
        if key == "down" then
            menu:nextButton()
        elseif key == "up" then
            menu:prevButton()
        end
    end
end


function loadMainMenu()
    local spacing = 100
    local w, h = love.graphics.getDimensions()
    menu = Menu(spacing, spacing, w - 2 * spacing, h - 2 * spacing, spacing)

    local hello = function()
    end
    menu:addButton("Start", hello, nil)

    local quit = function()
        love.event.quit()
    end
    menu:addButton("Quit", quit, nil)
end


palette = {
    {1.0, 0.0, 0.0, 1.0}, -- red
    {0.0, 1.0, 0.0, 1.0}, -- green
    {0.4, 0.4, 1.0, 1.0}, -- blue
    {0.9, 1.0, 0.2, 1.0}, -- yellow
    {1.0 ,1.0, 1.0, 1.0} -- white

}

function love.conf(t)
    t.window.width = 800
    t.window.height = 600
    t.window.title = "Snake"
end

function love.load()
    Object = require "classic"
    require "menu"
end

function love.update(dt)
end

function love.draw()
end


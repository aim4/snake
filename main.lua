Object = require "classic"
require "constants"
require "game"
require "menu"
require "state"

palette = {
    {1.0, 0.0, 0.0, 1.0}, -- red
    {0.0, 1.0, 0.0, 1.0}, -- green
    {0.4, 0.4, 1.0, 1.0}, -- blue
    {0.9, 1.0, 0.2, 1.0}, -- yellow
    {1.0 ,1.0, 1.0, 1.0}, -- white
    {0.4, 1.0, 0.0, 0.85} -- snake green

}

function love.load()
    game = Game()
end

function love.update(dt)
    game:update(dt)
end

function love.draw()
    game:draw()
end

function love:keypressed(key)
    game:keypressed(key)

end


State = Object:extend()

function State:new()
    self.game_over = false
    self.paused = false
    self.left = false
    self.right = false
    self.up = false
    self.down = false
    self.score = 0
    self.level = "Menu"
end



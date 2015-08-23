local GameOver = class('GameOver')

function GameOver:initialize(game)
    self.game = game
    self.x = 150
    self.text = "You are so hungry you can't go on"
    c = cron.after(2, function() self.text = "Game Over"
        self.x = 40
    end)
end

function GameOver:load()
end

function GameOver:draw()
    love.graphics.print(self.text, love.graphics.getWidth()/2 - self.x,
        love.graphics.getHeight()/2 - 10)
end

function GameOver:update(dt)
    c:update(dt)
end

return GameOver

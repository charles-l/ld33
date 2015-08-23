local Game = class('Game')
Game:include(Stateful)
function Game:load()
    love.graphics.setFont(font)
    self.curLevel = GameWin:new(self)
    love.audio.setVolume(0.5)
    love.audio.play(self.res.snd["music.ogg"])
end

function Game:draw()
    self.curLevel:draw()
end

function Game:update(dt)
    if love.mouse.isDown('l') then
        print(love.mouse.getX()/2, love.mouse.getY()/2)
    end
    self.curLevel:update(dt)
end

return Game

local Game = class('Game')
Game:include(Stateful)
function Game:load()
    love.graphics.setFont(font)
    self.curLevel = Level:new(self)
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

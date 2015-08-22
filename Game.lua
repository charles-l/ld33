local Game = class('Game')
Game:include(Stateful)

function Game:load()
    love.graphics.setFont(love.graphics.newFont('res/runescape_uf.ttf', 25))
    self.entities = {}
    self.entities.level = Level:new(self)
    self.entities.player = Player:new(self, 50, 50)
end

function Game:draw()
    self.cam:draw(function(l,t,w,h)
        love.graphics.scale(2)
        for _, v in pairs(self.entities) do
            v:draw()
        end
    end)
end

function Game:update(dt)
    for _, v in pairs(self.entities) do
        if v["update"] ~= nil then
            v:update(dt)
        end
    end
end

return Game

local Game = class('Game')
Game:include(Stateful)

function Game:load()
    love.graphics.setFont(love.graphics.newFont('res/runescape_uf.ttf', 25))
    self.entities = {}
    self.entities.level = Level:new(self)
    self.entities.player = Player:new(self, 50, 50)
    self.cam = gamera.new(0, 152, 2000, 2000)
end

function Game:draw()
    love.graphics.setColor(255, 255, 255, 255)
    self.cam:draw(function(l,t,w,h)
        love.graphics.scale(2)
        for _, v in pairs(self.entities) do
            v:draw()
        end
    end)
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), 150)
    love.graphics.rectangle('fill', 0, love.graphics.getHeight() - 150, love.graphics.getWidth(), 150)
end

function Game:update(dt)
    local cx, cy = self.pworld:getRect(self.entities.player)
    self.cam:setPosition(cx * 2, cy * 2) -- follow player

    for _, v in pairs(self.entities) do
        if v["update"] ~= nil then
            v:update(dt)
        end
    end
end

return Game

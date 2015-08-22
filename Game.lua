local Game = class('Game')
Game:include(Stateful)

function Game:initialize()
    self.res = {}
    self.res.img = {}
    self.res.snd = {}
    self.pworld = bump.newWorld()
end

function Game:load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.graphics.setFont(love.graphics.newFont('res/runescape_uf.ttf', 25))
    self.entities = {}
    self.entities.player = Player:new(self.pworld, 50, 50)
    self.entities.level = Level:new(self.pworld)
end

function Game:draw()
    love.graphics.rectangle('fill', 10, 10, 10, 10)
    for _, v in pairs(self.entities) do
        v:draw()
    end
end

function Game:update(dt)
    for _, v in pairs(self.entities) do
        if v["update"] ~= nil then
            v:update(dt)
        end
    end
end

return Game

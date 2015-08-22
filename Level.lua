local Level = class('Level')

function Level:initialize(game, file)
    -- tilemp load here
    self.pworld = game.pworld
    self.rect = {id = "floor"}
    self.pworld:add(self.rect, 0, 300, 800, 10)
    self.rect = {id = "wall"}
    self.pworld:add(self.rect, 0, 0, 6, love.graphics.getHeight())
    self.img = game.res.img["tilesheet.png"]
    self.img:setFilter('nearest', 'nearest')
    self.wallq = love.graphics.newQuad(12, 12, 12, 12, self.img:getDimensions())
    tilemp.bind('v', self.img, love.graphics.newQuad(0, 2 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('b', self.img, love.graphics.newQuad(1 * 12, 2 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('n', self.img, love.graphics.newQuad(2 * 12, 2 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('|', self.img, love.graphics.newQuad(0, 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('_', self.img, love.graphics.newQuad(0, 0, 12, 12, self.img:getDimensions()))
    tilemp.parse('res/level.txt')
end

function Level:draw()
    for x=0, 2000, 12 do
        for y=0, 2000, 12 do
            --love.graphics.draw(self.img, self.wallq, x, y)
        end
    end
    tilemp.drawTiles()
    love.graphics.rectangle('line', self.pworld:getRect(self.rect))
end

return Level

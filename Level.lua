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
    self.spritebatch = love.graphics.newSpriteBatch(self.img, 1000)
    tilemp.bind('v', self.img, love.graphics.newQuad(0, 2 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('b', self.img, love.graphics.newQuad(1 * 12, 2 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('n', self.img, love.graphics.newQuad(2 * 12, 2 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('>', self.img, love.graphics.newQuad(0, 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('|', self.img, love.graphics.newQuad(2 * 12, 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('_', self.img, love.graphics.newQuad(0, 0, 12, 12, self.img:getDimensions()))
    tilemp.bind('o', self.img, love.graphics.newQuad(3 * 12, 0, 12, 12, self.img:getDimensions()))
    tilemp.bind('p', self.img, love.graphics.newQuad(4 * 12, 0, 12, 12, self.img:getDimensions()))
    tilemp.bind('k', self.img, love.graphics.newQuad(3 * 12, 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('l', self.img, love.graphics.newQuad(4 * 12, 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('q', self.img, love.graphics.newQuad(0 * 12, 3 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('w', self.img, love.graphics.newQuad(1 * 12, 3 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('e', self.img, love.graphics.newQuad(2 * 12, 3 * 12, 12, 12, self.img:getDimensions()))
    tilemp.parse('res/level.txt')
    for x=0, 2000, 12 do
        for y=0, 2000, 12 do
            self.spritebatch:add(self.wallq, x, y)
        end
    end
end

function Level:draw()
    love.graphics.draw(self.spritebatch)
    tilemp.drawTiles()
    love.graphics.rectangle('line', self.pworld:getRect(self.rect))
end

return Level

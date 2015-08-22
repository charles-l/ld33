local Level1 = class('Level1')

function Level1:initialize(game, file)
    -- tilemp load here
    self.pworld = game.pworld
    self.rect = {id = "floor"}
    self.pworld:add(self.rect, 0, 300, 800, 10)
    self.rect = {id = "wall"}
    self.pworld:add(self.rect, 0, 0, 6, love.graphics.getHeight())
    self.img = game.res.img["tilesheet.png"]
    self.img:setFilter('nearest', 'nearest')
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
    tilemp.bind('y', self.img, love.graphics.newQuad(3 * 12, 2 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('h', self.img, love.graphics.newQuad(4 * 12, 2 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('t', self.img, love.graphics.newQuad(4 * 12, 3 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('u', self.img, love.graphics.newQuad(3 * 12, 3 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('"', self.img, love.graphics.newQuad(5 * 12, 0 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('.', self.img, love.graphics.newQuad(5 * 12, 1 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('a', self.img, love.graphics.newQuad(5 * 12, 2 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('s', self.img, love.graphics.newQuad(5 * 12, 3 * 12, 12, 12, self.img:getDimensions()))

    tilemp.bind('m', function(x,y)
        Littleman:new(game, x * 12, y * 12 - 10)
    end)
    tilemp.bind('f', function(x,y)
        Littleman:new(game, x * 12, y * 12 - 10, true)
    end)

    tilemp.parse('res/level.txt')
    Trigger:new(self.pworld, 278, 192, 100, 100, function() beholder.trigger("scare") end)
end

function Level1:draw()
    love.graphics.setBackgroundColor(220, 219, 218, 255)
    tilemp.drawTiles()
    love.graphics.rectangle('line', self.pworld:getRect(self.rect))
    Textbox.draw()
end

return Level1

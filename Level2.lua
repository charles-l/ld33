local Level2 = class('Level2')

function Level2:initialize(game)
    self.pworld = bump.newWorld()
    self.entities = table.ordered()
    self.entities.player = Player:new(game, self, 50, 50)
    self.game = game

    -- tilemp load here
    self.rect = {id = "floor"}
    self.pworld:add(self.rect, 0, 300, 800, 10)
    self.rect = {id = "wall"}
    self.pworld:add(self.rect, 0, 0, 6, love.graphics.getHeight())
    self.img = self.game.res.img["tilesheet.png"]
    self.img:setFilter('nearest', 'nearest')
    tilemp.bind('.', self.img, love.graphics.newQuad(0 * 12, 4 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('_', self.img, love.graphics.newQuad(1 * 12, 0 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('|', self.img, love.graphics.newQuad(1 * 12, 4 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('s', self.img, love.graphics.newQuad(5 * 12, 3 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('a', self.img, love.graphics.newQuad(2 * 12, 4 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('j', self.img, love.graphics.newQuad(1 * 12, 5 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('b', self.img, love.graphics.newQuad(3 * 12, 4 * 12, 12, 12, self.img:getDimensions()))

    tilemp.bind('m', function(x,y)
        Littleman:new(game, self, x * 12, y * 12 - 10)
    end)
    tilemp.bind('f', function(x,y)
        Littleman:new(game, self, x * 12, y * 12 - 10, true)
    end)

    tilemp.parse('res/level2.txt')
    Trigger:new(self.pworld, 278, 192, 100, 100, function() beholder.trigger("scare") end)

    self.cam = gamera.new(0, 152, 1550, 2000)
    Textbox.text('hi', 3, 100, 100)
end

function Level2:draw()
    love.graphics.setBackgroundColor(135, 206, 235)
    love.graphics.setColor(255, 255, 255, 255)
    self.cam:draw(function(l,t,w,h)
        love.graphics.scale(2)
        tilemp.drawTiles()
        for _, _, v in orderedPairs(self.entities) do
            v:draw()
        end
    end)
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), 150)
    love.graphics.rectangle('fill', 0, love.graphics.getHeight() - 150, love.graphics.getWidth(), 150)
    Textbox.draw()
end

function Level2:update(dt)
    local cx, cy = self.pworld:getRect(self.entities.player)
    self.cam:setPosition(cx * 2, cy * 2 - 100) -- follow player

    for _, v in pairs(self.entities) do
        if v["update"] ~= nil then
            v:update(dt)
        end
    end
    Textbox.update(dt)
end

return Level2

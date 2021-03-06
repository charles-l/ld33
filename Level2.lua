local Level2 = class('Level2')

function Level2:initialize(game)
    self.pworld = bump.newWorld()
    self.entities = table.ordered()
    self.entities.player = Player:new(game, self, 50, love.graphics.getHeight()/2)
    self.game = game

    -- tilemp load here
    self.rect = {id = "floor"}
    self.pworld:add(self.rect, 0, 300, 800, 10)
    self.rect = {id = "wall"}
    self.pworld:add(self.rect, 0, 0, 6, love.graphics.getHeight())
    self.img = self.game.res.img["tilesheet.png"]
    self.img:setFilter('nearest', 'nearest')
    tilemp.bind('.', self.img, love.graphics.newQuad(0 * 12, 4 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('-', self.img, love.graphics.newQuad(1 * 12, 7 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('<', self.img, love.graphics.newQuad(0 * 12, 7 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('>', self.img, love.graphics.newQuad(2 * 12, 7 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('z', self.img, love.graphics.newQuad(0 * 12, 6 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('x', self.img, love.graphics.newQuad(1 * 12, 6 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('_', self.img, love.graphics.newQuad(1 * 12, 0 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('|', self.img, love.graphics.newQuad(1 * 12, 4 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('s', self.img, love.graphics.newQuad(5 * 12, 3 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('a', self.img, love.graphics.newQuad(2 * 12, 4 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('b', self.img, love.graphics.newQuad(3 * 12, 4 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('c', self.img, love.graphics.newQuad(2 * 12, 5 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('d', self.img, love.graphics.newQuad(3 * 12, 5 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('e', self.img, love.graphics.newQuad(2 * 12, 6 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('g', self.img, love.graphics.newQuad(3 * 12, 6 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('j', self.img, love.graphics.newQuad(1 * 12, 5 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('r', self.img, love.graphics.newQuad(4 * 12, 4 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('y', self.img, love.graphics.newQuad(5 * 12, 4 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('q', self.img, love.graphics.newQuad(4 * 12, 5 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('h', self.img, love.graphics.newQuad(5 * 12, 5 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('v', self.img, love.graphics.newQuad(4 * 12, 6 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('n', self.img, love.graphics.newQuad(5 * 12, 6 * 12, 12, 12, self.img:getDimensions()))

    tilemp.bind('[', self.img, love.graphics.newQuad(6 * 12, 5 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind(']', self.img, love.graphics.newQuad(7 * 12, 5 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('{', self.img, love.graphics.newQuad(6 * 12, 6 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('}', self.img, love.graphics.newQuad(7 * 12, 6 * 12, 12, 12, self.img:getDimensions()))

    tilemp.bind('1', self.img, love.graphics.newQuad(6 * 12, 2 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('2', self.img, love.graphics.newQuad(6 * 12, 3 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('3', self.img, love.graphics.newQuad(6 * 12, 4 * 12, 12, 12, self.img:getDimensions()))

    tilemp.bind('m', function(x,y)
        Littleman:new(game, self, x * 12, y * 12 - 10)
    end)
    tilemp.bind('f', function(x,y)
        Littleman:new(game, self, x * 12, y * 12 - 10, true)
    end)

    tilemp.parse('res/level2.txt')
    tilemp.parse('res/level2l2.txt')
    Trigger:new(self.pworld, 800, 192, 100, 100, function()
        self.game.curLevel = Level3:new(self.game)
    end)

    self.cam = gamera.new(0, 152, 1550, 2000)
    Textbox.text('Francis: "Wait! Come back! You... tasty morsels"', 3, 100, 100)
    beholder.trigger("scare")

    -- HACK
    for _, v in pairs(self.entities) do
        if v["update"] ~= nil then
            v:update(0)
        end
    end
end

function Level2:draw()
    love.graphics.setBackgroundColor(135, 206, 235)
    love.graphics.setColor(255, 255, 255, 255)
    self.cam:draw(function(l,t,w,h)
        love.graphics.scale(2)
        tilemp.drawTiles()
        for _, _, v in orderedPairs(self.entities) do
            if v ~= nil then
                v:draw()
            end
        end
    end)
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), 150)
    love.graphics.rectangle('fill', 0, love.graphics.getHeight() - 150, love.graphics.getWidth(), 150)
    Textbox.draw()
    love.graphics.setColor(255,255,255,255)
    love.graphics.print('Hunger ', 10, 10)
    love.graphics.rectangle('fill', 95, 10, self.entities.player.hunger * 5, 25)
end

function Level2:update(dt)
    local cx, cy = self.pworld:getRect(self.entities.player)
    self.cam:setPosition(cx * 2, cy * 2 - 100) -- follow player

    Textbox.update(dt)
    if Textbox.static.boxing then return end

    for _, v in pairs(self.entities) do
        if v ~= nil then
            if v["update"] ~= nil then
                v:update(dt)
            end
        end
    end
end

return Level2

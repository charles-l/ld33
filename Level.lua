local Level = class('Level')

function Level:initialize(game)
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
        Littleman:new(game, self, x * 12, y * 12 - 10)
    end)
    tilemp.bind('f', function(x,y)
        Littleman:new(game, self, x * 12, y * 12 - 10, true)
    end)

    tilemp.parse('res/level1.txt')
    Trigger:new(self.pworld, 50, 192, 20, 100, function()
        Textbox.text('I don\'t feel like sleeping.' , 3, 100, 100)
    end, true)
    Trigger:new(self.pworld, 150, 192, 20, 100, function()
        Textbox.text('Now is really not the appropriate time to be reading "the Metamorphosis"', 3, 100, 100)
    end, true)
    Trigger:new(self.pworld, 278, 192, 100, 100, function()
        beholder.trigger("scare")
    end)
    Trigger:new(self.pworld, 800, 192, 100, 100, function()
        self.entities = nil
        tilemp.clear()
        self.game.curLevel = Level2:new(self.game)
    end)

    self.cam = gamera.new(0, 152, 1550, 2000)
    Textbox.text('Francis: "Whaa... what\'s wrong with me!?!!"', 3, 100, 100)
    Textbox.text('Francis: "Why have I transformed?!! AHHHHHHH!!!"', 3, 100, 100)
    Textbox.text('Francis: "uhhhhhhh... and why am I so hungry?!"', 3, 100, 100)
    Textbox.text('Hint: Arrow keys to move and space to eat', 3, 100, 100)

    --- HACK
    for _, v in pairs(self.entities) do
        if v["update"] ~= nil then
            v:update(0)
        end
    end
end

function Level:draw()
    love.graphics.setBackgroundColor(220, 219, 218, 255)
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
end

function Level:update(dt)
    local cx, cy = self.pworld:getRect(self.entities.player)
    self.cam:setPosition(cx * 2, cy * 2 - 100) -- follow player

    Textbox.update(dt)
    if Textbox.static.boxing then return end

    for _, v in pairs(self.entities) do
        if v["update"] ~= nil then
            v:update(dt)
        end
    end

end

return Level

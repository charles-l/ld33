local Level3 = class('Level3')

function Level3:initialize(game)
    self.pworld = bump.newWorld()
    self.entities = table.ordered()
    self.entities.player = Player:new(game, self, 50, love.graphics.getHeight()/2)
    self.game = game

    -- tilemp load here
    self.rect = {id = "floor"}
    self.pworld:add(self.rect, 0, 300, 800, 10)
    self.rect = {id = "wall"}
    self.pworld:add(self.rect, 0, 0, 6, love.graphics.getHeight())
    self.rect = {id = "wall"}
    self.pworld:add(self.rect, 800, 0, 6, love.graphics.getHeight())
    self.img = self.game.res.img["tilesheet.png"]
    self.img:setFilter('nearest', 'nearest')
    tilemp.clear()
    tilemp.bind('.', self.img, love.graphics.newQuad(0 * 12, 4 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('-', self.img, love.graphics.newQuad(3 * 12, 7 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('j', self.img, love.graphics.newQuad(4 * 12, 7 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('i', self.img, love.graphics.newQuad(5 * 12, 7 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('m', self.img, love.graphics.newQuad(6 * 12, 7 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('_', self.img, love.graphics.newQuad(1 * 12, 0 * 12, 12, 12, self.img:getDimensions()))
    tilemp.bind('|', self.img, love.graphics.newQuad(1 * 12, 4 * 12, 12, 12, self.img:getDimensions()))

    tilemp.parse('res/level3l2.txt')
    Trigger:new(self.pworld, 800, 192, 100, 100, function()
        --self.game.curLevel = Sewer:new(self.game)
    end)

    self.cam = gamera.new(60, 152, 1550, 2000)
    self.finish = false
    Textbox.text('Francis: "I have to figure out what\'s going on!"', 3, 100, 100)
    Trigger:new(self.pworld, 650, 192, 50, 100, function()
        if not self.finish then
            self.pworld:update(self.entities.player, 670, 250)
            Textbox.text('Francis: "Hang on. There\'s a log on the control panel"', 3, 100, 100)
            Textbox.text('Francis: "Even though it\'s not english, I understand... odd"', 3, 100, 100)
            Textbox.text('Log 0: "Landing gear failed so Wesen Squad #2 crash landed on planet."', 3, 100, 100)
            Textbox.text('Log 1: "Wesen Squad #2 has landed on the human planet."', 3, 100, 100)
            Textbox.text('Log 1 cont: "Will begin experiments soon."', 3, 100, 100)
            Textbox.text('Log 2: "Weson Squad #2 has begun experimenting."', 3, 100, 100)
            Textbox.text('Log 2 cont: "So far, we haven\'t seen any results with the Wesen Ray."', 3, 100, 100)
            Textbox.text('Log 3: "Finally seeing results. Subjects become extremely hungry? Will investigate."', 3, 100, 100)
            Textbox.text('Log 4: "Humans seem to react poorly to Wesans."', 3, 100, 100)
            Textbox.text('Log 4 cont: "They attacked us even after we offered cookies!"', 3, 100, 100)
            Textbox.text('Log 5: "Pff. We\'re giving up and heading home."', 3, 100, 100)
            Textbox.text('Control panel buttons: {Wesen reverser}, {Ultimate Wesan Ray}', 3, 100, 100)
            Textbox.text('Hint: use shift to press your button of choice', 3, 100, 100)
            self.finish = true
        end
    end, true)

    Trigger:new(self.pworld, 640, 250, 10, 100, function()
        if self.finish then
            Textbox.text('Francis: "OK, back to being human. I\'m kind of going to miss this."', 3, 100, 100)
            self.game.curLevel = GameWin:new(self.game, 'BadEnd')
        else
            Textbox.text('Francis: "I probably should press this button if I don\'t know what it does"', 3, 100, 100)
        end
    end, true)
    Trigger:new(self.pworld, 720, 250, 30, 100, function()
        if self.finish then
            Textbox.text('Francis: "Turn everyone into Wesens? Awesome!"', 3, 100, 100)
            self.game.curLevel = GameWin:new(self.game, 'GoodEnd')
        else
            Textbox.text('Francis: "I\'m not going to press this unless I know what it will do."', 3, 100, 100)
        end
    end, true)
    self.game.res.img["ufo.png"]:setFilter('nearest', 'nearest')
    self.game.res.img["tube.png"]:setFilter('nearest', 'nearest')
    beholder.trigger("scare")

    -- HACK
    for _, v in pairs(self.entities) do
        if v["update"] ~= nil then
            v:update(0)
        end
    end
end

function Level3:draw()
    love.graphics.setBackgroundColor(47, 66, 41)
    love.graphics.setColor(117, 166, 103, 255)
    self.cam:draw(function(l,t,w,h)
        love.graphics.scale(2)
        tilemp.drawTiles()
        love.graphics.draw(self.game.res.img["ufo.png"], 660, 250)
        love.graphics.draw(self.game.res.img["tube.png"], 640, 260)
        love.graphics.draw(self.game.res.img["tube.png"], 720, 260)
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

function Level3:update(dt)
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

return Level3

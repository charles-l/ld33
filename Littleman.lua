local Littleman = class('Littleman')

function Littleman:initialize(game, level, x, y, woman)
    self.x = x
    self.y = y
    self.scaredID = beholder.observe("scare", function() self.scared = true end)
    self.scared = false
    self.timer = cron.after(1, function()
        self.animation = self.run
    end)
    if woman then
        self.img = game.res.img["littlewoman.png"]
    else
        self.img = game.res.img["littleman.png"]
    end
    self.img:setFilter('nearest', 'nearest')
    local g = anim8.newGrid(6, 23, self.img:getWidth(), self.img:getHeight())
    self.shock = anim8.newAnimation(g('1-2', 1), 0.5)
    self.run = anim8.newAnimation(g('3-4', 1), 0.1)
    self.animation = self.shock
    level.entities["littleman" .. love.timer.getTime()] = self
end

function Littleman:draw()
    self.animation:draw(self.img, self.x, self.y)
end

function Littleman:update(dt)
    if not self.scared then return end
    self.timer:update(dt)
    self.x = self.x + 1
    self.animation:update(dt)
end

return Littleman

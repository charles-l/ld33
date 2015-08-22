local Littleman = class('Littleman')

function Littleman:initialize(game, level, x, y, woman)
    self.id = "littleman"
    self.scaredID = beholder.observe("scare", function() self.scared = true end)
    self.scared = false
    self.timer = cron.after(1, function()
        self.animation = self.run
    end)
    self.eattimer = cron.after(1, function()
        self.pworld:remove(self)
        self.level.entities[self.name] = nil
    end)
    if woman then
        self.img = game.res.img["littlewoman.png"]
    else
        self.img = game.res.img["littleman.png"]
    end
    self.img:setFilter('nearest', 'nearest')
    self.pworld = level.pworld
    self.pworld:add(self, x, y, 5, self.img:getHeight())
    local g = anim8.newGrid(6, 23, self.img:getWidth(), self.img:getHeight())
    self.shock = anim8.newAnimation(g('1-2', 1), 0.5)
    self.run = anim8.newAnimation(g('3-4', 1), 0.1)
    self.aeat = anim8.newAnimation(g(5,1), 1)
    self.eatnow = false
    self.animation = self.shock
    self.name = "littleman" .. love.timer.getTime()
    self.level = level
    self.level.entities[self.name] = self
end

function Littleman:draw()
    local x, y = self.pworld:getRect(self)
    if self.eatnow then
        local x,y,w,h = self.pworld:getRect(self.level.entities.player)
        if self.level.entities.player.flip then
            self.animation:draw(self.img, x, y, math.pi/2)
        else
            self.animation:draw(self.img, x, y, -math.pi/2)
        end
    else
        self.animation:draw(self.img, x, y)
    end

    love.graphics.rectangle('line', self.pworld:getRect(self))
end

function Littleman:eat()
    self.eatnow = true
    self.animation = self.aeat
    -- delete self
end

function Littleman:move(vx, vy)
    local x,y,w,h = self.pworld:getRect(self)
    local x, y, cols, len = self.pworld:move(self, x + vx, y + vy)
end

function Littleman:update(dt)
    self:move(0, 7) -- gravity
    self:move(1, 0)
    if self.eatnow then
        local x,y,w,h = self.pworld:getRect(self.level.entities.player)
        self.pworld:update(self, x + 60, y)
        self.eattimer:update(dt)
    end
    if not self.scared then return end
    self.timer:update(dt)
    self.animation:update(dt)
end

return Littleman

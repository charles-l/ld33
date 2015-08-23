local Littleman = class('Littleman')

function Littleman:initialize(game, level, x, y, woman)
    self.id = "littleman"
    self.scaredID = beholder.observe("scare", function() self.scared = true end)
    self.scared = false
    self.domove = false
    self.flip = false
    self.timer = cron.after(1, function()
        self.animation = self.run
        self.domove = true
    end)
    self.eattimer = cron.after(0.1, function()
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
    self.aeat = anim8.newAnimation(g(5,1), .3)
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
            self.animation:draw(self.img, x + 5, y + 15, math.pi/2)
        else
            self.animation:draw(self.img, x + 12, y + 23, -math.pi/2)
        end
        -- add particle system
    else
        if self.flip then
            self.animation:draw(self.img, x + 5, y, 0, -1, 1)
        else
            self.animation:draw(self.img, x, y)
        end
    end
end

function Littleman:eat()
    self.eatnow = true
    self.animation = self.aeat
    -- delete self
end

function Littleman:move(vx, vy)
    local x,y,w,h = self.pworld:getRect(self)
    local x, y, cols, len = self.pworld:move(self, x + vx, y + vy, function(item, other)
        if other.id == "trigger" then
            return 'cross'
        else
            if other.id == 'wall' then
                print(other.id)
                self.flip = not self.flip
            end
            return 'slide'
        end
    end)
end

function Littleman:update(dt)
    if self.eatnow then
        local x,y,w,h = self.pworld:getRect(self.level.entities.player)
        self.pworld:update(self, x + 60, y)
        self.eattimer:update(dt)
        return
    end

    self:move(0, 7) -- gravity

    if self.domove then
        if self.flip then
            self:move(-1,0)
        else
            self:move(1,0)
        end
    end

    if self.scared then
        self.timer:update(dt)
        self.animation:update(dt)
    end
end

return Littleman

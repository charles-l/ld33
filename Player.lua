local Player = class('Player')

function Player.filter(item, other)
    if other.id == "trigger" then
        return 'cross'
    else
        return 'slide'
    end
end

function Player:initialize(game, level, x, y)
    self.z = 200
    self.id = "player"
    self.img = game.res.img["idle.png"]
    self.img:setFilter('nearest', 'nearest')
    local g = anim8.newGrid(26, 38, self.img:getWidth(), self.img:getHeight())
    self.idle = anim8.newAnimation(g('1-8', 1), 0.5)
    self.walk = anim8.newAnimation(g('9-12', 1), 0.1)
    self.curAnim = self.idle
    self.pworld = level.pworld
    self.pworld:add(self, x, y, 26, 38)
    self.flip = false
    self.hunger = 100
end

function Player:draw()
    local x, y = self.pworld:getRect(self)
    if self.flip then
        self.curAnim:draw(self.img, x + 26, y, 0, -1, 1)
    else
        self.curAnim:draw(self.img, x, y, 0, 1, 1)
    end
    --love.graphics.rectangle('line', self.pworld:getRect(self))
end

function Player:move(vx, vy)
    local x,y,w,h = self.pworld:getRect(self)
    local x, y, cols, len = self.pworld:move(self, x + vx, y + vy, self.filter)
    for i = 1, len do
        local other = cols[i].other
        if other.id == "trigger" then
            other:trigger()
        end
    end
end

function Player:update(dt)
    self.curAnim:update(dt)
    self:move(0, 7) -- gravity
    --[[
    if love.keyboard.isDown('up') then
        self:move(0, -5)
    end
    if love.keyboard.isDown('down') then
        self:move(0, 5)
    end
    ]]--
    if love.keyboard.isDown('left') then
        self.curAnim = self.walk
        self:move(-5, 0)
        self.flip = true
    end
    if love.keyboard.isDown('right') then
        self.curAnim = self.walk
        self:move(5, 0)
        self.flip = false
    end
    if not love.keyboard.isDown('left') and not love.keyboard.isDown('right') then
        self.curAnim = self.idle
    end
    self.hunger = self.hunger - 1 * dt
end

return Player

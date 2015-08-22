local Player = class('Player')

function Player:initialize(pworld, x, y)
    self.id = "player"
    self.img = nil
    self.pworld = pworld
    self.pworld:add(self, x, y, 20, 20)
end

function Player:draw()
    love.graphics.rectangle('line', self.pworld:getRect(self))
end

function Player:move(vx, vy)
    local x,y,w,h = self.pworld:getRect(self)
    self.pworld:move(self, x + vx, y + vy)
end

function Player:update(dt)
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
        self:move(-5, 0)
    end
    if love.keyboard.isDown('right') then
        self:move(5, 0)
    end
end

return Player

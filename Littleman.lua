local Littleman = class('Littleman')

function Littleman:initialize(game, x, y)
    self.x = x
    self.y = y
    self.img = game.res.img["littleman.png"]
    self.img:setFilter('nearest', 'nearest')
    local g = anim8.newGrid(6, 23, self.img:getWidth(), self.img:getHeight())
    self.animation = anim8.newAnimation(g('1-2', 1), 1)
    game.entities.littleman = self
end

function Littleman:draw()
    self.animation:draw(self.img, self.x, self.y)
end

function Littleman:update(dt)
    --self.x = self.x + 4
    self.animation:update(dt)
end

return Littleman

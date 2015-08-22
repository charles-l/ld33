local Level = class('Level')

function Level:initialize(pworld, file)
    -- tilemp load here
    self.pworld = pworld
    self.rect = {id = "floor"}
    self.pworld:add(self.rect, 0, 300, 800, 10)
end

function Level:draw()
    love.graphics.rectangle('line', self.pworld:getRect(self.rect))
end

return Level

local GameWin = class('GameWin')
GameWin:include(Stateful)

function GameWin:initialize(game)
    self.game = game
    self:gotoState('GoodEnd')
    love.audio.play(self.game.res.snd["music1.ogg"])
    self.game.res.snd["woot.ogg"]:setLooping(true)
    love.audio.play(self.game.res.snd["woot.ogg"])
    self.q = love.graphics.newQuad(15 * 26, 0, 26, self.game.res.img["idle.png"]:getHeight(),
        self.game.res.img["idle.png"]:getWidth(),
        self.game.res.img["idle.png"]:getHeight())
    self.q2 = love.graphics.newQuad(18 * 26, 0, 26, self.game.res.img["idle.png"]:getHeight(),
        self.game.res.img["idle.png"]:getWidth(),
        self.game.res.img["idle.png"]:getHeight())
    self.t1 = love.graphics.newQuad(0, 12 * 3, 12, 12,
        self.game.res.img["tilesheet.png"]:getWidth(),
        self.game.res.img["tilesheet.png"]:getHeight())
    self.game.res.img["idle.png"]:setFilter("nearest", "nearest")
    self.game.res.img["tilesheet.png"]:setFilter("nearest", "nearest")

    self.rands = {}
    self.rands1 = {}
    self.rands2 = {}
    for i = 0, 30 do
        self.rands[i] = math.random(1, 50)
    end
    for i = 0, 30 do
        self.rands1[i] = math.random(1, 50)
    end
    for i = 0, 30 do
        self.rands2[i] = math.random(1, 50)
    end
end

local GoodEnd = GameWin:addState('GoodEnd')

function GoodEnd:draw()
    love.graphics.setBackgroundColor(135, 206, 235)
    love.graphics.scale(6)
    love.graphics.draw(self.game.res.img["tilesheet.png"], self.t1, 10,48)
    love.graphics.draw(self.game.res.img["tilesheet.png"], self.t1, 30,48, 0, -1, 1)
    love.graphics.draw(self.game.res.img["idle.png"], self.q, 10, 10)
    for i = 0, 30 do
        love.graphics.draw(self.game.res.img["idle.png"], self.q2, i * 10 - 10, 50 + math.sin(love.timer.getTime() * 10 + self.rands[i]))
    end
    for i = 0, 30 do
        love.graphics.draw(self.game.res.img["idle.png"], self.q2, i * 10 - 10, 60 + math.sin(love.timer.getTime() * 10 + self.rands1[i]))
    end
    for i = 0, 30 do
        love.graphics.draw(self.game.res.img["idle.png"], self.q2, i * 10 - 10, 70 + math.sin(love.timer.getTime() * 10 + self.rands2[i]))
    end
end

function GoodEnd:update(dt)
    love.audio.stop(self.game.res.snd["music.ogg"]) -- HACK
end

return GameWin

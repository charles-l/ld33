local GameWin = class('GameWin')
GameWin:include(Stateful)

function GameWin:initialize(game, state)
    self.game = game
    self:gotoState(state)
    self:load()
end

local GoodEnd = GameWin:addState('GoodEnd')

function GoodEnd:load()
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
    Textbox.static.text("The button turns all human beings into Wesen like you", 2, love.graphics.getHeight() - 45)
    Textbox.static.text("They unanimously choose you as their leader", 2, love.graphics.getHeight() - 45)
    Textbox.static.text("The end.", 2, love.graphics.getHeight() - 45)
end

function GoodEnd:draw()
    love.graphics.setBackgroundColor(135, 206, 235)
    love.graphics.setColor(255,255,255)
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
    love.graphics.scale(1/6)
    Textbox.static.draw()
end

function GoodEnd:update(dt)
    love.audio.stop(self.game.res.snd["music.ogg"]) -- HACK
    Textbox.static.update(dt)
end

local BadEnd = GameWin:addState('BadEnd')

function BadEnd:load()
    self.t1 = love.graphics.newQuad(0, 0, 6, self.game.res.img["littleman.png"]:getHeight(),
        self.game.res.img["littleman.png"]:getWidth(),
        self.game.res.img["littleman.png"]:getHeight())
    self.game.res.img["littleman.png"]:setFilter("nearest", "nearest")
    Textbox.static.text("You're human again", 2, love.graphics.getHeight() - 45)
    Textbox.static.text("... but you don't feel victorious", 2, love.graphics.getHeight() - 45)
    Textbox.static.text("You can now go back and live your life like you used to.", 2, love.graphics.getHeight() - 45)
    Textbox.static.text("The End", 2, love.graphics.getHeight() - 45)
end

function BadEnd:draw()
    love.graphics.setBackgroundColor(0,0,0,0)
    love.graphics.setColor(255,255,255,255)
    Textbox.static.draw()
    love.graphics.scale(5)
    love.graphics.draw(self.game.res.img["littleman.png"], self.t1, love.graphics.getWidth()/10, love.graphics.getHeight()/10)
end

function BadEnd:update(dt)
    Textbox.static.update(dt)
end


return GameWin


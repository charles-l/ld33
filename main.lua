class = require 'libs.middleclass.middleclass'
Stateful = require 'libs.stateful.stateful'
Tree = require 'libs.love-struct.tree'
anim8 = require 'libs.anim8.anim8'
loader = require 'libs.love-loader.love-loader'
Text = require 'libs.popo.Text'
bump = require 'libs.bump.bump'
Input = require 'libs.thomas.Input'
tilemp = require 'libs.tilemp.tilemp'
gamera = require 'libs.gamera.gamera'
cron = require 'libs.cron.cron'
beholder = require 'libs.beholder.beholder'
tween = require 'libs.tween.tween'
require 'util'

--[[
lick = require 'libs.LICK.lick'
lick.file = "Level.lua" -- for now
lick.reset = true -- live code reload
]]--

Player = require 'Player'
Littleman = require 'Littleman'
Level = require 'Level'
Level2 = require 'Level2'
Textbox = require 'Textbox'
Trigger = require 'Trigger'

Game = require 'Game'
Load = Game:addState('Load')

-- global font
font = love.graphics.newFont('res/runescape_uf.ttf', 25)

function Game:initialize()
    self.res = {}
    self.res.img = {}
    self.res.snd = {}
end

function Load:load_resources()
    for _, fname in pairs(love.filesystem.getDirectoryItems("res/img")) do
        --loader.newImage(self.res.img, fname, "res/img/" .. fname)
        self.res.img[fname] = love.graphics.newImage("res/img/" .. fname)
    end

    loader.start(self:gotoState())
    self:load() -- otherwise the load for the new state is never called
end


function Load:load()
    self:load_resources()
end

function Load:update(dt)
    loader.update()
end

function Load:draw()
    love.graphics.rectangle('fill',
        love.graphics.getWidth() / 2 + math.sin(love.timer.getTime()) * 100,
        love.graphics.getHeight() / 2, 10, 10)
    love.graphics.rectangle('fill',
        love.graphics.getWidth() / 2 + math.sin(love.timer.getTime() + 0.2) * 100,
        love.graphics.getHeight() / 2, 10, 10)
    love.graphics.rectangle('fill',
        love.graphics.getWidth() / 2 + math.sin(love.timer.getTime() - 0.2) * 100,
        love.graphics.getHeight() / 2, 10, 10)
    love.graphics.print("LOADING...", love.graphics.getWidth()/2 - 40, 250)
end

game = Game:new()
game:gotoState('Load')

function love.load()
    input = Input()
    game:load()
end

function love.draw()
    game:draw()
end

function love.update(dt)
    game:update(dt)
    input:update(dt)
end

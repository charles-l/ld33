local Textbox = class('Textbox')

Textbox.static.texts = {}

function Textbox.static.text(text, duration, x, y)
    local t = {}
    t.x = x
    t.y = y
    t.alpha = 255
    t.tween = tween.new(1, t, {alpha = 0})
    t.text = text
    t.dotween = false
    t.timerb = cron.after(duration - 1, function()
        Textbox.texts[#Textbox.texts].dotween = true
    end)
    t.timera = cron.after(duration, function()
        Textbox.texts[#Textbox.texts] = nil
    end)

    table.insert(Textbox.texts, t)
end

function Textbox.static.update(dt)
    for _, v in pairs(Textbox.texts) do
        if v ~= nil then
            if v.dotween then
                v.tween:update(dt)
            end
            v.timera:update(dt)
            v.timerb:update(dt)
        end
    end
end

function Textbox.static.draw()
    for _, v in pairs(Textbox.texts) do
        if v ~= nil then
            love.graphics.setColor(70, 42, 52, v.alpha)
            love.graphics.rectangle('fill', v.x - 10, v.y - 10, font:getWidth(v.text) + 20, font:getHeight() + 20)
            love.graphics.setColor(200, 200, 200, v.alpha)
            love.graphics.rectangle('line', v.x - 10, v.y - 10, font:getWidth(v.text) + 20, font:getHeight() + 20)
            love.graphics.setColor(255, 255, 255, v.alpha)
            love.graphics.print(v.text, v.x, v.y)
        end
        love.graphics.setColor(255, 255, 255, 255)
    end
end

return Textbox

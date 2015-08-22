local Textbox = class('Textbox')

Textbox.static.texts = {}

function Textbox.static.text(text, duration, x, y)
    local t = {}
    t.x = x
    t.y = y
    t.text = text
    t.timer = cron.after(duration, function()
        Textbox.texts[#Textbox.texts] = nil
    end)

    table.insert(Textbox.texts, t)
end

function Textbox.static.update(dt)
    for _, v in pairs(Textbox.texts) do
        if v ~= nil then
            v.timer:update(dt)
        end
    end
end

function Textbox.static.draw()
    for _, v in pairs(Textbox.texts) do
        if v ~= nil then
            love.graphics.print(v.text, v.x, v.y)
        end
    end
end

return Textbox

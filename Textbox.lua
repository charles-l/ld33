local Textbox = class('Textbox')

Textbox.static.queue = List.new()
Textbox.boxing = false

function Textbox.static.text(text, duration, y)
    local t = {}
    t.x = love.graphics.getWidth()/2 - font:getWidth(text)/2
    t.y = y
    t.text = text
    t.dtext = Text(10, 10, '['..t.text..'](textbox)', {
        textboxInit = function(c)
            c.t = 0
        end,
        textbox = function(dt, c)
            c.t = c.t + 3 * dt
            local r, g, b, a = love.graphics.getColor()
            love.graphics.setColor(r, g, b, 0)
            if c.t > c.position*0.2 then
                love.graphics.setColor(r, g, b, 255)
            end
        end
    })

    List.pushright(Textbox.static.queue, t)
    input:bind('return', function()
        local v = Textbox.static.queue[Textbox.static.queue.first]
        if v ~= nil then
            List.popleft(Textbox.static.queue)
        end
    end)
end

function Textbox.static.update(dt)
    local v = Textbox.static.queue[Textbox.static.queue.first]
    if v ~= nil then
        Textbox.static.boxing = true
        v.dtext:update(dt)
    else
        Textbox.static.boxing = false
    end
end

function Textbox.static.draw()
    local v = Textbox.static.queue[Textbox.static.queue.first]
    if v ~= nil then
        love.graphics.setColor(70, 42, 52, 255)
        love.graphics.rectangle('fill', v.x - 10, v.y - 10, font:getWidth(v.text) + 20, font:getHeight() + 20)
        love.graphics.setColor(200, 200, 200, 255)
        love.graphics.rectangle('line', v.x - 10, v.y - 10, font:getWidth(v.text) + 20, font:getHeight() + 20)
        love.graphics.setColor(255, 255, 255, 255)
        v.dtext:draw(v.x, v.y)
    end
    love.graphics.setColor(255, 255, 255, 255)
end

return Textbox

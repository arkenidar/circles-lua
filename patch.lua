-- in replit.com love 0.10.2 so older APIs
-- older love2d fix: https://replit.com/@dariocangialosi/love2d-rounded#main.lua

function draw.color_set(rgb)
    love.graphics.setColor(rgb[1] * 255, rgb[2] * 255, rgb[3] * 255)
end

function draw.color_get()
    local r, g, b = love.graphics.getColor()
    return { r / 255, g / 255, b / 255 }
end

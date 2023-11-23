function love.draw()
    screen_draw()
end

function pointer_position()
    return love.mouse.getPosition()
end

function rectangle_draw(x, y, w, h)
    love.graphics.rectangle("fill", x, y, w, h)
end

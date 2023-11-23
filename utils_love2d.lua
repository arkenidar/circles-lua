function love.draw()
    display()
end

function pointer_position()
    return love.mouse.getPosition()
end

function rectangle_draw(rectangle)
    local x, y, w, h = rectangle[1], rectangle[2], rectangle[3], rectangle[4]
    love.graphics.rectangle("fill", x, y, w, h)
end

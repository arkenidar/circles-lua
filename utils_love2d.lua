pointer_down = false
pointer_click = false

function pointer_down_check()
    return love.mouse.isDown(1)
end

function pointer_click_check()
    return pointer_click
end

function input_from_pointer()
    if not pointer_down and pointer_down_check() then
        pointer_click = true
        pointer_down = true
    else
        pointer_click = false
        pointer_down = pointer_down_check()
    end
end

function love.draw()
    input_from_pointer()
    display()
end

function pointer_position()
    return love.mouse.getPosition()
end

function rectangle_draw(rectangle)
    local x, y, w, h = rectangle[1], rectangle[2], rectangle[3], rectangle[4]
    love.graphics.rectangle("fill", x, y, w, h)
end

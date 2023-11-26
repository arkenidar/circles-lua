function love.draw()
    pointer.input(love.mouse)
    display()
end

graphics = love.graphics

draw = {}

function draw.rectangle_basic(rectangle)
    if rectangle[3] <= 0 or rectangle[4] <= 0 then return end
    local x, y, w, h = rectangle[1], rectangle[2], rectangle[3], rectangle[4]
    graphics.rectangle("fill", x, y, w, h)
end

function draw.color_set(rgba)
    graphics.setColor(rgba[1], rgba[2], rgba[3], rgba[4] or 1)
end

function draw.color_get()
    local r, g, b, a = graphics.getColor()
    return { r, g, b, a }
end

pointer = {}
function pointer.input(mouse)
    -- position, x, y
    local mx, my = mouse.getPosition()
    pointer.position = { mx, my }
    pointer.x = pointer.position[1]
    pointer.y = pointer.position[2]
    -- click and down
    pointer.down_previously = pointer.down
    pointer.down = mouse.isDown(1)
    pointer.click = false
    if pointer.down and not pointer.down_previously then
        pointer.click = true
    end
end

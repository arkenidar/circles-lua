require("draw_primitives")

function draw_primitives_test1()
    local circle1 = { center = { 100, 100 }, radius = 50, ranges = { 1, 0, 1, 1 } }
    local circle2 = { center = { 100 + 200, 100 }, radius = 50, ranges = { 0, 1, 1, 1 } }
    local rectangle = { circle1.center[1], circle1.center[2] - circle1.radius, 200, circle1.radius * 2 }
    circles_draw(circle1)
    circles_draw(circle2)
    rectangle_draw(rectangle)
end

function draw_primitives_test2()
    local x, y = 10, 10
    local mx, my = pointer_position()
    local width, height = non_negative(mx - x), non_negative(my - y)
    local rectangle = { x, y, width, height }
    capsule_draw(rectangle)
end

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
    local width, height = non_negative(pointer.x - x), non_negative(pointer.y - y)
    local rectangle = { x, y, width, height }
    local border_color = { 1, 1, 1 }
    local border_thickness = 20
    capsule_draw(rectangle, border_color, border_thickness)
end

function draw_primitives_test3()
    local radius = 30
    local x, y = 10, 10
    local width, height = math.max(2 * radius, pointer.x - x), math.max(2 * radius, pointer.y - y)
    local rectangle = { x, y, width, height }
    rounded_draw(rectangle, radius)
end

function draw_primitives_test4()
    local radius = 30
    local x, y = 10, 10
    local width, height = math.max(2 * radius, pointer.x - x), math.max(2 * radius, pointer.y - y)
    local rectangle = { x, y, width, height }
    local border_color = { 1, 1, 1 }
    local border_thickness = 20
    rounded_draw(rectangle, radius, border_color, border_thickness)
end

function draw_primitives_test5()
    local radius = 0
    local x, y = 10, 10
    local width, height = math.max(2 * radius, pointer.x - x), math.max(2 * radius, pointer.y - y)
    local rectangle = { x, y, width, height }
    local border_color = { 1, 1, 1 }
    local border_thickness = 20
    rounded_draw(rectangle, radius, border_color, border_thickness)
end
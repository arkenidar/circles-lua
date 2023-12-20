require("draw_primitives")

function draw_primitives_test1()
    local circle1 = { center = { 150, 100 }, radius = 50, ranges = { 1, 0, 1, 1 } }
    local circle2 = { center = { 150 + 200, 100 }, radius = 50, ranges = { 0, 1, 1, 1 } }
    local rectangle = { circle1.center[1], circle1.center[2] - circle1.radius, 200, circle1.radius * 2 }
    draw.circle(circle1)
    draw.circle(circle2)
    draw.rectangle(rectangle)
end

function draw_primitives_test2()
    local x, y = 60, 60
    local width, height = non_negative(pointer.x - x), non_negative(pointer.y - y)
    local rectangle = { x, y, width, height }
    local border = {}
    border.color = { 1, 1, 1 }
    border.thickness = 20
    draw.capsule(rectangle, border)
end

function draw_primitives_test3()
    local radius = 30
    local x, y = 60, 60
    local width, height = pointer.x - x, pointer.y - y
    local rectangle = { x, y, width, height }
    draw.rectangle(rectangle, { radius = radius })
end

function draw_primitives_test4()
    local radius = 30
    local x, y = 60, 60
    local width, height = pointer.x - x, pointer.y - y
    local rectangle = { x, y, width, height }
    local border = {}
    border.color = { 1, 1, 1 }
    border.thickness = 20
    draw.rectangle(rectangle, { radius = radius, border = border })
end

function draw_primitives_test5()
    local x, y = 60, 60
    local width, height = non_negative(pointer.x - x), non_negative(pointer.y - y)
    local rectangle = { x, y, width, height }
    local border = {}
    border.color = { 1, 1, 1 }
    border.thickness = 20
    draw.rectangle(rectangle, { border = border })
end

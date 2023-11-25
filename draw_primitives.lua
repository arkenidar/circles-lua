require("utils_math")
require("utils_love2d")

function pixel_draw(x, y)
    local pixel = { x, y, 1, 1 }
    rectangle_draw(pixel)
end

function circles_draw(circle)
    for x = circle.center[1] - circle.ranges[1] * circle.radius, circle.center[1] + circle.ranges[2] * circle.radius do
        for y = circle.center[2] - circle.ranges[3] * circle.radius, circle.center[2] + circle.ranges[4] * circle.radius do
            if distance(circle.center, { x, y }) <= circle.radius then
                pixel_draw(x, y)
            end
        end
    end
end

function rounded_draw_no_border(rectangle, radius)
    -- checks
    if rectangle[3] <= 0 or rectangle[4] <= 0 then return end
    radius = non_negative(radius)
    -- top
    circles_draw { center = { rectangle[1] + radius, rectangle[2] + radius }, radius = radius, ranges = { 1, 0, 1, 0 } }
    rectangle_draw { rectangle[1] + radius, rectangle[2], rectangle[3] - 2 * radius, radius + 1 }
    circles_draw { center = { rectangle[1] + rectangle[3] - radius, rectangle[2] + radius }, radius = radius, ranges = { 0, 1, 1, 0 } }
    -- middle
    rectangle_draw { rectangle[1], rectangle[2] + radius, rectangle[3], rectangle[4] - 2 * radius }
    -- bottom
    circles_draw { center = { rectangle[1] + radius, rectangle[2] + rectangle[4] - radius }, radius = radius, ranges = { 1, 0, 0, 1 } }
    rectangle_draw { rectangle[1] + radius, rectangle[2] + rectangle[4] - radius, rectangle[3] - 2 * radius, radius }
    circles_draw { center = { rectangle[1] + rectangle[3] - radius, rectangle[2] + rectangle[4] - radius }, radius = radius, ranges = { 0, 1, 0, 1 } }
end

function rounded_draw(rectangle, radius, border_color, border_thickness)
    if border_color then
        local inner_color = draw_color_get()
        draw_color_set(border_color)
        rounded_draw_no_border(rectangle, radius)
        -- inner
        radius = radius - border_thickness
        rectangle[1] = rectangle[1] + border_thickness
        rectangle[2] = rectangle[2] + border_thickness
        rectangle[3] = rectangle[3] - 2 * border_thickness
        rectangle[4] = rectangle[4] - 2 * border_thickness
        draw_color_set(inner_color)
    end
    rounded_draw_no_border(rectangle, radius)
end

function capsule_draw(rectangle, border_color, border_thickness)
    local radius = math.min(rectangle[3], rectangle[4]) / 2
    rounded_draw(rectangle, radius, border_color, border_thickness)
end

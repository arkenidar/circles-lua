require("utils_math")
require("utils_love2d")

function pixel_draw(x, y)
    rectangle_draw(x, y, 1, 1)
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

function capsule_draw(rectangle)
    local radius_common = math.min(rectangle[3], rectangle[4]) / 2
    local center_common = { rectangle[1] + radius_common, rectangle[2] + radius_common }
    local width = 0
    local height = 0
    local range1, range2
    local rectangle_width, rectangle_height
    local horizontal
    if rectangle[3] >= rectangle[4] then
        horizontal = 1
        width = rectangle[3] - rectangle[4]
        range1 = { 1, 0, 1, 1 }
        range2 = { 0, 1, 1, 1 }
        rectangle_width = width
        rectangle_height = radius_common * 2
    else
        horizontal = 0
        height = rectangle[4] - rectangle[3]
        range1 = { 1, 1, 1, 0 }
        range2 = { 1, 1, 0, 1 }
        rectangle_width = radius_common * 2
        rectangle_height = height
    end
    local circle1 = { center = center_common, radius = radius_common, ranges = range1 }
    local circle2 = {
        center = { center_common[1] + width, center_common[2] + height },
        radius = radius_common,
        ranges =
            range2
    }

    circles_draw(circle1)
    circles_draw(circle2)
    rectangle_draw(center_common[1] - (1 - horizontal) * radius_common, center_common[2] - horizontal * radius_common,
        rectangle_width, rectangle_height)
end

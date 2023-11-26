require("utils_math")

function draw.pixel(x, y)
    local pixel = { x, y, 1, 1 }
    draw.rectangle_basic(pixel)
end

function draw.circle(circle)
    for x = circle.center[1] - circle.ranges[1] * circle.radius, circle.center[1] + circle.ranges[2] * circle.radius do
        for y = circle.center[2] - circle.ranges[3] * circle.radius, circle.center[2] + circle.ranges[4] * circle.radius do
            if distance(circle.center, { x, y }) <= circle.radius then
                draw.pixel(x, y)
            end
        end
    end
end

function draw.rectangle_radius(rectangle, radius)
    -- checks
    radius = non_negative(radius)
    if not radius or radius == 0 then return draw.rectangle_basic(rectangle) end
    if rectangle[3] <= 0 or rectangle[4] <= 0 then return end
    local radius_safety = math.min(rectangle[3], rectangle[4]) / 2
    radius = math.min(radius, radius_safety)
    -- top
    draw.circle { center = { rectangle[1] + radius, rectangle[2] + radius }, radius = radius, ranges = { 1, 0, 1, 0 } }
    draw.rectangle_basic { rectangle[1] + radius, rectangle[2], rectangle[3] - 2 * radius, radius + 1 }
    draw.circle { center = { rectangle[1] + rectangle[3] - radius, rectangle[2] + radius }, radius = radius, ranges = { 0, 1, 1, 0 } }
    -- middle
    draw.rectangle_basic { rectangle[1], rectangle[2] + radius, rectangle[3], rectangle[4] - 2 * radius }
    -- bottom
    draw.circle { center = { rectangle[1] + radius, rectangle[2] + rectangle[4] - radius }, radius = radius, ranges = { 1, 0, 0, 1 } }
    draw.rectangle_basic { rectangle[1] + radius, rectangle[2] + rectangle[4] - radius, rectangle[3] - 2 * radius, radius }
    draw.circle { center = { rectangle[1] + rectangle[3] - radius, rectangle[2] + rectangle[4] - radius }, radius = radius, ranges = { 0, 1, 0, 1 } }
end

function draw.rectangle(rectangle, settings)
    if rectangle[3] <= 0 or rectangle[4] <= 0 then return end
    if not settings then settings = {} end
    local radius = settings.radius or 0
    local border = settings.border
    if border then
        -- border
        local color_restore = draw.color_get()
        draw.color_set(border.color)
        draw.rectangle_radius(rectangle, radius)
        draw.color_set(color_restore)
        -- inner sizing
        radius = radius - border.thickness
        rectangle[1] = rectangle[1] + border.thickness
        rectangle[2] = rectangle[2] + border.thickness
        rectangle[3] = rectangle[3] - 2 * border.thickness
        rectangle[4] = rectangle[4] - 2 * border.thickness
        if rectangle[3] <= 0 or rectangle[4] <= 0 then return end
    end
    -- main
    draw.rectangle_radius(rectangle, radius)
end

function draw.capsule(rectangle, border)
    local radius = math.min(rectangle[3], rectangle[4]) / 2
    draw.rectangle(rectangle, { radius = radius, border = border })
end

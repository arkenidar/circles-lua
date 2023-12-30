-- @category:debuggers Lua

-- tomblind.local-lua-debugger-vscode
-- in Microsoft VisualStudio Code:
-- see also ".vscode/launch.json"
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end -- see docs of extension: tomblind.local-lua-debugger-vscode

require("utils_love2d")
--require("patch") -- older love2d fix: https://replit.com/@dariocangialosi/love2d-rounded#main.lua
require("draw_primitives_testing")

test_index = 1

function display1()
    local tests = {
        draw_primitives_test1,
        draw_primitives_test2,
        draw_primitives_test3,
        draw_primitives_test4,
        draw_primitives_test5 }

    if pointer.click then
        test_index = (((test_index - 1) + 1) % #tests) + 1
    end

    draw.color_set { 1, 0, 0 }
    tests[test_index]()
end

local toggle = true

images.add("arrow_up")
images.add("arrow_down")
images.add("arrow_left")
images.add("arrow_right")

-- position will be wired to scroll-bars (WIP work in progress)
local vertical_position = 0.5 -- try 0 or 0.5 or 1 also (feature DEMO / TEST cases)

function display2()
    local square = 16 -- like PNG images
    local x, y

    -- scrollable setup

    -- content sizing
    local content_width = 250
    local content_height = 300

    x, y = 70, 50
    local scrollable_width, scrollable_height
    scrollable_width = math.max(3 * square, pointer.x - x)
    scrollable_height = math.max(2 * square, pointer.y - y)
    scrollable_width = 300
    scrollable_height = 250

    local rectangle_scrollable = { x, y, scrollable_width, scrollable_height } -- external

    -- back ground
    draw.color_set({ 1, 1, 1 }) -- white
    draw.rectangle_basic(rectangle_scrollable)

    -- clipping rectangle setup (internal)
    local scrollable_view_width = rectangle_scrollable[3] - square
    local scrollable_view_height = rectangle_scrollable[4] - square
    local clip_rectangle = { rectangle_scrollable[1], rectangle_scrollable[2],
        scrollable_view_width,
        scrollable_view_height }
    draw.set_clip_rectangle(clip_rectangle)

    -- press-to-scroll
    if pointer.down and point_inside_rectangle(pointer.position, clip_rectangle) then
        local delta_y = (pointer.position[2] - (clip_rectangle[2] + clip_rectangle[4] / 2)) / (clip_rectangle[4] / 2)
        vertical_position = vertical_position + delta_y / 10
        vertical_position = math.min(1, vertical_position)
        vertical_position = math.max(0, vertical_position)
    end

    -- calculate to draw both scroll-bars: horizontal and vertical

    -- horizontal settings
    local horizontal_percentage = math.min(1, scrollable_view_width / content_width)
    local horizontal_position = 0

    -- vertical settings
    local vertical_percentage = math.min(1, scrollable_view_height / content_height)

    local camera = {} -- camera settings
    camera.x = -horizontal_position * math.max(0, content_width - scrollable_view_width)
    camera.y = -vertical_position * math.max(0, content_height - scrollable_view_height)

    -- begin viewport transform (camera viewport)
    graphics.push()                        -- transformations stack, push operation
    graphics.translate(camera.x, camera.y) -- 2D translation transform

    -- adjust pointer position coordinates (before "pointer adjust")
    local pointer_previous_position = pointer.position

    -- "pointer adjust": adjust pointer to transform (before "content beginning").
    -- this is according to graphics.translate(camera.x, camera.y)
    pointer.x = pointer.x - camera.x
    pointer.y = pointer.y - camera.y
    pointer.position = { pointer.x, pointer.y }

    -- boolean pre-condition e.g. for :
    -- verify pointer click in *clipped* rectangle then (etcetera)
    -- if pointer.click and in_clip and point_inside_rectangle(pointer.position, rectangle) then
    -- TEST it by trying to click e.g. a rectangle outside the clipping area (partially outside?)
    -- this pre-condition should be applied to prevent such erroneous "clicks outside the viewport"
    local in_clip = point_inside_rectangle(pointer_previous_position, clip_rectangle)

    -- "content beginning"

    -- #1
    local rectangle = { 80, 50 + 10, 200, 100 }
    -- click to toggle (in_clip pre-condition is applied)
    if pointer.click and in_clip and point_inside_rectangle(pointer.position, rectangle) then
        toggle = not toggle
    end
    rectangle.settings = {
        radius = toggle and 30 or 0,
        border = { color = { 1, 0, 0 }, thickness = 10 }
    }
    draw.rectangle(rectangle, rectangle.settings)

    -- #2
    local capsule = { rectangle[1], rectangle[2] + rectangle[4] + 30, rectangle[3], rectangle[4] }
    capsule.settings = { border = { color = { 1, 0, 0 }, thickness = 10 } }
    draw.capsule(capsule, capsule.settings.border)

    -- #3
    draw.color_set({ 230 / 255, 229 / 255, 228 / 255 })
    draw.rectangle_outset({ 100, 270, 90, 50 })

    -- content ending

    -- end camera (end 2D viewport transformations)

    -- transformations stack, pop operation
    graphics.pop() -- pop() resets 2D viewport transformations

    -- adjust pointer position coordinates (after, reset)
    -- ... according to graphics.pop() transformations reset
    pointer.x = pointer_previous_position[1]
    pointer.y = pointer_previous_position[2]
    pointer.point_position = { pointer.x, pointer.y }

    draw.set_clip_rectangle() -- reset clipping area

    -- draw both scroll-bars: horizontal and vertical

    -- calculate widths
    local width = rectangle_scrollable[3] - 3 * square
    local width_part = width * horizontal_percentage

    -- calculate heights
    local height = rectangle_scrollable[4] - 2 * square
    local height_part = height * vertical_percentage

    -- draw horizontal scrollbar

    x, y = rectangle_scrollable[1], rectangle_scrollable[2] + rectangle_scrollable[4] - square

    draw.color_set({ 230 / 255, 229 / 255, 228 / 255 })
    draw.rectangle_outset({ x, y, square, square }) -- left
    draw.image(images.arrow_left, x, y)

    draw.color_set({ 243 / 255, 243 / 255, 243 / 255 })
    draw.rectangle_basic({ x + square, y, width, square }) -- total

    draw.color_set({ 230 / 255, 229 / 255, 228 / 255 })
    draw.rectangle_outset({ (x + square) + horizontal_position * (width - width_part), y, width_part, square }) -- part (movable)

    draw.color_set({ 230 / 255, 229 / 255, 228 / 255 })
    draw.rectangle_outset({ x + square + width, y, square, square }) -- right
    draw.image(images.arrow_right, x + square + width, y)

    -- draw vertical scrollbar

    x = x + square + width + square
    y = y - height - square

    draw.color_set({ 230 / 255, 229 / 255, 228 / 255 })
    draw.rectangle_outset({ x, y, square, square }) -- up
    draw.image(images.arrow_up, x, y)

    draw.color_set({ 243 / 255, 243 / 255, 243 / 255 })
    local vertical_box = { x, y + square, square, height }
    draw.rectangle_basic(vertical_box) -- total
    -- vertical_position update
    if pointer.down and point_inside_rectangle(pointer_previous_position, vertical_box) then
        vertical_position = (pointer_previous_position[2] - vertical_box[2]) / vertical_box[4]
    end

    draw.color_set({ 230 / 255, 229 / 255, 228 / 255 })
    draw.rectangle_outset({ x, (y + square) + vertical_position * (height - height_part), square, height_part }) -- part (movable)

    draw.color_set({ 230 / 255, 229 / 255, 228 / 255 })
    draw.rectangle_outset({ x, y + square + height, square, square }) -- down
    draw.image(images.arrow_down, x, y + square + height)
end

display_index = 2
display_list = { display1, display2 }
function display()
    local button = { 10, 50, 40, 40 }
    draw.color_set { 0, 1, 0 }
    draw.rectangle_outset(button)
    if pointer.click and point_inside_rectangle(pointer.position, button) then
        pointer.click = false -- stop propagation of event
        display_index = (((display_index - 1) + 1) % #display_list) + 1
    end

    draw.color_set { 1, 1, 1 }
    display_list[display_index]()
end

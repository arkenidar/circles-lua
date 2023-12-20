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

function display2()
    -- click to toggle
    if pointer.click then
        toggle = not toggle
    end

    local rectangle = { 80, 20, 200, 100 }
    rectangle.settings = {
        radius = toggle and 30 or 0,
        border = { color = { 1, 0, 0 }, thickness = 10 }
    }
    draw.rectangle(rectangle, rectangle.settings)

    local capsule = { rectangle[1], rectangle[2] + rectangle[4] + 30, rectangle[3], rectangle[4] }
    capsule.settings = { border = { color = { 1, 0, 0 }, thickness = 10 } }
    draw.capsule(capsule, capsule.settings.border)

    draw.color_set({ 230 / 255, 229 / 255, 228 / 255 })
    draw.rectangle_outset({ 100, 250, 90, 50 })

    local x, y
    local square = 16

    -- horizontal

    local width = 400
    local width_part = width / 3
    x, y = 100, 320

    draw.color_set({ 230 / 255, 229 / 255, 228 / 255 })
    draw.rectangle_outset({ x, y, square, square }) -- left
    draw.image(images.arrow_left, x, y)

    draw.color_set({ 243 / 255, 243 / 255, 243 / 255 })
    draw.rectangle_basic({ x + square, y, width, square }) -- total

    draw.color_set({ 230 / 255, 229 / 255, 228 / 255 })
    draw.rectangle_outset({ x + square, y, width_part, square }) -- part

    draw.color_set({ 230 / 255, 229 / 255, 228 / 255 })
    draw.rectangle_outset({ x + square + width, y, square, square }) -- right
    draw.image(images.arrow_right, x + square + width, y)

    -- vertical

    local height = 300
    local height_part = 200
    x = x + square + width + square
    y = y - height - square

    draw.color_set({ 230 / 255, 229 / 255, 228 / 255 })
    draw.rectangle_outset({ x, y, square, square }) -- up
    draw.image(images.arrow_up, x, y)

    draw.color_set({ 243 / 255, 243 / 255, 243 / 255 })
    draw.rectangle_basic({ x, y + square, square, height }) -- total

    draw.color_set({ 230 / 255, 229 / 255, 228 / 255 })
    draw.rectangle_outset({ x, y + square, square, height_part }) -- part

    draw.color_set({ 230 / 255, 229 / 255, 228 / 255 })
    draw.rectangle_outset({ x, y + square + height, square, square }) -- down
    draw.image(images.arrow_down, x, y + square + height)
end

display_index = 2
display_list = { display1, display2 }
function display()
    local button = { 10, 10, 40, 40 }
    draw.color_set { 0, 1, 0 }
    draw.rectangle_outset(button)
    if pointer.click and point_inside_rectangle(pointer.position, button) then
        pointer.click = false -- stop propagation of event
        display_index = (((display_index - 1) + 1) % #display_list) + 1
    end

    draw.color_set { 1, 1, 1 }
    display_list[display_index]()
end

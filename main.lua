-- @category:debuggers Lua

-- tomblind.local-lua-debugger-vscode
-- in Microsoft VisualStudio Code:
-- see also ".vscode/launch.json"
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end -- see docs of extension: tomblind.local-lua-debugger-vscode

require("utils_love2d")
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
end

display_index = 1
display_list = { display1, display2 }
function display()
    local button = { 10, 10, 60, 60 }
    draw.color_set { 0, 1, 0 }
    draw.rectangle(button)
    if pointer.click and point_inside_rectangle(pointer.position, button) then
        pointer.click = false -- stop propagation of event
        display_index = (((display_index - 1) + 1) % #display_list) + 1
    end

    draw.color_set { 1, 1, 1 }
    display_list[display_index]()
end

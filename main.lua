-- @category:debuggers Lua

-- tomblind.local-lua-debugger-vscode
-- in Microsoft VisualStudio Code:
-- see also ".vscode/launch.json"
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end -- see docs of extension: tomblind.local-lua-debugger-vscode


require("draw_primitives_testing")

test_index = 3
function display()
    local tests = { draw_primitives_test1, draw_primitives_test2, draw_primitives_test3 }

    if pointer_click_check() then
        test_index = (((test_index - 1) + 1) % #tests) + 1
    end

    tests[test_index]()
end

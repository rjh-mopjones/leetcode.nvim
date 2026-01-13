local config = require("leetcode.config")
local log = require("leetcode.logger")
local utils = require("leetcode.utils")

---@class lc.LocalTest
local M = {}

---Generate local test code for a question
---@param question lc.ui.Question
---@return string|nil code, string|nil error
function M.generate(question)
    local q = question.q
    local lang = question.lang

    local testcases = q.testcase_list
    if not testcases or #testcases == 0 then
        return nil, "No test cases found"
    end

    local meta = q.meta_data
    if not meta or not meta.params then
        return nil, "No metadata found"
    end

    local generator = M.generators[lang]
    if not generator then
        return nil, ("Local test generation not supported for %s"):format(lang)
    end

    return generator(meta, testcases)
end

---Parse a test case string into individual inputs
---@param testcase string
---@param num_params integer
---@return string[]
local function parse_testcase(testcase, num_params)
    local inputs = {}
    for line in vim.gsplit(testcase, "\n", { trimempty = true }) do
        table.insert(inputs, line)
    end
    return inputs
end

-- Language-specific generators
M.generators = {}

-- Python generator
M.generators["python"] = function(meta, testcases)
    local lines = {
        "",
        "# " .. string.rep("=", 50),
        "# LOCAL TESTING (runs offline)",
        "# " .. string.rep("=", 50),
        "if __name__ == '__main__':",
        "    sol = Solution()",
        "",
    }

    for i, tc in ipairs(testcases) do
        local inputs = parse_testcase(tc, #meta.params)
        local args = table.concat(inputs, ", ")

        table.insert(lines, ("    # Test case %d"):format(i))
        table.insert(lines, ("    result_%d = sol.%s(%s)"):format(i, meta.name, args))
        table.insert(lines, ("    print(f'Test %d: {result_%d}')"):format(i, i))
        table.insert(lines, "")
    end

    table.insert(lines, "    # Add expected outputs manually to verify")
    table.insert(lines, "    # expected = [...]")
    table.insert(lines, "    # for i, (r, e) in enumerate(zip([result_1, result_2, ...], expected)):")
    table.insert(lines, "    #     print(f'Test {i+1}: {\"PASS\" if r == e else \"FAIL\"}')")

    return table.concat(lines, "\n")
end

M.generators["python3"] = M.generators["python"]

-- JavaScript generator
M.generators["javascript"] = function(meta, testcases)
    local lines = {
        "",
        "// " .. string.rep("=", 50),
        "// LOCAL TESTING (runs offline)",
        "// " .. string.rep("=", 50),
        "",
    }

    for i, tc in ipairs(testcases) do
        local inputs = parse_testcase(tc, #meta.params)
        local args = table.concat(inputs, ", ")

        table.insert(lines, ("// Test case %d"):format(i))
        table.insert(lines, ("const result%d = %s(%s);"):format(i, meta.name, args))
        table.insert(lines, ("console.log('Test %d:', result%d);"):format(i, i))
        table.insert(lines, "")
    end

    return table.concat(lines, "\n")
end

-- TypeScript generator
M.generators["typescript"] = M.generators["javascript"]

-- Java generator
M.generators["java"] = function(meta, testcases)
    local lines = {
        "",
        "    // " .. string.rep("=", 50),
        "    // LOCAL TESTING (runs offline)",
        "    // Add this main method inside the Solution class",
        "    // " .. string.rep("=", 50),
        "    /*",
        "    public static void main(String[] args) {",
        "        Solution sol = new Solution();",
        "",
    }

    for i, tc in ipairs(testcases) do
        local inputs = parse_testcase(tc, #meta.params)
        local args = table.concat(inputs, ", ")

        table.insert(lines, ("        // Test case %d"):format(i))
        table.insert(lines, ("        System.out.println(\"Test %d: \" + sol.%s(%s));"):format(i, meta.name, args))
    end

    table.insert(lines, "    }")
    table.insert(lines, "    */")

    return table.concat(lines, "\n")
end

-- C++ generator
M.generators["cpp"] = function(meta, testcases)
    local lines = {
        "",
        "// " .. string.rep("=", 50),
        "// LOCAL TESTING (runs offline)",
        "// " .. string.rep("=", 50),
        "/*",
        "int main() {",
        "    Solution sol;",
        "",
    }

    for i, tc in ipairs(testcases) do
        local inputs = parse_testcase(tc, #meta.params)
        local args = table.concat(inputs, ", ")

        table.insert(lines, ("    // Test case %d"):format(i))
        table.insert(lines, ("    auto result%d = sol.%s(%s);"):format(i, meta.name, args))
        table.insert(lines, ("    cout << \"Test %d: \" << result%d << endl;"):format(i, i))
        table.insert(lines, "")
    end

    table.insert(lines, "    return 0;")
    table.insert(lines, "}")
    table.insert(lines, "*/")

    return table.concat(lines, "\n")
end

-- Go generator
M.generators["golang"] = function(meta, testcases)
    local lines = {
        "",
        "// " .. string.rep("=", 50),
        "// LOCAL TESTING (runs offline)",
        "// " .. string.rep("=", 50),
        "/*",
        "func main() {",
        "",
    }

    for i, tc in ipairs(testcases) do
        local inputs = parse_testcase(tc, #meta.params)
        local args = table.concat(inputs, ", ")

        table.insert(lines, ("    // Test case %d"):format(i))
        table.insert(lines, ("    result%d := %s(%s)"):format(i, meta.name, args))
        table.insert(lines, ("    fmt.Println(\"Test %d:\", result%d)"):format(i, i))
        table.insert(lines, "")
    end

    table.insert(lines, "}")
    table.insert(lines, "*/")

    return table.concat(lines, "\n")
end

-- Rust generator
M.generators["rust"] = function(meta, testcases)
    local lines = {
        "",
        "// " .. string.rep("=", 50),
        "// LOCAL TESTING (runs offline)",
        "// " .. string.rep("=", 50),
        "/*",
        "fn main() {",
        "",
    }

    for i, tc in ipairs(testcases) do
        local inputs = parse_testcase(tc, #meta.params)
        local args = table.concat(inputs, ", ")

        table.insert(lines, ("    // Test case %d"):format(i))
        table.insert(lines, ("    let result%d = Solution::%s(%s);"):format(i, meta.name, args))
        table.insert(lines, ("    println!(\"Test %d: {:?}\", result%d);"):format(i, i))
        table.insert(lines, "")
    end

    table.insert(lines, "}")
    table.insert(lines, "*/")

    return table.concat(lines, "\n")
end

-- Ruby generator
M.generators["ruby"] = function(meta, testcases)
    local lines = {
        "",
        "# " .. string.rep("=", 50),
        "# LOCAL TESTING (runs offline)",
        "# " .. string.rep("=", 50),
        "",
    }

    for i, tc in ipairs(testcases) do
        local inputs = parse_testcase(tc, #meta.params)
        local args = table.concat(inputs, ", ")

        table.insert(lines, ("# Test case %d"):format(i))
        table.insert(lines, ("result%d = %s(%s)"):format(i, meta.name, args))
        table.insert(lines, ("puts \"Test %d: #{result%d}\""):format(i, i))
        table.insert(lines, "")
    end

    return table.concat(lines, "\n")
end

return M

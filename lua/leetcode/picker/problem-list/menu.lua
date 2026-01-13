local NuiPopup = require("nui.popup")
local t = require("leetcode.translator")
local problem_list_picker = require("leetcode.picker.problem-list")
local config = require("leetcode.config")
local ui_utils = require("leetcode-ui.utils")

---Create a simple menu popup with hjkl navigation
---@param opts { title: string, items: table[], width: number, height: number, on_select: function }
local function create_menu(opts)
    local height = math.min(#opts.items, opts.height)

    local popup = NuiPopup({
        position = "50%",
        size = {
            width = opts.width,
            height = height,
        },
        enter = true,
        focusable = true,
        border = {
            style = "rounded",
            text = {
                top = " " .. opts.title .. " ",
                top_align = "center",
            },
        },
        buf_options = {
            modifiable = false,
            readonly = true,
            filetype = "leetcode_menu",
        },
        win_options = {
            cursorline = true,
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLine",
        },
    })

    popup:mount()

    -- Build lines with virtual text for highlights
    local lines = {}
    local ns_id = vim.api.nvim_create_namespace("leetcode_menu")

    for _, item in ipairs(opts.items) do
        local parts = {}
        for _, col in ipairs(item.entry) do
            if type(col) == "table" then
                table.insert(parts, col[1])
            else
                table.insert(parts, col)
            end
        end
        table.insert(lines, table.concat(parts, " "))
    end

    -- Set buffer content
    vim.api.nvim_buf_set_option(popup.bufnr, "modifiable", true)
    vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, false, lines)
    vim.api.nvim_buf_set_option(popup.bufnr, "modifiable", false)

    -- Apply highlights
    for i, item in ipairs(opts.items) do
        local col = 0
        for _, entry in ipairs(item.entry) do
            local text = type(entry) == "table" and entry[1] or entry
            local hl = type(entry) == "table" and entry[2] or nil
            local text_len = vim.fn.strdisplaywidth(text)

            if hl then
                vim.api.nvim_buf_add_highlight(popup.bufnr, ns_id, hl, i - 1, col, col + #text)
            end
            col = col + #text + 1 -- +1 for space
        end
    end

    local function close()
        popup:unmount()
    end

    local function select()
        local cursor = vim.api.nvim_win_get_cursor(popup.winid)
        local idx = cursor[1]
        local item = opts.items[idx]
        if item then
            close()
            vim.schedule(function()
                opts.on_select(item)
            end)
        end
    end

    -- Navigation keymaps
    local map_opts = { noremap = true, nowait = true }
    popup:map("n", { "<CR>", "l", "<Right>" }, select, map_opts)
    popup:map("n", { "<Esc>", "q", "h", "<Left>" }, close, map_opts)
    popup:map("n", { "j", "<Down>" }, "j", map_opts)
    popup:map("n", { "k", "<Up>" }, "k", map_opts)
    popup:map("n", "gg", "gg", map_opts)
    popup:map("n", "G", "G", map_opts)
    popup:map("n", "<C-d>", "<C-d>", map_opts)
    popup:map("n", "<C-u>", "<C-u>", map_opts)

    popup:on("BufLeave", close)

    return popup
end

---Show problems picker
local function show_problems(list_key, list_name, tag)
    local items = problem_list_picker.problems_items(list_key, tag)
    local max_height = math.floor(vim.o.lines * problem_list_picker.height)

    create_menu({
        title = t("Select a Problem") .. " - " .. list_name .. " - " .. tag,
        items = items,
        width = problem_list_picker.width,
        height = max_height,
        on_select = function(item)
            problem_list_picker.problems_select(item.value)
        end,
    })
end

---Show tags picker
local function show_tags(list_key, list_name)
    local items = problem_list_picker.tags_items(list_key)
    local max_height = math.floor(vim.o.lines * problem_list_picker.tag_height)

    create_menu({
        title = t("Select a Tag") .. " - " .. list_name,
        items = items,
        width = problem_list_picker.tag_width,
        height = max_height,
        on_select = function(item)
            show_problems(list_key, list_name, item.value.tag)
        end,
    })
end

---Show lists picker (main entry point)
return function()
    local items = problem_list_picker.lists_items()
    local max_height = math.floor(vim.o.lines * problem_list_picker.list_height)

    create_menu({
        title = t("Select a Problem List"),
        items = items,
        width = problem_list_picker.list_width,
        height = max_height,
        on_select = function(item)
            show_tags(item.value.key, item.value.name)
        end,
    })
end

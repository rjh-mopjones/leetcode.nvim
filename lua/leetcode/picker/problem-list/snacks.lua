local log = require("leetcode.logger")
local t = require("leetcode.translator")
local problem_list_picker = require("leetcode.picker.problem-list")

local picker = require("snacks.picker")

-- Helper to format entry for snacks picker
local function format_entry(item)
    local ret = {}
    vim.tbl_map(function(col)
        if type(col) == "table" then
            ret[#ret + 1] = col
        else
            ret[#ret + 1] = { col }
        end
        ret[#ret + 1] = { " " }
    end, item.item.entry)
    return ret
end

-- Show problems picker for a specific list and tag
local function show_problems_picker(list_key, tag)
    local items = problem_list_picker.problems_items(list_key, tag)
    local finder_items = {}
    local completed = false

    for _, item in ipairs(items) do
        local text = problem_list_picker.problems_ordinal(item.value)
        table.insert(finder_items, {
            text = text,
            item = item,
        })
    end

    picker.pick({
        items = finder_items,
        format = format_entry,
        title = t("Select a Problem") .. " - " .. tag,
        layout = {
            preset = "select",
            preview = false,
            layout = {
                height = problem_list_picker.height,
                width = problem_list_picker.width,
            },
        },
        actions = {
            confirm = function(p, item)
                if completed then
                    return
                end
                completed = true
                p:close()
                vim.schedule(function()
                    problem_list_picker.problems_select(item.item.value)
                end)
            end,
        },
        on_close = function()
            if completed then
                return
            end
            completed = true
        end,
    })
end

-- Show tags picker for a specific list
local function show_tags_picker(list_key, list_name)
    local items = problem_list_picker.tags_items(list_key)
    local finder_items = {}
    local completed = false

    for _, item in ipairs(items) do
        local text = problem_list_picker.tags_ordinal(item.value)
        table.insert(finder_items, {
            text = text,
            item = item,
        })
    end

    picker.pick({
        items = finder_items,
        format = format_entry,
        title = t("Select a Tag") .. " - " .. list_name,
        layout = {
            preset = "select",
            preview = false,
            layout = {
                height = problem_list_picker.tag_height,
                width = problem_list_picker.tag_width,
            },
        },
        actions = {
            confirm = function(p, item)
                if completed then
                    return
                end
                completed = true
                p:close()
                vim.schedule(function()
                    show_problems_picker(list_key, item.item.value.tag)
                end)
            end,
        },
        on_close = function()
            if completed then
                return
            end
            completed = true
        end,
    })
end

-- Main entry point - show lists picker
return function()
    local items = problem_list_picker.lists_items()
    local finder_items = {}
    local completed = false

    for _, item in ipairs(items) do
        local text = problem_list_picker.lists_ordinal(item.value)
        table.insert(finder_items, {
            text = text,
            item = item,
        })
    end

    picker.pick({
        items = finder_items,
        format = format_entry,
        title = t("Select a Problem List"),
        layout = {
            preset = "select",
            preview = false,
            layout = {
                height = problem_list_picker.list_height,
                width = problem_list_picker.list_width,
            },
        },
        actions = {
            confirm = function(p, item)
                if completed then
                    return
                end
                completed = true
                p:close()
                vim.schedule(function()
                    show_tags_picker(item.item.value.key, item.item.value.name)
                end)
            end,
        },
        on_close = function()
            if completed then
                return
            end
            completed = true
        end,
    })
end

local log = require("leetcode.logger")
local t = require("leetcode.translator")
local problem_list_picker = require("leetcode.picker.problem-list")

local picker = require("mini.pick")
local mini_pick_utils = require("leetcode.picker.mini_pick_utils")

-- Show problems picker for a specific list and tag
local function show_problems_picker(list_key, tag)
    local items = problem_list_picker.problems_items(list_key, tag)
    local ns_id = vim.api.nvim_create_namespace("MiniPick LeetCode ProblemList Problems Picker")
    local finder_items = {}
    local completed = false

    for _, item in ipairs(items) do
        local text = problem_list_picker.problems_ordinal(item.value)
        table.insert(finder_items, {
            entry = item.entry,
            text = text,
            item = item,
        })
    end

    local res = picker.start({
        source = {
            items = finder_items,
            name = t("Select a Problem") .. " - " .. tag,
            choose = function(item)
                if completed then
                    return
                end
                completed = true
                vim.schedule(function()
                    problem_list_picker.problems_select(item.item.value)
                end)
            end,
            show = function(buf_id, items_to_show)
                mini_pick_utils.show_items(buf_id, ns_id, items_to_show)
            end,
        },
        window = {
            config = {
                width = problem_list_picker.width,
                height = math.floor(vim.o.lines * problem_list_picker.height),
            },
        },
    })

    if res == nil then
        if completed then
            return
        end
        completed = true
    end
end

-- Show tags picker for a specific list
local function show_tags_picker(list_key, list_name)
    local items = problem_list_picker.tags_items(list_key)
    local ns_id = vim.api.nvim_create_namespace("MiniPick LeetCode ProblemList Tags Picker")
    local finder_items = {}
    local completed = false

    for _, item in ipairs(items) do
        local text = problem_list_picker.tags_ordinal(item.value)
        table.insert(finder_items, {
            entry = item.entry,
            text = text,
            item = item,
        })
    end

    local res = picker.start({
        source = {
            items = finder_items,
            name = t("Select a Tag") .. " - " .. list_name,
            choose = function(item)
                if completed then
                    return
                end
                completed = true
                vim.schedule(function()
                    show_problems_picker(list_key, item.item.value.tag)
                end)
            end,
            show = function(buf_id, items_to_show)
                mini_pick_utils.show_items(buf_id, ns_id, items_to_show)
            end,
        },
        window = {
            config = {
                width = problem_list_picker.tag_width,
                height = math.floor(vim.o.lines * problem_list_picker.tag_height),
            },
        },
    })

    if res == nil then
        if completed then
            return
        end
        completed = true
    end
end

-- Main entry point - show lists picker
return function()
    local items = problem_list_picker.lists_items()
    local ns_id = vim.api.nvim_create_namespace("MiniPick LeetCode ProblemList Lists Picker")
    local finder_items = {}
    local completed = false

    for _, item in ipairs(items) do
        local text = problem_list_picker.lists_ordinal(item.value)
        table.insert(finder_items, {
            entry = item.entry,
            text = text,
            item = item,
        })
    end

    local res = picker.start({
        source = {
            items = finder_items,
            name = t("Select a Problem List"),
            choose = function(item)
                if completed then
                    return
                end
                completed = true
                vim.schedule(function()
                    show_tags_picker(item.item.value.key, item.item.value.name)
                end)
            end,
            show = function(buf_id, items_to_show)
                mini_pick_utils.show_items(buf_id, ns_id, items_to_show)
            end,
        },
        window = {
            config = {
                width = problem_list_picker.list_width,
                height = math.floor(vim.o.lines * problem_list_picker.list_height),
            },
        },
    })

    if res == nil then
        if completed then
            return
        end
        completed = true
    end
end

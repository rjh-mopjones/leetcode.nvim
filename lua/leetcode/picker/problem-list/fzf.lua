local fzf = require("fzf-lua")
local t = require("leetcode.translator")
local problem_list_picker = require("leetcode.picker.problem-list")
local Picker = require("leetcode.picker")

local deli = " "

-- Show problems picker for a specific list and tag
local function show_problems_picker(list_key, tag)
    local items = problem_list_picker.problems_items(list_key, tag)
    local fzf_items = {}

    for i, item in ipairs(items) do
        fzf_items[i] = Picker.normalize({ item })[1]
            .. deli
            .. Picker.apply_hl(item.value.title_slug, "leetcode_alt")
    end

    fzf.fzf_exec(fzf_items, {
        prompt = t("Select a Problem") .. " - " .. tag .. "> ",
        winopts = {
            height = problem_list_picker.height,
            width = problem_list_picker.width,
        },
        fzf_opts = {
            ["--delimiter"] = deli,
            ["--nth"] = "3..-3",
        },
        actions = {
            ["default"] = function(selected)
                local slug = Picker.hidden_field(selected[1], deli)
                -- Find the item with this slug
                for _, item in ipairs(items) do
                    if item.value.title_slug == slug then
                        problem_list_picker.problems_select(item.value)
                        return
                    end
                end
            end,
        },
    })
end

-- Show tags picker for a specific list
local function show_tags_picker(list_key, list_name)
    local items = problem_list_picker.tags_items(list_key)
    local fzf_items = {}

    for i, item in ipairs(items) do
        fzf_items[i] = Picker.normalize({ item })[1]
            .. deli
            .. Picker.apply_hl(item.value.tag, "leetcode_alt")
    end

    fzf.fzf_exec(fzf_items, {
        prompt = t("Select a Tag") .. " - " .. list_name .. "> ",
        winopts = {
            height = problem_list_picker.tag_height,
            width = problem_list_picker.tag_width,
        },
        fzf_opts = {
            ["--delimiter"] = deli,
            ["--nth"] = "2..-2",
        },
        actions = {
            ["default"] = function(selected)
                local tag = Picker.hidden_field(selected[1], deli)
                vim.schedule(function()
                    show_problems_picker(list_key, tag)
                end)
            end,
        },
    })
end

-- Main entry point - show lists picker
return function()
    local items = problem_list_picker.lists_items()
    local fzf_items = {}

    for i, item in ipairs(items) do
        fzf_items[i] = Picker.normalize({ item })[1]
            .. deli
            .. Picker.apply_hl(item.value.key, "leetcode_alt")
    end

    fzf.fzf_exec(fzf_items, {
        prompt = t("Select a Problem List") .. "> ",
        winopts = {
            height = problem_list_picker.list_height,
            width = problem_list_picker.list_width,
        },
        fzf_opts = {
            ["--delimiter"] = deli,
            ["--nth"] = "2..-2",
        },
        actions = {
            ["default"] = function(selected)
                local key = Picker.hidden_field(selected[1], deli)
                -- Find the item with this key
                for _, item in ipairs(items) do
                    if item.value.key == key then
                        vim.schedule(function()
                            show_tags_picker(key, item.value.name)
                        end)
                        return
                    end
                end
            end,
        },
    })
end

local t = require("leetcode.translator")
local problem_list_picker = require("leetcode.picker.problem-list")

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local entry_display = require("telescope.pickers.entry_display")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

-- Displayer for lists
local list_displayer = entry_display.create({
    separator = " ",
    items = {
        { width = 2 },
        { remaining = true },
        { remaining = true },
    },
})

-- Displayer for tags
local tag_displayer = entry_display.create({
    separator = " ",
    items = {
        { width = 2 },
        { remaining = true },
        { remaining = true },
    },
})

-- Displayer for problems
local problem_displayer = entry_display.create({
    separator = " ",
    items = {
        { width = 1 },
        { width = 1 },
        { width = 5 },
        { remaining = true },
        { remaining = true },
    },
})

local function list_entry_maker(item)
    return {
        value = item.value,
        display = function()
            return list_displayer(item.entry)
        end,
        ordinal = problem_list_picker.lists_ordinal(item.value),
    }
end

local function tag_entry_maker(item)
    return {
        value = item.value,
        display = function()
            return tag_displayer(item.entry)
        end,
        ordinal = problem_list_picker.tags_ordinal(item.value),
    }
end

local function problem_entry_maker(item)
    return {
        value = item.value,
        display = function()
            return problem_displayer(item.entry)
        end,
        ordinal = problem_list_picker.problems_ordinal(item.value),
    }
end

local list_theme = require("telescope.themes").get_dropdown({
    layout_config = {
        width = problem_list_picker.list_width,
        height = problem_list_picker.list_height,
    },
})

local tag_theme = require("telescope.themes").get_dropdown({
    layout_config = {
        width = problem_list_picker.tag_width,
        height = problem_list_picker.tag_height,
    },
})

local problem_theme = require("telescope.themes").get_dropdown({
    layout_config = {
        width = problem_list_picker.width,
        height = problem_list_picker.height,
    },
})

-- Show problems picker for a specific list and tag
local function show_problems_picker(list_key, tag)
    local items = problem_list_picker.problems_items(list_key, tag)

    pickers
        .new(problem_theme, {
            prompt_title = t("Select a Problem") .. " - " .. tag,
            finder = finders.new_table({
                results = items,
                entry_maker = problem_entry_maker,
            }),
            sorter = conf.generic_sorter(problem_theme),
            attach_mappings = function(prompt_bufnr)
                actions.select_default:replace(function()
                    local selection = action_state.get_selected_entry()
                    if not selection then
                        return
                    end
                    problem_list_picker.problems_select(selection.value, function()
                        actions.close(prompt_bufnr)
                    end)
                end)
                return true
            end,
        })
        :find()
end

-- Show tags picker for a specific list
local function show_tags_picker(list_key, list_name)
    local items = problem_list_picker.tags_items(list_key)

    pickers
        .new(tag_theme, {
            prompt_title = t("Select a Tag") .. " - " .. list_name,
            finder = finders.new_table({
                results = items,
                entry_maker = tag_entry_maker,
            }),
            sorter = conf.generic_sorter(tag_theme),
            attach_mappings = function(prompt_bufnr)
                actions.select_default:replace(function()
                    local selection = action_state.get_selected_entry()
                    if not selection then
                        return
                    end
                    actions.close(prompt_bufnr)
                    vim.schedule(function()
                        show_problems_picker(list_key, selection.value.tag)
                    end)
                end)
                return true
            end,
        })
        :find()
end

-- Main entry point - show lists picker
return function()
    local items = problem_list_picker.lists_items()

    pickers
        .new(list_theme, {
            prompt_title = t("Select a Problem List"),
            finder = finders.new_table({
                results = items,
                entry_maker = list_entry_maker,
            }),
            sorter = conf.generic_sorter(list_theme),
            attach_mappings = function(prompt_bufnr)
                actions.select_default:replace(function()
                    local selection = action_state.get_selected_entry()
                    if not selection then
                        return
                    end
                    actions.close(prompt_bufnr)
                    vim.schedule(function()
                        show_tags_picker(selection.value.key, selection.value.name)
                    end)
                end)
                return true
            end,
        })
        :find()
end

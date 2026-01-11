local config = require("leetcode.config")
local log = require("leetcode.logger")
local t = require("leetcode.translator")
local ui_utils = require("leetcode-ui.utils")
local utils = require("leetcode.utils")
local problem_lists = require("leetcode.problem-lists")
local problemlist_cache = require("leetcode.cache.problemlist")
local Question = require("leetcode-ui.question")
local Picker = require("leetcode.picker")

---@class leet.Picker.ProblemList: leet.Picker
local P = {}

P.width = 80
P.height = 0.5

-- List picker dimensions (smaller for fewer items)
P.list_width = 60
P.list_height = 0.3

-- Tag picker dimensions
P.tag_width = 60
P.tag_height = 0.4

---@class leet.Picker.ListItem
---@field key string
---@field name string
---@field count integer

---Build picker items for available lists
---@return { entry: any, value: leet.Picker.ListItem }[]
function P.lists_items()
    local list_keys = problem_lists.get_list_keys()
    local items = {}

    for _, key in ipairs(list_keys) do
        local list = problem_lists.get_list(key)
        if list then
            table.insert(items, {
                entry = P.lists_entry({ key = key, name = list.name, count = #list.problems }),
                value = { key = key, name = list.name, count = #list.problems },
            })
        end
    end

    -- Sort by name
    table.sort(items, function(a, b)
        return a.value.name < b.value.name
    end)

    return items
end

---Format list entry for display
---@param item leet.Picker.ListItem
---@return table
function P.lists_entry(item)
    return {
        { "󰱔", "leetcode_alt" },
        { item.name },
        { ("(%d problems)"):format(item.count), "leetcode_ref" },
    }
end

---Ordinal text for list searching
---@param item leet.Picker.ListItem
---@return string
function P.lists_ordinal(item)
    return item.name .. " " .. item.key
end

---@class leet.Picker.TagItem
---@field tag string
---@field count integer

---Build picker items for tags in a list
---@param list_key string
---@return { entry: any, value: leet.Picker.TagItem }[]
function P.tags_items(list_key)
    local tags = problem_lists.get_tags(list_key)
    local all_problems = problem_lists.get_all_problems(list_key)
    local items = {}

    -- Add "All" option first
    table.insert(items, {
        entry = P.tags_entry({ tag = "All", count = #all_problems }),
        value = { tag = "All", count = #all_problems },
    })

    for _, tag in ipairs(tags) do
        local problems = problem_lists.get_problems_by_tag(list_key, tag)
        table.insert(items, {
            entry = P.tags_entry({ tag = tag, count = #problems }),
            value = { tag = tag, count = #problems },
        })
    end

    return items
end

---Format tag entry for display
---@param item leet.Picker.TagItem
---@return table
function P.tags_entry(item)
    local icon = item.tag == "All" and "󰀘" or ""
    return {
        { icon, "leetcode_alt" },
        { item.tag },
        { ("(%d)"):format(item.count), "leetcode_ref" },
    }
end

---Ordinal text for tag searching
---@param item leet.Picker.TagItem
---@return string
function P.tags_ordinal(item)
    return item.tag
end

---Get cached question data for a problem
---@param title_slug string
---@return lc.cache.Question|nil
local function get_cached_question(title_slug)
    local ok, question = pcall(problemlist_cache.get_by_title_slug, title_slug)
    if ok then
        return question
    end
    return nil
end

---Display user status icon
---@param question lc.cache.Question|nil
local function display_user_status(question)
    if not question then
        return { "?", "leetcode_ref" }
    end

    if question.paid_only then
        return config.auth.is_premium and config.icons.hl.unlock or config.icons.hl.lock
    end

    return config.icons.hl.status[question.status] or { " " }
end

---Display difficulty
---@param question lc.cache.Question|nil
local function display_difficulty(question)
    if not question then
        return { config.icons.square, "leetcode_ref" }
    end
    local hl = ui_utils.diff_to_hl(question.difficulty)
    return { config.icons.square, hl }
end

---Display question info
---@param question lc.cache.Question|nil
---@param title_slug string
local function display_question(question, title_slug)
    if not question then
        return { title_slug, "leetcode_ref" }
    end

    local index = { question.frontend_id .. ".", "leetcode_normal" }
    local title = { utils.translate(question.title, question.title_cn) }
    local ac_rate = { ("(%.1f%%)"):format(question.ac_rate), "leetcode_ref" }

    return unpack({ index, title, ac_rate })
end

---@class leet.Picker.ProblemItem
---@field title_slug string
---@field question lc.cache.Question|nil
---@field tags string[]

---Build picker items for problems in a list filtered by tag
---@param list_key string
---@param tag string
---@return { entry: any, value: leet.Picker.ProblemItem }[]
function P.problems_items(list_key, tag)
    local problems
    if tag == "All" then
        problems = problem_lists.get_all_problems(list_key)
    else
        problems = problem_lists.get_problems_by_tag(list_key, tag)
    end
    local items = {}

    for _, problem in ipairs(problems) do
        local question = get_cached_question(problem.title_slug)
        local item = {
            title_slug = problem.title_slug,
            question = question,
            tags = problem.tags,
        }
        table.insert(items, {
            entry = P.problems_entry(item),
            value = item,
        })
    end

    return items
end

---Format problem entry for display
---@param item leet.Picker.ProblemItem
---@return table
function P.problems_entry(item)
    return {
        display_user_status(item.question),
        display_difficulty(item.question),
        display_question(item.question, item.title_slug),
    }
end

---Ordinal text for problem searching
---@param item leet.Picker.ProblemItem
---@return string
function P.problems_ordinal(item)
    if item.question then
        return ("%s. %s %s %s"):format(
            tostring(item.question.frontend_id),
            item.question.title,
            item.question.title_cn or "",
            item.question.title_slug
        )
    end
    return item.title_slug
end

---Handle problem selection
---@param item leet.Picker.ProblemItem
---@param close function|nil
function P.problems_select(item, close)
    if not item.question then
        return log.warn("Problem not found in cache. Try updating cache?")
    end

    if item.question.paid_only and not config.auth.is_premium then
        return log.warn("Question is for premium users only")
    end

    if close then
        close()
    end

    Question(item.question):mount()
end

return P

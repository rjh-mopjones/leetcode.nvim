local path = require("plenary.path")
local config = require("leetcode.config")
local log = require("leetcode.logger")

---@type Path
local cache_dir = nil

---@class lc.cache.Questions
local Questions = {}

local function get_cache_dir()
    if not cache_dir then
        cache_dir = config.storage.cache:joinpath("questions")
        cache_dir:mkdir({ parents = true, exists_ok = true })
    end
    return cache_dir
end

---Get the cache file path for a question
---@param title_slug string
---@return Path
local function get_cache_file(title_slug)
    local suffix = config.is_cn and "_cn" or ""
    return get_cache_dir():joinpath(title_slug .. suffix .. ".json")
end

---Check if a question is cached
---@param title_slug string
---@return boolean
function Questions.is_cached(title_slug)
    return get_cache_file(title_slug):exists()
end

---Get cached question data
---@param title_slug string
---@return lc.question_res|nil
function Questions.get(title_slug)
    local file = get_cache_file(title_slug)
    if not file:exists() then
        return nil
    end

    local ok, contents = pcall(file.read, file)
    if not ok or not contents then
        return nil
    end

    local ok2, data = pcall(vim.json.decode, contents)
    if not ok2 or not data then
        return nil
    end

    return data
end

---Save question data to cache
---@param title_slug string
---@param data lc.question_res
---@return boolean success
function Questions.save(title_slug, data)
    local file = get_cache_file(title_slug)

    local ok, encoded = pcall(vim.json.encode, data)
    if not ok then
        log.error("Failed to encode question data for caching: " .. title_slug)
        return false
    end

    local ok2 = pcall(file.write, file, encoded, "w")
    if not ok2 then
        log.error("Failed to write question cache: " .. title_slug)
        return false
    end

    return true
end

---Delete cached question
---@param title_slug string
function Questions.delete(title_slug)
    local file = get_cache_file(title_slug)
    if file:exists() then
        pcall(path.rm, file)
    end
end

---Get list of all cached question slugs
---@return string[]
function Questions.list_cached()
    local dir = get_cache_dir()
    local suffix = config.is_cn and "_cn" or ""

    local cached = {}
    local handle = vim.loop.fs_scandir(dir:absolute())
    if handle then
        while true do
            local name = vim.loop.fs_scandir_next(handle)
            if not name then
                break
            end
            if name:match("%.json$") then
                local slug = name:gsub(suffix .. "%.json$", "")
                table.insert(cached, slug)
            end
        end
    end

    return cached
end

---Clear all cached questions
function Questions.clear_all()
    local dir = get_cache_dir()
    local handle = vim.loop.fs_scandir(dir:absolute())
    if handle then
        while true do
            local name = vim.loop.fs_scandir_next(handle)
            if not name then
                break
            end
            local file = dir:joinpath(name)
            pcall(path.rm, file)
        end
    end
end

return Questions

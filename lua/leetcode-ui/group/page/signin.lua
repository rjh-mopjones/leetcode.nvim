local cmd = require("leetcode.command")
local config = require("leetcode.config")

local Page = require("leetcode-ui.group.page")
local Title = require("leetcode-ui.lines.title")
local Buttons = require("leetcode-ui.group.buttons.menu")
local Group = require("leetcode-ui.group")
local Button = require("leetcode-ui.lines.button.menu")
local ExitButton = require("leetcode-ui.lines.button.menu.exit")

local header = require("leetcode-ui.lines.menu-header")

local page = Page()

page:insert(header)

page:insert(Title({}, "Sign in"))

local problems = Button("Sign in (From Chrome)", {
    icon = "󱛖",
    sc = "s",
    on_press = function()
        local cookie = require("leetcode.cache.cookie")
        local script = vim.fn.expand("~/term_prof/scripts/chrome_leetcode_cookie.py")
        vim.fn.jobstart({ "python3", script }, {
            stdout_buffered = true,
            on_stdout = function(_, data)
                local cookie_str = table.concat(data, "")
                if cookie_str == "" then return end
                vim.schedule(function()
                    local err = cookie.set(cookie_str)
                    if not err then
                        require("leetcode.logger").info("Sign-in successful")
                        cmd.start_user_session()
                    else
                        require("leetcode.logger").error("Sign-in failed: " .. err)
                    end
                end)
            end,
            on_stderr = function(_, data)
                local err = table.concat(data, "")
                if err ~= "" then
                    vim.schedule(function()
                        require("leetcode.logger").error("Cookie extraction failed: " .. err)
                    end)
                end
            end,
        })
    end,
})

local exit = ExitButton()

page:insert(Buttons({
    problems,
    exit,
}))

local footer = Group({}, {
    hl = "Number",
})
footer:append("leetcode." .. config.domain)
page:insert(footer)

return page

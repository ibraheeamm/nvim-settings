
local state = require("utils.replacer.state")
local pickers = require("utils.replacer.pickers")
local finders = require("utils.replacer.finders")
local actions = require("utils.replacer.actions")

local M = {}

-- Log helper
local function log(msg)
    vim.notify("[FindReplace Core] " .. msg, vim.log.levels.INFO)
end

function M.open_find_replace()
    log("Initializing Find and Replace")

    -- Initialize the state
    local current_state = state.new()

    -- Log all the state variables
    log("Current state: " .. vim.inspect(current_state))
    -- Create the picker and pass the state
    pickers.new({
        state = current_state,
        prompt_title = "Find and Replace",
        finder = finders,
        actions = actions,
    })

    log("Find and Replace initialized successfully")
end

return M

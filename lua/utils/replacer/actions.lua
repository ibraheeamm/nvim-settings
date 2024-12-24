
local state = require("utils.replacer.state")

local actions = {}

function actions.replace()
    local current_state = state.get()

    local replace_text = vim.api.nvim_buf_get_lines(current_state.buf, 1, 2, false)[1]:gsub("Replace:%s*", "")

    if current_state.search == "" then
        print("Search pattern cannot be empty!")
        return
    end

    vim.cmd("vimgrep /" .. current_state.search:gsub("/", "\\/") .. "/j **/*")
    local qf_list = vim.fn.getqflist()

    for _, entry in ipairs(qf_list) do
        vim.cmd(string.format("edit %s", entry.filename))
        vim.fn.cursor(entry.lnum, entry.col)
        vim.cmd(string.format("s/%s/%s/g", current_state.search, replace_text))
    end

    print("Replacements completed!")
end

return actions

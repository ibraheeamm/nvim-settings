
local M = {}

-- Function to display all keymaps in a new scratch buffer
function M.display_keymaps()
    -- Create a new buffer
    local buf = vim.api.nvim_create_buf(false, true) -- Create a non-listed, scratch buffer

    -- Open the new buffer in a vertical split
    vim.api.nvim_command("vsplit")
    vim.api.nvim_win_set_buf(0, buf)

    -- Set buffer options
    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].swapfile = false

    -- Make the buffer modifiable before writing lines
    vim.bo[buf].modifiable = true

    -- Get all keymaps
    local modes = { "n", "i", "v", "x", "c", "t" }
    local lines = {}
    for _, mode in ipairs(modes) do
        table.insert(lines, "Mode: " .. mode)
        for _, map in ipairs(vim.api.nvim_get_keymap(mode)) do
            local line = string.format("  %s -> %s", map.lhs, map.rhs or "N/A")
            table.insert(lines, line)
        end
        table.insert(lines, "") -- Add a blank line between modes
    end

    -- Write lines to the new buffer
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    -- Optionally make the buffer read-only
    vim.bo[buf].modifiable = false
end

return M

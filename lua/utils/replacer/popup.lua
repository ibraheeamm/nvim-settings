
local function create_popup()
    -- Create a new buffer
    local buf = vim.api.nvim_create_buf(false, true) -- false: not listed, true: scratch buffer

    -- Set buffer options
    vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
    vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Welcome to the popup!", "This is a floating window." })

    -- Define the popup dimensions
    local width = math.floor(vim.o.columns * 0.5) -- 50% of the screen width
    local height = math.floor(vim.o.lines * 0.3)  -- 30% of the screen height
    local col = math.floor((vim.o.columns - width) / 2) -- Center horizontally
    local row = math.floor((vim.o.lines - height) / 2)  -- Center vertically

    -- Open the floating window
    local win = vim.api.nvim_open_win(buf, true, { -- `true` to enter the window
        relative = "editor",        -- Relative to the editor
        width = width,             -- Window width
        height = height,           -- Window height
        col = col,                 -- Column position
        row = row,                 -- Row position
        style = "minimal",         -- No statusline or background
        border = "rounded",        -- Rounded border
    })

    -- Configure keymaps to close the popup
    vim.api.nvim_buf_set_keymap(buf, "n", "q", ":lua require('popup').close_popup()<CR>", { noremap = true, silent = true })

    -- Save state to use later
    vim.g.popup_buf = buf
    vim.g.popup_win = win
end

local function close_popup()
    -- Get the popup state
    local buf = vim.g.popup_buf
    local win = vim.g.popup_win

    -- Validate and close the window
    if win and vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
    end

    -- Validate and delete the buffer
    if buf and vim.api.nvim_buf_is_valid(buf) then
        vim.api.nvim_buf_delete(buf, { force = true })
    end

    -- Clear state
    vim.g.popup_buf = nil
    vim.g.popup_win = nil
end

-- Export functions
return {
    create_popup = create_popup,
    close_popup = close_popup,
}

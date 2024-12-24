
local popup = require("plenary.popup")
local state = require("utils.replacer.state")

local pickers = {}

-- Log helper for debugging
local function log(msg)
    vim.notify("[FindReplace Pickers] " .. msg, vim.log.levels.INFO)
end

function pickers.new(opts)
    log("Creating picker")
    opts = opts or {}
    opts.prompt_title = opts.prompt_title or "Find and Replace"
    local current_state = opts.state

    -- Define popup dimensions
    local width = math.floor(vim.o.columns * 0.6)
    local height = math.floor(vim.o.lines * 0.4)
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    -- Create the popup using Plenary
    local popup_opts = {
        title = opts.prompt_title,
        highlight = "Normal",
        width = width,
        height = height,
        line = row,
        col = col,
        border = true,
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }, -- Custom border style
        titlehighlight = "Title",
    }

    -- Correctly handle the return values
    local win_id, popup_details = popup.create("", popup_opts)

    -- Store the popup window ID and border window ID in the current state
    current_state.win = popup_details.win_id or nil
    current_state.border_win = popup_details.border or nil

    -- Validate the main popup window
    if not current_state.win or not vim.api.nvim_win_is_valid(current_state.win) then
        log("Failed to create popup window")
        error("Failed to create a valid popup window.")
    end

    log("Popup created successfully with win=" .. current_state.win)

    -- Configure the popup content
    vim.api.nvim_buf_set_option(popup_details.buf, "buftype", "nofile")
    vim.api.nvim_buf_set_option(popup_details.buf, "bufhidden", "wipe")
    vim.api.nvim_buf_set_lines(popup_details.buf, 0, -1, false, {
        "Search: ",
        "Replace: ",
        "",
        "Results will appear below:",
    })

    -- Attach finder and actions if provided
    if opts.finder then
        log("Attaching finder")
        opts.finder.attach(current_state)
    end

    pickers.setup_keymaps(current_state, opts)

    return pickers
end

function pickers.setup_keymaps(current_state, opts)
    local buf = vim.api.nvim_win_get_buf(current_state.win)

    -- Close the popup
    vim.api.nvim_buf_set_keymap(
        buf,
        "n",
        "q",
        ":lua require('utils.replacer.pickers').close()<CR>",
        { noremap = true, silent = true }
    )

    -- Replace occurrences
    vim.api.nvim_buf_set_keymap(
        buf,
        "n",
        "<CR>",
        ":lua require('utils.replacer.actions').replace()<CR>",
        { noremap = true, silent = true }
    )
end

function pickers.close()
    local current_state = state.get()
    log("Closing picker")

    -- Close the border window if valid
    if current_state.border_win and vim.api.nvim_win_is_valid(current_state.border_win) then
        vim.api.nvim_win_close(current_state.border_win, true)
    end

    -- Close the main popup window
    if current_state.win and vim.api.nvim_win_is_valid(current_state.win) then
        vim.api.nvim_win_close(current_state.win, true)
    end

    -- Clear state
    current_state.win = nil
    current_state.border_win = nil

    log("Picker closed")
end

return pickers

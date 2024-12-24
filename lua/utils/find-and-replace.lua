
local M = {}

-- Debug toggle
local DEBUG_MODE = true

-- Profiling utility
local function debug_log(msg)
    if DEBUG_MODE then
        vim.api.nvim_echo({ { "[FindReplace DEBUG] " .. msg, "WarningMsg" } }, false, {})
    end
end

-- Floating windows and buffers
local input_win, input_buf
local results_win, results_buf

-- Dimensions
local function get_dimensions()
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.7)
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)
    return width, height, col, row
end

-- Close windows and buffers
local function close_windows()
    if results_win and vim.api.nvim_win_is_valid(results_win) then
        vim.api.nvim_win_close(results_win, true)
    end
    if input_win and vim.api.nvim_win_is_valid(input_win) then
        vim.api.nvim_win_close(input_win, true)
    end
    if results_buf and vim.api.nvim_buf_is_valid(results_buf) then
        vim.api.nvim_buf_delete(results_buf, { force = true })
    end
    if input_buf and vim.api.nvim_buf_is_valid(input_buf) then
        vim.api.nvim_buf_delete(input_buf, { force = true })
    end
end

-- Create input window
local function create_input_window()
    local width, _, col, row = get_dimensions()
    input_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(input_buf, "buftype", "nofile")
    vim.api.nvim_buf_set_option(input_buf, "bufhidden", "wipe")

    input_win = vim.api.nvim_open_win(input_buf, true, {
        relative = "editor",
        width = width,
        height = 3,
        col = col,
        row = row,
        border = "rounded",
        style = "minimal",
    })

    vim.api.nvim_buf_set_lines(input_buf, 0, -1, false, { "Search:", "Replace:" })
    vim.api.nvim_buf_set_option(input_buf, "modifiable", true)
    vim.api.nvim_win_set_cursor(input_win, { 1, 8 }) -- Position cursor after "Search:"

    -- Restrict cursor movement
    vim.api.nvim_create_autocmd("CursorMoved", {
        buffer = input_buf,
        callback = function()
            local cursor = vim.api.nvim_win_get_cursor(0)
            local row = cursor[1]
            if row < 1 then
                vim.api.nvim_win_set_cursor(0, { 1, 8 })
            elseif row > 2 then
                vim.api.nvim_win_set_cursor(0, { 2, 8 })
            end
        end,
    })
end

-- Create results window
local function create_results_window()
    local width, height, col, row = get_dimensions()
    results_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(results_buf, "buftype", "nofile")
    vim.api.nvim_buf_set_option(results_buf, "bufhidden", "wipe")

    results_win = vim.api.nvim_open_win(results_buf, false, {
        relative = "editor",
        width = width,
        height = height - 4,
        col = col,
        row = row + 4,
        border = "rounded",
        style = "minimal",
    })

    vim.api.nvim_buf_set_lines(results_buf, 0, -1, false, { "Results:" })
    vim.api.nvim_buf_set_option(results_buf, "modifiable", false)
end

-- Update results
local function update_results()
    local start_time = vim.loop.hrtime()

    if not vim.api.nvim_buf_is_valid(input_buf) or not vim.api.nvim_buf_is_valid(results_buf) then
        return
    end

    local lines = vim.api.nvim_buf_get_lines(input_buf, 0, 2, false)
    local search_pattern = lines[1] and lines[1]:gsub("^Search:%s*", "") or ""

    -- Clear results
    vim.api.nvim_buf_set_option(results_buf, "modifiable", true)
    vim.api.nvim_buf_set_lines(results_buf, 1, -1, false, {})

    if search_pattern == "" then
        vim.api.nvim_buf_set_lines(results_buf, 1, -1, false, { "No matches found." })
        vim.api.nvim_buf_set_option(results_buf, "modifiable", false)
        return
    end

    -- Perform search
    local results = {}
    local ok, err = pcall(function()
        vim.cmd("silent! vimgrep /" .. search_pattern:gsub("/", "\\/") .. "/j **/*")
    end)

    if not ok then
        vim.api.nvim_buf_set_lines(results_buf, 1, -1, false, { "No matches found." })
        vim.api.nvim_buf_set_option(results_buf, "modifiable", false)
        debug_log("vimgrep failed: " .. (err or "Unknown error"))
        return
    end

    -- Collect results
    local qf_list = vim.fn.getqflist()
    for _, entry in ipairs(qf_list) do
        local filename = vim.fn.fnamemodify(entry.filename or "", ":p")
        if filename ~= "" then
            local lnum = entry.lnum or 0
            local col = entry.col or 0
            local text = entry.text or ""
            table.insert(results, string.format("%s:%d:%d: %s", filename, lnum, col, text))
        end
    end

    -- Display results
    if #results > 0 then
        vim.api.nvim_buf_set_lines(results_buf, 1, -1, false, results)
    else
        vim.api.nvim_buf_set_lines(results_buf, 1, -1, false, { "No matches found." })
    end

    vim.api.nvim_buf_set_option(results_buf, "modifiable", false)

    local end_time = vim.loop.hrtime()
    debug_log(string.format("Search completed in %.2f ms", (end_time - start_time) / 1e6))
end

-- Initialize plugin
function M.open_find_replace()
    close_windows()
    create_input_window()
    create_results_window()

    -- Attach autocmd to update results
    vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
        buffer = input_buf,
        callback = update_results,
    })
end

return M

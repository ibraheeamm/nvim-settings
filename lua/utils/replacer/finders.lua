
local finders = {}

function finders.attach(current_state)
    local buf = current_state.buf

    -- Watch for input changes
    vim.api.nvim_buf_attach(buf, false, {
        on_lines = function(_, _, _, first_line, _, _)
            if first_line == 0 then
                finders.search(current_state)
            end
        end,
    })
end

function finders.search(current_state)
    local buf = current_state.buf
    local lines = vim.api.nvim_buf_get_lines(buf, 0, 2, false)
    current_state.search = lines[1]:gsub("Search:%s*", "")

    -- Clear results
    vim.api.nvim_buf_set_lines(buf, 3, -1, false, {})

    if current_state.search == "" then
        vim.api.nvim_buf_set_lines(buf, 3, -1, false, { "No matches found." })
        return
    end

    -- Perform search
    local results = {}
    vim.cmd("silent! vimgrep /" .. current_state.search:gsub("/", "\\/") .. "/j **/*")
    local qf_list = vim.fn.getqflist()

    for _, entry in ipairs(qf_list) do
        table.insert(results, string.format("%s:%d:%d: %s", entry.filename, entry.lnum, entry.col, entry.text))
    end

    -- Update results
    if #results > 0 then
        vim.api.nvim_buf_set_lines(buf, 3, -1, false, results)
    else
        vim.api.nvim_buf_set_lines(buf, 3, -1, false, { "No matches found." })
    end

    current_state.results = results
end

return finders

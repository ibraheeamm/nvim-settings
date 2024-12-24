
local state = {
    buf = nil,      -- Popup buffer ID
    win = nil,      -- Popup window ID
    results = {},   -- Search results
    search = "",    -- Current search pattern
    replace = "",   -- Current replace text
}

-- Create or reset the shared state
function state.new()
    state.buf = nil
    state.win = nil
    state.results = {}
    state.search = ""
    state.replace = ""
    return state
end

-- Get the shared state
function state.get()
    return state
end

return state

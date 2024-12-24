-- vim-go settings
local go_settings = {
    go_highlight_types = 1,
    go_highlight_extra_types = 1,
    go_highlight_methods = 1,
    go_highlight_operators = 1,
    go_highlight_build_constraints = 1,
    go_highlight_fields = 1,
    go_highlight_functions = 1,
    go_highlight_function_calls = 1,
    go_highlight_function_parameters = 1,
    go_highlight_function_parameters_unused = 1,
    go_highlight_generate_tags = 1,
    go_highlight_space_tab_error = 1,
    go_highlight_trailing_whitespace_error = 1,
    go_highlight_variable_assignments = 1,
    go_highlight_variable_declarations = 1,
    go_highlight_variable_types = 1,
    go_highlight_variables = 1,
    go_highlight_whitespace_error = 1,
    go_def_mode = 'gopls',
    go_info_mode = 'gopls',
    go_fmt_command = 'goimports',
}

-- Apply settings
for k, v in pairs(go_settings) do
    vim.g[k] = v
end
--
-- vim.g.go_highlight_types = 1
-- vim.g.go_highlight_types = 1
-- vim.g.go_highlight_extra_types = 1
-- vim.g.go_highlight_methods = 1
-- vim.g.go_highlight_operators = 1
-- vim.g.go_highlight_build_constraints = 1
-- vim.g.go_highlight_fields = 1
-- vim.g.go_highlight_functions = 1
-- vim.g.go_highlight_function_calls = 1
-- vim.g.go_highlight_function_parameters = 1
-- vim.g.go_highlight_function_parameters_unused = 1
-- vim.g.go_highlight_generate_tags = 1
-- vim.g.go_highlight_operators = 1
-- vim.g.go_highlight_space_tab_error = 1
-- vim.g.go_highlight_trailing_whitespace_error = 1
-- vim.g.go_highlight_variable_assignments = 1
-- vim.g.go_highlight_variable_declarations = 1
-- vim.g.go_highlight_variable_types = 1
-- vim.g.go_highlight_variables = 1
-- vim.g.go_highlight_whitespace_error = 1
-- vim.g.go_def_mode = 'gopls'
-- vim.g.go_info_mode = 'gopls'
-- vim.g.go_fmt_command = 'goimports'
--
--

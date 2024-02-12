
-- copilot setup

vim.g.copilot_autotrigger = true
vim.g.copilot_no_tab_map = false
vim.g.copilot_autostart = 1
vim.g.copilot_autostop = 1
vim.g.copilot_autostart_min_lines = 10
vim.g.copilot_autostop_min_lines = 10
vim.g.copilot_autostart_delay = 5
vim.g.copilot_autostop_delay = 5
vim.g.copilot_autostart_filetype = '*'
vim.g.copilot_autostop_filetype = '*'


-- suggest 
vim.api.nvim_set_keymap("i", "<C-s>", "copilot#Suggest()", {silent = true, expr = true})
vim.api.nvim_set_keymap("i", "<C-N>", "copilot#Next()", {silent = true, expr = true})
vim.api.nvim_set_keymap("i", "<C-P>", "copilot#Previous()", {silent = true, expr = true})




-- imap <silent><   script><expr><C-J> copilot#Accept("\<CR>")
-- convergt to lua

-- imap <silent><   script><expr><C-J> copilot#Accept("\<CR>")
local ok, copilot = pcall(require, "copilot")
if not ok then 
    return 
end


vim.g.copilot_autotrigger = true
vim.g.copilot_no_tab_map = true
vim.g.copilot_autostart = 1
vim.g.copilot_autostop = 1
vim.g.copilot_autostart_min_lines = 10
vim.g.copilot_autostop_min_lines = 10
vim.g.copilot_autostart_delay = 5
vim.g.copilot_autostop_delay = 5
vim.g.copilot_autostart_filetype = '*'
vim.g.copilot_autostop_filetype = '*'

-- test 


vim.api.nvim_set_keymap("i", "<C-j>", "copilot#Accept('<CR>')", {silent = true, expr = true})
vim.api.nvim_set_keymap("i", "<C-k>", "copilot#Accept('<Esc>')", {silent = true, expr = true})
vim.api.nvim_set_keymap("i", "<C-l>", "copilot#Accept('<Right>')", {silent = true, expr = true})
vim.api.nvim_set_keymap("i", "<C-h>", "copilot#Accept('<Left>')", {silent = true, expr = true})
vim.api.nvim_set_keymap("i", "<C-n>", "copilot#Accept('<Down>')", {silent = true, expr = true})
vim.api.nvim_set_keymap("i", "<C-p>", "copilot#Accept('<Up>')", {silent = true, expr = true})
vim.api.nvim_set_keymap("i", "<C-Space>", "copilot#Trigger()", {silent = true, expr = true})
vim.api.nvim_set_keymap("i", "<C-e>", "copilot#Stop()", {silent = true, expr = true})
vim.api.nvim_set_keymap("i", "<C-d>", "copilot#Delete()", {silent = true, expr = true})
vim.api.nvim_set_keymap("i", "<C-b>", "copilot#Backspace()", {silent = true, expr = true})
vim.api.nvim_set_keymap("i", "<C-u>", "copilot#Clear()", {silent = true, expr = true})
vim.api.nvim_set_keymap("i", "<C-a>", "copilot#ClearAll()", {silent = true, expr = true})
vim.api.nvim_set_keymap("i", "<C-f>", "copilot#MoveForward()", {silent = true, expr = true})
vim.api.nvim_set_keymap("i", "<C-b>", "copilot#MoveBackward()", {silent = true, expr = true})
vim.api.nvim_set_keymap("i", "<C-Left>", "copilot#MoveLeft()", {silent = true, expr = true})
vim.api.nvim_set_keymap("i", "<C-Right>", "copilot#MoveRight()", {silent = true, expr = true})



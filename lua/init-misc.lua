-- set runtime path
-- vim.o.runtimepath = vim.o.runtimepath .. ',~/.config/nvim/'
-- set theme
-- set colorscheme nord
--vim.cmd('colorscheme nord')
-- setup space as leader key
vim.g.mapleader = ","
-- set termguicolors 


-- set colorscheme 

-- Disable some default plugins
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1

-- Split to the right in vsplit
vim.o.splitright = true
-- Split to the bottom in split
vim.o.splitbelow = true
-- Enable mouse for any mode
vim.o.mouse = "a"
vim.o.writebackup = false
vim.o.termguicolors = true
vim.o.tabstop = 8
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.smartindent = true
vim.o.expandtab = true
-- Show line number
vim.o.relativenumber = true
-- Highlight current line number
vim.o.cursorline = true
-- Display long text in one line
vim.o.wrap = false
-- Do not fold on default
vim.o.foldenable = false
-- Add scrolloff for better zt/zb
vim.o.scrolloff = 3
-- Show sign columnf(e.g. lsp Error sign)
vim.o.signcolumn = "yes"
-- Better completion
vim.o.completeopt = "menu,menuone,noselect"

-- Highlight on yank
vim.cmd([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]])

-- Set buffers keymaps
-- next buffer
vim.api.nvim_set_keymap("n", "<C-n>", ":bn<CR>", { noremap = true, silent = true })
-- previous buffer
vim.api.nvim_set_keymap("n", "<C-p>", ":bp<CR>", { noremap = true, silent = true })
-- close buffer
vim.api.nvim_set_keymap("n", "<C-d>", ":bd<CR>", { noremap = true, silent = true })
-- close all buffers
vim.api.nvim_set_keymap("n", "<leader>q", ":bufdo bd<CR>", { noremap = true, silent = true })
-- buffer number
vim.api.nvim_set_keymap("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>", { noremap = true, silent = true })
-- set clipboard+=unnamedplus
vim.o.clipboard = "unnamedplus"

-- disable editorconfig
vim.g.editorconfig = false

-- setup undo and redo shortcuts
vim.api.nvim_set_keymap("n", "U", ":redo<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "u", ":undo<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-s>", "<cmd> w <CR>", { noremap = true, silent = true })

-- remove a from changing the mode to INSERT
--vim.api.nvim_set_keymap("n", "a", "<NOP>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>d", "\"_d", { noremap = true, silent = true })

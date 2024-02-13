
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.o.termguicolors = true

local tree = require("nvim-tree")
tree.setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})

vim.api.nvim_set_keymap("n", "<C-t>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

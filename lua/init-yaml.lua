
-- autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
vim.api.nvim_create_autocmd('FileType', 'go', 'nmap <leader>b :<C-u>call <SID>build_go_files()<CR>', {noremap = true})

--  yaml settings 
-- let g:yaml_limit_spell = 1 
vim.g.yaml_limit_spell = 1

-- autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
vim.api.nvim_create_autocmd('FileType', 'yaml', 'setlocal ts=2 sts=2 sw=2 expandtab', {noremap = true})

-- let g:indentLine_char = '⦙'
vim.g.indentLine_char = '⦙'

-- vimrc
-- nnoremap <C-n> :NvimTreeToggle<CR>
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true})
-- nnoremap <leader>r :NvimTreeRefresh<CR>
vim.api.nvim_set_keymap('n', '<leader>r', ':NvimTreeRefresh<CR>', {noremap = true})
-- nnoremap <leader>n :NvimTreeFindFile<CR>
vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeFindFile<CR>', {noremap = true})

--[=[" More available functions:
" NvimTreeOpen
" NvimTreeClose
" NvimTreeFocus
" NvimTreeFindFileToggle
" NvimTreeResize
" NvimTreeCollapse
" NvimTreeCollapseKeepBuffers

set termguicolors " this variable must be enabled for colors to be applied properly

 a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=blue

--]=]


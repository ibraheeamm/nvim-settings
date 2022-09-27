
-- format go.nvim
require('go.format').goimports()



-- run goimport on save
-- Run gofmt + goimport on save
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)

-- go language server 




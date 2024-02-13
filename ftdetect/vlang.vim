augroup det_md
  autocmd!
  autocmd BufRead,BufNewFile *.v  set filetype=v
  autocmd BufRead,BufNewFile *.vsh set filetype=vsh
  autocmd BufRead,BufNewFile *.vv set filetype=vv
  autocmd FileType v autocmd BufWritePre <buffer> execute "normal! mz:mkview\<esc>:%!v fmt -w\<esc>:loadview\<esc>`z"
  autocmd FileType vsh autocmd BufWritePre <buffer> execute "normal! mz:mkview\<esc>:%!v fmt -w\<esc>:loadview\<esc>`z"
augroup END

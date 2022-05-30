#!/bin/sh 
  

function update(){
git submodule foreach git pull
}
# run this script when beside . directory 
git submodule add https://github.com/fatih/vim-go.git ./pack/plugins/start/vim-go
git submodule add https://github.com/arcticicestudio/nord-vim.git ./pack/plugins/start/nord-vim
git submodule add https://github.com/tpope/vim-fugitive.git ./pack/plugins/start/vim-fugitive
git submodule add https://github.com/preservim/nerdtree.git ./pack/plugins/start/nerdtree
git submodule add https://github.com/vim-airline/vim-airline.git ./pack/plugins/start/vim-airline
git submodule add https://github.com/vim-airline/vim-airline-themes.git ./pack/plugins/start/vim-airline-themes
git submodule add https://github.com/AndrewRadev/splitjoin.vim.git ./pack/plugins/start/splitjoin.vim
git submodule add https://github.com/godlygeek/tabular.git ./pack/plugins/start/tabular
git submodule add https://github.com/preservim/vim-markdown.git ./pack/plugins/start/vim-markdown
git submodule add https://github.com/github/copilot.vim.git ./pack/plugins/start/copilot.vim
git submodule add https://github.com/ctrlpvim/ctrlp.vim.git ./pack/plugins/start/ctrlp.vim
git submodule add https://github.com/dart-lang/dart-vim-plugin.git ./pack/plugins/start/dart-vim-plugin

git submodule add https://github.com/stephpy/vim-yaml.git ./pack/plugins/start/vim-yaml

git submodule add https://github.com/Yggdroot/indentLine.git ./pack/plugins/start/indentLine

" Make NeoVim also load Vim plugins and stuff. Vim files will be loaded
" _before_ NeoVim files.
set runtimepath^=~/.vim runtimepath+=~/.vim/after
" Alternatively, this would load NeoVim files first:
" let &runtimepath=stdpath("config") . ",~/.vim," . $VIMRUNTIME . "," . stdpath("config") . "/after"

" Load my vimrc.
source ~/.vim/vimrc

source ~/.config/nvim/shell.vim
source ~/.config/nvim/plugins.vim
source ~/.config/nvim/default.vim
source ~/.config/nvim/dracula.vim
source ~/.config/nvim/autosave.vim
source ~/.config/nvim/airline.vim
source ~/.config/nvim/nerdtree.vim

if filereadable(expand('~/.config/nvim/dev.vim'))
    source ~/.config/nvim/dev.vim
endif

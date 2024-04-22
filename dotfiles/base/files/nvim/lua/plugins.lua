_Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.local/share/nvim/plugged')

_Plug('dracula/vim', {as = 'dracula'})
_Plug('jiangmiao/auto-pairs')
_Plug('907th/vim-auto-save')
_Plug('vim-airline/vim-airline')
_Plug('preservim/nerdtree')
_Plug('ryanoasis/vim-devicons')
_Plug('tpope/vim-fugitive')
_Plug('tpope/vim-surround')
_Plug('cespare/vim-toml')
_Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
_Plug('ray-x/guihua.lua', {['do'] = 'cd lua/fzy && make'})

local ok, _ = pcall(require, 'plugins-dev')
if ok then
    vim.g.ElJefDevPluginsEnabled = true
end

vim.call('plug#end')

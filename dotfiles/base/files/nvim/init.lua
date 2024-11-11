vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('ej.modules.lazy')
require('ej.config.shell')
require('ej.config.defaults')

require('lazy').setup({
    spec = {
        { import = 'ej.plugins' },
    },
})

require('ej.config.colorscheme')
require('ej.config.nvimtree')
require('ej.config.bufferline')
require('ej.config.lualine')
require('ej.config.scroll')
require('ej.config.treesitter')
require('ej.config.todo')
require('ej.config.languages')
require('ej.config.markdown')
require('ej.config.filetype')
require('ej.config.pairs')

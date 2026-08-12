require('dracula').setup({
    transparent_bg = true,
})

local colors = require('dracula').colors()

vim.cmd [[
  colorscheme dracula
]]

vim.api.nvim_set_hl(0, 'NvimTreeWinSeparator', { bg = colors.bg, fg = colors.menu })
vim.api.nvim_set_hl(0, 'ColorColumn', { bg = colors.menu })

vim.g.dracula_bold = 1
vim.g.dracula_italic = 1
vim.g.dracula_underline = 1
vim.g.dracula_undercurl = 1
vim.g.dracula_inverse = 1
vim.g.dracula_colorterm = 1

--vim.cmd [[
--  hi! Normal ctermbg=NONE
--  hi! NonText ctermbg=NONE
--  hi! Normal guibg=NONE
--  hi! NonText guibg=NONE
--]]

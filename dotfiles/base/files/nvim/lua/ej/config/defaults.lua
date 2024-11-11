vim.cmd [[
  syntax enable
]]

vim.opt.termguicolors = true

vim.opt.backspace = {'indent', 'eol', 'start'}

vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true

vim.wo.wrap = false
vim.opt.wrap = false
vim.opt.textwidth = 0
vim.opt.wrapmargin = 0

vim.opt.number = true
vim.opt.cursorline = true

vim.opt.showmatch = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

vim.opt.mouse = 'a'
vim.keymap.set('n', '<Leader>y', '"+y')
vim.keymap.set('n', '<Leader>p', '"+p')

vim.opt.colorcolumn = {80, 120}

vim.opt.list = true
vim.opt.listchars.tab = '>-'
vim.opt.listchars.trail = '.'

vim.opt.cmdheight = 2
vim.opt.updatetime = 300
vim.opt.shortmess:append {c = true}
vim.opt.signcolumn = 'yes'


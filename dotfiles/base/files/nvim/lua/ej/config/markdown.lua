-- syntax highlighting in md
require('hl-mdcodeblock').setup({})

-- preview md
if vim.fn.executable('glow') == 1 then
  require("glow").setup()

  vim.api.nvim_set_keymap('n', '<C-g>', ':Glow<CR>', {})
end

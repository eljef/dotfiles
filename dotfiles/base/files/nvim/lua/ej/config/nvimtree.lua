require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 40,
  },
  renderer = {
    group_empty = true,
    icons = {
      show = {
        modified = true,
      },
    },
  },
  hijack_cursor = true,
  modified = {
    enable = true,
  },
  filters = {
    custom = { "^.git$" },
  }
})

-- Keymap Ctrl+n opens and closes tree view
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', {})

-- If nvim-tree is the last open window, automatically close it
vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    local tree_wins = {}
    local floating_wins = {}
    local wins = vim.api.nvim_list_wins()
    for _, w in ipairs(wins) do
      local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
      if bufname:match("NvimTree_") ~= nil then
        table.insert(tree_wins, w)
      end
      if vim.api.nvim_win_get_config(w).relative ~= '' then
        table.insert(floating_wins, w)
      end
    end
    if 1 == #wins - #floating_wins - #tree_wins then
      -- Should quit, so we close all invalid windows.
      for _, w in ipairs(tree_wins) do
        vim.api.nvim_win_close(w, true)
      end
    end
  end
})

-- Open nvim tree when neovim is opened
require("nvim-tree.api").tree.toggle({ find_file = true })

-- Open a file when it is created
local api = require("nvim-tree.api")
api.events.subscribe(api.events.Event.FileCreated, function(file)
  vim.cmd("edit " .. file.fname)
end)


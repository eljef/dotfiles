require('shell')
require('plugins')
require('default')
require('dracula')
require('autosave')
require('airline')
require('nerdtree')
require('treesitter')

local ok, _ = pcall(require, 'dev')
if ok then
    vim.g.ElJefDevAdded = true
end

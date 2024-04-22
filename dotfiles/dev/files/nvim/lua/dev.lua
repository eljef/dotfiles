require('omnifunc')
require('files')
require('coc-node-path')
require('coc')

local ok, _ = pcall(require, 'golang')
if ok then
    vim.g.ElJefDevGoLangEnabled = true
end

local lspconfig_defaults = require('lspconfig').util.default_config

lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

-- bash
if vim.fn.executable('bash-language-server') == 1 then
  require('lspconfig').bashls.setup{}
end

-- golang
if vim.fn.executable('go') == 1 then
  require('go').setup()
  require('lspconfig').gopls.setup{}
  require('goplements').setup( {
    prefix = {
      interface = ":by -> ",
      struct = ":is -> ",
    },
    display_package = true,
  })

  local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
      require('go.format').goimports()
    end,
    group = format_sync_grp,
  })

end

--python
if vim.fn.executable('pylsp') == 1 then
require'lspconfig'.pylsp.setup{
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {'W391'},
          maxLineLength = 120
        }
      }
    }
  }
}
end

-- completion (must be last)
local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = "go_pkgs" },
        { name = 'buffer' },
        { name = 'path' },
    },
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    matching = { disallow_symbol_nonprefix_matching = false },
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = {
                menu = 50,
                abbr = 50,
            },
            ellipsis_char = '...',
            show_labelDetails = true,
            before = function(entry, vim_item)
                return vim_item
            end
        })
    },
})

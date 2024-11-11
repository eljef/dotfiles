require('bufferline').setup({
    options = {
        diagnostics = 'nvim_lsp',
        offsets = {
            {
                filetype = 'NvimTree',
                text = '',
                text_align = 'center',
                separator = true,
            },
        },
        separator_style = { '>', '>' },
    },
})

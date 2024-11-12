local colors = require('dracula').colors()

require('bufferline').setup({
    options = {
        diagnostics = 'nvim_lsp',
        themable = false,
        offsets = {
            {
                filetype = 'NvimTree',
                text = '',
                text_align = 'center',
                separator = true,
            },
        },
        separator_style = "slope",
    },
    highlights = {
        fill = {
            bg = colors.selection,
        },
        background = {
            bg = colors.comment,
            fg = colors.fg,
        },
        buffer_selected = {
            bg = colors.purple,
            fg = colors.selection,
        },
        buffer_visible = {
            bg = colors.comment,
            fg = colors.fg,
        },
        close_button = {
            bg = colors.comment,
            fg = colors.fg,
        },
        close_button_visible = {
            bg = colors.comment,
            fg = colors.fg,
        },
        close_button_selected = {
            bg = colors.purple,
            fg = colors.selection,
        },
        separator = {
            bg = colors.comment,
            fg = colors.selection,
        },
        separator_visible = {
            bg = colors.comment,
            fg = colors.selection,
        },
        separator_selected = {
            bg = colors.purple,
            fg = colors.selection,
        },
        indicator_visible = {
            bg = colors.comment,
            fg = colors.fg,
        },
        indicator_selected = {
            bg = colors.purple,
            fg = colors.selection,
        },
        diagnostic = {
            bg = colors.comment,
            fg = colors.fg,
        },
        diagnostic_visible = {
            bg = colors.comment,
            fg = colors.fg,
        },
        diagnostic_selected = {
            bg = colors.purple,
            fg = colors.fg,
        },
        hint = {
            bg = colors.comment,
            fg = colors.fg,
        },
        hint_visible = {
            bg = colors.comment,
            fg = colors.fg,
        },
        hint_selected = {
            bg = colors.purple,
            fg = colors.fg,
        },
        hint_diagnostic = {
            bg = colors.comment,
            fg = colors.fg,
        },
        hint_diagnostic_visible = {
            bg = colors.comment,
            fg = colors.fg,
        },
        hint_diagnostic_selected = {
            bg = colors.purple,
            fg = colors.fg,
        },
        warning = {
            bg = colors.comment,
            fg = colors.yellow,
        },
        warning_visible = {
            bg = colors.comment,
            fg = colors.yellow,
        },
        warning_selected = {
            bg = colors.purple,
            fg = colors.yellow,
        },
        warning_diagnostic = {
            bg = colors.comment,
            fg = colors.yellow,
        },
        warning_diagnostic_visible = {
            bg = colors.comment,
            fg = colors.yellow,
        },
        warning_diagnostic_selected = {
            bg = colors.purple,
            fg = colors.yellow,
        },
        error = {
            bg = colors.comment,
            fg = colors.red,
        },
        error_visible = {
            bg = colors.comment,
            fg = colors.red,
        },
        error_selected = {
            bg = colors.purple,
            fg = colors.red,
        },
        error_diagnostic = {
            bg = colors.comment,
            fg = colors.red,
        },
        error_diagnostic_visible = {
            bg = colors.comment,
            fg = colors.red,
        },
        error_diagnostic_selected = {
            bg = colors.purple,
            fg = colors.red,
        },
        modified = {
            bg = colors.comment,
            fg = colors.orange,
        },
        modified_visible = {
            bg = colors.comment,
            fg = colors.orange,
        },
        modified_selected = {
            bg = colors.purple,
            fg = colors.orange,
        },
        pick = {
            bg = colors.comment,
            fg = colors.fg,
        },
        pick_visible = {
            bg = colors.comment,
            fg = colors.fg,
        },
        pick_selected = {
            bg = colors.purple,
            fg = colors.fg,
        },
        numbers = {
            bg = colors.comment,
            fg = colors.fg,
        },
        numbers_visible = {
            bg = colors.comment,
            fg = colors.fg,
        },
        numbers_selected = {
            bg = colors.purple,
            fg = colors.selection,
        },
        trunc_marker = {
            bg = colors.selection,
        },
    },
})

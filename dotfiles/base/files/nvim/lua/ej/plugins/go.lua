return {
    {
        'ray-x/go.nvim',
        dependencies = {
            'ray-x/guihua.lua',
            'maxandron/goplements.nvim',
            'Snikimonkd/cmp-go-pkgs',
        },
        ft = { "go", 'gomod' },
    }
}

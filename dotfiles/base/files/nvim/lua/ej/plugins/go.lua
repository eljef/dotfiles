return {
    {
        'ray-x/go.nvim',
        dependencies = {
            'ray-x/guihua.lua',
            'maxandron/goplements.nvim',
            'Snikimonkd/cmp-go-pkgs',
            'mfussenegger/nvim-dap',
            'nvim-neotest/nvim-nio',
            'rcarriga/nvim-dap-ui',
            'theHamsta/nvim-dap-virtual-text',
        },
        ft = { "go", 'gomod' },
    }
}

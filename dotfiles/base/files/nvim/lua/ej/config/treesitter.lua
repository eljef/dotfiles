require('nvim-treesitter').setup {
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
    }
}

if vim.fn.executable('git') == 1 then
    local tsinstalls = 0
    if vim.fn.executable('gcc') == 1 then
        tsinstalls = 1
    elseif vm.fn.executable('clang') == 1 then
        tsinstalls = 1
    end

    if tsinstalls == 1 then
        require('nvim-treesitter').install({
            'awk',
            'bash',
            'c',
            'cpp',
            'cmake',
            'comment',
            'css',
            'diff',
            'dockerfile',
            'git_rebase',
            'gitattributes',
            'gitcommit',
            'gitignore',
            'go',
            'gomod',
            'gosum',
            'gotmpl',
            'gowork',
            'html',
            'javascript',
            'json',
            'lua',
            'make',
            'markdown',
            'markdown_inline',
            'nginx',
            'powershell',
            'python',
            'rust',
            'sql',
            'toml',
            'typescript',
            'vim',
            'yaml'
        })
    end
end

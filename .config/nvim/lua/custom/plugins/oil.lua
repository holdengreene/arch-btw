return {
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {
            default_file_explorer = true,
            view_options = { show_hidden = true },
        },
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
        lazy = false,
        keys = {
            {
                '<leader>n',
                '<cmd>Oil<cr>',
                desc = 'Open Oil',
            },
        },
    },
}

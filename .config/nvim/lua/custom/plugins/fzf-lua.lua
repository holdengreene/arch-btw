return {
    {
        "ibhagwan/fzf-lua",
        event = 'VimEnter',
        dependencies = { 'nvim-mini/mini.icons' },
        opts = {},
        config = function()
            local builtin = require 'fzf-lua'
            vim.keymap.set('n', '<leader>sh', builtin.helptags, { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
            vim.keymap.set('n', '<leader>sf', builtin.files, { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect fzf-lua' })
            vim.keymap.set('n', '<leader>sw', builtin.grep_cword, { desc = '[S]earch current [W]ord' })
            vim.keymap.set('n', '<leader>sg', builtin.global, { desc = '[S]earch [G]lobally' })
            vim.keymap.set('n', '<leader>sG', builtin.live_grep_native, { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<leader>sd', builtin.lsp_document_diagnostics, { desc = '[S]earch [D]iagnostics' })
            vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
            vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
            vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

            vim.keymap.set('n', '<leader>/', function()
                builtin.grep_curbuf(builtin.setup { winopts = { preview = { hidden = true } } })
            end, { desc = '[/] Fuzzily search in current buffer' })

            vim.keymap.set('n', '<leader>sn', function()
                builtin.files({
                    cwd = vim.fn.stdpath('config')
                })
            end, { desc = '[S]earch [N]eovim files' })

            builtin.setup {
                winopts = {
                    preview = {
                        default = 'bat_native'
                    }
                },
            }
        end
    }
}

local vue_language_server_path = vim.fn.stdpath 'data' ..
    '/mason/packages/vue-language-server/node_modules/@vue/language-server'
local vue_plugin = {
    name = '@vue/typescript-plugin',
    location = vue_language_server_path,
    languages = { 'vue' },
    configNamespace = 'typescript',
}

vim.api.nvim_create_user_command('OrganizeImports', function()
    -- Get the current buffer number
    local bufnr = vim.api.nvim_get_current_buf()

    -- Find the vtsls client attached to the current buffer
    local client = nil
    for _, active_client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
        if active_client.name == 'vtsls' then
            client = active_client
            break
        end
    end

    -- If the vtsls client isn't running for this buffer, print an error
    if not client then
        vim.notify('[LSP] vtsls is not active for this buffer.', vim.log.levels.ERROR)
        return
    end

    -- Define the parameters for the 'organizeImports' command
    local params = {
        command = 'typescript.organizeImports',
        arguments = { vim.api.nvim_buf_get_name(bufnr) },
        title = '' -- This is required by the LSP specification
    }

    -- Send the command to the vtsls client
    client.request('workspace/executeCommand', params, nil, bufnr)
end, { desc = 'Organize Imports (vtsls)' })

-- Create the keymap to trigger the command
vim.keymap.set('n', '<leader>oi', '<cmd>OrganizeImports<cr>', {
    noremap = true,
    silent = true,
    desc = 'Organize Imports'
})

---@module "vim.lsp.client"
---@class vim.lsp.ClientConfig
return {
    settings = {
        vtsls = {
            tsserver = {
                globalPlugins = {
                    vue_plugin,
                },
            },
        },
    },
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    on_attach = function(client, bufnr)
        if vim.bo[bufnr].filetype == 'vue' then
            client.server_capabilities.semanticTokensProvider = nil
        end
    end,
}

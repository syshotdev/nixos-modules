local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local servers = { 'gdscript', 'dockerls', 'lua_ls', 'vimls', 'csharp_ls', 'gradle_ls', 'jdtls', 'clangd', 'rust_analyzer',
  'nil_ls' }

-- For every server, add these keymaps
for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    capabilities = capabilities,
    -- Add client if you need it
    on_attach = function(bufnr)
      print('LSP attached to buffer ' .. bufnr)
    end
  }
end

-- Specific lua-for-neovim setup
require 'lspconfig'.lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
      return
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT'
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
        }
      }
    })
  end,
  settings = {
    Lua = {}
  }
}

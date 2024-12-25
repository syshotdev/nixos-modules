local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local servers = { 'gdscript', 'dockerls', 'lua_ls', 'vimls', 'csharp_ls', 'gradle_ls', 'jdtls', 'ccls', 'rust_analyzer',
  'nil_ls' }

print("LSPconfig setting up")

-- For every server, add these keymaps
for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    capabilities = capabilities,
    -- Add client if you need it
    on_attach = function(bufnr)
      print("LSP attached to buffer " .. bufnr)
    end
  }
end

print("LSPconfig servers inited")

-- Specific lua-for-neovim setup
require 'lspconfig'.lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
      return
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {}
  }
}


local function get_pkg_config_flags()
  local handle = io.popen("pkg-config --cflags glib-2.0")
  if (handle == nil) then
    return ""
  end
  local result = handle:read("*a")
  handle:close()
  return vim.split(result:gsub("%s+", " "), "\n", { trimempty = true })
end

require('lspconfig').ccls.setup {
  init_options = {
    cache = {
      directory = ".ccls-cache",
    },
    clang = {
      extraArgs = get_pkg_config_flags(),
    },
  },
}

print("LSPconfig servers configured fully!")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local servers = { 'gdscript', 'dockerls', 'lua_ls', 'vimls', 'csharp_ls', 'gradle_ls', 'jdtls', 'ccls', 'rust_analyzer',
  'nil_ls' }

-- For every server, add these keymaps
for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    capabilities = capabilities,
  }
end

local lspconfig = require('lspconfig')
-- Specific lua-for-neovim setup
lspconfig.lua_ls.setup {
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

-- Requires pkg-config to be installed
local function get_library_paths(package_name)
    local pkg_flags = {}
    local handle = io.popen("pkg-config --cflags --libs " .. package_name)
    if handle then
        for flag in handle:read("*a"):gmatch("%S+") do
            table.insert(pkg_flags, flag)
        end
        handle:close()
    end
    return pkg_flags
end

local glib_flags = get_library_paths("glib-2.0")

lspconfig.ccls.setup {
    cmd = { "ccls" },
    root_dir = lspconfig.util.root_pattern(".ccls", "compile_commands.json", ".git"),
    init_options = {
        cache = {
            directory = ".ccls-cache";
        },
        clang = {
            extraArgs = vim.tbl_flatten({
                { "-std=c11", "-x", "c", "--gcc" },
                glib_flags,
            }),
        },
    },
}

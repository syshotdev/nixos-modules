# This file was inspired by Matt Cairn's config on github, go check him out for a more full config
{
  pkgs,
  ...
}:
let 
  # Shorthand for adding plugins (Not finished)
  #addPlugin = plugin: config: {plugin = pkgs.vimPlugins.plugin; config = config};
in{
  programs.neovim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraLuaConfig = ''
      ${builtins.readFile config/keymaps.lua}
      ${builtins.readFile config/options.lua}
    '';

    plugins = with pkgs.vimPlugins; [
      # Colorscheme
      { 
        plugin = tokyonight-nvim;
        config = "vim.cmd[[colorscheme tokyonight-night]]";
      	type = "lua";
      }
      {
        plugin = lualine-nvim;
        config = "
          require('lualine').setup {
            options = {
              theme = 'tokyonight',
            }
          }
        ";
	      type = "lua";
      }

      # Nvim-tree stuff (file explorer I think)
      nvim-web-devicons


      # Syntax highlighting
      {
        plugin = nvim-treesitter;
        config = ''
          require('nvim-treesitter.configs').setup {}
        '';
        type = "lua";
      }
      nvim-treesitter.withAllGrammars
      vim-nix


      # File searching via telescope
      {
        plugin = telescope-nvim;
        config = builtins.readFile config/setup/telescope.lua;
	      type = "lua";
      }
      telescope-fzf-native-nvim # To fix fuzzy finding to be better
      

      # What buttons do I press to do a command again?
      {
        plugin = which-key-nvim;
        config = ''require("which-key").setup {}'';
	      type = "lua";
      }

      # Signs for git
      {
        plugin = gitsigns-nvim;
        config = ''require("gitsigns").setup {}'';
	      type = "lua";
      }

      # Make it easier to pair up brackets [] and (){}<>
      {
        plugin = nvim-autopairs;
        config = ''require("nvim-autopairs").setup {}'';
	      type = "lua";
      }

      # LSP stuff (autocompletion)
      {
        plugin = nvim-lspconfig;
        config = builtins.readFile config/setup/lspconfig.lua;
	      type = "lua";
      }
      {
        plugin = nvim-cmp;
        config = builtins.readFile config/setup/cmp.lua;
	      type = "lua";
      }
      cmp-nvim-lsp
      luasnip
    ];
  };

  home.packages = with pkgs; [
    xsel # Add things to clipboard

    rust-analyzer
    jdt-language-server
    gdtoolkit
    lua-language-server

    # Packages that are required as dependencies
    gcc
  ];
}

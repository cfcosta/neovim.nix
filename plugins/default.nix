{ pkgs, deps, ... }: {
  programs.nightvim.plugins = with deps; [
    (nightvim.lib.mkPlugin "codegpt" codegpt {
      depends = [ "nui" "plenary" ];
      config = ''
        if os.getenv "OPENAI_API_KEY" then
          require "codegpt.config"
        end
      '';
    })
    (nightvim.lib.mkPlugin "comment" comment {
      config = ''
        require("Comment").setup {}
      '';
    })
    (nightvim.lib.mkPlugin "diffview" diffview { })
    (nightvim.lib.mkPlugin "gitsigns" gitsigns { })
    (nightvim.lib.mkPlugin "neo-tree" neo-tree {
      depends = [ "plenary" "nvim-web-devicons" "nui" ];
      config = ''
        vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]
        require("neo-tree").setup()
      '';
    })
    (nightvim.lib.mkPlugin "neogit" neogit {
      depends = [ "plenary" "diffview" ];
      config = builtins.readFile ./neogit.lua;
    })
    (nightvim.lib.mkPlugin "neorg" neorg {
      config = builtins.readFile ./neorg.lua;
    })
    (nightvim.lib.mkPlugin "nvim-web-devicons" nvim-web-devicons { })
    (nightvim.lib.mkPlugin "nui" nui { config = ""; })
    (nightvim.lib.mkPlugin "null-ls" null-ls {
      depends = [ "plenary" "nvim-lspconfig" ];

      inputs = with pkgs; [
        actionlint
        nixfmt
        nodePackages.eslint
        shellcheck
        shfmt
        statix
        stylua
      ];

      config = builtins.readFile ./null-ls.lua;
    })
    (nightvim.lib.mkPlugin "nvim-autopairs" nvim-autopairs {
      config = ''
        require("nvim-autopairs").setup({
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        })
      '';
    })
    (nightvim.lib.mkPlugin "nvim-cmp" nvim-cmp {
      depends = [
        "cmp-buffer"
        "cmp-cmdline"
        "cmp-nvim-lsp"
        "cmp-path"
        "cmp-snippy"
        "nvim-dap"
        "nvim-lspconfig"
        "nvim-snippy"
        "plenary"
        "neorg"
      ];

      config = builtins.readFile ./cmp.lua;
    })
    (nightvim.lib.mkPlugin "nvim-dap" nvim-dap { config = ""; })
    (nightvim.lib.mkPlugin "nvim-lspconfig" nvim-lspconfig {
      inputs = with pkgs; [
        rnix-lsp
        nodePackages.eslint
        nodePackages.svelte-language-server
        nodePackages.typescript
        nodePackages.typescript-language-server
      ];

      config = ''
        local lspconfig = require('lspconfig')

        lspconfig.rnix.setup {}
        lspconfig.tsserver.setup {}
        lspconfig.eslint.setup {}
        lspconfig.svelte.setup {}
      '';
    })
    (nightvim.lib.mkPlugin "nvim-snippy" nvim-snippy { config = ""; })
    (nightvim.lib.mkPlugin "nvim-surround" nvim-surround { })
    (nightvim.lib.mkPlugin "plenary" plenary { config = ""; })
    (nightvim.lib.mkPlugin "rust-tools" rust-tools {
      inputs = with pkgs; [ rust-analyzer ];
    })
    (nightvim.lib.mkPlugin "cmp-buffer" cmp-buffer { config = ""; })
    (nightvim.lib.mkPlugin "cmp-cmdline" cmp-cmdline { config = ""; })
    (nightvim.lib.mkPlugin "cmp-nvim-lsp" cmp-nvim-lsp { config = ""; })
    (nightvim.lib.mkPlugin "cmp-path" cmp-path { config = ""; })
    (nightvim.lib.mkPlugin "cmp-snippy" cmp-snippy { config = ""; })
    (nightvim.lib.mkPlugin "moonlight" moonlight {
      lazy = false;
      config = ''
        require("moonlight").set()
      '';
    })
    (nightvim.lib.mkPlugin "toggleterm" toggleterm { })
    (nightvim.lib.mkPlugin "telescope" telescope {
      inputs = with pkgs; [ ripgrep ];

      config = builtins.readFile ./telescope.lua;
    })
    (nightvim.lib.mkPlugin "trouble" trouble {
      depends = [ "nvim-web-devicons" ];
    })
    (nightvim.lib.mkPlugin "lualine" lualine {
      depends = [ "nvim-web-devicons" ];
      config = ''
        require("lualine").setup {
          options = {
            theme = "moonlight",
          }
        }
      '';
    })
    (nightvim.lib.mkPlugin "nvim-treesitter-endwise" nvim-treesitter-endwise {
      config = "";
    })
    (nightvim.lib.mkPlugin "nvim-treesitter" nvim-treesitter {
      depends = [ "nvim-treesitter-endwise" ];

      inputs = with pkgs; [ gcc git ];

      config = builtins.readFile ./telescope.lua;
    })
    (nightvim.lib.mkPlugin "treesj" treesj { })
    (nightvim.lib.mkPlugin "indent-blankline" indent-blankline {
      config = builtins.readFile ./indentline.lua;
    })
  ];
}

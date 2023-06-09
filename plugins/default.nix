{ pkgs, deps, ... }:
with deps.nightvim.lib; {
  programs.nightvim.plugins = with deps; [
    (mkPlugin "comment" comment { config = ''require("Comment").setup {}''; })
    (mkPlugin "neo-tree" neo-tree {
      depends = [ "plenary" "nvim-web-devicons" "nui" ];
      config = ''
        vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]
        require("neo-tree").setup()
      '';
    })
    (mkPlugin "neogit" neogit {
      depends = [ "plenary" "diffview" ];
      config = builtins.readFile ./neogit.lua;
    })
    (mkPlugin "null-ls" null-ls {
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
    (mkPlugin "nvim-autopairs" nvim-autopairs {
      config = ''
        require("nvim-autopairs").setup({
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        })
      '';
    })
    (mkPlugin "nvim-cmp" nvim-cmp {
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
    (mkPlugin "nvim-lspconfig" nvim-lspconfig {
      inputs = with pkgs; [
        deps.aiken
        gopls
        luajitPackages.lua-lsp
        nixd
        nodePackages.dockerfile-language-server-nodejs
        nodePackages.eslint
        nodePackages.svelte-language-server
        nodePackages.typescript
        nodePackages.typescript-language-server
        nodePackages.vscode-langservers-extracted
      ];

      config = builtins.readFile ./lsp.lua;
    })
    (mkPlugin "rust-tools" rust-tools {
      inputs = with pkgs; [ rust-analyzer ];
      depends = [ "cmp-nvim-lsp" ];
      config = builtins.readFile ./rust-tools.lua;
    })
    (mkPlugin "moonlight" moonlight {
      lazy = false;
      config = ''require("moonlight").set()'';
    })
    (mkPlugin "toggleterm" toggleterm { })
    (mkPlugin "telescope" telescope {
      inputs = with pkgs; [ ripgrep ];

      config = builtins.readFile ./telescope.lua;
    })
    (mkPlugin "trouble" trouble { depends = [ "nvim-web-devicons" ]; })
    (mkPlugin "lualine" lualine {
      depends = [ "nvim-web-devicons" ];
      config = ''
        require("lualine").setup {
          options = {
            theme = "moonlight",
          }
        }
      '';
    })
    (mkPlugin "nvim-treesitter" nvim-treesitter {
      depends = [ "nvim-treesitter-endwise" ];
      inputs = with pkgs; [ gcc git ];
      config = builtins.readFile ./telescope.lua;
    })
    (mkPlugin "indent-blankline" indent-blankline {
      config = builtins.readFile ./indentline.lua;
    })
    (mkPlugin "neorg" neorg { config = builtins.readFile ./neorg.lua; })
    (mkPlugin "cmp-buffer" cmp-buffer { config = ""; })
    (mkPlugin "cmp-cmdline" cmp-cmdline { config = ""; })
    (mkPlugin "cmp-nvim-lsp" cmp-nvim-lsp { config = ""; })
    (mkPlugin "cmp-path" cmp-path { config = ""; })
    (mkPlugin "cmp-snippy" cmp-snippy { config = ""; })
    (mkPlugin "diffview" diffview { })
    (mkPlugin "gitsigns" gitsigns { })
    (mkPlugin "nui" nui { config = ""; })
    (mkPlugin "nvim-dap" nvim-dap { config = ""; })
    (mkPlugin "nvim-snippy" nvim-snippy { config = ""; })
    (mkPlugin "nvim-surround" nvim-surround { })
    (mkPlugin "nvim-treesitter-endwise" nvim-treesitter-endwise {
      config = "";
    })
    (mkPlugin "nvim-web-devicons" nvim-web-devicons { })
    (mkPlugin "plenary" plenary { config = ""; })
    (mkPlugin "treesj" treesj { })
  ];
}

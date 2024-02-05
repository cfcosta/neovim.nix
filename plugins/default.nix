{ pkgs, deps, ... }:
with deps.nightvim.lib; {
  programs.nightvim.plugins = with deps;
    [
      (mkPlugin "comment" comment { config = ''require("Comment").setup {}''; })
      (mkPlugin "neo-tree" neo-tree {
        depends = [ "plenary" "nvim-web-devicons" "nui" ];
        config = builtins.readFile ./neo-tree.lua;
      })
      (mkPlugin "neogit" neogit {
        depends = [ "plenary" "diffview" ];
        config = builtins.readFile ./neogit.lua;
      })
      (mkPlugin "null-ls" null-ls {
        depends = [ "plenary" "nvim-lspconfig" ];

        inputs = with pkgs; [
          actionlint
          clang-tools
          cmake-format
          deadnix
          jq
          nixfmt
          nodePackages.eslint
          python311Packages.mdformat
          python311Packages.mdformat-gfm
          python311Packages.mdformat-frontmatter
          python311Packages.mdformat-footnote
          ruff
          ruff-lsp
          rustfmt
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
          "copilot"
          "copilot-cmp"
          "cmp-buffer"
          "cmp-cmdline"
          "cmp-nvim-lsp"
          "cmp-path"
          "cmp-snippy"
          "nvim-dap"
          "nvim-lspconfig"
          "nvim-snippy"
          "plenary"
        ];

        config = builtins.readFile ./cmp.lua;
      })
      (mkPlugin "nvim-lspconfig" nvim-lspconfig {
        inputs = with pkgs; [
          buf-language-server
          gopls
          lua-language-server
          nixd
          nodePackages.dockerfile-language-server-nodejs
          nodePackages.eslint
          nodePackages.typescript
          nodePackages.typescript-language-server
          nodePackages.vscode-langservers-extracted
          pyright
          ruff
        ];

        config = builtins.readFile ./lsp.lua;
      })
      (mkPlugin "rust-tools" rust-tools {
        inputs = with pkgs; [ rust-analyzer ];
        depends = [ "cmp-nvim-lsp" ];
        config = builtins.readFile ./rust-tools.lua;
      })
      (mkPlugin "dracula" dracula {
        lazy = false;
        config = "vim.cmd[[colorscheme dracula]]";
      })
      (mkPlugin "toggleterm" toggleterm {
        config = ''
          require("toggleterm").setup {
            size = 72
          }
        '';
      })
      (mkPlugin "telescope" telescope {
        inputs = with pkgs; [ ripgrep zf ];
        depends = [ "trouble" ];
        config = builtins.readFile ./telescope.lua;
      })
      (mkPlugin "trouble" trouble { depends = [ "nvim-web-devicons" ]; })
      (mkPlugin "lualine" lualine {
        depends = [ "nvim-web-devicons" ];
        config = ''
          require("lualine").setup {
            options = {
              theme = "dracula-nvim",
            }
          }
        '';
      })
      (mkPlugin "nvim-treesitter" nvim-treesitter {
        depends = [ "nvim-treesitter-endwise" ];
        inputs = with pkgs; [ gcc git ];
        config = builtins.readFile ./treesitter.lua;
      })
      (mkPlugin "indent-blankline" indent-blankline {
        config = builtins.readFile ./indentline.lua;
      })
      (mkPlugin "copilot" copilot {
        inputs = with pkgs; [ nodejs ];
        depends = [ "copilot-cmp" ];
        config = builtins.readFile ./copilot.lua;
      })
      (mkPlugin "copilot-cmp" copilot-cmp {
        config = "require('copilot_cmp').setup()";
      })
      (mkPlugin "nvim-osc52" osc52 { config = builtins.readFile ./osc52.lua; })
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
      (mkPlugin "nvim-treesitter-just" nvim-treesitter-just { config = ""; })
      (mkPlugin "nvim-web-devicons" nvim-web-devicons { })
      (mkPlugin "plenary" plenary { config = ""; })
      (mkPlugin "treesj" treesj { })
      (mkPlugin "aiken-neovim" aiken-neovim { config = ""; })
      (mkPlugin "wakatime" wakatime {
        inputs = with pkgs; [ wakatime ];
        config = builtins.readFile ./wakatime.lua;
        lazy = false;
      })
      (mkPlugin "which-key" which-key { })
    ] ++ (pkgs.lib.optionals pkgs.stdenv.isDarwin [
      (mkPlugin "dash.nvim" dash-nvim {
        depends = [ "telescope" ];
        config = "require('dash').setup()";
      })
    ]);
}

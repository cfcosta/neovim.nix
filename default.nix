{ pkgs, deps, ... }:
with deps.nightvim.lib;
with builtins;
{
  programs.nightvim.plugins =
    with deps;
    [
      (mkPlugin "comment" comment { config = ''require("Comment").setup {}''; })
      (mkPlugin "neo-tree" neo-tree {
        depends = [
          "plenary"
          "nvim-web-devicons"
          "nui"
        ];
        config = readFile ./plugins/neo-tree.lua;
      })
      (mkPlugin "neogit" neogit {
        depends = [
          "plenary"
          "diffview"
        ];
        config = readFile ./plugins/neogit.lua;
      })
      (mkPlugin "null-ls" null-ls {
        depends = [
          "plenary"
          "nvim-lspconfig"
        ];

        inputs = with pkgs; [
          actionlint
          clang-tools
          cmake-format
          deadnix
          jq
          nixfmt-rfc-style
          nodePackages.eslint
          postgres-lsp
          ruff
          ruff-lsp
          sqlfluff

          mdformat
          (python311Packages.mdformat-gfm.overridePythonAttrs (_: {
            src = deps.mdformat-gfm;
          }))
          python311Packages.mdformat-frontmatter
          python311Packages.mdformat-footnote
          python311Packages.mdformat-tables
          python311Packages.mdit-py-plugins
        ];

        config = readFile ./plugins/null-ls.lua;
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
          "copilot"
          "copilot-cmp"
          "lspkind"
          "nvim-dap"
          "nvim-lspconfig"
          "nvim-snippy"
          "cmp-ai"
          "plenary"
        ];

        config = readFile ./plugins/cmp.lua;
      })
      (mkPlugin "nvim-lspconfig" nvim-lspconfig {
        inputs = with pkgs; [
          buf-language-server
          deps.nixd.packages."${stdenv.hostPlatform.system}".nixd
          gopls
          lua-language-server
          nodePackages.dockerfile-language-server-nodejs
          nodePackages.eslint
          nodePackages.typescript
          nodePackages.typescript-language-server
          nodePackages.vscode-langservers-extracted
          pyright
          ruff
        ];

        config = readFile ./plugins/lsp.lua;
      })
      (mkPlugin "rust-tools" rust-tools {
        inputs = with pkgs; [ rust-analyzer ];
        depends = [ "cmp-nvim-lsp" ];
        config = readFile ./plugins/rust-tools.lua;
      })
      (mkPlugin "tokyonight" tokyonight {
        lazy = false;
        config = readFile ./plugins/colorscheme.lua;
      })
      (mkPlugin "toggleterm" toggleterm {
        config = ''
          require("toggleterm").setup {
            size = 72
          }
        '';
      })
      (mkPlugin "telescope" telescope {
        inputs = with pkgs; [
          ripgrep
          zf
        ];
        depends = [ "trouble" ];
        config = readFile ./plugins/telescope.lua;
      })
      (mkPlugin "trouble" trouble { depends = [ "nvim-web-devicons" ]; })
      (mkPlugin "lualine" lualine {
        depends = [ "nvim-web-devicons" ];
        config = ''
          require("lualine").setup {
            options = {
              theme = "tokyonight",
            }
          }
        '';
      })
      (mkPlugin "nvim-treesitter" nvim-treesitter {
        depends = [ "nvim-treesitter-endwise" ];
        inputs = with pkgs; [
          gcc
          git
        ];
        config = readFile ./plugins/treesitter.lua;
      })
      (mkPlugin "indent-blankline" indent-blankline { config = readFile ./plugins/indentline.lua; })
      (mkPlugin "copilot" copilot {
        inputs = with pkgs; [ nodejs ];
        config = readFile ./plugins/copilot.lua;
      })
      (mkPlugin "lspkind" lspkind { config = ""; })
      (mkPlugin "copilot-cmp" copilot-cmp { config = ""; })
      (mkPlugin "nvim-osc52" osc52 { config = readFile ./plugins/osc52.lua; })
      (mkPlugin "cmp-buffer" cmp-buffer { config = ""; })
      (mkPlugin "cmp-cmdline" cmp-cmdline { config = ""; })
      (mkPlugin "cmp-nvim-lsp" cmp-nvim-lsp { config = ""; })
      (mkPlugin "cmp-path" cmp-path { config = ""; })
      (mkPlugin "cmp-snippy" cmp-snippy { config = ""; })
      (mkPlugin "cmp-ai" cmp-ai { config = ""; })
      (mkPlugin "diffview" diffview { })
      (mkPlugin "gitsigns" gitsigns { })
      (mkPlugin "nui" nui { config = ""; })
      (mkPlugin "nvim-dap" nvim-dap { config = ""; })
      (mkPlugin "nvim-snippy" nvim-snippy { config = ""; })
      (mkPlugin "nvim-surround" nvim-surround { })
      (mkPlugin "nvim-treesitter-endwise" nvim-treesitter-endwise { config = ""; })
      (mkPlugin "nvim-treesitter-just" nvim-treesitter-just { config = ""; })
      (mkPlugin "nvim-web-devicons" nvim-web-devicons { })
      (mkPlugin "plenary" plenary { config = ""; })
      (mkPlugin "treesj" treesj { })
      (mkPlugin "aiken-neovim" aiken-neovim { config = ""; })
      (mkPlugin "wakatime" wakatime {
        inputs = with pkgs; [ wakatime ];
        config = readFile ./plugins/wakatime.lua;
        lazy = false;
      })
      (mkPlugin "which-key" which-key { })
      (mkPlugin "gen-nvim" gen-nvim { config = readFile ./plugins/gen.lua; })
    ]
    ++ (pkgs.lib.optionals pkgs.stdenv.isDarwin [
      (mkPlugin "dash.nvim" dash-nvim {
        depends = [ "telescope" ];
        config = "require('dash').setup()";
      })
    ]);
}

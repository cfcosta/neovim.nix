{
  description = "A great neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    gitignore = {
      url = "github:hercules-ci/gitignore.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        gitignore.follows = "gitignore";
      };
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neovim Plugins
    aiken-neovim = {
      url = "github:aiken-lang/editor-integration-nvim";
      flake = false;
    };
    avante-nvim = {
      url = "github:yetone/avante.nvim";
      flake = false;
    };
    catppuccin-nvim = {
      url = "github:catppuccin/nvim";
      flake = false;
    };
    cmp-buffer = {
      url = "github:hrsh7th/cmp-buffer";
      flake = false;
    };
    cmp-cmdline = {
      url = "github:hrsh7th/cmp-cmdline";
      flake = false;
    };
    cmp-nvim-lsp = {
      url = "github:hrsh7th/cmp-nvim-lsp";
      flake = false;
    };
    cmp-path = {
      url = "github:hrsh7th/cmp-path";
      flake = false;
    };
    cmp-snippy = {
      url = "github:dcampos/cmp-snippy";
      flake = false;
    };
    comment = {
      url = "github:numtostr/comment.nvim";
      flake = false;
    };
    conform-nvim = {
      url = "github:stevearc/conform.nvim";
      flake = false;
    };
    diffview = {
      url = "github:sindrets/diffview.nvim";
      flake = false;
    };
    dressing = {
      url = "github:stevearc/dressing.nvim";
      flake = false;
    };
    dropbar-nvim = {
      url = "github:Bekaboo/dropbar.nvim";
      flake = false;
    };
    fix-cursor-hold = {
      url = "github:antoinemadec/FixCursorHold.nvim";
      flake = false;
    };
    grug-far = {
      url = "github:MagicDuck/grug-far.nvim";
      flake = false;
    };
    gitsigns = {
      url = "github:lewis6991/gitsigns.nvim";
      flake = false;
    };
    indent-blankline = {
      url = "github:lukas-reineke/indent-blankline.nvim";
      flake = false;
    };
    lspkind = {
      url = "github:onsails/lspkind-nvim";
      flake = false;
    };
    lualine = {
      url = "github:nvim-lualine/lualine.nvim";
      flake = false;
    };
    neogit = {
      url = "github:TimUntersberger/neogit";
      flake = false;
    };
    neotest = {
      url = "github:nvim-neotest/neotest";
      flake = false;
    };
    nio = {
      url = "github:nvim-neotest/nvim-nio";
      flake = false;
    };
    nvim-notify = {
      url = "github:rcarriga/nvim-notify";
      flake = false;
    };
    nui = {
      url = "github:MunifTanjim/nui.nvim";
      flake = false;
    };
    nvim-autopairs = {
      url = "github:windwp/nvim-autopairs";
      flake = false;
    };
    nvim-cmp = {
      url = "github:hrsh7th/nvim-cmp";
      flake = false;
    };
    nvim-dap = {
      url = "github:mfussenegger/nvim-dap";
      flake = false;
    };
    lspconfig = {
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };
    nvim-snippy = {
      url = "github:dcampos/nvim-snippy";
      flake = false;
    };
    surround = {
      url = "github:kylechui/nvim-surround";
      flake = false;
    };
    nvim-tree = {
      url = "github:nvim-tree/nvim-tree.lua";
      flake = false;
    };
    nvim-treesitter = {
      url = "github:nvim-treesitter/nvim-treesitter";
      flake = false;
    };
    nvim-treesitter-endwise = {
      url = "github:RRethy/nvim-treesitter-endwise";
      flake = false;
    };
    nvim-treesitter-just = {
      url = "github:IndianBoy42/tree-sitter-just";
      flake = false;
    };
    nvim-web-devicons = {
      url = "github:nvim-tree/nvim-web-devicons";
      flake = false;
    };
    obsidian-nvim = {
      url = "github:epwalsh/obsidian.nvim";
      flake = false;
    };
    octo = {
      url = "github:pwntester/octo.nvim";
      flake = false;
    };
    plenary = {
      url = "github:nvim-lua/plenary.nvim";
      flake = false;
    };
    render-markdown = {
      url = "github:MeanderingProgrammer/render-markdown.nvim";
      flake = false;
    };
    rustacean = {
      url = "github:mrcjkb/rustaceanvim";
      flake = false;
    };
    telescope = {
      url = "github:nvim-telescope/telescope.nvim";
      flake = false;
    };
    telescope-ui-select = {
      url = "github:nvim-telescope/telescope-ui-select.nvim";
      flake = false;
    };
    toggleterm-nvim = {
      url = "github:akinsho/toggleterm.nvim";
      flake = false;
    };
    treesj = {
      url = "github:Wansmer/treesj";
      flake = false;
    };
    trouble = {
      url = "github:folke/trouble.nvim";
      flake = false;
    };
    wakatime = {
      url = "github:wakatime/vim-wakatime";
      flake = false;
    };
    which-key = {
      url = "github:folke/which-key.nvim";
      flake = false;
    };
    zen-mode = {
      url = "github:folke/zen-mode.nvim";
      flake = false;
    };
  };

  outputs =
    {
      self,
      flake-utils,
      nixpkgs,
      pre-commit-hooks,
      rust-overlay,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            rust-overlay.overlays.default

            (_: final: {
              nightvim = rec {
                inherit (rustPlatform) buildRustPackage;

                rust = final.rust-bin.stable.latest.default.override {
                  extensions = [
                    "rust-src"
                    "rust-analyzer"
                  ];
                };

                rustPlatform = pkgs.makeRustPlatform {
                  rustc = rust;
                  cargo = rust;
                };
              };
            })
          ];
        };

        nightvim = pkgs.callPackage ./lib {
          inherit (self) inputs;
        };
      in
      {
        packages = {
          inherit nightvim;
          inherit (nightvim) plugins;

          default = nightvim;
        };

        checks.pre-commit-check = pre-commit-hooks.lib.${system}.run {
          src = ./.;

          hooks = {
            deadnix.enable = true;
            nixfmt-rfc-style.enable = true;
            statix.enable = true;

            luacheck = {
              enable = true;
              entry = "${pkgs.luajitPackages.luacheck}/bin/luacheck --std luajit --globals vim -- ";
            };

            stylua.enable = true;
          };
        };

        devShells.default = pkgs.mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;

          packages = with pkgs; [
            deadnix
            luaPackages.luacheck
            nixfmt-rfc-style
            statix
            stylua
          ];
        };
      }
    );
}

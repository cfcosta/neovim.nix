{
  description = "A great neovim config";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    gitignore = {
      url = "github:hercules-ci/gitignore.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
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
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
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
    comment = {
      url = "github:numtostr/comment.nvim";
      flake = false;
    };
    conform-nvim = {
      url = "github:stevearc/conform.nvim";
      flake = false;
    };
    dressing = {
      url = "github:stevearc/dressing.nvim";
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
    plenary = {
      url = "github:nvim-lua/plenary.nvim";
      flake = false;
    };
    rainbow-delimiters = {
      url = "gitlab:HiPhish/rainbow-delimiters.nvim";
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
    todo-comments = {
      url = "github:folke/todo-comments.nvim";
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
  };

  outputs =
    {
      self,
      flake-utils,
      nixpkgs,
      pre-commit-hooks,
      rust-overlay,
      treefmt-nix,
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

        nightvim = pkgs.callPackage ./lib { inherit (self) inputs; };
        treefmt =
          (treefmt-nix.lib.evalModule pkgs {
            projectRootFile = "flake.nix";

            settings = {
              allow-missing-formatter = true;
              verbose = 0;

              global.excludes = [
                "*.lock"
                "LICENSE"
                "*.md"
              ];

              formatter = {
                nixfmt.options = [ "--strict" ];
                shfmt.options = [
                  "--ln"
                  "bash"
                ];
                prettier.excludes = [ "*.md" ];
              };
            };

            programs = {
              nixfmt.enable = true;
              prettier.enable = true;
              shfmt.enable = true;
              stylua.enable = true;
              taplo.enable = true;
            };
          }).config.build.wrapper;
      in
      {
        formatter = treefmt;

        packages = {
          inherit nightvim;
          inherit (nightvim) plugins;

          default = nightvim;
        };

        checks.pre-commit-check = pre-commit-hooks.lib.${system}.run {
          src = ./.;

          hooks = {
            deadnix.enable = true;
            statix.enable = true;

            treefmt = {
              enable = true;
              package = treefmt;
            };

            luacheck = {
              enable = true;
              entry = "${pkgs.luajitPackages.luacheck}/bin/luacheck --std luajit --globals vim -- ";
            };
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

{
  description = "A great neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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

    aiken-neovim = {
      url = "github:aiken-lang/editor-integration-nvim";
      flake = false;
    };
    avante-nvim = {
      url = "github:yetone/avante.nvim";
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
    diffview = {
      url = "github:sindrets/diffview.nvim";
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
    neo-tree = {
      url = "github:nvim-neo-tree/neo-tree.nvim";
      flake = false;
    };
    neogit = {
      url = "github:TimUntersberger/neogit";
      flake = false;
    };
    nui = {
      url = "github:MunifTanjim/nui.nvim";
      flake = false;
    };
    null-ls = {
      url = "github:jose-elias-alvarez/null-ls.nvim";
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
    nvim-lspconfig = {
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };
    nvim-snippy = {
      url = "github:dcampos/nvim-snippy";
      flake = false;
    };
    nvim-surround = {
      url = "github:kylechui/nvim-surround";
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
    osc52 = {
      url = "github:ojroques/nvim-osc52";
      flake = false;
    };
    plenary = {
      url = "github:nvim-lua/plenary.nvim";
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
    toggleterm = {
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

    # Colorschemes
    catpuccin = {
      url = "github:catppuccin/nvim";
      flake = false;
    };
    dracula = {
      url = "github:Mofiqul/dracula.nvim";
      flake = false;
    };
  };

  outputs =
    {
      self,
      flake-utils,
      home-manager,
      nixpkgs,
      pre-commit-hooks,
      ...
    }:
    let
      inherit (self) inputs;

      hmModule =
        {
          config,
          lib,
          pkgs,
          ...
        }:
        {
          imports = [
            ./hm-module.nix
            (import ./. {
              inherit config lib pkgs;
              deps = inputs;
            })
          ];

          programs.nightvim = {
            enable = true;
            extraConfig = builtins.readFile ./init.lua;
          };
        };
    in
    {
      inherit hmModule;
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;

          config = {
            allowUnfree = true;
            allowUnsupportedSystem = true;
          };
        };
      in
      {
        defaultPackage =
          (home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            modules = [
              hmModule
              (
                { pkgs, ... }:
                {
                  home = {
                    username = "nightvim";
                    homeDirectory = if pkgs.stdenv.isLinux then "/home/nightvim" else "/Users/nightvim";
                    stateVersion = "24.11";
                  };
                }
              )
            ];
          }).activation-script;

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

        devShell = pkgs.mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;
          packages = with pkgs; [
            stylua
            nixfmt-rfc-style
          ];
        };
      }
    );
}

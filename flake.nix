{
  description = "A great neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nightvim = {
      url = "github:cfcosta/nightvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
        home-manager.follows = "home-manager";
      };
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
    codegpt = {
      url = "github:dpayne/codegpt.nvim";
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
    gitsigns = {
      url = "github:lewis6991/gitsigns.nvim";
      flake = false;
    };
    indent-blankline = {
      url = "github:lukas-reineke/indent-blankline.nvim";
      flake = false;
    };
    lualine = {
      url = "github:nvim-lualine/lualine.nvim";
      flake = false;
    };
    dracula = {
      url = "github:Mofiqul/dracula.nvim";
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
      url = "github:muniftanjim/nui.nvim";
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
    plenary = {
      url = "github:nvim-lua/plenary.nvim";
      flake = false;
    };
    rust-tools = {
      url = "github:simrat39/rust-tools.nvim";
      flake = false;
    };
    telescope = {
      url = "github:nvim-telescope/telescope.nvim";
      flake = false;
    };
    telescope-zf-native = {
      url = "github:natecraddock/telescope-zf-native.nvim";
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
    osc52 = {
      url = "github:ojroques/nvim-osc52";
      flake = false;
    };
    aiken-neovim = {
      url = "github:aiken-lang/editor-integration-nvim";
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
    dash-nvim = {
      url = "github:Kapeli/dash.nvim";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, home-manager, nightvim, ... }:
    let
      hmModule = { options, config, lib, pkgs, ... }: {
        imports = [
          nightvim.hmModule
          (import ./plugins {
            inherit pkgs;
            deps = inputs;
          })
        ];

        programs.nightvim = {
          enable = true;
          extraConfig = builtins.readFile ./init.lua;
        };
      };

      devScripts = pkgs:
        with pkgs;
        [
          (writeShellScriptBin "neovim-format" ''
            ${stylua}/bin/stylua --glob '**/*.lua' -- .

            for file in $(find . -name "*.nix" -not -path "./.git/*"); do
              echo "Formatting $file..."
              ${nixfmt}/bin/nixfmt "$file"
            done
          '')
        ];
    in {
      inherit hmModule;
    } // flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          config.allowUnfree = true;
          inherit system;
        };
      in {
        defaultPackage = (home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            hmModule
            ({ options, config, lib, pkgs, ... }: {
              home.username = "nightvim";
              home.homeDirectory = if pkgs.stdenv.isLinux then
                "/home/nightvim"
              else
                "/Users/nightvim";

              home.stateVersion = "23.05";
            })
          ];
        }).activation-script;

        devShell =
          pkgs.mkShell { packages = with pkgs; [ stylua (devScripts pkgs) ]; };
      });
}

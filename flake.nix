{
  description = "A great neovim config";

  inputs = {
    gitignore = {
      url = "github:hercules-ci/gitignore.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
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
    blink-cmp = {
      url = "github:saghen/blink.cmp";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    colorful-menu = {
      url = "github:xzbdmw/colorful-menu.nvim";
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
    fff = {
      url = "github:dmtrKovalenko/fff.nvim";

      inputs = {
        nixpkgs.follows = "nixpkgs";
        rust-overlay.follows = "rust-overlay";
      };
    };
    friendly-snippets = {
      url = "github:rafamadriz/friendly-snippets";
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
    lean = {
      url = "github:Julian/lean.nvim";
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
    nvim-autopairs = {
      url = "github:windwp/nvim-autopairs";
      flake = false;
    };
    lspconfig = {
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };
    surround = {
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
    nvim-web-devicons = {
      url = "github:nvim-tree/nvim-web-devicons";
      flake = false;
    };
    obsidian-nvim = {
      url = "github:obsidian-nvim/obsidian.nvim";
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
    snacks = {
      url = "github:folke/snacks.nvim";
      flake = false;
    };
    telescope = {
      url = "github:nvim-telescope/telescope.nvim";
      flake = false;
    };
    tokyonight = {
      url = "github:folke/tokyonight.nvim";
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
    which-key = {
      url = "github:folke/which-key.nvim";
      flake = false;
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      treefmt-nix,
      ...
    }:
    let
      supportedSystems = [
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      mkNightvim = pkgs: pkgs.callPackage ./lib { inherit inputs; };

      forEachSupportedSystem =
        f:
        nixpkgs.lib.genAttrs supportedSystems (
          system:
          let
            pkgs = import nixpkgs { inherit system; };
            nightvim = mkNightvim pkgs;
          in
          f { inherit system pkgs nightvim; }
        );
    in
    {
      formatter = forEachSupportedSystem (
        { pkgs, ... }:
        (treefmt-nix.lib.evalModule pkgs {
          projectRootFile = "flake.nix";

          settings = {
            allow-missing-formatter = true;
            verbose = 0;

            global.excludes = [ "*.lock" ];

            formatter = {
              nixfmt.options = [ "--strict" ];
              shfmt.options = [
                "--ln"
                "bash"
              ];
            };
          };

          programs = {
            nixfmt.enable = true;
            oxfmt.enable = true;
            shfmt.enable = true;
            stylua.enable = true;
            taplo.enable = true;
          };
        }).config.build.wrapper
      );

      packages = forEachSupportedSystem (
        { nightvim, ... }:
        {
          inherit nightvim;
          inherit (nightvim) plugins;

          default = nightvim;
        }
      );

      devShells = forEachSupportedSystem (
        { pkgs, ... }:
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              deadnix
              luaPackages.luacheck
              nixfmt
              statix
              stylua
            ];
          };
        }
      );
    };
}

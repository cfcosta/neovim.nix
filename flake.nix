{
  description =
    "An attempt to make neovim cli functional like an IDE while being very beautiful, blazing fast startuptime";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
  };

  outputs = { nixpkgs, flake-utils, rust-overlay, ... }:
    {
      hmModule = { options, config, lib, pkgs, ... }:
        let cfg = config.programs.devos.neovim;
        in {
          options.programs.devos.neovim = {
            enable = lib.mkEnableOption "My Neovim configuration";

            lsp.modules = lib.mkOption {
              type = lib.types.listOf lib.types.string;
              default = [ "nix" "rust" "lua" "sh" "js" ];
              description = "The LSP modules to enable";
            };
          };

          config = lib.mkIf cfg.enable {
            home.packages = with pkgs;
              [
                gcc
                git
                luajit
                python310Packages.tiktoken
                ripgrep
                tree-sitter
                vimPlugins.nvim-treesitter.withAllGrammars
              ] ++ (lib.optionals (builtins.elem "rust" cfg.lsp.modules) [
                (rust-overlay.packages.${pkgs.system}.default.override {
                  extensions = [ "rust-analyzer" "rust-src" "rustfmt" ];
                })
              ]) ++ (lib.optionals (builtins.elem "nix" cfg.lsp.modules) [
                pkgs.rnix-lsp
                pkgs.nixfmt
              ]) ++ (lib.optionals (builtins.elem "lua" cfg.lsp.modules) [
                pkgs.lua-language-server
                pkgs.stylua
              ]) ++ (lib.optionals (builtins.elem "sh" cfg.lsp.modules) [
                pkgs.nodePackages.bash-language-server
                pkgs.shellcheck
                pkgs.shfmt
              ]) ++ (lib.optionals (builtins.elem "js" cfg.lsp.modules) [
                pkgs.nodePackages.dockerfile-language-server-nodejs
                pkgs.nodePackages.typescript-language-server
                pkgs.nodePackages.vscode-json-languageserver
                pkgs.nodePackages.yaml-language-server
              ]);

            programs.neovim.enable = true;

            xdg.configFile."nvim" = {
              source = ./.;
              recursive = true;
            };
          };
        };
    } // flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        devShell = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [ lua-language-server stylua ];
        };
      });
}

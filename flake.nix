{
  description =
    "An attempt to make neovim cli functional like an IDE while being very beautiful, blazing fast startuptime";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    {
      hmModule = { options, config, lib, pkgs, ... }:
        let cfg = config.programs.devos.neovim;
        in {
          options.programs.devos.neovim = {
            enable = lib.mkEnableOption "NVChad Configuration";
            neovide.enable = lib.mkEnableOption "Neovide Intagration";
          };

          config = lib.mkIf cfg.enable {
            home.packages = with pkgs;
              [ tree-sitter gcc luajit ]
              ++ lib.optionals cfg.neovide.enable [ neovide ];

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
          nativeBuildInputs = with pkgs; [ lua-language-server ];
        };
      });
}

{
  description =
    "An attempt to make neovim cli functional like an IDE while being very beautiful, blazing fast startuptime ";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable"; };

  outputs = { nixpkgs, ... }: {
    hmModule = { options, config, lib, pkgs, ... }:
      let cfg = config.programs.devos.neovim;
      in {
        options.programs.devos.neovim.enable =
          lib.mkEnableOption "NVChad Configuration";

        config = lib.mkIf cfg.enable {
          home.packages = with pkgs; [ tree-sitter ];

          programs.neovim.enable = true;

          xdg.configFile."nvim" = {
            source = ./.;
            recursive = true;
          };
        };
      };
  };
}

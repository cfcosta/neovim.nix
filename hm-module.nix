{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (builtins) readFile;

  cfg = config.programs.nightvim;
in
{
  options.programs.nightvim = with lib; {
    enable = mkEnableOption "NightVim";

    plugins = mkOption {
      type = with types; listOf package;
      default = [ ];
      description = "List of NightVim plugin packages";
    };
  };

  config =
    let
      inherit (builtins)
        concatStringsSep
        map
        ;
      inherit (lib) mkIf;
      inherit (pkgs.stdenv) mkDerivation;

      quoteString = d: ''"${d}"'';
      listToLua = list: "{${concatStringsSep " , " (map quoteString list)}}";

      nightvim-plugins = pkgs.symlinkJoin {
        name = "nightvim-plugins";
        paths = cfg.plugins;
      };

      mapSpec = p: ''
        __nv.setup_plugin(
          "${p.name}",
          ${listToLua p.depends},
          function()
            ${p.config}
          end
        )'';
    in
    mkIf cfg.enable {
      programs.neovim = {
        enable = true;

        package = mkDerivation {
          inherit (pkgs.neovim-unwrapped) meta lua;

          name = "nightvim";
          src = pkgs.neovim-unwrapped;

          nativeBuildInputs = [
            pkgs.makeWrapper
          ];

          dontBuild = true;
          installPhase = ''
            mkdir $out
            cp -rf * $out

            wrapProgram $out/bin/nvim --suffix PATH : ${nightvim-plugins}/bin
          '';
        };
      };

      xdg.configFile = {
        "nvim/init.lua".text = ''
          vim.opt.packpath:append("${nightvim-plugins}")

          local __nv = (function()
            ${readFile ./lua/init.lua}
          end)()

          ${concatStringsSep "\n" (map mapSpec cfg.plugins)}

          __nv.finish()
        '';
      };
    };
}

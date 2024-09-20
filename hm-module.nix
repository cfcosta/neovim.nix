{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.nightvim;
in
{
  options.programs.nightvim = with lib; {
    enable = mkEnableOption "NightVim";

    plugins =
      with types;
      mkOption {
        type = listOf (submodule {
          options = {
            name = mkOption { type = str; };

            src = mkOption { type = path; };

            depends = mkOption {
              type = listOf str;
              default = [ ];
            };

            inputs = mkOption {
              type = listOf attrs;
              default = [ ];
            };

            config = mkOption { type = str; };
            module = mkOption { type = str; };

            lazy = mkOption {
              type = bool;
              default = false;
            };
          };
        });
        default = [ ];
      };
  };

  config =
    let
      inherit (builtins)
        concatStringsSep
        foldl'
        map
        ;
      inherit (lib) mkIf;
      inherit (pkgs.stdenv) mkDerivation;

      quoteString = d: ''"${d}"'';
      listToLua = list: ''
        {${builtins.concatStringsSep " , " (builtins.map quoteString list)}} 
      '';

      nightvim-plugins =
        let
          mkPLugin =
            attr:
            mkDerivation {
              inherit (attr) src;

              name = "nightvim-${attr.name}";
              dontBuild = true;
              installPhase = ''
                mkdir -p $out/pack/nightvim/opt/${attr.name}
                cp -r . $out/pack/nightvim/opt/${attr.name}
              '';
            };
        in
        pkgs.symlinkJoin {
          name = "nightvim-plugins";
          paths = map mkPLugin cfg.plugins;
        };

      loadFunc = p: if p.lazy then "__nv.setup_plugin" else "__nv.setup_plugin_eager";
      mapSpec = p: ''
        ${loadFunc p}(
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

        package =
          let
            inputs = foldl' (acc: p: acc ++ p.inputs) [ ] cfg.plugins;
            paths = map (p: "--suffix PATH : ${p}/bin") inputs;
          in
          mkDerivation {
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

              wrapProgram $out/bin/nvim \
                ${concatStringsSep " " paths} \
                --set NIGHTVIM_PLUGIN_ROOT ${nightvim-plugins}
            '';
          };
      };

      xdg.configFile = {
        "nvim/lua/nightvim" = {
          source = ./lua;
          recursive = true;
        };

        "nvim/init.lua".text = ''
          local __nv = require("nightvim")
          __nv.init()

          ${concatStringsSep "\n" (map mapSpec cfg.plugins)}

          __nv.finish()
        '';
      };
    };
}

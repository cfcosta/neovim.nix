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
          mkPlugin =
            attr:
            mkDerivation {
              inherit (attr) src;

              name = "nightvim-${attr.name}";
              dontBuild = true;
              installPhase = ''
                mkdir -p $out/pack/nightvim/start/${attr.name}
                cp -r . $out/pack/nightvim/start/${attr.name}
              '';
            };
        in
        pkgs.symlinkJoin {
          name = "nightvim-plugins";
          paths = map mkPlugin cfg.plugins;
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

              wrapProgram $out/bin/nvim ${concatStringsSep " " paths}
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

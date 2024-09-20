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
          mkPlugin =
            attr:
            mkDerivation {
              inherit (attr) src;

              name = "nightvim-${attr.name}";
              dontBuild = true;
              installPhase = ''
                mkdir -p $out/pack/nightvim/start/${attr.name}/plugin
                cp -r . $out/pack/nightvim/start/${attr.name}/plugin/
              '';
            };
        in
        pkgs.symlinkJoin {
          name = "nightvim-plugins";
          paths = map mkPlugin cfg.plugins;
        };

      loadFunc = p: if p.lazy then "__nv.setup_plugin" else "__nv.setup_plugin";
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
        "nvim/init.lua".text = ''
          local __nv_builder = function()
            ${readFile ./lua/init.lua}
          end
          local __nv = __nv_builder()
          vim.opt.packpath:prepend(os.getenv("NIGHTVIM_PLUGIN_ROOT"))

          __nv.init()

          ${concatStringsSep "\n" (map mapSpec cfg.plugins)}

          __nv.finish()
        '';
      };
    };
}

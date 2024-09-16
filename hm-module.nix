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

    extraConfig = mkOption {
      type = types.str;
      default = "";
    };
  };

  config =
    let
      inherit (builtins)
        concatStringsSep
        foldl'
        map
        readFile
        ;
      inherit (lib) mkIf;
      inherit (pkgs.stdenv) mkDerivation;

      quoteString = d: ''"${d}"'';
      listToLua = list: ''
        {${builtins.concatStringsSep " , " (builtins.map quoteString list)}} 
      '';

      pluginFolders = lib.foldl' (
        acc: attr: acc // { "nvim/night/plugins/start/${attr.name}".source = attr.src; }
      ) { } cfg.plugins;
      loadFunc = p: if p.lazy then "_nv_setup_plugin" else "_nv_setup_plugin_eager";
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
                ${concatStringsSep " " paths}
            '';
          };
      };

      xdg.configFile = pluginFolders // {
        "nvim/init.lua".text = ''
            ${readFile ./nv.lua}

          _nv_init()

            ${concatStringsSep "\n" (map mapSpec cfg.plugins)}

            ${cfg.extraConfig}

          _nv_finish()'';
      };
    };
}

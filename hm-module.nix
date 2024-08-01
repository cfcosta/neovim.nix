{ config, lib, ... }:
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
            depends = mkOption { type = listOf str; };
            inputs = mkOption { type = listOf attrs; };
            config = mkOption { type = str; };
            module = mkOption { type = str; };
            lazy = mkOption { type = bool; };
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
    (lib.mkIf cfg.enable {
      programs.neovim.enable = true;

      home.packages = builtins.foldl' (acc: p: acc ++ p.inputs) [ ] cfg.plugins;

      xdg.configFile = pluginFolders // {
        "nvim/init.lua".text = ''
          ${builtins.readFile ./nv.lua}

          _nv_init()

          ${builtins.concatStringsSep "\n" (builtins.map mapSpec cfg.plugins)}

          ${cfg.extraConfig}

          _nv_finish()'';
      };
    });
}

{
  deps,
  mkPlugin,
  pkgs,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "wakatime";
  src = deps.wakatime;
  inputs = [ pkgs.wakatime ];
  config = ''
    vim.g.wakatime_CLIPath = "${pkgs.wakatime}/bin/wakatime-cli"
    ${readFile ./configuration.lua}
  '';
}

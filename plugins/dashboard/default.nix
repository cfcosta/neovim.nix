{ inputs, mkPlugin, ... }:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "dashboard";
  src = inputs.dashboard;
  depends = [
    "telescope"
    "nvim-web-devicons"
  ];
  config = readFile ./configuration.lua;
}

{ mkPlugin, deps, ... }:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "trouble";
  src = deps.trouble;

  depends = [
    "nvim-web-devicons"
  ];

  config = readFile ./configuration.lua;
}

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
  name = "telescope";
  depends = [ "trouble" ];
  inputs = with pkgs; [ ripgrep ];
  config = readFile ./configuration.lua;
  src = deps.telescope;
}
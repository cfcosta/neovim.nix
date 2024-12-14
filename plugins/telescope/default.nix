{
  inputs,
  mkPlugin,
  pkgs,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "telescope";
  depends = [
    "trouble"
    "plenary"
  ];
  inputs = with pkgs; [ ripgrep ];
  config = readFile ./configuration.lua;
  src = inputs.telescope;
}

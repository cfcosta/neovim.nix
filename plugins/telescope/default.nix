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
    "fff"
    "trouble"
    "plenary"
  ];
  inputs = with pkgs; [ ripgrep ];
  lazy.manual = true;
  config = readFile ./configuration.lua;
  src = inputs.telescope;
}

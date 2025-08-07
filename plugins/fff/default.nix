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
  name = "fff";
  src = inputs.fff.packages.${pkgs.system}.fff-nvim;
  config = readFile ./configuration.lua;
}

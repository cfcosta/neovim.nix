{
  inputs,
  mkPlugin,
  pkgs,
  ...
}:
let
  inherit (builtins) readFile;
  inherit (pkgs.stdenv.hostPlatform) system;
in
mkPlugin {
  name = "fff";
  src = inputs.fff.packages.${system}.fff-nvim;
  config = readFile ./configuration.lua;
}

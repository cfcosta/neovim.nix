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
  name = "grug-far";
  src = deps.grug-far;

  inputs = with pkgs; [
    ripgrep
  ];

  config = readFile ./configuration.lua;
}

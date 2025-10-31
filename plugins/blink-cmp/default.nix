{
  inputs,
  mkPlugin,
  pkgs,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) system;
in
mkPlugin {
  name = "blink-cmp";
  src = inputs.blink-cmp.packages.${system}.blink-cmp;

  depends = [
    "colorful-menu"
    "friendly-snippets"
  ];

  config = builtins.readFile ./configuration.lua;
}

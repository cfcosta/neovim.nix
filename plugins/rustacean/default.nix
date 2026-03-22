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
  name = "rustacean";
  src = inputs.rustacean;

  inputs = with pkgs; [
    cargo-nextest
  ];

  config = readFile ./configuration.lua;
}

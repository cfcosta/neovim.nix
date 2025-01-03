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

  depends = [ "telescope" ];

  inputs = with pkgs; [
    cargo-nextest
    nightvim.rust
  ];

  config = readFile ./configuration.lua;
}

{ inputs, mkPlugin, ... }:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "snacks";
  src = inputs.snacks;
  config = readFile ./configuration.lua;
}

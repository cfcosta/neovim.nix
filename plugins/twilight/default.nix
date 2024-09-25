{ inputs, mkPlugin, ... }:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "twilight";
  src = inputs.twilight;
  config = readFile ./configuration.lua;
}

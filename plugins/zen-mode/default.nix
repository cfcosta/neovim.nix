{ inputs, mkPlugin, ... }:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "zen-mode";
  src = inputs.zen-mode;
  config = readFile ./configuration.lua;
}

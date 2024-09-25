{ inputs, mkPlugin, ... }:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "zen-mode";
  src = inputs.zen-mode;
  depends = [ "twilight" ];
  config = readFile ./configuration.lua;
}

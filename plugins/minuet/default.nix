{ mkPlugin, deps, ... }:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "minuet";
  src = deps.minuet;

  depends = [ ];

  config = readFile ./configuration.lua;
}

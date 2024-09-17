{ mkPlugin, deps, ... }:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "neo-tree";
  src = deps.neo-tree;

  depends = [
    "plenary"
    "nvim-web-devicons"
    "nui"
  ];

  config = readFile ./configuration.lua;
}

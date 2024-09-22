{ mkPlugin, inputs, ... }:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "neo-tree";
  src = inputs.neo-tree;

  depends = [
    "plenary"
    "nvim-web-devicons"
    "nui"
  ];

  config = readFile ./configuration.lua;
}

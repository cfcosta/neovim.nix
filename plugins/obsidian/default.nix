{ inputs, mkPlugin, ... }:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "obsidian-nvim";
  src = inputs.obsidian-nvim;

  depends = [
    "cmp"
    "treesitter"
    "plenary"
    "telescope"
  ];

  config = readFile ./configuration.lua;
}

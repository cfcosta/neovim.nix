{ inputs, mkPlugin, ... }:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "catppuccin";
  src = inputs.catppuccin-nvim;

  depends = [
    "grug-far"
    "indent-blankline"
    "nvim-tree"
    "surround"
    "trouble"
    "which-key"
  ];

  config = readFile ./configuration.lua;
}

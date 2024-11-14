{ inputs, mkPlugin, ... }:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "catppuccin";
  src = inputs.catppuccin-nvim;

  depends = [
    "cmp"
    "diffview"
    "gitsigns"
    "grug-far"
    "indent-blankline"
    "neogit"
    "nvim-dap"
    "nvim-tree"
    "surround"
    "trouble"
    "which-key"
  ];

  config = readFile ./configuration.lua;
}

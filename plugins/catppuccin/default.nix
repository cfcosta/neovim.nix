{ deps, mkPlugin, ... }:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "catppuccin";
  src = deps.catppuccin-nvim;

  depends = [
    "cmp"
    "diffview"
    "gitsigns"
    "grug-far"
    "indent-blankline"
    "neogit"
    "neo-tree"
    "nvim-dap"
    "surround"
    "trouble"
    "which-key"
  ];

  config = readFile ./configuration.lua;
}

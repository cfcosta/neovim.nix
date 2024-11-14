{ mkPlugin, inputs, ... }:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "nvim-tree";
  src = inputs.nvim-tree;

  depends = [
    "nvim-web-devicons"
  ];

  config = readFile ./configuration.lua;
}

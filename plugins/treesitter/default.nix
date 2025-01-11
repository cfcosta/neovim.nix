{
  inputs,
  mkPlugin,
  pkgs,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "treesitter";
  src = inputs.nvim-treesitter;

  inputs = with pkgs; [
    gcc
    git
    nodejs
    tree-sitter
  ];

  depends = [ "nvim-treesitter-endwise" ];

  config = readFile ./configuration.lua;
}

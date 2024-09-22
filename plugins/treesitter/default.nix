{
  deps,
  mkPlugin,
  pkgs,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "treesitter";
  src = deps.nvim-treesitter;

  inputs = with pkgs; [
    gcc
    git
  ];

  depends = [ "nvim-treesitter-endwise" ];

  config = readFile ./configuration.lua;
}
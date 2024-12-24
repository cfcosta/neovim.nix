{ inputs, mkPlugin, ... }:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "nvim-autopairs";
  src = inputs.nvim-autopairs;
  config = readFile ./configuration.lua;
}

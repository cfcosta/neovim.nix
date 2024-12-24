{ inputs, mkPlugin, ... }:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "toggleterm-nvim";
  src = inputs.toggleterm-nvim;

  config = readFile ./configuration.lua;
}

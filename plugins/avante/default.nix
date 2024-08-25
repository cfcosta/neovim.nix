{ mkPlugin, deps, ... }:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "avante.nvim";
  src = deps.avante-nvim;

  depends = [
    "dressing"
    "nui"
    "nvim-web-devicons"
    "plenary"
    "render-markdown"
  ];

  config = readFile ./configuration.lua;
}

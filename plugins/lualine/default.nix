{ inputs, mkPlugin, ... }:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "lualine";
  src = inputs.lualine;

  depends = [
    "tokyonight"
    "nvim-web-devicons"
  ];

  config = readFile ./configuration.lua;
}

{ mkPlugin, inputs, ... }:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "trouble";
  src = inputs.trouble;

  depends = [
    "nvim-web-devicons"
  ];

  config = readFile ./configuration.lua;
}

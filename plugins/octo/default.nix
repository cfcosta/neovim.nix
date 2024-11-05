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
  name = "octo";
  src = inputs.octo;

  inputs = with pkgs; [
    gh
  ];

  depends = [
    "diffview"
    "nvim-web-devicons"
    "plenary"
    "telescope"
  ];

  config = readFile ./configuration.lua;
}

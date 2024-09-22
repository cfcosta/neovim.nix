{
  inputs,
  mkPlugin,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "octo";
  src = inputs.octo;

  depends = [
    "diffview"
    "nvim-web-devicons"
    "plenary"
    "telescope"
  ];

  config = readFile ./configuration.lua;
}

{ inputs, mkPlugin, ... }:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "neogit";
  src = inputs.neogit;

  depends = [
    "diffview"
    "plenary"
    "telescope"
  ];

  config = readFile ./configuration.lua;
}

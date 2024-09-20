{
  deps,
  mkPlugin,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "octo";
  src = deps.octo;

  depends = [
    "diffview"
    "plenary"
    "telescope"
  ];

  config = readFile ./configuration.lua;
}

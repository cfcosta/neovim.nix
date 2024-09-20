{
  deps,
  mkPlugin,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "neogit";
  src = deps.neogit;

  depends = [
    "diffview"
    "plenary"
  ];

  config = readFile ./configuration.lua;
}

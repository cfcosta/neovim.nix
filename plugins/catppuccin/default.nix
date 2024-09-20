{
  deps,
  mkPlugin,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "catppuccin";
  src = deps.catppuccin;
  config = readFile ./configuration.lua;
}

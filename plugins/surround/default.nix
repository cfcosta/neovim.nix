{
  deps,
  mkPlugin,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "surround";
  src = deps.surround;
  config = readFile ./configuration.lua;
}

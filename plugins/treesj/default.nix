{
  deps,
  mkPlugin,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "treesj";
  src = deps.treesj;
  config = readFile ./configuration.lua;
}

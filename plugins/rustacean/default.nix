{
  deps,
  mkPlugin,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "rustacean";
  src = deps.rustacean;
  config = readFile ./configuration.lua;
}

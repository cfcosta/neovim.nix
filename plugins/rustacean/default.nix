{
  inputs,
  mkPlugin,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "rustacean";
  src = inputs.rustacean;
  config = readFile ./configuration.lua;
}

{
  inputs,
  mkPlugin,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "surround";
  src = inputs.surround;
  config = readFile ./configuration.lua;
}

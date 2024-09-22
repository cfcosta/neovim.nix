{
  inputs,
  mkPlugin,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "indent-blankline";
  src = inputs.indent-blankline;
  config = readFile ./configuration.lua;
}

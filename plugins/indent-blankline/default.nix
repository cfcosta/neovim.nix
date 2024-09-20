{
  deps,
  mkPlugin,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "indent-blankline";
  src = deps.indent-blankline;
  config = readFile ./configuration.lua;
}

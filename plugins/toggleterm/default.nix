{
  deps,
  mkPlugin,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "toggleterm-nvim";
  src = deps.toggleterm-nvim;

  config = readFile ./configuration.lua;
}

{
  deps,
  mkPlugin,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "nvim-osc52";
  src = deps.nvim-osc52;
  config = readFile ./configuration.lua;
}

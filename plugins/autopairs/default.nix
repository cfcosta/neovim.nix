{
  deps,
  mkPlugin,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "nvim-autopairs";
  src = deps.nvim-autopairs;
  config = readFile ./configuration.lua;
}

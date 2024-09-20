{
  deps,
  mkPlugin,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "nvim-web-devicons";
  src = deps.nvim-web-devicons;
  config = readFile ./configuration.lua;
}

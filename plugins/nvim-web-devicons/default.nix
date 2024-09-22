{
  inputs,
  mkPlugin,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "nvim-web-devicons";
  src = inputs.nvim-web-devicons;
  config = readFile ./configuration.lua;
}

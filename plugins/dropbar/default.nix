{
  inputs,
  mkPlugin,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "dropbar";
  src = inputs.dropbar-nvim;
  depends = [ "nvim-web-devicons" ];
  config = readFile ./configuration.lua;
}

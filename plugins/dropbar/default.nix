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

  depends = [
    "nvim-web-devicons"
    "pomo"
  ];

  config = readFile ./configuration.lua;
}

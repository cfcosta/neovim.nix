{
  inputs,
  mkPlugin,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "hunk";
  src = inputs.hunk-nvim;

  depends = [
    "nui"
    "nvim-web-devicons"
  ];

  config = readFile ./configuration.lua;
}

{
  deps,
  mkPlugin,
  pkgs,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "grug-far.nvim";
  src = deps.grug-far;

  inputs = with pkgs; [
    ripgrep
  ];

  depends =
    [
    ];

  config = readFile ./configuration.lua;
}

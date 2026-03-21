{
  inputs,
  mkPlugin,
  pkgs,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "grug-far";
  src = inputs.grug-far;

  inputs = with pkgs; [
    ast-grep
    ripgrep
  ];

  lazy = {
    keys = [
      {
        mode = "n";
        lhs = "<leader>fr";
        desc = "Grug-far: Find and replace in project";
      }
    ];
  };

  config = readFile ./configuration.lua;
}

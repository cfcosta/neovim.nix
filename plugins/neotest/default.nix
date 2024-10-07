{
  inputs,
  mkPlugin,
  ...
}:
let
  inherit (builtins) readFile;
in
mkPlugin {
  name = "neotest";
  src = inputs.neotest;

  depends = [
    "fix-cursor-hold"
    "nio"
    "plenary"
    "rustacean"
    "treesitter"
  ];

  config = readFile ./configuration.lua;
}

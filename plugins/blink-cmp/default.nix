{
  inputs,
  mkPlugin,
  pkgs,
  ...
}:
mkPlugin {
  name = "blink-cmp";
  src = inputs.blink-cmp.packages.${pkgs.system}.blink-cmp;

  depends = [
    "friendly-snippets"
    "noice"
  ];

  config = builtins.readFile ./configuration.lua;
}

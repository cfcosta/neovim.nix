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
    "colorful-menu"
    "friendly-snippets"
  ];

  config = builtins.readFile ./configuration.lua;
}

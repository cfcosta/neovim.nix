{
  inputs,
  mkPlugin,
  pkgs,
  ...
}:
mkPlugin {
  name = "blink-cmp";
  src = inputs.blink-cmp.packages.${pkgs.system}.blink-cmp;

  config = builtins.readFile ./configuration.lua;
}

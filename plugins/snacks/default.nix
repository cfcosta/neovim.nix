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
  name = "snacks";
  src = inputs.snacks;
  inputs = with pkgs; [
    # snacks.lazygit
    lazygit

    # snacks.image
    ghostscript
    tectonic
    mermaid-cli
  ];
  config = readFile ./configuration.lua;
}
